var IndexModel = require('../model/indexModel');
var responderSet = require('../config/_responderSet');
const activityLogger = require('../utils/activitylogger');
var resultStatus = responderSet.checkResult;

var indexController = {
    postNewStudent: function (req, res, next) {
        var data = req.body;
        console.log("Data Of New Student", data);
        IndexModel.addNewStudent(res.pool, data)
            .then(function (res_data) {
                return IndexModel.updateStudentDetails(res.pool, res_data.insertId, data.mobileNumber);
            })
            //Add log for student Regsitration
            .then(function (res_data1) {
                activityLogger.log(req, res.pool, 'CANDIDATE_REGISTERED', 'New candidate added', {
                    student_id: res_data1.id,

                }).catch(function (err) {
                    console.error("[ActivityLogger] Error logging candidate registration:", err);
                });
                return res_data1;
            })
            .then(function (res_data1) {
                res.render('error_page', {
                    head: "Your Login Information",
                    data: res_data1,
                    isError: 0
                })
            })
            .catch(function (error) {
                res.render('error_page', {
                    message: error,
                    head: "Error",
                    isError: 1
                })
            });

    },
    addNewStudent: function (req, res, next) {
        res.render('add-student', {
            title: 'Add New Student'
        });
        req.session.destroy(function (err) {
            // cannot access session her
        });
    },
    getExamIsDonePage: function (req, res, next) {
        res.render('exam_is_done');

        req.session.destroy(function (err) {
            // cannot access session here
        });
    },
    getExamHomePage: function (req, res, next) {

        // IndexModel.getUserInfo(res.pool,function(reciveData){
        //     res.send(reciveData._data);
        res.render('index', {
            title: 'Exam Login',
            isSessionMessage: typeof (req.session.SessionMessage) === 'undefined' ? false : req.session.SessionMessage,
            exam_link: typeof (req.session.ExamLink) === 'undefined' ? false : req.session.ExamLink
        });

        req.session.destroy(function (err) {
            // cannot access session here
        });
    },
    checkExamLink: function (req, res, next) {
        const _req_data = req.body;
        console.log(_req_data, '=====DATAFORCHECKEXAMLINK==')
        if (typeof (_req_data._lnk) == 'undefined') {
            req.session.SessionMessage = {
                msg: "No Exam Link Passed.",
                class: 'alert-warning'
            };
            req.session.ExamLink = "";
            res.redirect('/');
        } else {
            req.session.ExamLink = _req_data._lnk;
            IndexModel.verifyLink(res.pool, _req_data._lnk)
                .then(function (db_result) {
                    return resultStatus.checkResultForNullData(db_result);
                })
                .then(function (db_result) {
                    db_result = db_result._data[0];
                    req.session.Exam = {
                        published_id: db_result.id,
                        publish_link_encode: db_result.ptl_link,
                        exam_orignal_id: db_result.ptl_test_id,
                        exam_time: db_result.mt_test_time,
                        exam_total_question: db_result.mt_total_test_question,
                        exam_info: (JSON.parse(db_result.ptl_test_info))[0],
                        batch_no: db_result.tm_allow_to,
                        mt_name: db_result.mt_name,
                        is_show_mark_for_review: db_result.is_show_mark_for_review,
                        is_show_clear_response: db_result.is_show_clear_response
                    };
                    res.redirect('/add-student');
                }).catch(function (error_data) {
                    req.session.SessionMessage = {
                        msg: "Invalid Exam Link, please try again.",
                        class: 'alert-danger'
                    };
                    res.redirect('/');
                });
        }

    },
    addStudentView: function (req, res, next) {
        // if (typeof (req.session.SessionMessage) == 'undifined')
        var session_value = typeof (req.session.SessionMessage) == 'undifined' ? false : req.session.SessionMessage;
        delete req.session.SessionMessage;

        res.render('auth-student-view', {
            title: "Add Student Form Exam",
            isSessionMessage: session_value
        });
    },
    verifyCandidateForExam: function (req, res, next) {

        var student_details = req.body;
        console.log(student_details, "================studentde==========");

        //  console.log(req.body);
        // var test_credensials = {
        //     "test_id": 61,
        //     "student_id": 1,
        //     "publish_id": 73,
        //     "test_question_limit": 45,
        //     "publish_link_encode": "NjE=_1642"
        // };
        if (typeof (req.session.Exam) == 'undefined') {
            res.redirect('/');
        } else {

            IndexModel.getStudentVerifyForExam(req, res.pool, student_details, req.session.Exam.batch_no)
                .then(function (db_result) {
                    return resultStatus.checkResultForNullData(db_result);
                })
                .then(function (result_data) {
                    var db_student_info = result_data._data[0];
                    req.session.StudentInfo = db_student_info

                    //add log for student verify
                    activityLogger.log(
                        req,
                        res.pool,
                        'CANDIDATE_LOGIN',
                        'Candidate verified and logged into exam system',
                        {
                            student_id: db_student_info.id,
                            student_name: db_student_info.sl_f_name + ' ' + db_student_info.sl_l_name,
                            roll_no: db_student_info.sl_roll_number,

                            exam_id: req.session.Exam.exam_orignal_id,
                            published_id: req.session.Exam.published_id,
                            exam_name: req.session.Exam.mt_name,

                            link_id: req.session.ExamLink,

                            batch_id: db_student_info.sl_batch_no,
                            pc_label: db_student_info.pc_no || null,

                            login_time: new Date(),
                            login_type: 'exam_portal'
                        }
                    ).catch(function (err) {
                        console.error("[ActivityLogger] Error logging candidate login:", err);
                    });





                    var test_credensials = {
                        test_id: req.session.Exam.exam_orignal_id,
                        student_id: req.session.StudentInfo.id,
                        publish_id: req.session.Exam.published_id,
                        test_question_limit: req.session.Exam.exam_total_question,
                        publish_link_encode: req.session.Exam.publish_link_encode
                    };
                    return IndexModel.checkIsUserExist(res.pool, test_credensials)
                    //res.redirect('/exam-aggrement');
                })
                .then(function (isUserExists) {
                    if (isUserExists.length == 0) {
                        var test_credensials = {
                            test_id: req.session.Exam.exam_orignal_id,
                            student_id: req.session.StudentInfo.id,
                            publish_id: req.session.Exam.published_id,
                            test_question_limit: req.session.Exam.exam_total_question,
                            publish_link_encode: req.session.Exam.publish_link_encode
                        };
                        IndexModel.deleteStudentTesList(res.pool, test_credensials, function (data) {
                            IndexModel.addLockUser(res.pool, test_credensials, function (data) {
                                IndexModel.markAsPresent(res.pool, test_credensials, function (data) {
                                    res.redirect('/exam-aggrement');
                                })
                            });
                        });
                    } else {
                        var test_credensials = {
                            test_id: req.session.Exam.exam_orignal_id,
                            student_id: req.session.StudentInfo.id,
                            publish_id: req.session.Exam.published_id,
                            test_question_limit: req.session.Exam.exam_total_question,
                            publish_link_encode: req.session.Exam.publish_link_encode
                        };

                        switch (isUserExists[0].stl_test_status) {
                            case 'undifined':
                                IndexModel.deleteStudentTesList(res.pool, test_credensials, function (data) {
                                    IndexModel.addLockUser(res.pool, test_credensials, function (data) {
                                        res.redirect('/exam-aggrement');
                                    });
                                });
                                break;
                            case 1:
                                req.session.isNew = false;
                                IndexModel.addLockUser(res.pool, test_credensials, function (data) {
                                    res.redirect('/warm-up');
                                });
                                break;
                            case 2:
                                req.session.isNew = true;
                                IndexModel.addLockUser(res.pool, test_credensials, function (data) {
                                    res.redirect('/warm-up');
                                });
                                break;
                            case 0:
                                req.session.isNew = true;
                                IndexModel.addLockUser(res.pool, test_credensials, function (data) {
                                    res.redirect('/testisdone');
                                });
                                break;
                            default:
                                IndexModel.deleteStudentTesList(res.pool, test_credensials, function (data) {
                                    IndexModel.addLockUser(res.pool, test_credensials, function (data) {
                                        res.redirect('/exam-aggrement');
                                    });
                                });
                        }
                    }
                })
                .catch(function (err) {
                    if (err._call == 0) {
                        req.session.SessionMessage = {
                            msg: err._error,
                            class: 'alert-warning',
                            student_info: student_details
                        };
                        res.redirect('/add-student');
                    } else {
                        req.session.SessionMessage = {
                            msg: "Invalid Information Passed",
                            class: 'alert-warning',
                            student_info: student_details
                        };
                        res.redirect('/add-student');
                    }
                });
        }
    },
    viewExamAggrement: function (req, res, next) {
        if (typeof (req.session.StudentInfo) == 'undefined' || typeof (req.session.Exam) == 'undefined') res.redirect('/');
        //res.send(req.session);
        var session_value = typeof (req.session.SessionMessage) == 'undifined' ? false : req.session.SessionMessage;
        delete req.session.SessionMessage;
        res.render('aggreement-view', {
            title: 'Exam Aggrement View',
            test_info: req.session.Exam,
            stud_info: req.session.StudentInfo,
            isSessionMessage: session_value
        });
    },
    Confirmtion: function (req, res, next) {
        if (typeof (req.session.StudentInfo) == 'undefined' || typeof (req.session.Exam) == 'undefined') res.redirect('/');

        var test_credensials = {
            test_id: req.session.Exam.exam_orignal_id,
            student_id: req.session.StudentInfo.id,
            publish_id: req.session.Exam.published_id,
            test_question_limit: req.session.Exam.exam_total_question,
            publish_link_encode: req.session.Exam.publish_link_encode,
            exam_time: req.session.Exam.exam_time
        };

        IndexModel.ckeckExamActivated(res.pool, test_credensials)
            .then(function (data) {
                if (data.length == 1) {
                    IndexModel.checkExamCreatedNot(res.pool, test_credensials)
                        .then(function (data) {
                            if (data.length == 1) {
                                return { data: 1 };
                            } else {
                                return IndexModel.createStudentQuestionPaper(res.pool, test_credensials)
                            }
                        })
                        // .then(function (data) {
                        //     req.session.isNew = true;
                        //     res.redirect('/warm-up');
                        // })
                        //add log for Agreement Confirmtion
                        .then(function (data) {
                            activityLogger.log(req, res.pool, 'AGREEMENT_CONFIRMED', 'Candidate confirmed exam agreement terms', {
                                student_id: test_credensials.student_id,
                                exam_id: test_credensials.test_id,
                                published_id: test_credensials.publish_id
                            }).catch(function (err) {
                                console.error("[ActivityLogger] Error logging agreement confirmation:", err);
                            });

                            req.session.isNew = true;
                            res.redirect('/warm-up');
                        })

                        .catch(function (error_data) {
                            req.session.SessionMessage = {
                                msg: error_data._error,
                                class: 'alert-warning'
                            };
                            console.log(error_data);
                            res.redirect('/exam-aggrement');
                        });
                } else {
                    req.session.SessionMessage = {
                        msg: 'Please Wait... Exam Session Not Yet Started.',
                        class: 'alert-danger'
                    };
                    res.redirect('/exam-aggrement');
                }
            })
            .catch(function (error_data) {
                req.session.SessionMessage = {
                    msg: 'Data-1 Not Found',
                    class: 'alert-warning'
                };
                console.log(error_data);
                res.redirect('/exam-aggrement');
            });
    },
    viewWarmUp: function (req, res, next) {
        if (typeof (req.session.StudentInfo) == 'undefined' || typeof (req.session.Exam) == 'undefined') res.redirect('/');

        var is_new_session_value = typeof (req.session.isNew) == 'undifined' ? false : req.session.isNew;

        res.render('warm-up-view', {
            title: 'Exam Warm Up',
            is_test_new: is_new_session_value
        });
    },
    // startExamination: function (req, res, next) {
    //     if (typeof (req.session.StudentInfo) == 'undefined' || typeof (req.session.Exam) == 'undefined') res.redirect('/');

    //     var test_credensials = {
    //         test_id: req.session.Exam.exam_orignal_id,
    //         student_id: req.session.StudentInfo.id,
    //         publish_id: req.session.Exam.published_id,
    //         test_question_limit: req.session.Exam.exam_total_question,
    //         publish_link_encode: req.session.Exam.publish_link_encode,
    //         exam_time: req.session.Exam.exam_time,
    //     };

    //     var student_question_paper = [];
    //     var student_test_time = {
    //         _min: 0,
    //         _sec: 0
    //     }

    //     IndexModel.getStudentTestPaper(res.pool, test_credensials)
    //         .then(function (studentQuestionPaper) {
    //             return resultStatus.checkResultForNullData(studentQuestionPaper);
    //         })
    //         .then(function (isDataFound) {
    //             student_question_paper = isDataFound._data;
    //             return IndexModel.getStudentTestTimeDetails(res.pool, test_credensials);
    //         })
    //         .then(function (studentTestTimeDetails) {
    //             return resultStatus.checkResultForNullData(studentTestTimeDetails);
    //         })
    //         .then(function (getTimeCheck) {
    //             student_test_time._min = getTimeCheck._data[0]._min;
    //             student_test_time._sec = getTimeCheck._data[0]._sec;
    //             var paper_obj = {
    //                 test_basic_info: [req.session.Exam.exam_info],
    //                 test_session_info: [req.session],
    //                 question_paper: student_question_paper,
    //                 orignal_test_id: req.session.Exam.exam_orignal_id,
    //                 orignal_publish_id: req.session.Exam.published_id,
    //                 orignal_student_id: req.session.StudentInfo.id,
    //                 stud_info: req.session.StudentInfo,
    //                 _min: getTimeCheck._data[0]._min,
    //                 _sec: getTimeCheck._data[0]._sec
    //             }


    //             if (getTimeCheck._data[0].test_status > 0) {
    //                 var isResume = req.session.isNew === false;
    //                 var actionType = isResume ? 'EXAM_RESUMED_SUCCESSFULLY' : 'EXAM_STARTED_SUCCESSFULLY';
    //                 var actionMsg = isResume ? 'Exam resumed successfully' : 'Exam started successfully';


    //                 //add log for resume exam or started exam
    //                 activityLogger.log(
    //                     req,
    //                     res.pool,
    //                     actionType,
    //                     actionMsg,
    //                     {
    //                         student_id: test_credensials.student_id,
    //                         exam_id: test_credensials.test_id,
    //                         published_id: test_credensials.publish_id,
    //                         start_time: new Date()
    //                     }
    //                 )
    //                     .then(function () {
    //                         res.render('examination', paper_obj);
    //                     })
    //                     .catch(function (err) {

    //                         console.log('Activity log failed:', err);

    //                         // still allow exam
    //                         res.render('examination', paper_obj);
    //                     });

    //             } else {
    //                 res.redirect(
    //                     '/climax/' +
    //                     req.session.Exam.published_id +
    //                     '/' +
    //                     req.session.StudentInfo.id
    //                 );
    //             }




    //         })
    //         .catch(function (err) {
    //             res.send(err);
    //         });
    // },





    startExamination: function (req, res, next) {

        if (
            typeof (req.session.StudentInfo) == 'undefined' ||
            typeof (req.session.Exam) == 'undefined'
        ) {
            return res.redirect('/');
        }

        var test_credensials = {
            test_id: req.session.Exam.exam_orignal_id,
            student_id: req.session.StudentInfo.id,
            publish_id: req.session.Exam.published_id,
            test_question_limit: req.session.Exam.exam_total_question,
            publish_link_encode: req.session.Exam.publish_link_encode,
            exam_time: req.session.Exam.exam_time,
        };

        var student_question_paper = [];

        IndexModel.getStudentTestPaper(res.pool, test_credensials)

            .then(function (studentQuestionPaper) {
                return resultStatus.checkResultForNullData(studentQuestionPaper);
            })

            .then(function (isDataFound) {
                student_question_paper = isDataFound._data;
                return IndexModel.getStudentTestTimeDetails(res.pool, test_credensials);
            })

            .then(function (studentTestTimeDetails) {
                return resultStatus.checkResultForNullData(studentTestTimeDetails);
            })

            .then(function (getTimeCheck) {

                if (getTimeCheck._data[0].test_status <= 0) {
                    return res.redirect(
                        '/climax/' +
                        req.session.Exam.published_id +
                        '/' +
                        req.session.StudentInfo.id
                    );
                }

                var paper_obj = {
                    test_basic_info: [req.session.Exam.exam_info],
                    test_session_info: [req.session],
                    question_paper: student_question_paper,
                    orignal_test_id: req.session.Exam.exam_orignal_id,
                    orignal_publish_id: req.session.Exam.published_id,
                    orignal_student_id: req.session.StudentInfo.id,
                    stud_info: req.session.StudentInfo,
                    _min: getTimeCheck._data[0]._min,
                    _sec: getTimeCheck._data[0]._sec
                };

                // SEND RESPONSE FIRST
                res.render('examination', paper_obj);

                // BACKGROUND LOGGING
                var isResume = req.session.isNew === false;

                var actionType = isResume
                    ? 'EXAM_RESUMED_SUCCESSFULLY'
                    : 'EXAM_STARTED_SUCCESSFULLY';

                var actionMsg = isResume
                    ? 'Exam resumed successfully'
                    : 'Exam started successfully';

                activityLogger.log(
                    req,
                    res.pool,
                    actionType,
                    actionMsg,
                    {
                        student_id: test_credensials.student_id,
                        exam_id: test_credensials.test_id,
                        published_id: test_credensials.publish_id,
                        start_time: new Date()
                    }
                )
                    .catch(function (err) {
                        console.log('Activity log failed:', err);
                    });

            })

            .catch(function (err) {
                console.log(err);
                res.send(err);
            });
    },




    viewExamClimax: function (req, res, next) {
        const data = req.params;
        var studentClimaxDetails = {
            student_info: [],
            exam_info: []
        }

        if (typeof (req.session.StudentInfo) == 'undefined' || typeof (req.session.Exam) == 'undefined') res.redirect('/');

        var updateDetails = {
            test_status: 0,
            publish_id: Number(data.publish_id),
            student_id: Number(data.student_id)
        };

        IndexModel.updateStudentExamStatus(res.pool, updateDetails)
            .then(function (isStudentStatus) {
                res.render('climax-view', {
                    title: 'Exam Aggrement View',
                    test_info: req.session.Exam,
                    studentDetails: req.session.StudentInfo,
                });

                req.session.destroy(function (err) {
                });
            })
            .catch(function (error) {
                res.render('climax-view', {
                    title: 'Exam Aggrement View',
                    test_info: req.session.Exam,
                    studentDetails: req.session.StudentInfo,
                });

                req.session.destroy(function (err) {
                });
            });
    },

    updateTestDetails: function (req, res, next) {
        var details = req.body;
        var updateDetails = {
            test_id: Number(details['test_id']),
            min: Number(details['min']),
            sec: Number(details['sec']),
            test_status: Number(details['test_status']),
            test_id: Number(details['test_id']),
            publish_id: Number(details['publish_id']),
            student_id: Number(details['student_id'])
        };
        details.list = JSON.parse(details.list);
        req.getConnection(function (err, connection) {
            if (err) {
                res.status(400).send({ call: 2 });
            } else {
                IndexModel.updateStudentTestTimerAndStatus(connection, updateDetails)
                    .then(function (isStudentStatus) {
                        return resultStatus.checkResultUpdated(isStudentStatus, 'Unable to update details.');
                    })
                    .then(function (isQuestionPaperUpdated) {
                        if (details.list.length > 0) {
                            return IndexModel.updateTestQuestionDetails(connection, details.list[0]);
                        } else {
                            return isQuestionPaperUpdated;
                        }
                    })
                    .then(function (updatedData) {
                        if (details.list.length > 0) {
                            return resultStatus.checkResultUpdated(updatedData, 'Unable to update details.');
                        } else {
                            return updatedData;
                        }
                    })
                    .then(function (final_result) {
                        res.status(200).send({ call: 1 });
                    })
                    .catch(function (err) {
                        if (err._call == 0) { res.status(200).send({ call: 2 }) };
                        if (err._call == 3) { res.status(404).send({ call: 2 }) };
                    });
            }

        });
    },

    updateTestDetailsV2: function (req, res, next) {
        var details = req.body;
        console.log(details, '====updatedetatils========')
        var updateDetails = {
            test_id: Number(details['test_id']),
            min: Number(details['min']),
            sec: Number(details['sec']),
            test_status: Number(details['test_status']),
            test_id: Number(details['test_id']),
            publish_id: Number(details['publish_id']),
            student_id: Number(details['student_id'])
        };
        details.list = JSON.parse(details.list);
        req.getConnection(function (err, connection) {
            if (err) {
                res.status(400).send({ call: 2 });
            } else {
                IndexModel.updateStudentTestTimerAndStatus(connection, updateDetails)
                    .then(function (isStudentStatus) {
                        return resultStatus.checkResultUpdated(isStudentStatus, 'Unable to update details.');
                    })
                    .then(function (isQuestionPaperUpdated) {
                        if (details.list.length > 0) {
                            return IndexModel.updateTestQuestionDetailsV2(connection, details.list[0]);
                        } else {
                            return isQuestionPaperUpdated;
                        }
                    })
                    .then(function (updatedData) {
                        if (details.list.length > 0) {
                            return resultStatus.checkResultUpdated(updatedData, 'Unable to update details.');
                        } else {
                            return updatedData;
                        }
                    })
                    .then(function (final_result) {

                        let actionType = 'TIMER_UPDATE';
                        let message = 'Candidate timer updated';


                        const hasAnswer =
                            details.list &&
                            Array.isArray(details.list) &&
                            details.list.length > 0;
                        console.log(details.list[0], 'details==========');

                        let fromVal =
                            (details.from !== undefined &&
                                details.from !== null &&
                                details.from !== '')
                                ? Number(details.from)
                                : null;

                        let toVal =
                            (details.to !== undefined &&
                                details.to !== null &&
                                details.to !== '')
                                ? Number(details.to)
                                : null;

                        // Answer saved only
                        if (hasAnswer) {
                            actionType = details.action_type || 'ANSWER_SAVE';
                            
                            if (actionType === 'MARK_FOR_REVIEW') {
                                message = 'Candidate marked question for review';
                            } else if (actionType === 'UNMARK_FOR_REVIEW') {
                                message = 'Candidate unmarked question for review';
                            } else if (actionType === 'CLEAR_RESPONSE' || details.list[0].user_ans === '' || details.list[0].user_ans === null) {
                                actionType = 'CLEAR_RESPONSE';
                                message = 'Candidate cleared response';
                            } else {
                                message = 'Candidate answer saved';
                            }
                        }

                        // Navigation only
                        if (!hasAnswer && fromVal && toVal) {
                            actionType = 'QUESTION_NAVIGATE';
                            message = `Candidate navigated from Q.${fromVal} to Q.${toVal}`;
                        }

                        // Answer save + navigation
                        if (hasAnswer && fromVal && toVal) {
                            if (actionType === 'ANSWER_SAVE') {
                                actionType = 'ANSWER_SAVE_AND_NAVIGATE';
                                message = `Candidate saved answer for Q.${fromVal} and went to Q.${toVal}`;
                            } else if (actionType === 'MARK_FOR_REVIEW') {
                                message = `Candidate marked question for review on Q.${fromVal}`;
                            } else if (actionType === 'UNMARK_FOR_REVIEW') {
                                message = `Candidate unmarked question for review on Q.${fromVal}`;
                            } else if (actionType === 'CLEAR_RESPONSE') {
                                message = `Candidate cleared response for Q.${fromVal}`;
                            }
                        }

                        // Exam submission action
                        if (updateDetails.test_status === 0) {
                            actionType = 'EXAM_SUBMITTED';
                            message = 'Candidate submitted the exam';
                        }

                        // Log activity asynchronously in the background without blocking the response
                        activityLogger.log(
                            req,
                            connection,
                            actionType,
                            message,
                            {
                                student_id: updateDetails.student_id,
                                exam_id: updateDetails.test_id,
                                published_id: updateDetails.publish_id,
                                exam_name: req.session.Exam ? req.session.Exam.mt_name : null,
                                duration_mins: updateDetails.min,
                                test_status: updateDetails.test_status,
                                link_id: req.session.ExamLink,

                                question_id: details.list.length > 0
                                    ? details.list[0].question_id || null
                                    : null,

                                question_no: fromVal ||
                                    (
                                        details.list.length > 0
                                            ? details.list[0].question_no || null
                                            : null
                                    ),

                                selected_option: details.list.length > 0
                                    ? details.list[0].selected_option || details.list[0].user_ans || null
                                    : null,

                                answer_snapshot: details.list.length > 0
                                    ? details.list[0]
                                    : null,

                                attempted: details.total_attempted || details.attempted || null,
                                total_questions: details.total_questions || (req.session && req.session.Exam ? req.session.Exam.exam_total_question : null),

                                from_q: fromVal,
                                to_q: toVal,
                                pc_label: details.pc_label || null,

                                exam_remaining_time: {
                                    min: updateDetails.min,
                                    sec: updateDetails.sec
                                }
                            }
                        ).catch(error => {
                            console.error("[ActivityLogger] Error logging in updateTestDetailsV2:", error);
                        });

                        // Send success response back to student client side
                        console.log("headersSent", res.headersSent);
                        res.status(200).send({ call: 1 });


                    })

                    .catch(function (err) {
                        console.log(err, 'err');
                        if (err._call == 0) { res.status(200).send({ call: 2 }) };
                        if (err._call == 3) { res.status(404).send({ call: 2 }) };
                    });
            }

        });
    },

    viewErrorPage: function (req, res, next) {
        // res.render('error_page',{
        //     message: "This Is Error Message",
        //     head: "Error",
        //     isError: 1
        // })
        res.render('error_page', {
            head: "Your Login Information",
            data: { name: 'Deepak', password: 8007070845 },
            isError: 0
        })
    }

}


module.exports = indexController;