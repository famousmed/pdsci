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
	//initPlayer("resEdu","${sysCfgMap['edu_player_control']}","${sysCfgMap['edu_play_validation']}");
	initPlayer("${chapter.chapterFlow}","${sysCfgMap['res_edu_player_control']}","${sysCfgMap['res_edu_play_validation']}","${sysCfgMap['upload_base_url']}",'Y',"${sysCfgMap['upload_stream_url']}");
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
});
function reload(){
	window.location.reload(true);
}
/* function collection(){
	$("#collectionCount").text(1);
	$("#sc-a").css("background-image","url(<s:url value='/jsp/edu/css/images/head.png'/>)");
}
 */
 
/* function selectTag(showContent, selfObj,studyStatusId) {
    var tags = $('.tags');
    $.each(tags , function(i , n){
    	$(n).removeClass("on");
    });
    $(selfObj).addClass("on");
    var tagContents=$('.tagContent');
    $.each(tagContents , function(i , n){
    	$(n).hide();
    });
    $("#"+showContent).show();
} */
 

function goBack(){
	var url = "<s:url value='/resedu/course/courseMain'/>?courseFlow=${course.courseFlow}";
	window.location.href=url;
}
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

function nextChapter(chapterFlow,courseFlow){
	var url="<s:url value='/resedu/course/nextChapters?chapterFlow='/>"+chapterFlow+'&courseFlow='+courseFlow;
	jboxPost(url,null,function(rep){
		var Url;
		if(rep=="${GlobalConstant.LAST_CHAPTER}"){
			jboxTip("已经是最后一章了！！！");
		}else{
			Url="<s:url value='/resedu/course/chapterDetail'/>?chapterFlow="+rep;
			window.location.href=Url;
		};
	},null,false);
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
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<div style="overflow: auto;height: 100%;width: 100%" id="mainDiv">
<!--videoPage-->
<div class="videoPage cbody clearfix" >
   <div class="video-title">
     <h3 class="fl"><a href="javascript:void(0)" title="点击返回" onclick="goBack()">&lt;&lt;</a>&nbsp;&nbsp;${chapter.chapterName }</h3>
     <div class="fr">
        <%-- <p class="fl p1"><a href="javascript:void(0)" onclick="collection();" id="sc-a"
        	<c:if test="${not empty collectionList}">
        		style="background-image: url(<s:url value='/jsp/edu/css/images/head.png'/>)"
        	</c:if> >收藏（<span id="collectionCount"><c:if test="${empty chapterExt.collectionCount}">0</c:if>${chapterExt.collectionCount}</span>）</a>
       	</p> --%>
     </div>
  </div>
   <div class="videoBox">
        <div class="videobg">
	  		<div class="video" id="myPlayer">Loading the player...</div>
	  		<div class="next-box" id="completeShowBox" style="display:none">
	            <div class="next-inner">
	                <div><a href="javascript:void(0)" class="again" onclick="doRestart()" title="点击重新播放">重新观看</a></div>
	                <div><a class="btn-exam btn-xlarge" href="javascript:void(0)" onclick="nextChapter('${chapter.chapterFlow}','${course.courseFlow }');">学习下一章</a></div>
	                <c:if test="${empty resultList and not empty paperFlow}">
	                   <div><a class="btn-exam btn-xlarge" href="<s:url value='/resedu/student/startTest'/>?paperFlow=${paperFlow }" target="_blank">开始考试</a></div>
	                </c:if>
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
  		<c:if test="${sysCfgMap['res_edu_player_control']!=GlobalConstant.FLAG_Y}">
  		 <div class="video-des">
            <ul class="fl">
            	<li class="video-pause"><input type="button" id="playButton"/></li>
                <li  class="video-j" onclick="setMute(this)" style="cursor: pointer;" title="静音"></li>
            </ul>
            <div class="video-v">
            <div  id="mySlider"></div>
            </div>
            <span id="volume">70%</span>
            <div class="video-des-r fr"><span id="play_length"><span id="nowMinutes">00</span>:<span id="nowSecond">00</span></span>/<span id="video_length">00:00</span></div>
        </div>
        </c:if>
  </div> 
  
 <!--video-r-->
 <%--  <div class="video-r fr">
  	<dl>
    	<dt>
      	<c:choose>
	       <c:when test="${studentCourse.courseTypeId eq eduCourseTypeEnumRequired.id }">
		       <input class="fr r-bnt" type="button" value="必修" />
	       </c:when>
	       <c:otherwise>
	           <input class="fr i-bnt" type="button" value="选修" />
	       </c:otherwise>
	     </c:choose>课程介绍</dt>
        <dd style="text-indent: 0;line-height: 24px;">${course.courseIntro }</dd>
    </dl>
    
    <dl>
        <dt>授课老师：${teacher.userName }</dt>
        <dd style="line-height: 24px;">教师简介：<br/>熊继柏，男，1942年出生，湖南省石门县人，湖南中医药大学教授，研究生导师，全国第四批、第五批老中医药专家学术经验继承人指导老师，中医药师承教育博士生导师，湖南省名中医，湖南中医药大学第一附属医院学术顾问。</dd>
    </dl>
  </div> --%>
  	
    
  <div class="clear"></div>
  
</div>

<!--/content-->
</div>
<div id="footer">技术支持：南京品德信息技术有限公司<br />Copyright © 2001- 2014 Character Technology, Inc. All rights reserved.</div>
</body>
</html>