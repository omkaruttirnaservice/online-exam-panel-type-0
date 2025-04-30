var exam_list = []; 
var new_exam_list = [];
$(function(){
    getAllExamList();
    $('#get-exam-list').on('click',function(){
        test_id_list = [];
        test_id_list = exam_list.map(function(data){
            return data.id;
        });
       $.post(getUrl()+'get-exam-list',{exam_list:JSON.stringify(test_id_list)},
           function(data, status){
                if(status == 'success'){
                    if(typeof data === 'object'){
                        var _json = data;
                    }else{
                        var _json = JSON.parse(data);
                    }
                    
                    if(_json.call == 1){
                        LoadExamList(_json.data,'#new_exams_list_tbody',2);
                    }else{
                        if(_json.call == 999){
                            alert('Master Server Not Found');
                        }else{
                            alert('Exam Not Found On Master Server');
                        }
                        
                    }
                }else{
                    alert('Master Server Not Found');
                }
           }).
        error(function(error){
            alert('Server Error');
            console.log(error);
        });
    })
});

// functions 
function getAllExamList(){
    $.get(getUrl()+'get-all-exam-list',
           function(data, status){
                if(status == 'success'){
                    var _json = data;
                    if(_json.call == 1){
                        LoadExamList(_json.data,'#done_exams_list_tbody',1);
                    }
                }else{
                    alert('Master Server Error');
                }
           }).
        error(function(error){
            alert('Error');
            console.log(error);
        });
}
function LoadExamList(list,table_name,type){
    exam_list = list;
    if(list.length > 0){
        $(table_name).html('');
        list.forEach(function(value,index) {
            var _tr = '<tr>';
            if(type == 1){
                _tr += '<td>'+(index+1)+'</td>'+
                        '<td>'+value.mt_name+'</td>';
                if(value.ptl_is_test_done == '1'){
                    _tr +=  '<td><label class="btn-warning btn-sm" style="margin-right:10px;">Done!</label>'+
                            '<td>'+value.mt_test_time +' Min</td>'+
                            '<td>Batch-'+value.tm_allow_to+'</td>';
                }else{
                    if(value.is_test_loaded == '1'){
                        _tr +=  '<td><label  class="btn-success btn-sm" style="margin-right:10px;">'+value.ptl_link_1+'</label>'+
                                '<td>'+value.mt_test_time +' Min</td>'+
                                '<td>Batch-'+value.tm_allow_to+'</td>';
                    }else{
                        _tr +=  '<td><center><label  class=""  title="'+value.ptl_link_1+'"><i class="text-success fa fa-history fa-2x"></i><center></label>'+
                                '<td>'+value.mt_test_time +' Min</td>'+
                                '<td>Batch-'+value.tm_allow_to+'</td>';
                    }
                }
                        
            
                if(value.is_test_loaded == '1'){
                    if(value.is_start_exam == '1'){
                         if(value.is_test_generated == '1'){
                            _tr +=  '<td><center><i class="text-success fa fa-check-square-o fa-2x"></i></center></td>'+
                                    '<td><center><i class="text-warning fa fa-check-square-o fa-2x"></i></center></td>'+
                                    '<td><center><i class="text-primary fa fa-check-square-o fa-2x"></i></center></td>'+
                                    '';
                            }else{
                                _tr +=  '<td><center><i class="text-success fa fa-check-square-o fa-2x"></i></center></td>'+
                                '<td><button type="button" class="btn btn-primary btn-sm" onclick="takeExamBackup('+value.id+','+value.tm_allow_to+','+cc+')">End Slot & Backup</button></td>'+
                                '<td><center><i class="text-danger fa fa-hourglass-o fa-2x"></i></center></td>';
                            }
                        }else{
                            _tr += '<td><button type="button" class="btn btn-success btn-sm" onclick="activeExam('+value.id+')">Start Exam</button></td>'+
                                    '<td><center><i class="text-danger fa fa-hourglass-o fa-2x"></i></center></td>'+
                                    '<td><center><i class="text-danger fa fa-hourglass-o fa-2x"></i></center></td>';
                        }
                    }else{
                        _tr += '<td><button type="button" class="btn btn-primary btn-sm" onclick="activeSession('+value.id+')">Start Session</button></td>'+
                        '<td><center><i class="text-danger fa fa-hourglass-o fa-2x"></i></center></td>'+
                        '<td><center><i class="text-danger fa fa-hourglass-o fa-2x"></i></center></td>';
                    }
            if(value.is_start_exam == '1'){
                if(value.is_absent_mark == '1'){
                    _tr +='<td><center><i class="text-danger fa fa-check-circle fa-2x"></i></center></td></tr>';
                }else{
                    _tr +='<td><center><button type="button" class="btn btn-danger btn-sm" style="margin-right:10px;" onclick=markStudentAsAbsent(this,event,'+value.id+','+value.tm_allow_to+')>Mark Batch-'+value.tm_allow_to+' Absent </button></center></td></tr>';
                }
            }else{
                _tr +='<td><center><i class="text-danger fa fa-hourglass-o fa-2x"></i></center></td></tr>';
            }
               /* if(value.is_test_loaded == '1'){
                    _tr +=  '<td><button type="button" class="btn btn-success btn-sm" onclick="downloadStudent('+value.id+','+value.tm_allow_to+')">re-download</button></td>'+
                            '<td><button type="button" class="btn btn-info btn-sm" onclick="showExamStudentList('+value.id+')">view</button></td>'+       
                            '</tr>';
                }else{
                    _tr += '<td><button type="button" class="btn btn-info btn-sm" onclick="downloadStudent('+value.id+','+value.tm_allow_to+')">download</button></td>'+
                            '<td>-</td>'+       
                            '</tr>';
                }*/
                
            }else{
                
                _tr += '<td>'+(index+1)+'</td>'+
                        '<td>'+value.mt_name+'</td>'+
                        '<td>'+value.mt_test_time +' Min</td>'+
                        '<td>Batch-'+value.tm_allow_to+'</td>';
            
                new_exam_list = list;
                 $('#new_exams_list_table').removeClass('hide');
                _tr +=  '<td><button type="button" class="btn btn-primary btn-sm" onclick="downloadExam('+value.id+','+index+')">Download</button></td>'+
                        '</tr>';
                }
            $(table_name).append(_tr);
        });
        
    }else{
        $('#new_exams_list_table').addClass('hide');
        $(table_name).html('<tr><td colspan="7" style="text-align:center"> No Exams Found</td></tr>');
    }
}
function markStudentAsAbsent(_this,event,id,batch_no){
    prompt('Enter Authentication Password','*******','password',function(value){
        if(parseInt(value,10) !== cc) {
            alert('Invalid Password !!!!');
            return false;
        }
        
        addLoading();
        $.post(getUrl()+'marked-as-absent',{pub_id:id,batch_no:batch_no},
                function(data, status){
                    removeLoading();
                    if(status == 'success'){
                        if(typeof data === 'object'){
                            var _json = data;
                        }else{
                            var _json = JSON.parse(data);
                        }
                        if(_json.call == 1){
                            getAllExamList();
                        }else{
                            if(_json.call == 999){
                                alert('Master Server Not Found');
                            }else{
                                alert('Exam Not Found On Master Server');
                            }
                        }
                    }else{
                        alert('Master Server Not Found');
                    }
                }).
            error(function(error){
                removeLoading();
                alert('Server Error');
                console.log(error);
            });
    });
}
function showExamStudentList(pub_id){
    window.location="/admin/student-list/"+pub_id;
}
function downloadExam(id, index){
        prompt('Enter Authentication Password','*******','password',function(value){
            if(parseInt(value,10) !== cc) {
                alert('Invalid Password !!!!');
                return false;
            }
        addLoading();
       
        $.post(getUrl()+'download-exam',{id:id},
        function(data, status){
                removeLoading();
                if(status == 'success'){
                    var _json = data;
                    switch (_json.call) {
                        case -1:
                            alert('Internal Query Error');
                            break;
                        case 3:
                            alert('Question Paper Not Found');
                        break;
                        case 2:
                            alert('Exam Not Found');
                        break;
                        case 1:
                            alert('Exam Added Successfully');
                            getAllExamList();
                            new_exam_list = new_exam_list.filter(function(ele){
                                return ele.id != id;
                            });
                            LoadExamList(new_exam_list,'#new_exams_list_tbody', 2);
                        break;
                        case 999:
                                alert('Master Server Not Found.');
                            break;
                    
                        default:
                            break;
                    }
                }else{
                    alert('Server Error');
                }
        })
    })
}

function downloadStudent(pub_id,student_type){
    $.post(getUrl()+'download-student',{student_type:student_type,pub_id:pub_id},
        function(data, status){
            if(status == 'success'){
                var _json = data;
                switch (_json.call) {
                    case 0:
                        alert("Fail.. Try Again.");
                        break;
                    case 1:
                        alert("Student Downloaded Successfully.");
                        getAllExamList();
                        break;
                }
            }
        });
}

function activeSession(pub_id){
    $.post(getUrl()+'/startExamSession',{pub_id:pub_id},
        function(data, status){
            if(status == 'success'){
                var _json = data;
                switch (_json.call) {
                    case 0:
                        alert("Fail.. Try Again.");
                        break;
                    case 1:
                        alert("Session Started Successfully.");
                        getAllExamList();
                        break;
                }
            }
        });
}
function activeExam(pub_id){
    prompt('Enter Authentication Password','*******','password',function(value){
        if(parseInt(value,10) !== cc) {
            alert('Invalid Password !!!!');
            return false;
        }
            $.post(getUrl()+'/loadExam',{pub_id:pub_id},
                function(data, status){
                    if(status == 'success'){
                        var _json = data;
                        switch (_json.call) {
                            case 0:
                                alert("Fail.. Try Again.");
                                break;
                            case 1:
                                alert("Exam Started Successfully.");
                                getAllExamList();
                                break;
                        }
                    }
                });
    });
}

function takeExamBackupSql(pub_id,batch_no,cc){
    addLoading();
    $.post(getUrl()+'/exam-backup-sql',
        {
            pub_id:pub_id,
            batch_no:batch_no,
            cc:cc,
        },
        function(data, status){
            removeLoading();
            if(status == 'success'){
                var _json = data;
                switch (_json.call) {
                    case 0:
                        alert("Fail.. Try Again.");
                        break;
                    case 1:
                        alert("Backup Created Successfully.");
                        unsetExam(pub_id,batch_no,cc)
                        break;
                }
            }
        });
    
}
function unsetExam(pub_id,batch_no,cc){
    addLoading();
    $.post(getUrl()+'/unset-exam',
    {
        pub_id:pub_id,
        batch_no:batch_no,
        cc:cc,
    },
    function(data, status){
        removeLoading();
        if(status == 'success'){
            var _json = data;
            switch (_json.call) {
                case 0:
                    alert("Fail.. Try Again.");
                    break;
                case 1:
                    alert("Exam Stopped Successfully.");
                    getAllExamList();
                    break;
                default:
                    alert("Server Error, Try Again");
                break;
            }
        }
    });
}
function takeExamBackup(pub_id,batch_no,cc){
    confirmCall("Is Scheduled Exam Completed ?", function ($this_data, type, ev) {
        if (type == 'yes') {
            confirmCall("Are You Sure To Create Backup ?", function ($this_data, type, ev) {
                if (type == 'yes') {
                prompt('Enter Authentication Password','*******','password',function(value){
                    if(parseInt(value,10) !== cc) {
                        alert('Invalid Password !!!!');
                        return false;
                    }
                    addLoading();
                        $.post(getUrl()+'/exam-backup', {
                            pub_id:pub_id,
                            batch_no:batch_no,
                            cc:cc,
                        },
                        function(data, status){
                            removeLoading();
                            if(status == 'success'){
                                var _json = data;
                                switch (_json.call) {
                                    case 0:
                                        alert("Fail.. Try Again.");
                                        break;
                                    case 1:
                                        alert("Exam Saved Successfully.... Click Ok To Take Backup");
                                        takeExamBackupSql(pub_id,batch_no,cc);
                                        break;
                                    case 2:
                                        alert("Student Records Not Found For Backup.");
                                    break;
                                    default:
                                        alert("Server Error, Try Again");
                                    break;
                                }
                            }
                        });
                    });
                }
                
            });
        }
    });
} 