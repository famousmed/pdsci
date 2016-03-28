<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script>
$(function(){
	$.mobile.pageLoadErrorMessage = '不能进行此操作!';
	$.mobile.loadingMessageTheme = 'a';
	$.mobile.loadingMessage = "加载中...";
	$.mobile.page.prototype.options.domCache = false;
	//$.mobile.ajaxEnabled=false;
});
</script>

<style>
<!--
/* fixed闪屏 */
.ui-page {  
    backface-visibility: hidden;  
    -webkit-backface-visibility: hidden; /* Chrome and Safari */ 
    -moz-backface-visibility: hidden; /* Firefox */ 
}
-->
</style>

<script>
function onBridgeReady(){
	 WeixinJSBridge.call('hideOptionMenu');
}
function weixin(){
	if (typeof WeixinJSBridge == "undefined"){
	    if( document.addEventListener ){
	        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	    }else if (document.attachEvent){
	        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	    }
	}else{
	    onBridgeReady();
	}
}
$(document).ready(function(){
	var forms = $("form");
	$.each(forms , function(i , form){ 
		$(form).validationEngine("attach",{
			promptPosition : "bottomLeft",
			scroll:true,
			autoPositionUpdate: false,
			//addPromptClass:"formError-noArrow formError-text"
			autoHidePrompt:true,
			maxErrorsPerField:1,
			showOneMessage : true
			}
		); 
	});
	weixin();
}); 
$(document).on("pageinit",function(event,data){
	var forms = $("form");
	$.each(forms , function(i , form){ 
		$(form).validationEngine("attach",{
			promptPosition : "bottomLeft",
			scroll:true,
			autoPositionUpdate: false,
			//addPromptClass:"formError-noArrow formError-text"
			autoHidePrompt:true,
			maxErrorsPerField:1,
			showOneMessage : true
			}
		); 
	});	
	weixin();
});
$( window ).on( "navigate", function( event, data ) {
	  console.log( data.state.info );
	  console.log( data.state.direction );
	  console.log( data.state.url );
	  console.log( data.state.hash );
	  //$.mobile.changePage(data.state.url+"&time="+new Date(),null);
});
</script>