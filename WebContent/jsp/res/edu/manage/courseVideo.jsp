<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>学习中心-查看课程</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="resedu" value="true"/>
	<jsp:param name="video" value="true"/>
</jsp:include>

<script type="text/javascript">
$(function(){
	/*播放器初始化*/
	initPlayer("${param.chapterFlow}","Y","N","${sysCfgMap['upload_base_url']}",'N',"${sysCfgMap['upload_stream_url']}");
	/*播放器音量控制插件*/
	 $("#mySlider").slider({
	      range: "min",
	      value: 70,
	      min: 0,
	      max: 100,
	      stop: function(event,ui) {
	    	  setVolume(ui.value);
	      },
	      change:function(event,ui){
	      	  $("#volume").html(ui.value+"%");
	      },
	      slide:function(event,ui){
	      	  $("#volume").html(ui.value+"%");
	      }
	    });
	 //$('.feature-3').click(function() {$("body").scrollTo('.public', 1000 ); });
	 //$.scrollTo("#tag3",1000);
	 //$("body").scrollTo("#tag3", 1000);
})
function onEvent(src,e){
    if(window.event)
        keyPressed = window.event.keyCode; // IE
    else
       keyPressed = e.which; // Firefox
    if(keyPressed==13)
    {          
      return false;
    }
}
</script>
<style>
#volume{margin-left:15px;}
#mySlider{
width:100px;
border:1px solid #dbdbdb;
background:#898989;
height:2px;
}
.ui-widget-header {
border: 1px solid #aaa;
background: #2783d9;
color: #222;
font-weight: bold;
}
.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default {
border: 2px solid #2783d9;
background: #edf0f2;
font-weight: normal;
color: #555;
}
.ui-slider .ui-slider-handle {
position: absolute;
z-index: 2;
width: 8px;
height: 8px;
border-radius:5px;
cursor: default;
}
.ui-slider-horizontal .ui-slider-handle {
margin-left:0;
margin-right:0;
}
.ui-dialog{position: relative;}

#register {
background: url("<s:url value='/css/skin/${skinPath}/images/station_bg.jpg' />") repeat-x;
height: 75px;
text-align: left;
}
#logo {
margin: 0 auto;
width: 1150px;
height: 75px;
line-height: 75px;
}
#logo img {
vertical-align: middle;
padding-top: 20px;
}
#footer {
margin: 0 auto;
margin-top: 15px;
margin-bottom: 30px;
width: 900px;
text-align: center;
color: #999999;
font-size: 13px;
height: 100px;
}
</style>
</head>
<body onkeydown="return onEvent(this,event);">
<div id="register">
   <div class="video-logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<div style="overflow: hidden;height: 100%;width: 100%" id="mainDiv">
<!--videoPage-->
<div class="videoPage cbody clearfix video-sig" >
   <div class="video-title">
     <h3 class="fl">&nbsp;&nbsp;预览视频${chapter.chapterFileName }</h3>
  </div>
   <div class="videoBox">
        <div class="videobg">
	  		<div class="video" id="myPlayer">Loading the player...</div>
	  		<div class="next-box " id="completeShowBox" style="display:none">
	            <div class="next-inner">
	                <div><a href="javascript:void(0)" class="again" onclick="doRestart()" title="点击重新播放">重新观看</a></div>
	            </div>
	        </div>
		     <div  id="randomConfirm" class="next-box" style="display:none">
		     	<form id="randForm">
		         <div class="next-inner">
		           <div class="next-line">
		           <h1>请您输入验证码后继续观看</h1>
		                 <h1><font>验证码：</font><span class="logo_text"><input name="verifyCode" type="text" class="validate[required]"
							id="verifyCode"	style="width: 250px; padding-bottom:7px; text-indent:10px;" placeholder=""/></span></h1>
							<h1><img id="verifyImage" src="<s:url value='/captcha'/>" style="cursor:pointer;padding-left:68px;" onclick="reloadVerifyCode();" title="点击更换验证码" alt="看不清，换一张" /><span id="sec" style="color: red">59</span>秒后重新播放！</h1>
		       	    <h1><input type="button" class="btn-exam btn-refer" style="width: 114px;" value="提交" onclick="doContinue();"/></h1>
		       	   </div>
		      	</div>
		      	</form>
        	</div>
  		</div>
  		<c:if test="${sysCfgMap['edu_player_control']!=GlobalConstant.FLAG_Y}">
  		 <div class="video-des">
            <ul class="fl">
            	<li class="video-pause"><input type="button" id="playButton"/></li>
                <li  class="video-j" onclick="setMute(this)" style="cursor: pointer;" title="静音"></li>
            </ul>
            <div class="video-v">
            <div  id="mySlider"></div>
            </div>
            <span id="volume">100%</span>
            <div class="video-des-r fr"><span id="play_length"><span id="nowMinutes">00</span>:<span id="nowSecond">00</span></span>/<span id="video_length">00:00</span></div>
        </div>
        </c:if>
  </div> 
  <div class="clear"></div>
  
</div>

<!--/content-->
<div id="footer">技术支持：南京品德信息技术有限公司<br />Copyright © 2001- 2015 Character Technology, Inc. All rights reserved.</div>
</div>
</body>
</html>