const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');
const momentTz = require('moment-timezone');
const FormData = require('form-data');
const { default: axios } = require('axios');
const { cleanExsistingDb } = require('../model/dumpModel');
require('dotenv').config();

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

const ONE_MIN_TO_MILISECONDS = 60000;
const BACKUP_INTERVAL_MIN = 1;
let backupIntervalTime = BACKUP_INTERVAL_MIN * ONE_MIN_TO_MILISECONDS;

// let serverNumber = null;
// let centerCode = null;

const getTimestamp = () => {
    return momentTz().tz('Asia/Kolkata').format('YYYY_MM_DD_HH_mm_ss_SSS');
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
            console.log(
                `Backup interval time : ${backupIntervalTime} miliseconds [${BACKUP_INTERVAL_MIN} min]`
            );
            console.log(`Info: IS_CONNECTED_TO_BACKUP_SERVER : ${IS_CONNECTED_TO_BACKUP_SERVER}`);
            await dbBackupController.checkPrimaryToBackupConnection();

            if (!IS_CONNECTED_TO_BACKUP_SERVER) {
                console.log('Info: clearing backup interval...');
                clearInterval(backupInterval);
            }

            return res.status(200).json({
                call: IS_CONNECTED_TO_BACKUP_SERVER ? 1 : 0,
                message: IS_CONNECTED_TO_BACKUP_SERVER
                    ? 'Connected successfully to backup server'
                    : !BACKUP_SERVER_IP
                    ? 'No backup server IP found'
                    : 'No able to connect to backup server',
                status: IS_CONNECTED_TO_BACKUP_SERVER,
                backupConnectedIP: BACKUP_SERVER_IP,
            });
        } catch (error) {
            return res.status(200).json({
                call: IS_CONNECTED_TO_BACKUP_SERVER ? 1 : 0,
                message: error?.message || '',
                status: IS_CONNECTED_TO_BACKUP_SERVER,
                backupConnectedIP: BACKUP_SERVER_IP,
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
            const backupFileName = `backup_cc_${centerCode}_${getTimestamp()}.sql`;
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
                        console.log(
                            `❎ Error : ${error?.message || 'Error whie uploading db backup file'}`
                        );
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

    async restoreDb(req, res, next) {
        try {
            const databaseName = process.env.DB_DATABASE;
            // remove old database (remove everything, truncate all)
            console.log('Info: cleaning exsisting database started...');
            await cleanExsistingDb(res.pool, databaseName);
            console.log('Info: cleaning exsisting database completed...');

            //  restore database
            const file = req?.files?.backup_file;
            if (!file) {
                return res.status(200).json({
                    call: 0,
                    message: 'No file provided',
                });
            }

            console.log('Info: Started restoring database...');
            const mySqlConfigPath = DIR.MY_SQL_CNF_PATH;
            const database = process.env.DB_DATABASE;

            const restoreCommand = spawn('mysql', [
                `--defaults-extra-file=${mySqlConfigPath}`,
                database,
            ]);
            restoreCommand.stdin.write(file.data);
            restoreCommand.stdin.end();

            restoreCommand.stdout.on('data', (data) => console.log(`MYSQL: ${data}`));
            restoreCommand.stderr.on('data', (data) => console.error(`ERROR: Restore failed`));

            restoreCommand.on('close', (code) => {
                if (code === 0) {
                    console.log(`✅ Database restored successfully into ${database}`);
                    return res.status(200).json({
                        call: 1,
                        message: 'Successfully restored database',
                    });
                } else {
                    console.log(`❌ Restore failed with exit code ${code}`);
                    return res.status(200).json({
                        call: 0,
                        message: 'Error while restoring database',
                    });
                }
            });
        } catch (error) {
            console.log(error.message, '=');
            return res.status(200).json({
                call: 0,
                message: 'Error while restoring database',
            });
        }
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

                resolve(response);
            } catch (error) {
                console.log(`Info: ${error?.message || 'Unable to save to backup server...'}`);
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

            if (!fs.existsSync(DIR.DB_BACKUP)) {
                fs.mkdirSync(DIR.DB_BACKUP, { recursive: true });
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
            backupInterval = setInterval(async () => {
                console.log(
                    `Backup interval time : ${backupIntervalTime} miliseconds [${BACKUP_INTERVAL_MIN} min]`
                );
                await dbBackupController.backupDb();
            }, backupIntervalTime);
        }
    },
};

const createMyCnfFile = () => {
    const fs = require('fs');
    const myCnfPath = DIR.MY_SQL_CNF_PATH;

    if (fs.existsSync(myCnfPath)) {
        fs.unlinkSync(myCnfPath);
    }

    if (!fs.existsSync(DIR.DB_BACKUP)) {
        console.log('➡️ Info: Creating backup directory started...');
        fs.mkdirSync(DIR.DB_BACKUP, { recursive: true });
        console.log('➡️ Info: Creating backup directory completed...');
    }

    console.log('➡️ Creating .my.cnf file');
    const fileConfig = `
        [client]
        user='${process.env.DB_USER}'
        password="${process.env.DB_PASSWORD}"
        host="${process.env.DB_HOST}"
    `.replace(/^\s+/gm, '');

    fs.writeFileSync(myCnfPath, fileConfig);
    console.log('✅ Completed Creating .my.cnf file');
};

module.exports = { dbBackupController, createMyCnfFile };
