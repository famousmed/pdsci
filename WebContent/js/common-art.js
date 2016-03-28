//////////////////// art相关  ////////////////////////
function jboxStartLoading(){
	if(window.parent.frames['mainIframe']!=null){
		top.dialog({
			id:'artLoading',
		    backdropOpacity: 0.1,
			width: 40,
			height: 40
		}).showModal(); 
	}else{
		dialog({
			id:'artLoading',
		    backdropOpacity: 0.1,
			width: 40,
			height: 40
		}).showModal(); 
	}
	jboxCenter();
}
function jboxEndLoading(){
	_dialogClose('artLoading');
}
function _dialogClose(dialogId){
	var myDialog = top.dialog.get(dialogId);
	if(myDialog!=null&&myDialog.open){
		top.$("[name='jbox-iframe']").attr("name","");
		myDialog.close().remove();
	}
}
function jboxCenter(){
	if(window.parent.frames['mainIframe']!=null){
		var jboxs = $(window.parent.document).find(".ui-dialog");
		$.each(jboxs , function(i,jbox){ 
			$(jbox).parent().position({
				   my: "center",
				   at: "center",
				   of: $("body",window.parent.document),
				   within: $("body",window.parent.document)
				});	
		});
	}else{
		var jboxs = $(window.document).find(".ui-dialog");
		$.each(jboxs , function(i,jbox){ 
			$(jbox).parent().position({
				   my: "center",
				   at: "center",
				   of: $("body",window.document),
				   within: $("body",window.document)
				});		
		});
	}

}
function jboxContentClose(){
	_dialogClose('openDialog');
}
function jboxClose(){
	_dialogClose('jbox-iframe');
}
function jboxTip(tip){
	if(window.parent.frames['mainIframe']!=null){
		var d = top.dialog({
			id:"artTip",
			padding:5,
			content:tip,
		    backdropOpacity: 0.1
		});
		d.show();
		setTimeout(function(){
			d.close().remove();
		},2000);
	}else{
		var d = dialog({
			id:"artTip",
			padding:5,
			content:tip,
		    backdropOpacity: 0.1
		});
		d.show();
		setTimeout(function(){
			d.close().remove();
		},2000);
	}
	jboxCenter();
}
function jboxMessager(url,title,width,height,id,showClose){
	if(id==null){
		id = "jbox-message-iframe";
	}
	var newUrl = $(url).attr("src");
	newUrl+=(newUrl+(newUrl.indexOf('?')>-1?"&":"?")+"time="+new Date());
//	if(newUrl.indexOf('?')>-1){
//		newUrl = newUrl+"&time="+new Date();
//	}else{
//		newUrl = newUrl+"?time="+new Date();
//	}	
	$(url).attr("src",newUrl);
	if(showClose!=false){
		showClose = true;
	}
	if(window.parent.frames['mainIframe']!=null){
		top.dialog({
			id:'jbox-message-iframe',
			align: 'bottom right',
			fixed: true,
			padding: 5,
			title: title,
			content: url,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		        return true;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.top.window.document).remove();
		}
	}else{
		dialog({
			id:'jbox-message-iframe',
			align: 'bottom right',
			fixed: true,
			padding: 5,
			title: title,
			content: url,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		        return true;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.document).remove();
		}
	}
}
function jboxCloseMessager(){
	if(window.parent.frames['mainIframe']!=null){
		var openDialog = top.dialog.get('jbox-message-iframe');
		if(openDialog!=null&&openDialog.open){
			openDialog.close().remove();
		}
	}else{
		var openDialog = dialog.get('jbox-message-iframe');
		if(openDialog!=null&&openDialog.open){
			openDialog.close().remove();
		}
	}
}
function jboxInfoBasic(info,width){
	if(window.parent.frames['mainIframe']!=null){
		var d = top.dialog({
			id:"artInfo",
			fixed: true,
			width:width,
		    title: '提示',
		    cancelValue:'关闭',
		    content: info,
		    backdropOpacity:0.1,
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
	}else{
		var d = dialog({
			id:"artInfo",
			fixed: true,
			width:width,
		    title: '提示',
		    cancelValue:'关闭',
		    content: info,
		    backdropOpacity:0.1,
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
	jboxCenter();
}

function jboxInfo(info){
	jboxInfoBasic(info,300);
}
function jboxError(error){
	if(window.parent.frames['mainIframe']!=null){
		var d = top.dialog({
			id:"artError",
			fixed: true,
			width:300,
		    title: '错误',
		    cancelValue:'关闭',
		    content: error,
		    backdropOpacity:0.1,
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
	}else{
		var d = dialog({
			id:"artError",
			fixed: true,
			width:300,
		    title: '错误',
		    cancelValue:'关闭',
		    content: info,
		    backdropOpacity:0.1,
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
	jboxCenter();
}
function jboxConfirm(msg,funcOk,funcCancel){
	if(window.parent.frames['mainIframe']!=null){
		  top.dialog({
			fixed: true,
			width:300,
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
	}else{
		  dialog({
			fixed: true,
			width:300,
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
	jboxCenter();
}
function jboxOpen(url,title,width,height,showClose){
	if(showClose!=false){
		showClose = true;
	}
	if(url.indexOf('?')>-1){
		url = url+"&time="+new Date();
	}else{
		url = url+"?time="+new Date();
	}	
	if(window.parent.frames['mainIframe']!=null){
		top.dialog({
			id:'jbox-iframe',
			fixed: true,
			padding: 5,
			title: title,
			url: url,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		        return showClose;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.top.window.document).remove();
		}
	}else{
		dialog({
			id:'jbox-iframe',
			fixed: true,
			padding: 5,
			title: title,
			url: url,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		        return showClose;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.document).remove();
		}
	}
	jboxCenter();
}

function jboxOpenContent2(content , title , width,height,showClose){
	if(showClose!=false){
		showClose = true;
	}
	dialog({
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

function jboxOpenContent(content , title , width,height,showClose){
	if(showClose!=false){
		showClose = true;
	}
	if(window.parent.frames['mainIframe']!=null){
		top.dialog({
			id:'openDialog',
			fixed: true,
			padding: 5,
			title: title,
			content: content,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		    	if(window.top.frames['jbox-iframe']){
		    		$(window.top.frames['jbox-iframe']).remove();
		    	}
		        return showClose;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.top.window.document).remove();
		}
	}else{
		dialog({
			id:'openDialog',
			fixed: true,
			padding: 5,
			title: title,
			content: content,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		    	if(window.top.frames['jbox-iframe']){
		    		$(window.top.frames['jbox-iframe']).remove();
		    	}
		        return showClose;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.document).remove();
		}
	}
	jboxCenter();
}
//////////////////////////// ajax 相关 ///////////////////////////
function jboxGet(geturl,getdata,funcOk,funcErr,showResp){
	if(showResp!=false){
		showResp = true;
	}
	$.ajax({
		type : "get",
		url : geturl,
		data : getdata,
		cache : false,
		beforeSend : function(){
			jboxStartLoading();
		},
		success : function(resp) {
			jboxEndLoading();
			if(showResp){
				jboxTip(resp);
			}
			if(funcOk!=null){
				if(showResp){
					setTimeout(function(){
						funcOk(resp);
					},1000);
				}else{
					funcOk(resp);
				}
			}				
		},
		error : function() {
			jboxEndLoading();
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		complete : function(){
			jboxEndLoading();
		}
	});
}
function jboxScript(geturl,funcOk){
	jboxStartLoading();
	$.getScript(geturl).done(function(script, textStatus) {
		funcOk();
	})
	.fail(function(jqxhr, settings, exception) {
		 console.log( exception );
	})
	.complete(function(){
		
	});
	jboxEndLoading();
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

function jboxLoadPost(id,geturl,showLoading){
	$.ajax({
		type : "post",
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

function jboxPost(posturl,postdata,funcOk,funcErr,showResp){
	if(showResp!=false){
		showResp = true;
	}
	$.ajax({
		type : "post",
		url : posturl,
		data : postdata,
		cache : false,
		beforeSend : function(){
			jboxStartLoading();
		},
		success : function(resp) {
			jboxEndLoading();
			if(showResp){
				jboxTip(resp);
			}
			if(funcOk!=null){
				if(showResp){
					setTimeout(function(){
						funcOk(resp);
					},1000);
				}else{
					funcOk(resp);
				}

			}				
		},
		error : function() {
			jboxEndLoading();
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		complete : function(){
			jboxEndLoading();
		}
	});
}
function jboxPostNoLoad(posturl,postdata,funcOk,funcErr,showResp){
	if(showResp!=false){
		showResp = true;
	}
	$.ajax({
		type : "post",
		url : posturl,
		data : postdata,
		cache : false,
		beforeSend : function(){
		},
		success : function(resp) {
			jboxEndLoading();
			if(showResp){
				jboxTip(resp);
			}
			if(funcOk!=null){
				if(showResp){
					setTimeout(function(){
						funcOk(resp);
					},1000);
				}else{
					funcOk(resp);
				}

			}				
		},
		error : function() {
			jboxEndLoading();
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		complete : function(){
		}
	});
}
function jboxSubmit(jqForm,posturl,funcOk,funcErr,showResp){
	if(showResp!=false){
		showResp = true;
	}
	var options = {
		url : posturl,
		type : "post", 
		cache : false,
		beforeSend : function(){
			jboxStartLoading();
		},
		success : function(resp) {
			jboxEndLoading();
			if(showResp){
				jboxTip(resp);
			}
			if(funcOk!=null){
				if(showResp){
					setTimeout(function(){
						funcOk(resp);
					},1000);
				}else{
					funcOk(resp);
				}
			}				
		},
		error : function() {
			jboxEndLoading();
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		complete : function(){
			jboxEndLoading();
		},
		iframe : true
	};
	jqForm.ajaxSubmit(options);
}

function jboxSubmitNoLoad(jqForm,posturl,funcOk,funcErr,showResp){
	var options = {
		url : posturl,
		type : "post", 
		cache : false,
		beforeSend : function(){
		},
		success : function(resp) {
			jboxEndLoading();
			if(showResp==false){
				
			}else{
				jboxTip(resp);					
			}
			if(funcOk!=null){
				funcOk(resp);				
			}				
		},
		error : function() {
			jboxEndLoading();
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		complete : function(){
		},
		iframe : true
	};
	jqForm.ajaxSubmit(options);
}

function jboxPostJson(posturl,postdata,funcOk,funcErr,showResp){
	if(showResp!=false){
		showResp = true;
	}
	$.ajax({
		type : "post",
		url : posturl,
		//dataType:"json",      
        contentType:"application/json",
		data : postdata,
		cache : false,
		beforeSend : function(){
			jboxStartLoading();
		},
		success : function(resp) {
			jboxEndLoading();
			if(showResp){
				jboxTip(resp);
			}
			if(funcOk!=null){
				if(showResp){
					setTimeout(function(){
						funcOk(resp);
					},1000);
				}else{
					funcOk(resp);
				}
			}
		},
		error : function() {
			jboxEndLoading();
			jboxTip("操作失败,请刷新页面后重试");
			if(funcErr!=null){
				funcErr();				
			}
		},
		complete : function(){
			jboxEndLoading();
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
//jboxPostOpen
function jboxPostOpen(url,title,width,height,showClose){
	if(showClose!=false){
		showClose = true;
	}
	if(url.indexOf('?')>-1){
		url = url+"&time="+new Date();
	}else{
		url = url+"?time="+new Date();
	}	
	if(window.parent.frames['mainIframe']!=null){
		top.dialog({
			id:'jbox-iframe',
			fixed: true,
			padding: 5,
			title: title,
			url: url,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		        return showClose;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.top.window.document).remove();
		}
	}else{
		dialog({
			id:'jbox-iframe',
			fixed: true,
			padding: 5,
			title: title,
			url: url,
			width:width,
			height:height,
			cancelDisplay: false,
		    cancelValue: '关闭',
		    backdropOpacity:0.1,
		    cancel: function () {
		        return showClose;
		    }
		}).showModal();
		if(showClose==false){
			$(".ui-dialog-close",window.document).remove();
		}
	}
	jboxCenter();
}


