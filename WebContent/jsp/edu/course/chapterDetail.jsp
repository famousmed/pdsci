<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>医学教育知识平台-查看课程</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="video" value="true"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	/*课程评分*/
	$("#courseRaty").raty({
		score:'${chapterExt.chapterScore}',
		cancel:false,
		path:'<s:url value="/js/jquery-raty/images/"/>',
		starOff : 'star-off-big.png',
		starOn  : 'star-on-big.png',
		starHalf : 'star-half-big.png',
		hints:['很烂','一般','不妨一看','比较精彩','棒极了'],
		readOnly:true
		
	});
	/*我的评分*/
	$("#myRaty").raty({
		score:${empty sch.score?0:sch.score},
		cancel:false,
		half:false,
		path:'<s:url value="/js/jquery-raty/images/"/>',
		starOff : 'star-off-big.png',
		starOn  : 'star-on-big.png',
		starHalf : 'star-half-big.png',
		hints:['很烂','一般','不妨一看','比较精彩','棒极了'],
		click: function(score, evt) {
			$("#score").val(score);
		  },
		readOnly:${!empty sch.score}
	});
	/*播放器初始化*/
	initPlayer("${chapterExt.chapterFlow}","${sysCfgMap['edu_player_control']}","${sysCfgMap['edu_play_validation']}");
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
function reload(){
	window.location.reload(true);
}
function submitEvaluate(){
	var form=$("#sEvaluate");
	var url="<s:url value='/edu/course/submitEvaluate'/>";
	
	if(form.validationEngine("validate")){
		jboxConfirm("确认提交评价?" , function(){
			jboxPost(url,form.serialize(),function(data){
				$("#p1eclone").append(data['eduCourseSchedule'].evaluate);
				 for(var j=1;j<=5-data['eduCourseSchedule'].score;j++){
					 $("#p2eclone").append($("#star-off").html());
				 }
				 for(var j=1;j<=data['eduCourseSchedule'].score;j++){
					 $("#p2eclone").append($("#star-on").html());
				 }
				
				$("#evaluateContent").prepend($("#eClone"));
				$("#noneEvaluate").hide();
				$("#sEvaluate").hide();
				$("#countEvaluate").text(parseInt($("#countEvaluate").text())+1);
				$("#courseRaty").raty({
					score:data['chapter'].chapterScore,
					cancel:false,
					path:'<s:url value="/js/jquery-raty/images/"/>',
					starOff : 'star-off-big.png',
					starOn  : 'star-on-big.png',
					starHalf : 'star-half-big.png',
					hints:['很烂','一般','不妨一看','比较精彩','棒极了'],
					readOnly:true
					
				});
				$("#chapterScore").text("（"+data['chapter'].chapterScore+"分）");
			},function(){
				jboxTip("${GlobalConstant.SAVE_FAIL}");
			},false);
		});
		
	}
}
function submitQuestion(){
    	var form=$("#cQuestion");
    	var url="<s:url value='/edu/course/submitQuestion'/>";
    	if(form.validationEngine("validate")){
    		jboxConfirm("确认发布问题？",function(){
    			jboxPost(url,form.serialize(),function(data){
    				if(data.questionFlow){
    					jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
    					var allQueCount = parseInt($.trim($("#allQueCount").html()));
    					$("#allQueCount").html(allQueCount+1);
    					var queHtml = $("#qClone").html();
    					queHtml = queHtml.replace(/\{0\}/g,"${sessionScope.currUser.userName}")
    						 			 .replace(/\{1\}/g,data.questionContent)
    					     			 .replace(/\{2\}/g,data.questionFlow);
    					if($("#noQuestion")!=null){
    						$("#noQuestion").remove();
    					}
    					$("#qContent").prepend(queHtml);
    					form[0].reset();
    				}
        		},function(){
        			jboxTip("${GlobalConstant.SAVE_FAIL}");
        		},false);
    		},null);
    	}
    }
function submitAnswer(questionFlow){
	var form=$("#aForm_"+questionFlow);
	var url="<s:url value='/edu/course/submitAnswer'/>";
	var requestData = form.serialize()+"&questionFlow="+questionFlow;
	if(form.validationEngine("validate")){
		jboxPost(url,requestData,function(data){
			if(data.answerFlow){
				jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
				var allAnsCount = parseInt($("#allAnsCount_"+questionFlow).val())+1;
				//alert(allAnsCount);
				$("#allAnsCount_"+questionFlow).val(allAnsCount);
				$("#answer_switch_"+questionFlow).attr("onclick","hideAnswer('"+questionFlow+"','"+allAnsCount+"')");
				var ansHtml = $("#aClone").html();
				ansHtml = ansHtml.replace(/\{0\}/g,"${sessionScope.currUser.userName}")
				 				 .replace(/\{1\}/g,data.answerContent);
				if($("#noAnswer_"+questionFlow)!=null){
					$("#noAnswer_"+questionFlow).remove();
				}
				$("#answer_intro_"+questionFlow).prepend(ansHtml);
				form.hide("slow");
				form[0].reset();
			}
		},function(){
			jboxTip("${GlobalConstant.SAVE_FAIL}");
		},false);
	}
}
function hideAnswer(questionFlow,aCount){
	var $qListObj = $("#answer_"+questionFlow);
	var $aSwitchObj = $("#answer_switch_"+questionFlow);
	if($qListObj.is(":hidden")){
		$qListObj.slideDown();
		$aSwitchObj.html("收起回复");
		$("#aForm_"+questionFlow).show("slow");
	}else{
		$qListObj.slideUp();
		$aSwitchObj.html("回复（"+aCount+"）");
	}
}
function savePraise(){
	var url="<s:url value='/edu/course/savePraise'/>?recordFlow=${sch.recordFlow}";
	jboxPost(url,null,function(resp){
		var $obj = $("#praiseCount");
		var count = parseInt($.trim($obj.html()));
		var $a = $obj.parent();
		if(resp=='${GlobalConstant.FLAG_Y}'){
			$obj.html(count-1)
			$a.attr("style","");
		}else{
			$obj.html(count+1)
			$a.attr("style","background-image:url(<s:url value='/jsp/edu/css/images/hand-r.png'/>)");
		}
	},null,false);
}
function collection(){
	 var url = "<s:url value='/edu/course/collection'/>?collectionTypeId=${eduCollectionTypeEnumChapter.id}&resourceFlow=${chapterExt.chapterFlow}";
	 jboxPost(url,null,
				function(resp){
					var collectionCount =parseInt($("#collectionCount").text());
					if(resp == "${GlobalConstant.FLAG_N}"){
						//alert("取消收藏！");
						$("#collectionCount").text(collectionCount-1);
						$("#sc-a").css("background-image","url(<s:url value='/jsp/edu/css/images/head-off.png'/>)");
					}else if(resp == "${GlobalConstant.FLAG_Y}"){
						//alert("收藏成功！");
						$("#collectionCount").text(collectionCount+1);
						$("#sc-a").css("background-image","url(<s:url value='/jsp/edu/css/images/head.png'/>)");
					}
				},
				function(resp){},false);
}

function selectTag(showContent, selfObj,studyStatusId) {
	if(studyStatusId!='${eduStudyStatusEnumFinish.id}'){
	if(isFinish=="" && showContent=="tagContent3"){
		jboxInfo("请先学习完视频再进行随堂测试！");
		return false;
	}
	}
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
   
}
$(document).ready(function(){
	$("#div_${sessionScope.currUser.userFlow}").css("border-bottom","none");
});
function nextChapter(nowChapterFlow,courseFlow){
	var url = "<s:url value='/edu/course/nextChapter'/>?nowChapterFlow="+nowChapterFlow+"&courseFlow="+courseFlow;
	jboxPost(url,null,function(resp){
		if(resp=='${GlobalConstant.LAST_CHAPTER}'){
			jboxTip('${GlobalConstant.LAST_CHAPTER}');
		}else if(resp=='${GlobalConstant.NOT_NORMAL_FINISH_COURSE}'){
			jboxTip('${GlobalConstant.NOT_NORMAL_FINISH_COURSE}')
		}else{
			url="<s:url value='/edu/course/chapter'/>"+"/"+resp;
			window.location.href=url;
		}
	},null,false);
	
}
function showTest(){
	selectTag("tagContent3", $("#tag3"),'${sch.studyStatusId}');
	$("body").scrollTo("#tag3", 1000,{ offset:{ top:-20} } );
}
function submitTest(){
	jboxTip("提交成功！");
	$("#nextChapter").removeAttr("disabled");
	$("#nextChapter").removeClass("fb-btn-grey");
}
function goBack(){
	var url = "<s:url value='/edu/user/checkRole'/>";
	jboxPost(url,null,function(resp){
		var toUrl;
		if(resp=="${GlobalConstant.STUDENT_ROLE}"){
			toUrl = "<s:url value='/edu/course/stuCourseDetail/${chapterExt.course.courseFlow}'/>";
		}else if(resp!=""){
			toUrl = "<s:url value='/edu/course/courseDetail/${chapterExt.course.courseFlow}'/>";
		}else{
			toUrl = "<s:url value='/inx/edu'/>";
		}
		window.location.href=toUrl;
	},null,false);
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
</style>
</head>
<body onkeydown="return onEvent(this,event);">
<div style="overflow: auto;height: 100%;width: 100%" id="mainDiv">
<jsp:include page="/jsp/edu/include/top.jsp"/>
<!--videoPage-->
<div class="videoPage cbody clearfix" >
   <div class="video-title">
     <h3 class="fl"><a href="javascript:void(0)" title="点击返回" onclick="goBack()">&lt;&lt;</a>&nbsp;&nbsp;${chapterExt.course.courseName}-${chapterExt.chapterNo}${chapterExt.chapterName}</h3>
     <div class="fr">
        <p class="fl p1"><a href="javascript:void(0)" onclick="collection();" id="sc-a"
        	<c:if test="${not empty collectionList}">
        		style="background-image: url(<s:url value='/jsp/edu/css/images/head.png'/>)"
        	</c:if> >收藏（<span id="collectionCount"><c:if test="${empty chapterExt.collectionCount}">0</c:if>${chapterExt.collectionCount}</span>）</a>
       	</p>
        <p class="fl p2"><a href="javascript:void(0)"  onclick="savePraise()" <c:if test="${sch.praiseStatus==GlobalConstant.FLAG_Y }">style="background-image:url(<s:url value='/jsp/edu/css/images/hand-r.png'/>)"</c:if> >点赞（<span id="praiseCount"><c:out value="${chapterExt.chapterPraise}" default="0"/></span>）</a></p>    
     </div>
  </div>
   <div class="videoBox">
        <div class="videobg">
	  		<div class="video" id="myPlayer">Loading the player...</div>
	  		<div class="next-box " id="completeShowBox" style="display:none">
	            <div class="next-inner">
	                <div><a href="javascript:void(0)" class="again" onclick="doRestart()" title="点击重新播放">重新观看</a></div>
	                <c:if test="${not empty sch.studyStatusId }">
	                <div><a class="btn-exam btn-xlarge" href="javascript:void(0)" onclick="showTest();">进入随堂测试</a></div>
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
  		<c:if test="${sysCfgMap['edu_player_control']!=GlobalConstant.FLAG_Y}">
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
   <!--video-l-->
  <div class="video-l fl">
  	<div class="videot1 module-tabs">
    	<p class="on tags" id="tag1" onclick="selectTag('tagContent1',this,'${sch.studyStatusId}')">问答</p>
    	<p class="tags" id="tag2" onclick="selectTag('tagContent2',this,'${sch.studyStatusId}')">评价</p>
    	<c:if test="${not empty sch.studyStatusId }">
    	<p class="tags" id="tag3"  onclick="selectTag('tagContent3',this,'${sch.studyStatusId}')">随堂测试</p>
    	</c:if>
    </div>
     
    <div class="module-content">
      <ul>
       <!-- 全部问答 -->
        <li style="display:block;" class="tagContent" id="tagContent1"> 
    <form id="cQuestion" style="position: relative;">
    <input type="hidden" name="chapterFlow" id="chapterFlow" value="${chapterExt.chapterFlow}"/>
    <input type="hidden" name="courseFlow" value="${chapterExt.courseFlow}"/>
   <table width="760" border="0">
   	 <Tr>
     	<Td width="10%" align="left" valign="top" style="font-size:13px; color:#545454">我要提问：</Td>
        <Td colspan="2">
        	<textarea name="questionContent" placeholder="请输入问题内容" class="validate[required]"></textarea>
        </Td>
     </Tr>
     <Tr height="45">
     	<Td></Td>
        <Td align="left"><input style="vertical-align:-1px;" type="checkbox" name="submitTeacher" id="submitTeacher" value="${GlobalConstant.FLAG_Y}" checked="checked"/>&nbsp;&nbsp;<label for="submitTeacher">提交给老师</label></Td>
        <Td align="right"><input class="fb-btn" type="button" value="发布" onclick="submitQuestion()"/></Td>
     </Tr>
   </table>
   </form>
   <div class="videot1">
   	  <p style=" color:#575757; border-bottom:2px solid #636363">全部问答（<span id="allQueCount">${fn:length(qList)}</span>）</p>
   </div>
   
   <div class="video-info" id="qContent">
   <c:forEach items="${qList}" var="question">
   		<dl>
        	<dt>
       	        <div class="fl infoT-l">
			  			<img class="t-face" src="${sysCfgMap['upload_base_url']}${qEduUserMap[question.user.userFlow].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'" />
                <br/>${question.user.userName }
                </div> 
                <div class="fr infoT-r">
                	<p class="p1"><img src="<s:url value='/jsp/edu/css/images/aicon.png'/>" width="16" height="16" />${question.questionContent}</p>
                    <p class="p2"><span id="answer_switch_${question.questionFlow}" class="fr blue" onclick="hideAnswer('${question.questionFlow}','${fn:length(question.answerList)}')">回复（${fn:length(question.answerList)}）</span><input type="hidden" id="allAnsCount_${question.questionFlow}" value="${fn:length(question.answerList)}"/>${pdfn:signBetweenTowDate(pdfn:getCurrDateTime("yyyyMMddHHmmss"),question.questionTime) }</p>
                </div>
                <c:if test="${question.quintessence == GlobalConstant.FLAG_Y }">
                <div class="best"></div>
                </c:if>
            </dt>
            <dd id="answer_${question.questionFlow}" style="display:none;">
            	<form id="aForm_${question.questionFlow}" style="position: relative;">
            	<div class="huif clearfix">
                	<textarea name="answerContent" placeholder="请输入回复内容" class="validate[required]"></textarea>
                    <input type="button" class="fb-btn fr" value="提交回复" onclick="submitAnswer('${question.questionFlow}')" />
                </div>
                </form>
                <div id="answer_intro_${question.questionFlow}">
                <c:forEach items="${question.answerList}" var="answer">
                <ul>
                	<li>
			  			<img class="fl t-face" src="${sysCfgMap['upload_base_url']}${qEduUserMap[answer.user.userFlow].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'"/>
                       <p class="p3"><span class="fr">${pdfn:signBetweenTowDate(pdfn:getCurrDateTime("yyyyMMddHHmmss"),answer.answerTime) }</span>${answer.user.userName }<c:if test="${answer.user.userFlow==chapterExt.teacher.userFlow }">&nbsp;<font color="green">[老师回复]</font></c:if></p>
                       <p class="p4">${answer.answerContent}</p>
                    
                     </li>
                </ul>
                </c:forEach>
                 </div>
                <c:if test="${empty question.answerList}">
                	<ul id="noAnswer_${question.questionFlow}">
                		<div class="nomessage"> 
                         <img src="<s:url value='/jsp/edu/css/images/tanhao.png'/>"/>           
                         <p>暂无回复！</p>
                        </div>
                	</ul>
                </c:if>
            </dd>
        </dl>
        </c:forEach>
        <c:if test="${empty qList}">
        	<dl id="noQuestion">
        		<dd>
                 <div class="nomessage nomq"> 
                   <img src="<s:url value='/jsp/edu/css/images/tanhao.png'/>"/>           
                   <p>暂无相关问答！</p>
                 </div> 
                </dd>
        	</dl>
        </c:if>
   </div>
     </li>
     <!-- 全部评价 -->
     <li style="display:none;" class="tagContent" id="tagContent2">
   <c:if test="${(sch.userFlow eq sessionScope.currUser.userFlow) and (empty sch.evaluate) and (empty sch.score) and (chapterExt.teacherId != sessionScope.currUser.userFlow)}">
   <form id="sEvaluate" style="position: relative;">   
   <table width="760" border="0">
    <Tr>
     	<Td width="10%" align="left" style="font-size:13px; color:#545454;height:65px; line-height:65px;">课程评分：</Td>
        <Td colspan="2">
        	<span id="myRaty"></span>&nbsp;<span id="myScore" style="padding-bottom:15px;"><c:choose><c:when test="${empty sch.score}"></c:when><c:otherwise>（${sch.score}分）</c:otherwise></c:choose></span>
        </Td>
     </Tr>
     
   	 <Tr>
     	<Td width="10%" align="left" valign="top" style="font-size:13px; color:#545454">我的评价：</Td>
        <Td colspan="2">
           <input type="hidden" name="score" id="score" value="0"/>
           <input type="hidden" name="chapterFlow" value="${chapterExt.chapterFlow}"/>
           <input type="hidden" name="courseFlow" value="${chapterExt.courseFlow}"/>
        	<textarea name="evaluate" id="evaluate" placeholder="请输入评价内容" class="validate[required]"></textarea>
        </Td>
     </Tr>
     
     <Tr height="45">
     	<Td></Td>
        <Td colspan="2" align="right"><input class="fb-btn" type="button" value="提交评价" onclick="submitEvaluate()"/></Td>
     </Tr>
   </table>
  </form>
  </c:if>
   <!--<div class="videot1">
   	  <p style=" color:#575757; border-bottom:2px solid #636363">全部评价（<span id="countEvaluate">${fn:length(scheduleList) }</span>）</p>
   </div>-->
   <c:if test="${fn:length(scheduleList)==0 }">
      <dl id="noneEvaluate">
        <dd>
          <div class="nomessage"> 
          <img src="<s:url value='/jsp/edu/css/images/tanhao.png'/>"/>           
          <p>暂无相关评价！</p>
          </div>                 
        </dd>
      </dl>
   </c:if>
     
  
  
   <div class="video-info" id="evaluateContent">
   		<c:forEach items="${scheduleList }" var="schedule">
   		<dl <c:if test="${schedule.userFlow eq sessionScope.currUser.userFlow }">class="vedio-own"</c:if>>
        	<dt>
       	        <div class="fl infoT-l">
			  			<img class="t-face" src="${sysCfgMap['upload_base_url']}${eduUserMap[schedule.userFlow].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'" />
 				<br/>${sysUserMap[schedule.userFlow].userName }
                </div> 
                <div class="fr infoT-r" <c:if test="${schedule.userFlow eq sessionScope.currUser.userFlow }">id="div_${schedule.userFlow }"</c:if>>
                	<p class="p1"><img src="<s:url value='/jsp/edu/css/images/aicon.png'/>" width="16" height="16" />${schedule.evaluate }</p>
                    <p class="p2" id="${schedule.score }">
                    <span  class="fr" style="padding-top:10px;cursor: default;">
                      <c:forEach var="i" begin="1" end="${schedule.score }">
                         <img src="<s:url value='/js/jquery-raty/images/star-on-big.png'/>"/>
                      </c:forEach>
                       <c:forEach var="i" begin="1" end="${5-schedule.score }">
                         <img src="<s:url value='/js/jquery-raty/images/star-off-big.png'/>"/>
                      </c:forEach>
                    </span>
                    <c:if test="${not empty schedule.evaluateTime }">
                    ${pdfn:signBetweenTowDate(pdfn:getCurrDateTime("yyyyMMddHHmmss"),schedule.evaluateTime) }
                    </c:if>
                    </p>
                </div>
            </dt>
        </dl>
        </c:forEach>
   </div>
     </li>
     <!-- 随堂测试 -->
     <li  style="display:none;" class="tagContent" id="tagContent3">
       <div class="test">
            	<dl>
                	<dt class="fl">1</dt>
                    <dd class="fl">
                    	<p>关节镜下前交叉韧带重建治疗需要几个疗程？</p>
                        <input type="radio" class="noL"/>1个<input type="radio"/>2个<input type="radio"/>3个<input type="radio"/>4个
                    </dd>
                </dl>
                <dl>
                	<dt class="fl">2</dt>
                    <dd class="fl">
                    	<p>关节镜下前交叉韧带重建治疗需要几个疗程？</p>
                        <input type="radio" class="noL"/>1个<input type="radio"/>2个<input type="radio"/>3个<input type="radio"/>4个
                    </dd>
                </dl>
                <dl>
                	<dt class="fl">3</dt>
                    <dd class="fl">
                    	<p>关节镜下前交叉韧带重建治疗需要几个疗程？</p>
                        <input type="radio" class="noL"/>1个<input type="radio"/>2个<input type="radio"/>3个<input type="radio"/>4个
                    </dd>
                </dl>
                <dl>
                	<dt class="fl">4</dt>
                    <dd class="fl">
                    	<p>关节镜下前交叉韧带重建治疗需要几个疗程？</p>
                        <input type="radio" class="noL"/>1个<input type="radio"/>2个<input type="radio"/>3个<input type="radio"/>4个
                    </dd>
                </dl>
                <input type="button" id="nextChapter" class="fb-btn fb-btn-grey fr" value="学习下一章" onclick="nextChapter('${chapterExt.chapterFlow}','${chapterExt.courseFlow}');" disabled="disabled"/>
                <input type="button" class="fb-btn fr" value="提交" onclick="submitTest();"/>
                </div>
     </li>
    </ul>
   </div>
  </div>
 <!--video-r-->
  <div class="video-r fr">
  	<dl>
    	<dt>${chapterExt.chapterNo}${chapterExt.chapterName}</dt>
        <dd class="video-rtype">
           <c:choose>
           <c:when test="${chapterExt.course.courseTypeId eq eduCourseTypeEnumRequired.id }">
             <input class="fl r-bnt" type="button" value="${chapterExt.course.courseTypeName }" />
           </c:when>
           <c:when test="${chapterExt.course.courseTypeId eq eduCourseTypeEnumOptional.id }">
             <input class="fl i-bnt" type="button" value="${chapterExt.course.courseTypeName }" />
           </c:when>
           <c:when test="${chapterExt.course.courseTypeId eq eduCourseTypeEnumPublic.id }">
             <input class="fl b-bnt" type="button" value="${chapterExt.course.courseTypeName }" />
           </c:when>
           </c:choose>
        </dd>
        <dd>课程简介：${chapterExt.chapterIntro}</dd>
        <ul>
    	<li class="h3">章节评价<p><span id="courseRaty"></span>&nbsp;<span id="chapterScore">（<c:out value="${chapterExt.chapterScore }" default="0.0"/>分）</span></p></li>
        </ul>
    </dl>
    
    <dl>
        <dt>授课老师：${chapterExt.teacher.userName}</dt>
        <dd>教师简介：<br/>爱分享、爱极客的编程怪兽，Coding之路注定是痛苦的，少不了BUG和崩溃，但那又怎样，哪怕不能执行，也要编的漂亮，我就是 eclipse_xu，我为我自己代言，为编程而生，为需求而死，为Debug而奋斗一辈子！</dd>
    </dl>
  </div>
  	
    
  <div class="clear"></div>
  
</div>

<!--/content-->
<jsp:include page="/jsp/edu/include/foot.jsp"/>
</div>
<div id="qClone" style="display: none">
<dl>
  	<dt>
 	        <div class="fl infoT-l">
		  			<img class="t-face" src="${sysCfgMap['upload_base_url']}${sessionScope[GlobalConstant.CURR_EDU_USER].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'"  />
          <br/>{0}
          </div> 
          <div class="fr infoT-r">
          	<p class="p1"><img src="<s:url value='/jsp/edu/css/images/aicon.png'/>" width="16" height="16" />{1}</p>
              <p class="p2"><span id="answer_switch_{2}" class="fr blue" onclick="hideAnswer('{2}','0')">回复（0）</span><input type="hidden" id="allAnsCount_{2}" value="0"/>刚刚</p>
          </div>
      </dt>
      <dd id="answer_{2}" style="display:none;">
            	<form id="aForm_{2}">
            	<div class="huif clearfix">
                	<textarea name="answerContent" placeholder="请输入回复内容" class="validate[required]"></textarea>
                    <input type="button" class="fb-btn fr" value="提交回复" onclick="submitAnswer('{2}')" />
                </div>
                </form>
                <div id="answer_intro_{2}"></div>
               	<ul id="noAnswer_{2}">
               		<li>暂无回复！<li>
               	</ul>
     	 </dd>
 </dl>
 </div>
 <div id="aClone" style="display: none">
 	 <ul>
     	<li>
		  			<img class="fl t-face" src="${sysCfgMap['upload_base_url']}${sessionScope[GlobalConstant.CURR_EDU_USER].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'"/>
            <p class="p3"><span class="fr">刚刚</span>{0}</p>
            <p class="p4">{1}</p>
         
          </li>
     </ul>
 </div>
     <div style="display: none;">
        <dl id="eClone">
        	<dt>
        	<div class="fl infoT-l">
		  			<img class="t-face" src="${sysCfgMap['upload_base_url']}${sessionScope[GlobalConstant.CURR_EDU_USER].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'" />
		  		 <br/>${sessionScope.currUser.userName}
		    </div>
                <div class="fr video-own infoT-r" style="border-bottom:0;">
                	<p class="p1" id="p1eclone"><img src="<s:url value='/jsp/edu/css/images/aicon.png'/>" width="16" height="16" /></p>
                    <p class="p2" id="p2eclone"><span  class="fr" style="padding-top:10px;"></span>
                                                              刚刚
                    </p>
                </div>
            </dt>
        </dl>
      </div>
        <div id="star-on" style="display: none;">
        <img class="fr" style="padding-top:10px;padding-right:5px; cursor: default;" src="<s:url value='/js/jquery-raty/images/star-on-big.png'/>"/>
        </div>
        <div id="star-off" style="display: none;">
        <img class="fr" style="padding-top:10px;cursor: default;" src="<s:url value='/js/jquery-raty/images/star-off-big.png'/>"/>
        </div>
</body>
</html>