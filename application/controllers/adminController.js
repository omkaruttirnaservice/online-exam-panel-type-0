var AdminModel = require('../model/adminModel');
var responderSet = require('../config/_responderSet');
var cURLConf = require('../config/curl.config');
var request = require('request'); //requiring request module
const fs = require('fs');

var resultStatus = responderSet.checkResult;

var adminController = {
  updateMasterIpAress: function (req, res, next) {
    var data = req.body;
    AdminModel.updateMasterIP(res.pool, data)
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  adminHome: (req, res, next) => {
    if (typeof req.session.Admin == 'undefined') {
      res.render('admin/index', {
        cc: 0,
        c_name: '',
      });
    } else {
      res.redirect('/admin/exams');
    }
  },
  swHome: (req, res, next) => {
    if (typeof req.session.Admin == 'undefined') {
      res.render('sw/index', {
        cc: 0,
        c_name: '',
      });
    } else {
      res.redirect('/sw/exam_lock_status');
    }
  },
  adminExams: (req, res, next) => {
    res.render('admin/exams', {
      cc: req.session.Admin.cc,
      c_name: req.session.Admin.c_name,
    });
  },

  adminLoginAuth: (req, res, next) => {
    var data = req.body;
    AdminModel.checkAdminLoginAuth(res.pool, data)
      .then((result) => {
        if (result.length == 0) {
          res.redirect('/admin');
        } else {
          req.session.Admin = {
            admin_id: result[0].admin_id,
            cc: result[0].cc,
            c_name: result[0].c_name,
          };
          res.redirect('/admin/exams');
        }
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ call: error });
      });
  },
  getAdminnerView: (req, res, next) => {
    res.render('admin/adminner', {
      cc: req.session.Admin.cc,
      c_name: req.session.Admin.c_name,
    });
  },
  adminLogOut: (req, res, next) => {
    req.session.destroy(function (err) {
      res.redirect('/admin');
    });
  },
  ajaxGetExamList: function (req, res, next) {
    AdminModel.getPublishTestList(res.pool)
      .then((result) => {
        if (result.length > 0) {
          res.status(200).send({ call: 1, data: result });
        } else {
          res.status(200).send({ call: 0 });
        }
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ data: error });
      });
  },
  ajaxGetDoneExamList: function (req, res, next) {
    AdminModel.getDonePublishTestList(res.pool)
      .then((result) => {
        if (result.length > 0) {
          res.status(200).send({ call: 1, data: result });
        } else {
          res.status(200).send({ call: 0 });
        }
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ data: error });
      });
  },
  getStudentAttendanceView: function (req, res, next) {
    res.render('admin/student-attendance', {
      cc: req.session.Admin.cc,
      c_name: req.session.Admin.c_name,
    });
  },
  getAllStudentsView: function (req, res, next) {
    res.render('admin/all-students', {
      cc: req.session.Admin.cc,
      c_name: req.session.Admin.c_name,
    });
  },
  getBatchStudentList: function (req, res, next) {
    var data = req.body;
    AdminModel.getBatchStudentList(res.pool, data)
      .then((result) => {
        res.status(200).send({ call: 1, data: result });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  markStudentAttendace: function (req, res, next) {
    var data = req.body;
    AdminModel.markStudentAttendace(res.pool, data.applicant_id)
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  getSingleStudentDetails: function (req, res, next) {
    var data = req.body;
    AdminModel.getSingleStudentDetails(res.pool, data.applicant_id)
      .then((result) => {
        result.length == 0 ? res.status(200).send({ call: 0 }) : res.status(200).send({ call: 1, data: result });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  getExamStudentList: function (req, res, next) {
    var data = req.params;
    var details = {
      exam: [],
      student: [],
    };
    AdminModel.getExamStudentList(res.pool, data.pub_id)
      .then((result) => {
        if (result.length == 0) {
          details.student = [];
        } else {
          details.student = result;
        }
        return AdminModel.getSinglePublishInfo(res.pool, data.pub_id);
      })
      .then((result) => {
        res.render('admin/exam-student-list', {
          exam_info: result,
          student_list: details.student,
          cc: req.session.Admin.cc,
          c_name: req.session.Admin.c_name,
        });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  loadExam: function (req, res, next) {
    var data = req.body;
    AdminModel.loadExam(res.pool, data.pub_id)
      .then((result) => {
        if (result.affectedRows > 0) {
          res.status(200).send({ call: 1 });
        } else {
          res.status(200).send({ call: 0 });
        }
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  startExamSession: function (req, res, next) {
    var data = req.body;
    AdminModel.startExamSession(res.pool, data.pub_id)
      .then((result) => {
        if (result.affectedRows > 0) {
          res.status(200).send({ call: 1 });
        } else {
          res.status(200).send({ call: 0 });
        }
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },

  getCURLExamList: function (req, res, next) {
    var data = req.body;
    exam_list = {
      exam_list: JSON.parse(data.exam_list),
    };
    request.post(
      {
        url: cURLConf.CURL_link.new_exam_list,
        body: JSON.stringify({ exam_list }),
      },
      function (error, response, body) {
        if (typeof response === 'undefined') {
          res.status(200).send({ call: 999 });
        } else {
          if (!error && response.statusCode == 200) {
            res.status(200).send(body);
          } else {
            res.status(response.statusCode).send(body);
          }
        }
      }
    );
  },
  getCURLCenterDetails: function (req, res, next) {
    var data = req.body;
    request(cURLConf.CURL_link.get_center_data + '/' + data.center_code, function (error, response, body) {
      // res.status(response.statusCode).send(body);
      if (typeof response === 'undefined') {
        res.status(200).send({ call: 999 });
      } else {
        if (!error && response.statusCode == 200) {
          var json_data = JSON.parse(body);
          switch (json_data.call) {
            case 1:
              AdminModel.cleanAuthDetails(res.pool)
                .then((result) => {
                  return AdminModel.addAuthDetails(res.pool, json_data.data);
                })
                .then((result) => {
                  res.status(200).send({ call: 1 });
                })
                .catch((error) => {
                  res.status(200).send({ call: 0, err: error });
                });
              break;
            default:
              res.status(200).send({ call: 5 });
              break;
          }
        } else {
          res.status(response.statusCode).send(body);
        }
      }
    });
  },
  getCURLDownloadStudent: function (req, res, next) {
    var data = req.body;
    request(cURLConf.CURL_link.download_student_batch + '/' + data.center_code + '/' + data.batch_list, function (error, response, body) {
      if (typeof response === 'undefined') {
        res.status(200).send({ call: 999 });
      } else {
        if (!error && response.statusCode == 200) {
          var json_data = JSON.parse(body);
          // console.log(json_data);
          switch (json_data.call) {
            case 1:
              AdminModel.cleanStudent(res.pool, data)
                .then((result) => {
                  return AdminModel.addBatchToList(res.pool, json_data.exam_student_list);
                })
                .then((result) => {
                  res.status(200).send({ call: 1 });
                })
                .catch((error) => {
                  console.log(error);
                  res.status(200).send({ call: 0, err: error });
                });
              break;
            default:
              res.status(200).send({ call: 5 });
              break;
          }
        } else {
          res.status(response.statusCode).send(body);
        }
      }
    });
  },
  getCURLDownloadExam: function (req, res, next) {
    var data = req.body;
    //console.log(cURLConf.CURL_link.download_exam + '/' + data.id);
    request(cURLConf.CURL_link.download_exam + '/' + data.id, function (error, response, body) {
      if (typeof response === 'undefined') {
        res.status(200).send({ call: 999 });
      } else {
        if (!error && response.statusCode == 200) {
          var json_data = JSON.parse(body);
          switch (json_data.call) {
            case 1:
              AdminModel.cleanPublish(res.pool, json_data.exam_info[0].id)
                .then((data) => {
                  return AdminModel.addPublishList(res.pool, json_data.exam_info);
                })
                .then((data) => {
                  return AdminModel.cleanQuestionPaper(res.pool, json_data.exam_info[0].ptl_test_id);
                })
                .then((data) => {
                  return AdminModel.addQuestionPaper(res.pool, json_data.exam_question);
                })
                .then((data) => {
                  res.status(200).send({ call: 1 });
                })
                .catch((error) => {
                  console.log(error);
                  res.status(200).send({ call: -1, error: error });
                });
              break;
            case 2:
              res.status(200).send({ call: 2 });
              break;
            case 3:
              res.status(200).send({ call: 3 });
              break;
            default:
              res.status(200).send({ call: 0 });
              break;
          }
        } else {
          res.status(response.statusCode).send(body);
        }
      }
    });
  },
  getCURLSendData: function (req, res, next) {
    var data = req.body;
    var send_data = {
      student_list: [],
      exam_paper: [],
      pub_id: data.pub_id,
    };

    AdminModel.getDoneExamsStudentListData(res.pool, data.pub_id)
      .then((res_data) => {
        if (res_data.length == 0) {
          return [];
        } else {
          send_data.student_list = res_data;
          return AdminModel.getDoneExamsStudentExamData(res.pool, data.pub_id);
        }
      })
      .then((result) => {
        if (result.length == 0) {
          return { call: 4 };
        } else {
          send_data.exam_paper = result;
          return AdminModel.uploadResultPerBatch(cURLConf, request, send_data);
        }
      })
      .then((result) => {
        if (result.call == 1) {
          return AdminModel.updatePublishExamUploaded(res.pool, data.pub_id);
        } else {
          return result;
        }
      })
      .then((result) => {
        res.status(200).send(result);
      })
      .catch((error) => {
        res.status(200).send({ call: 0, data: error });
      });
  },
  addRemoteTest: function (req, res, next) {
    var data = req.body;
    AdminModel.addPublishList(res.pool, data.publish_data)
      .then(function (res_data) {
        return AdminModel.addBatchToList(res.pool, data.batch_to_publish);
      })
      .then(function (res_data) {
        return AdminModel.addTestInfo(res.pool, data.test_info);
      })
      .then(function (res_data) {
        return AdminModel.addQuestionPaper(res.pool, data.question_set);
      })
      .then(function (res_data) {
        res.status(200).send({ call: 1 });
      })
      .catch(function (error) {
        console.log(error);
        res.status(200).send(error);
      });
  },
  addRemoteStudent: function (req, res, next) {
    var data = req.body;
    res.status(200).sent(data);
  },
  createDbBackup: function (req, res, next) {
    var data = req.body;
    AdminModel.createDbBackup(res.pool, data)
      .then(function (res_data) {
        try {
          if (fs.existsSync(res_data)) {
            return AdminModel.updateExamIsGen(res.pool, data);
          } else {
            return { call: -1 };
          }
        } catch (error) {
          console.log(error);
          return { call: 0, data: error };
        }
      })
      .then((is_done) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ call: error });
      });
  },
  unsetExam: function (req, res, next) {
    var data = req.body;
    AdminModel.RemoveThisExamData(res.pool, data)
      .then((result) => {
        return AdminModel.updateExamIsDone(res.pool, data);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, 'utr_student_attendance');
      })
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  clearDB: function (req, res, next) {
    var table = responderSet.table_list;
    console.log(table[0]);
    AdminModel.clearTableRecored(res.pool, table[0])
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[1]);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[2]);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[3]);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[4]);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[5]);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[6]);
      })
      .then((result) => {
        return AdminModel.clearTableRecored(res.pool, table[7]);
      })
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  loadStudentListBackToFinal: function (req, res, next) {
    var data = req.body;
    AdminModel.RemoveOldExamData(res.pool, data)
      .then((result) => {
        return AdminModel.loadStudentListBackToFinal(res.pool, data);
      })
      .then((result) => {
        res.status(200).send(result);
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  getExamLockStatus: function (req, res, next) {
    AdminModel.getExamLockStatus(res.pool)
      .then((result) => {
        res.render('admin/exam-lock-list', {
          cc: req.session.Admin.cc,
          student_list: result,
          c_name: req.session.Admin.c_name,
        });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  swExamLockStatus: function (req, res, next) {
    AdminModel.getExamLockStatus(res.pool)
      .then((result) => {
        res.render('admin/sw-exam-lock-list', {
          student_list: result,
        });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },
  markedAsAbsent: function (req, res, next) {
    var data = req.body;
    AdminModel.markAsAbsent(res.pool, data)
      .then((result) => {
        return AdminModel.updateTestAsAbsent(res.pool, data);
      })
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ call: 0, data: error });
      });
  },
  unlockOneUser: function (req, res, next) {
    var data = req.body;
    AdminModel.clearUnlockOneUser(res.pool, data.stud_id)
      .then((result) => {
        return AdminModel.addclearUnlockUserLog(res.pool, data);
      })
      .then((data) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ call: 0, data: error });
      });
  },
  unlockAllUser: function (req, res, next) {
    AdminModel.clearTableRecored(res.pool, 'utr_student_attendance')
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ call: 0, data: error });
      });
  },
  getLiveExamStatus: function (req, res, next) {
    AdminModel.getLiveExamStatus(res.pool)
      .then((result) => {
        res.render('admin/live-exam-status', {
          cc: req.session.Admin.cc,
          student_list: result,
          c_name: req.session.Admin.c_name,
        });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send(error);
      });
  },

  getUploadBannerView: function (req, res, next) {
    res.render('admin/upload-banner-view.pug', {
      cc: req.session.Admin.cc,
      c_name: req.session.Admin.c_name,
    });
  },

  postUploadBanner: function (req, res, next) {
    let bannerImage = req.files.banner;
    console.log(bannerImage);
    let fileName = `bannerImage.${bannerImage.name.split('.')[1]}`;

    bannerImage.mv(`./public/img/banner-image/${fileName}`, function (err) {
      if (err) {
        return res.status(200).json({
          call: 0,
        });
      } else {
        return res.status(200).json({
          call: 1,
        });
      }
    });
  },

  clearThisExamSession: function (req, res, next) {
    var data = req.body;
    AdminModel.clearExamFormPublish(res.pool, data.pub_id)
      .then((result) => {
        return AdminModel.clearExamFormStudentList(res.pool, data.batch_no);
      })
      .then((result) => {
        return AdminModel.clearExamFormStudentTestList(res.pool, data.pub_id);
      })
      .then((result) => {
        return AdminModel.clearExamFormStudentQuestionPaper(res.pool, data.pub_id);
      })
      .then((result) => {
        res.status(200).send({ call: 1 });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ call: 0, data: error });
      });
  },
  getValueListPost: (request, response) => {
    AdminModel.getValueListFromDbPost(response.pool)
      .then((result) => {
        response.render('admin/get-value-list-post', {
          list: result,
          batch: 'All',
        });
      })
      .catch((error) => {
        console.log(error);
        response.status(200).send({ call: 0, data: error });
      });
  },
  getValueList: (request, response) => {
    let { id } = request.params;
    AdminModel.getValueListFromDb(response.pool, id)
      .then((result) => {
        response.render('admin/get-value-list', {
          list: result,
          batch: 'All',
        });
      })
      .catch((error) => {
        console.log(error);
        response.status(200).send({ call: 0, data: error });
      });
  },
  setValueList: (request, response) => {
    let data = request.body;
    AdminModel.setUpdateNull(response.pool, Number(data.id))
      .then((result) => {
        // console.log(result);
        return AdminModel.setUpdateAccept(response.pool, data.id, Number(data.c));
      })
      .then((result) => {
        console.log(result);
        return AdminModel.setUpdateMoreAccept(response.pool, data.id, Number(data.i));
      })
      .then((result) => {
        console.log(result);
        response.redirect('/admin/get-value');
      })
      .catch((error) => {
        console.log(error);
        response.status(200).send({ call: 0, data: error });
      });
  },
};

module.exports = adminController;

// {"id":"100191","c":"30","i":"60"}
