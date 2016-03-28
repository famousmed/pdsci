function jboxTip(tip){
	var d = dialog({
		padding:20,
		content:tip
	});
	d.show();
	setTimeout(function(){
		d.close().remove();
	},2000);
}


function jboxConfirmBasic(msg,funcOk,funcCancel,width){
	  dialog({
		fixed: true,
		width:width,
	    title: '提示',
	    cancelValue:'关闭',
	    content: msg,
	    backdropOpacity:0.1,
	    button:[
	         {
	        	 value: '确定',
	             callback:funcOk,
	             autofocus: true
	         }, 
	         {
	        	 value: '取消',
	             callback:funcCancel
	         }
	    ]
	}).showModal();
}

function jboxConfirm(msg,funcOk,funcCancel){
	jboxConfirmBasic(msg,funcOk,funcCancel, 300);
}
function jboxInfo(info){
	var d = dialog({
		fixed: true,
		width:300,
	    title: '提示',
	    cancelValue:'关闭',
	    content: info,
	    button:[
	         {
	        	 value: '确定',
	             callback:function(){
	            	 d.close().remove();
	             },
	             autofocus: true
	         }
	    ]
	});
	d.show();
}

function jboxOpen(url,title,width,height,showClose){
	top.dialog({
		id:'openDialog',
		fixed: true,
		padding: 5,
		title: title,
		url: url,
		width:width,
		height:height,
		cancelDisplay: showClose,
	    cancelValue: '关闭',
	    backdropOpacity:0.1
	}).showModal();
}

function jboxOpenContent(content , title , width,height,showClose){
	if(showClose!=false){
		showClose = true;
	}
	top.dialog({
		id:'openDialog',
		fixed: true,
		padding: 5,
		title: title,
		content: content,
		width:width,
		height:height,
		cancelDisplay: showClose,
	    cancelValue: '关闭',
	    backdropOpacity:0.1
	}).showModal();
}


function dialogClose(dialogId){
	var myDialog = dialog.get(dialogId);
	if(myDialog!=null&&myDialog.open){
		myDialog.close().remove();
	}
}
function jboxClose(){
	var openDialog = top.dialog.get('openDialog');
	if(openDialog!=null&&openDialog.open){
		openDialog.close().remove();
	}
}
function jboxDelayClose(){
	var openDialog = top.dialog.get('openDialog');
	if(openDialog!=null&&openDialog.open){
		setTimeout(function(){
			openDialog.close().remove();
		},2000);
	}
}
function jboxBubble(targetId,content,direction,quickClose){
	dialog({
		id:'bubbleDialog',
		padding:11,
	    content: content,
	    align: direction,//方向
	    quickClose: quickClose// 点击空白处快速关闭
	}).show(document.getElementById(targetId));
}
function jboxBubbleClose(){
	dialogClose('bubbleDialog');
}
function jboxStartLoading(){
	dialog({
		id:'loadingDialog',
		width: 40,
		height: 40,
		backdropOpacity:0.1
	}).showModal(); 
}
function jboxEndLoading(){
	dialogClose('loadingDialog');
}
////////////////////////////ajax 相关 ///////////////////////////
function jboxGet(geturl,getdata,funcOk,funcErr,showResp){
	$.ajax({
		type : "get",
		url : geturl,
		data : getdata,
		cache : false,
		success : function(resp) {
			if(showResp==false){
				
			}else{
				jboxTip(resp);					
			}
			if(funcOk!=null){
				funcOk(resp);				
			}				
		},
		error : function() {
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		}
	});
}
function jboxLoad(id,geturl,showLoading){
	$.ajax({
		type : "get",
		url : geturl,
		cache : false,
		beforeSend : function(){
			if(showLoading){
				jboxStartLoading();
			}
		},
		success : function(resp) {
			$("#"+id).html(resp);		
		},
		error : function() {
		},
		complete : function(){
			if(showLoading){
				jboxEndLoading();				
			}
		}
	});
}

function jboxPostLoad(id,geturl,data,showLoading){
	$.ajax({
		type : "post",
		url : geturl,
		data:data,
		cache : false,
		beforeSend : function(){
			if(showLoading){
				jboxStartLoading();
			}
		},
		success : function(resp) {
			$("#"+id).html(resp);		
		},
		error : function() {
		},
		complete : function(){
			jboxEndLoading();
		}
	});
}

function jboxPost(posturl,postdata,funcOk,funcErr,showResp){
	$.ajax({
		type : "post",
		url : posturl,
		data : postdata,
		cache : false,
		success : function(resp) {
			if(showResp==false){
				
			}else{
				jboxTip(resp);					
			}
			if(funcOk!=null){
				funcOk(resp);				
			}				
		},
		error : function() {
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		}
	});
}
function jboxSubmit(jqForm,posturl,funcOk,funcErr,showResp){
	var options = {
		url : posturl,
		type : "post", 
		cache : false,
		success : function(resp) {
			if(showResp==false){
				
			}else{
				jboxTip(resp);					
			}
			if(funcOk!=null){
				funcOk(resp);				
			}				
		},
		error : function() {
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		iframe : true
	};
	jqForm.ajaxSubmit(options);
}

function jboxPostJson(posturl,postdata,funcOk,funcErr,showResp){
	$.ajax({
		type : "post",
		url : posturl,
		//dataType:"json",      
        contentType:"application/json",
		data : postdata,
		cache : false,
		success : function(resp) {
			if(showResp==false){
				
			}else{
				jboxTip(resp);					
			}
			if(funcOk!=null){
				funcOk(resp);				
			}				
		},
		error : function() {
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		}
	});
}


