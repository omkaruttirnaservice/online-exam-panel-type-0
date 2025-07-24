const fileUpload = require('express-fileupload');
const {
    primaryToBackupStatus,
    connectBackupServer,
    checkConnectionStatus,
} = require('../application/controllers/dbBackupController');

const router = require('express').Router();

// 1.
router.post('/connect-backup-server', connectBackupServer);
router.get('/check-connection', checkConnectionStatus);

// 2.
router.get('/primary-to-backup-status', primaryToBackupStatus);
router.post('/upload-file', fileUpload(), )

module.exports = router;
