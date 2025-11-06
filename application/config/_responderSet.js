exports.sendData = {
    _call: 0,
    _error: '',
    _sys_erorr: '',
    _data: [],
};
exports.checkResult = {
    checkResultForNullData: function (result) {
        return new Promise(function (resolve, reject) {
            if (result.length == 0) {
                reject({ _call: 1, _error: 'No Data Found', _data: [] });
            } else {
                resolve({ _call: 1, _error: '', _data: result });
            }
        });
    },
    checkResultInserted: function (data, msg) {
        return new Promise(function (resolve, reject) {
            if (data.affectedRows <= 0) {
                reject({ _call: 0, _error: msg, _sys_erorr: {}, _data: [] });
            } else {
                resolve({ _call: 1, _error: '', _sys_erorr: {}, _data: [] });
            }
        });
    },
    checkResultUpdated: function (data, msg) {
        return new Promise(function (resolve, reject) {
            if (data.affectedRows <= 0) {
                reject({ _call: 0, _error: msg, _sys_erorr: {}, _data: [] });
            } else {
                resolve({ _call: 1, _error: '', _sys_erorr: {}, _data: [] });
            }
        });
    },
};
exports.table_list = [
    'tm_final_student_question_paper',
    'tm_final_student_test_list',
    'tm_publish_test_by_post',
    'tm_publish_test_list',
    'tm_stud_institute_list',
    'tm_student_final_result_set',
    'tm_student_question_paper',
    'tm_student_test_attendance',
    'tm_student_test_list',
    'tm_test_question_sets',
    'tn_main_student_list',
    'tn_student_list',
    'utr_images',
    'utr_master_exams_list',
    'utr_student_attendance',
    'utr_time_table',
    'utr_unlock_list',
];
