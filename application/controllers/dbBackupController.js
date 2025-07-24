const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');
const momentTz = require('moment-timezone');

const __PROJECT_ROOT = path.resolve('');
const DIR = {
    TEMP_DIR: path.resolve(__PROJECT_ROOT, 'public', 'temp'),
    PICS_DIR: path.resolve(__PROJECT_ROOT, 'public', 'pics', '_images'),
    DB_BACKUP: path.resolve(__PROJECT_ROOT, 'db_backup'),
    MY_SQL_CNF_PATH: path.resolve(__PROJECT_ROOT, '.my.cnf'),
};

let IS_CONNECTED_TO_BACKUP_SERVER = false;
let BACKUP_SERVER_IP = null;
let serverNumber = null;
let centerCode = null;

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

    checkConnectionStatus: (req, res, next) => {
        // This API will be used from client side on same server
        return res.status(200).json({
            call: IS_CONNECTED_TO_BACKUP_SERVER ? 1 : 0,
            message: '',
            status: IS_CONNECTED_TO_BACKUP_SERVER,
        });
    },

    async connectBackupServer(req, res, next) {
        // This will update the backup db IP
        try {
            console.log(req.body);

            BACKUP_SERVER_IP = req.body.backup_ip;
            if (!BACKUP_SERVER_IP) {
                return res.status(200).json({
                    call: 0,
                    message: 'Please enter backup server IP',
                });
            }

            const URL = `${BACKUP_SERVER_IP}/primary-to-backup-status`;
            const resp = await fetch(URL);
            if (!resp.ok) {
                throw new Error('Failed to connect to backup server');
            }
            const json = await res.json();
            console.log({ json });
            IS_CONNECTED_TO_BACKUP_SERVER = true;
            return res.status(200).json({
                call: 1,
                message: 'Connected',
            });
        } catch (error) {
            IS_CONNECTED_TO_BACKUP_SERVER = false;
            console.log(error);
            return res.status(200).json({
                call: 0,
                message: error?.message || 'Error while connecting',
            });
        }
    },

    backupDb() {
        const mySqlConfigPath = DIR.MY_SQL_CNF_PATH;
        const BACKUP_DIR = DIR.DB_BACKUP;
        const DATABASE_NAME = process.env.DB_DATABASE;
        const backupFileName = `backup_${DATABASE_NAME}_cc_${centerCode}_server_${serverNumber}_${getTimestamp()}.sql`;
        let backupFilePath = path.join(BACKUP_DIR, backupFileName);
        let gZipFileName = null;
        let gZipFilePath = null;

        let encFileName = null;
        let encFilePath = null;

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

            dumpWriteStream.on('finish', () => {
                const dumpStats = fs.statSync(backupFilePath);
                console.log(`✅ Dump completed: ${getBytesToMB(dumpStats.size)} MB`);
                // prettier-ignore
                console.log(`Database Backup completed with file size: ${getBytesToMB(dumpStats.size)} MB\n`)
                console.log(`File path: ${backupFilePath}`);

                console.log('Starting gzip file...');
                const gzipCommand = spawn('gzip', ['-k', `${backupFilePath}`]);

                gzipCommand.on('close', async (gzipCode) => {
                    if (gzipCode !== 0) {
                        console.log(`Gzip failed with code ${gzipCode}\n`);
                        return;
                    }
                    console.log(`✅ Gzip successful`);

                    gZipFileName = `${backupFileName}.gz`;
                    gZipFilePath = path.join(BACKUP_DIR, gZipFileName);

                    encFileName = `${gZipFileName}.enc`;
                    encFilePath = path.join(BACKUP_DIR, encFileName);

                    if (!fs.existsSync(gZipFilePath)) {
                        console.log('Info: Backup doesnt exsists...');
                        // sendAdminMessage(
                        //     'backup-connection-status',
                        //     'Gzipped backup file doesnt exsists'
                        // );
                        return;
                    }

                    // sendAdminMessage('backup-connection-status', 'Encrypting backup file...');

                    await encryptFile(gZipFilePath, encFilePath, '1234');

                    const fileBuffer = fs.readFileSync(encFilePath);

                    // sendMessageToBackupServer('send-backup', {
                    //     fileName: path.basename(encFilePath),
                    //     file: fileBuffer,
                    // });
                });

                gzipCommand.on('error', (err) => {
                    console.log(err);
                    console.log('Gzip process error: ' + err.message + '\n');
                });
            });
        } catch (error) {
            console.log(error);
        }
    },
};
module.exports = dbBackupController;
