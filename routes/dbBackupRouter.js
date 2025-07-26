const fileUpload = require('express-fileupload');
const { checkForPoolConnection } = require('./middleware');
const { dbBackupController } = require('../application/controllers/dbBackupController');

const router = require('express').Router();

// 1.
router.post('/connect-backup-server', dbBackupController.connectBackupServer);
router.get('/check-connection', dbBackupController.checkConnectionStatus);

router.post('/restore', checkForPoolConnection, dbBackupController.restoreDb);

// 2.
router.get('/primary-to-backup-status', dbBackupController.primaryToBackupStatus);
router.post('/upload-file', dbBackupController.saveUploadedFile);

module.exports = router;
