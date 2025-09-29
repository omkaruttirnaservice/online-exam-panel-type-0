var _ip_adress = require('../../ip_data.js')
var host = _ip_adress.host
var CURL_link = {
    new_exam_list: host + '/gov/getNewExamList',
    download_exam: host + '/gov/DownloadExam',
    download_student_batch: host + '/gov/DownloadStudentBatch',
    upload_exam_link: host + '/gov/saveUploadedExam',
    get_center_data: host + '/gov/getCenterData',
};
exports.CURL_link = CURL_link;
