const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');
const momentTz = require('moment-timezone');
const FormData = require('form-data');
const { default: axios } = require('axios');

const __PROJECT_ROOT = path.resolve('');
const DIR = {
    TEMP_DIR: path.resolve(__PROJECT_ROOT, 'public', 'temp'),
    PICS_DIR: path.resolve(__PROJECT_ROOT, 'public', 'pics', '_images'),
    DB_BACKUP: path.resolve(__PROJECT_ROOT, 'db_backup'),
    MY_SQL_CNF_PATH: path.resolve(__PROJECT_ROOT, '.my.cnf'),
};

let IS_CONNECTED_TO_BACKUP_SERVER = false;
let BACKUP_SERVER_IP = null;
let serverNumber = 1;
let centerCode = 101;
let backupInterval = null;
let backupIntervalTime = 5000;

// let serverNumber = null;
// let centerCode = null;

const getTimestamp = () => {
    return momentTz().tz('Asia/Kolkata').format('YYYY_MM_DD_HH_mm_ss');
};
const getBytesToMB = (bytes, precision = 2) => {
    if (typeof bytes !== 'number' && isNaN(bytes))
        throw new Error('Please enter valid bytes value');
    return (bytes / (1024 * 1024)).toFixed(precision);
};

const dbBackupController = {
    primaryToBackupStatus: (req, res, next) => {
        return res.status(200).json({
            call: 1,
            message: 'Connected',
        });
    },

    checkPrimaryToBackupConnection() {
        return new Promise(async (resolve, reject) => {
            try {
                if (!BACKUP_SERVER_IP) {
                    reject({
                        call: 0,
                        message: 'Please enter backup server IP',
                    });
                    return;
                }

                const URL = `${BACKUP_SERVER_IP}/primary-to-backup-status`;
                console.log(URL, '=url');
                const resp = await fetch(URL);
                if (!resp.ok) {
                    throw new Error('Failed to connect to backup server');
                }

                IS_CONNECTED_TO_BACKUP_SERVER = true;

                resolve({
                    call: 1,
                    message: 'Connection successful',
                });
            } catch (error) {
                IS_CONNECTED_TO_BACKUP_SERVER = false;
                let _message = null;
                if (error.message == 'fetch failed') {
                    console.log({ message: error.message });
                    _message = 'Failed to connect to backup server';
                } else {
                    _message = error?.message;
                }
                reject({
                    call: 0,
                    message: _message || 'Error while connecting',
                });
            }
        });
    },

    checkConnectionStatus: async (req, res, next) => {
        // This API will be used from client side on same server
        try {
            await dbBackupController.checkPrimaryToBackupConnection();

            if (!IS_CONNECTED_TO_BACKUP_SERVER) {
                console.log('Info: clearing backup interval...');
                clearInterval(backupInterval);
            }

            return res.status(200).json({
                call: IS_CONNECTED_TO_BACKUP_SERVER ? 1 : 0,
                message: '',
                status: IS_CONNECTED_TO_BACKUP_SERVER,
            });
        } catch (error) {
            return res.status(200).json({
                call: IS_CONNECTED_TO_BACKUP_SERVER ? 1 : 0,
                message: '',
                status: IS_CONNECTED_TO_BACKUP_SERVER,
            });
        }
    },

    async connectBackupServer(req, res, next) {
        // This will update the backup db IP
        try {
            BACKUP_SERVER_IP = req.body.backup_ip;
            // first check connection with backup
            await dbBackupController.checkPrimaryToBackupConnection();

            // take initial backup when connected
            await dbBackupController.backupDb();

            // start the interval for backup automatically
            dbBackupController.runBackupInterval();
            return res.status(200).json({
                call: 1,
                message: 'Connected',
            });
        } catch (error) {
            IS_CONNECTED_TO_BACKUP_SERVER = false;
            return res.status(200).json({
                call: 0,
                message: error?.message || 'Error while connecting',
            });
        }
    },

    backupDb() {
        return new Promise((resolve, reject) => {
            const mySqlConfigPath = DIR.MY_SQL_CNF_PATH;
            const BACKUP_DIR = DIR.DB_BACKUP;
            const DATABASE_NAME = process.env.DB_DATABASE;
            const backupFileName = `backup_${DATABASE_NAME}_cc_${centerCode}_server_${serverNumber}_${getTimestamp()}.sql`;
            let backupFilePath = path.join(BACKUP_DIR, backupFileName);

            const dumpWriteStream = fs.createWriteStream(backupFilePath);

            try {
                if (!fs.existsSync(BACKUP_DIR)) {
                    console.log('Info: checking if backup dir exsists');
                    fs.mkdirSync(BACKUP_DIR, { recursive: true });
                }
                if (!fs.existsSync(mySqlConfigPath)) {
                    console.log("Info: config file doesn't exsists");
                    return;
                }
                const dumpCommand = spawn('mysqldump', [
                    `--defaults-extra-file=${mySqlConfigPath}`,
                    `${DATABASE_NAME}`,
                ]);

                dumpCommand.stdout.pipe(dumpWriteStream);

                dumpCommand.stderr.on('data', (data) => {
                    console.log(data);
                });

                dumpCommand.on('error', (err) => {
                    console.log(err);
                });

                dumpCommand.on('close', (dumpCode) => {
                    console.log(dumpCode, '=dumpCode');
                    if (dumpCode !== 0) {
                        return;
                    }
                });

                dumpWriteStream.on('finish', async () => {
                    const dumpStats = fs.statSync(backupFilePath);
                    console.log(`✅ Dump completed: ${getBytesToMB(dumpStats.size)} MB`);
                    // prettier-ignore
                    console.log(`Database Backup completed with file size: ${getBytesToMB(dumpStats.size)} MB\n`)
                    console.log(`File path: ${backupFilePath}`);
                    try {
                        await dbBackupController.uploadToBackupServer(backupFilePath);
                        resolve({
                            call: 1,
                            message: `Generated db backup successful`,
                        });
                    } catch (error) {
                        console.log({ error });
                    }
                });
            } catch (error) {
                reject({
                    call: 0,
                    message: error?.message || 'Error while db backup',
                });
            }
        });
    },

    async uploadToBackupServer(filePath) {
        return new Promise(async (resolve, reject) => {
            try {
                const file = fs.createReadStream(filePath);

                const formData = new FormData();

                formData.append('file', file);

                const URL = `${BACKUP_SERVER_IP}/upload-file`;

                const response = await axios.post(URL, formData, {
                    headers: formData.getHeaders(),
                });

                console.log({ response });
                resolve(response);
            } catch (error) {
                console.log(error);
                let _message = null;
                if (error.code == 'ERR_INVALID_URL') {
                    _message = 'Invalid url';
                } else {
                    _message = error?.message;
                }
                reject({
                    call: 0,
                    message: _message || 'Unable to upload db backup to server',
                });
            }
        });
    },

    saveUploadedFile(req, res, next) {
        try {
            if (!req.files || !req.files.file) {
                return res.status(400).json({ call: 0, message: 'No file uploaded' });
            }

            const uploadedFile = req.files.file;
            console.log(`✅ Received: ${uploadedFile.name}, size: ${uploadedFile.size} bytes`);

            uploadedFile.mv(path.join(DIR.DB_BACKUP, uploadedFile.name), (err) => {
                if (err) {
                    return res.status(500).json({ call: 0, message: 'Save failed' });
                }
                res.json({ call: 1, message: 'File uploaded successfully' });
            });
        } catch (error) {
            console.log(error);
            return res.status(500).json({
                call: 0,
                message: error?.message || 'Unable to upload db backup to server',
            });
        }
    },

    runBackupInterval() {
        if (backupInterval) {
            clearInterval(backupInterval);
        }
        if (IS_CONNECTED_TO_BACKUP_SERVER) {
            setInterval(async () => {
                await dbBackupController.backupDb();
            }, backupIntervalTime);
        }
    },
};

module.exports = dbBackupController;
