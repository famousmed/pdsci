function fill_answer_q_single(qmodel, answer){
    var question = qmodel.question;
    if (question.custom_attr["disp_type"] !== "dropdown"){
        var option_id = answer[0];
        var option_element = $("#option_" + option_id);
        get_parent(option_element, "span").find("a").click();
        if (answer.length > 1){
            $("#option_open_"+option_id).val(answer[1]);
        }
    }else{
        var qdiv = $("#question_" + qmodel.qid);
        qdiv.find("select").val(answer[0]);
    }
}

function fill_answer_q_multiple(qmodel, answer){
    for (var i = 0; i < answer.length; i++) {
        var item = answer[i];
        var option_id = item[0];
        var option_element = $("#option_" + option_id);
        get_parent(option_element, "span").find("a").click();
        if (item.length > 1){
            $("#option_open_"+option_id).val(item[1]);
        }
    }
}

function fill_answer_q_blank(qmodel, answer){
    for(var option_id in answer){
        var rel_oid = option_id.replace("_open", "");
        $("#" + rel_oid).val(answer[option_id]);
    }
}

function fill_answer_q_score(qmodel, answer){
    for (var option_id in answer){
        var score_td = $("#option_"+option_id);
        var score_table = get_parent(score_td, "tr").find(".table_score");
        var score = answer[option_id][0];
        score_table.find("td:contains("+score+").div_float").click();
    }
}

function fill_answer_q_multiple_blank(qmodel, answer){
    for(var option_id in answer){
        var rel_oid = option_id.replace("_open", "");
        $("#option_" + rel_oid).val(answer[option_id]);
    }
}

function fill_answer_q_image_single(qmodel, answer){
    var option_id = answer[0];
    var option_element = $("#option_" + option_id);
    get_parent(option_element, "span").find("a").click();
}

function fill_answer_q_blank_drop(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for (var i = 0; i < qmodel.question.option_id_list.length; i++) {
        var option_id = qmodel.question.option_id_list[i];
        var key = option_id + "_open";
        $("#"+option_id).val(answer[key]);
        $("#"+option_id).change();
    }
}

function fill_answer_q_sort(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for(var option_id in answer){
        var label = qdiv.find("label[id='"+option_id+"']");
        var index = answer[option_id][0];
        var new_label = label.clone(true);
        new_label.attr("site", index).attr("name", index);
        qdiv.find(".pxlist td:eq("+(index-1)+")").append(new_label);
        label.empty().remove();
    }
}

function fill_answer_q_blank_upload(qmodel, answer){
    var save_key;
    for(var option_key in answer){
        save_key = answer[option_key];
    }
    var key = save_key.split("|")[0];
    var orig_fname = save_key.split("|")[1];
    var qdiv = $("#question_"+qmodel.qid);
    var file_input = qdiv.find("input:file");
    file_input.unbind();
    //$("#upload_btn_"+qmodel.qid).hide();
    // $("#delete_btn_"+qmodel.qid).show();
    $("#filename_"+qmodel.qid).show().text(orig_fname);
    /*
	$("#reupload_btn_"+qmodel.qid).show();
    $("#reupload_btn_"+qmodel.qid).click(function(){
        var qdiv = $(this).parents("div .question");
        qdiv.find("input:file").click();
    })
	*/
	
    file_input.change(function(){
        var qdiv = $(this).parents("div .question");
        var qid = qdiv.attr("id").split("_")[1];
        var answer = total_answers[qid];
        var orig_key;
        for(var option_key in answer){
            orig_key = answer[option_key];
        }
        var file_name = orig_key.split("/")[2].split("|")[0];
		file_name = new UUID();
		file_name = file_name.toString();
		file_name = file_name.substring(0, 12) + '-' + file_name.substring(12);
        if ($(this).val() != ""){
            upload_file(this.id, get_oid(project), qid, file_name);
        }
    });
	
    // $("#delete_btn_"+qmodel.qid).click(function(){
    //     if (confirm("确认要删除吗?")){
    //         var qdiv = $(this).parents("div .question");
    //         var qid = qdiv.attr("id").split("_")[1];
    //         var answer = total_answers[qid];
    //         var orig_key;
    //         for(var option_key in answer){
    //             orig_key = answer[option_key];
    //         }
    //         ajaxPost("/f/del_cloud_file", {"orig_key": orig_key}, function(ret){
    //             alert("删除成功");
    //         })
    //     }
    // })
}

function UUID(){this.id=this.createUUID()}UUID.prototype.valueOf=function(){return this.id};UUID.prototype.toString=function(){return this.id};UUID.prototype.createUUID=function(){var c=new Date(1582,10,15,0,0,0,0);var f=new Date();var h=f.getTime()-c.getTime();var i=UUID.getIntegerBits(h,0,31);var g=UUID.getIntegerBits(h,32,47);var e=UUID.getIntegerBits(h,48,59)+"2";var b=UUID.getIntegerBits(UUID.rand(4095),0,7);var d=UUID.getIntegerBits(UUID.rand(4095),0,7);var a=UUID.getIntegerBits(UUID.rand(8191),0,7)+UUID.getIntegerBits(UUID.rand(8191),8,15)+UUID.getIntegerBits(UUID.rand(8191),0,7)+UUID.getIntegerBits(UUID.rand(8191),8,15)+UUID.getIntegerBits(UUID.rand(8191),0,15);return i+g+e+b+d+a};UUID.getIntegerBits=function(f,g,b){var a=UUID.returnBase(f,16);var d=new Array();var e="";var c=0;for(c=0;c<a.length;c++){d.push(a.substring(c,c+1))}for(c=Math.floor(g/4);c<=Math.floor(b/4);c++){if(!d[c]||d[c]==""){e+="0"}else{e+=d[c]}}return e};UUID.returnBase=function(c,d){var e=["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];if(c<d){var b=e[c]}else{var f=""+Math.floor(c/d);var a=c-f*d;if(f>=d){var b=this.returnBase(f,d)+e[a]}else{var b=e[f]+e[a]}}return b};UUID.rand=function(a){return Math.floor(Math.random()*a)};

function fill_answer_q_date(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    var date_input = qdiv.find(".option");
    var date_answer;
    for(var key in answer){
        date_answer = answer[key];
        break;
    }
    date_input.val(date_answer);
}

function fill_answer_q_time(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for(var key in answer){
        var option_id = key.replace("_open", "");
        $("#option_"+option_id).val(answer[key]);
    }
}

function fill_answer_q_matrixsingle(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for(var row_id in answer){
        var option_id = answer[row_id][0];
        var open_content = answer[row_id].length > 1 ? answer[row_id][1] : null;
        $("#option_"+row_id+"_"+option_id).prev().click();
        if (isNotEmpty(open_content)){
            $("#open_"+row_id+"_"+option_id).val(open_content);
        }
    }
}

function fill_answer_q_matrixmultiple(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for(var row_id in answer){
        var row_select = answer[row_id];
        for (var i = 0; i < row_select.length; i++) {
            var option_id = row_select[i][0];
            var open_content = row_select[i].length > 1 ? row_select[i][1] : null;
            $("#option_"+row_id+"_"+option_id).prev().click();
            if (isNotEmpty(open_content)){
                $("#open_"+row_id+"_"+option_id).val(open_content);
            }
        }
    }
}

function fill_answer_q_matrixblank(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for(var row_id in answer){
        var row_answer = answer[row_id];
        for(var option_id in row_answer){
            var open_content = row_answer[option_id];
            $("#open_"+row_id+"_"+option_id).val(open_content);
        }
    }
}

function fill_answer_q_matrixscore(qmodel, answer){
    var qdiv = $("#question_"+qmodel.qid);
    for(var row_id in answer){
        var row_answer = answer[row_id];
        for(var option_id in row_answer){
            var score = row_answer[option_id];
            score = parseInt(score);
            $("#option_"+row_id+"_"+option_id+" img:eq("+(score-1)+")").click();
        }
    }
}

var FILL_ANSWER_FUNC_MAP = {};
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_SINGLE] = fill_answer_q_single;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_MULTIPLE] = fill_answer_q_multiple;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_BLANK] = fill_answer_q_blank;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_SCORE] = fill_answer_q_score;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_MULTIPLE_BLANK] = fill_answer_q_multiple_blank;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_BLANK_DROPDOWN] = fill_answer_q_blank_drop;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_ORDER] = fill_answer_q_sort;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_MATRIX_SINGLE] = fill_answer_q_matrixsingle;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_MATRIX_MULTIPLE] = fill_answer_q_matrixmultiple;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_MATRIX_BLANK] = fill_answer_q_matrixblank;
FILL_ANSWER_FUNC_MAP[QUESTION_TYPE_MATRIX_SCORE] = fill_answer_q_matrixscore;
FILL_ANSWER_FUNC_MAP["upload_file"] = fill_answer_q_blank_upload;
FILL_ANSWER_FUNC_MAP["date"] = fill_answer_q_date;
FILL_ANSWER_FUNC_MAP["time"] = fill_answer_q_time;