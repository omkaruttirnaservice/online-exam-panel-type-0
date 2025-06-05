var express = require('express');
var router = express.Router();
var commenMiddleware = require('./middleware');
var indexController = require('../application/controllers/indexConroller');

router.get('/api-check', (req, res, next) => {
    return res.status(200).json({
        call: 1,
        message: 'Server connected.',
    });
});

/* GET home page. */
router.get('/', commenMiddleware.checkForPoolConnection, indexController.getExamHomePage);
router.get('/student-add', commenMiddleware.checkForPoolConnection, indexController.addNewStudent);
router.post(
    '/add-new-student',
    commenMiddleware.checkForPoolConnection,
    indexController.postNewStudent
);
router.post('/chk/link', commenMiddleware.checkForPoolConnection, indexController.checkExamLink);
router.get(
    '/add-student',
    commenMiddleware.checkForPoolConnectionWithSession,
    indexController.addStudentView
);
router.post(
    '/verify-candidate',
    commenMiddleware.checkForPoolConnection,
    indexController.verifyCandidateForExam
);
router.get(
    '/exam-aggrement',
    commenMiddleware.checkForPoolConnection,
    indexController.viewExamAggrement
);
router.get('/confirmtion', commenMiddleware.checkForPoolConnection, indexController.Confirmtion);
router.get('/warm-up', commenMiddleware.checkForPoolConnection, indexController.viewWarmUp);
router.get('/test', commenMiddleware.checkForPoolConnection, indexController.startExamination);
router.post('/go', indexController.updateTestDetails);
router.get(
    '/climax/:publish_id/:student_id',
    commenMiddleware.checkForPoolConnection,
    indexController.viewExamClimax
);
router.get(
    '/testisdone',
    commenMiddleware.checkForPoolConnection,
    indexController.getExamIsDonePage
);

module.exports = router;
