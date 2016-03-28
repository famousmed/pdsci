<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <jsp:include page="/jsp/common/htmlhead.jsp"> --%>
<%-- 	<jsp:param name="basic" value="true"/> --%>
<%-- 	<jsp:param name="jbox" value="true"/> --%>
<%-- 	<jsp:param name="jquery_form" value="false"/> --%>
<%-- 	<jsp:param name="jquery_ui_tooltip" value="true"/> --%>
<%-- 	<jsp:param name="jquery_ui_combobox" value="false"/> --%>
<%-- 	<jsp:param name="jquery_ui_sortable" value="false"/> --%>
<%-- 	<jsp:param name="jquery_cxselect" value="false"/> --%>
<%-- 	<jsp:param name="jquery_scrollTo" value="false"/> --%>
<%-- 	<jsp:param name="jquery_jcallout" value="false"/> --%>
<%-- 	<jsp:param name="jquery_validation" value="true"/> --%>
<%-- 	<jsp:param name="jquery_datePicker" value="true"/> --%>
<%-- 	<jsp:param name="jquery_fullcalendar" value="false"/> --%>
<%-- 	<jsp:param name="jquery_fngantt" value="false"/> --%>
<%-- 	<jsp:param name="jquery_fixedtableheader" value="true"/> --%>
<%-- 	<jsp:param name="jquery_placeholder" value="true"/> --%>
<%-- 	<jsp:param name="jquery_iealert" value="false"/> --%>
<%-- 	<jsp:param name="resedu" value="false"/> --%>
<%-- </jsp:include> --%>
<html>
<head>
<script>
function preTrainForm(){
	var h = $('.main_fix').height();
	jboxOpen("<s:url value='/res/rec/showRegistryForm'/>"+
			"?recTypeId=${resRecTypeEnumPreTrainForm.id }"+
			"&schDeptFlow="+indexObj.schDeptFlow+
			"&rotationFlow="+indexObj.rotationFlow+
			"&roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}"+
			"&resultFlow=${param.resultFlow}"+
			"&recFlow=${preTrainFormRec.recFlow}", "科室岗前培训表",800,h);
}	

$(document).ready(function() {
	   $(".parentA").click(function(event){
	        event.stopPropagation();
	    });
	   loadStudyInfo();
});
function loadStudyInfo(){
	var url="<s:url value='/resedu/student/loadStudyInfo'/>?roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}&resultFlow=${param.resultFlow}"+
	"&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}";
	jboxLoad("studyInfoDiv",url,true);
}
function changeDeptAndTeacher(){
	jboxOpen("<s:url value='/res/doc/changeDeptAndTeacher'/>?processFlow=${process.processFlow}", "修改科主任和带教老师",400,200);
}
</script>
<style>
a {
cursor: pointer;
background: transparent;
color: #428bca;
text-decoration: none;
}
</style>
</head>
<body>
	<div class="toolkit bg-f6 toolkit-lg toolkit-bar" style="border-top: 0;cursor: pointer;" onclick="toggleItem('inDeptView');">
		<ul class="j_e-nav-tab toolkit-list fl">
			<li class="j_mainline_link toolkit-item toolkit-item-tab j_mainline_link_task router">
				<span class="tool_title">
				入科&#12288;
				</span>
				<span>
				<a href="javascript:modifySchDate();" class="parentA">[${empty process.startDate?process.schStartDate:process.startDate}&nbsp;至&nbsp;${empty process.endDate?process.schEndDate:process.endDate}]</a>
				&#12288;
				<a class="parentA" onclick="changeDeptAndTeacher();">
					带教老师：<span id="headUserNameSpan">${process.teacherUserName}</span>
					&#12288;
					科主任：<span id="teacherUserNameSpan">${process.headUserName}</span>
				</a>
				</span>
			</li>
		</ul>
	</div>
	<div id="inDeptView_div">
	<div class="col-tb ps-r scrollwrapper flowsteps" style="width: 80%;margin: 10px auto 0;"> 
		<c:set var="preKey" value="res_${preRecTypeEnumPreTrainForm.id}_form_flag"/>
		<ol class="${(sysCfgMap[preKey]!= GlobalConstant.FLAG_Y && sysCfgMap['res_inExam_flag']!= GlobalConstant.FLAG_Y)?'num3':'num4'}">
	        <li class="first done" id="step1">
	          <span><i>1</i><em>入科报到</em></span>
	        </li>
	        <li id="step2" class="done">
	          <span><i>2</i><em>入科学习</em></span>
	        </li>
	        <c:choose>
	        <c:when test="${sysCfgMap[preKey]== GlobalConstant.FLAG_Y && sysCfgMap['res_inExam_flag']== GlobalConstant.FLAG_Y}">
	        	<li id="step3" class="done">
		          <span><i></i><em>科室岗前培训表</em></span>
		        </li>
		        <li class="lasted" id="step4">
		          <span><i>4</i><em>入科考试</em></span>
		        </li>
	        </c:when>
	        <c:otherwise>
	        	<c:choose>
		        <c:when test="${sysCfgMap[preKey]== GlobalConstant.FLAG_Y}">
		        	<li id="step3" class="done">
			          <span><i>3</i><em>科室岗前培训表</em></span>
			        </li>
			        <li class="lasted" id="step4">
			          <span><i>4</i><em>完成</em></span>
			        </li>
		        </c:when>
		        <c:when test="${sysCfgMap['res_inExam_flag']== GlobalConstant.FLAG_Y}">
		        	<li id="step3" class="done">
			          <span><i>3</i><em>入科考试</em></span>
			        </li>
			        <li class="lasted" id="step4">
			          <span><i>4</i><em>完成</em></span>
			        </li>
		        </c:when>
		        <c:otherwise>
		        	<li class="lasted" id="step3">
				        <span><i>3</i><em>完成</em></span>
				    </li>
		        </c:otherwise>
		        </c:choose>
	        </c:otherwise>
	        </c:choose>
	      </ol>
	</div>
	<div class="col-tb ps-r scrollwrapper" style="width: 99%;"> 
		<div class="col-cell j_center" style="width:100%; min-width: 400px;">
			<ul class=" e-list task-list" style="margin-top: 5px;">
				<li  style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="javascript:sop();">${process.schDeptName}轮转信息规范</a></span>
				</li>
<%-- 				<c:if test="${sysCfgMap['res_study_file_flag']== GlobalConstant.FLAG_Y}"> --%>
<!-- 				<li style="position: relative;"> -->
<!-- 					<span class="mark"><i></i></span> -->
<%-- 					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="<s:url value =''/>">入科学习</a></span> --%>
<!-- 				</li> -->
<%-- 				</c:if> --%>
				<c:if test="${sysCfgMap['res_study_course_flag']== GlobalConstant.FLAG_Y}">
				<li style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a href="<s:url value ='/resedu/student/main?resultFlow=${param.resultFlow}&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}'/>">入科学习</a></span>
				</li>
				</c:if>
				<c:if test="${sysCfgMap[preKey]== GlobalConstant.FLAG_Y}">
				<li style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a onclick="preTrainForm();">科室岗前培训表(${empty preTrainFormRec.recFlow?'<font color="red">未填写</font>':(empty preTrainFormRec.auditStatusId?'未审核':'已审核')})</a></span>
				</li>
				</c:if>
				<c:if test="${sysCfgMap['res_inExam_flag']== GlobalConstant.FLAG_Y}">
				<li style="position: relative;">
					<span class="mark"><i></i></span>
					<span class="j_title  ellipsis" style="padding-left: 10px;"><a onclick="">入科考试</a></span>
				</li>
				</c:if>
			</ul>
		</div>
	</div>
	<c:if test="${sysCfgMap['res_study_course_flag']== GlobalConstant.FLAG_Y}">
	<div class="col-tb ps-r scrollwrapper" style="width: 100%;border-top: 1px solid #ddd;display: "> 
		<div class="panel-head" id="studyInfoDiv"></div>
	</div>
	</c:if>
	</div>
</body>
</html>
