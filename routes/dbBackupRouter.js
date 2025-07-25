const fileUpload = require('express-fileupload');
const {
    primaryToBackupStatus,
    connectBackupServer,
    checkConnectionStatus,
    saveUploadedFile,
    restoreDb,
} = require('../application/controllers/dbBackupController');
const { checkForPoolConnection } = require('./middleware');

const router = require('express').Router();

// 1.
router.post('/connect-backup-server', connectBackupServer);
router.get('/check-connection', checkConnectionStatus);

router.post('/restore', checkForPoolConnection, restoreDb);

// 2.
router.get('/primary-to-backup-status', primaryToBackupStatus);
router.post('/upload-file', saveUploadedFile);

module.exports = router;
