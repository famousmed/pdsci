<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
</jsp:include>
<script type="text/javascript">
function joinMyCourseList(courseFlow){
	 var msg="确认把该课程加入我的课程中吗？";
	 jboxConfirm(msg,function(){
	 var url = "<s:url value='/resedu/course/joinMyCourseList'/>?courseFlow="+courseFlow;
	 jboxPost(url,null,
				function(resp){
		           if(resp!='${GlobalConstant.OPRE_FAIL}'){
      	              jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
      	              var tipSpan=$("#"+resp+"_tip");
      	              $(tipSpan).html($("#tipCopy").html());
                   }
				},
				null,false);
	 });
}
$(function(){
	if ("${param.tagId}"!="") {
		$(".selectTag").removeClass("selectTag");
		$("#${param.tagId}").addClass("selectTag");
		$("#${param.tagId}").find("a").click();
	} else {
		$("li:first").addClass("selectTag");
		$("li:first").find("a").click();
	}
});
function selectTag(url, id) {
	// 操作标签
	var tag = document.getElementById("tags").getElementsByTagName("li");
	var taglength = tag.length;
    for (i = 0; i < taglength; i++) {
	    tag[i].className = "ui-bluetag";
	}
	document.getElementById(id).parentNode.className = "selectTag";
	// 操作内容
	jboxLoad("tagContent",url,true);
}

function doBack() {
	window.location.href="<s:url value='/res/doc/rotationDetail'/>?roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}&resultFlow=${param.resultFlow}"+
			"&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}";
}

$(document).ready(function(){
});

function selectCourseTypeId(typeId){
   	var courseTypeId=$("#courseTypeId");
   	courseTypeId.val(typeId);
   	showCourse();
}

function checkStatus(status){
	var studyStatus=$("#studyStatus");
	studyStatus.val(status);
	showCourse();
}

function checkCourseCategory(categoryId){
	var courseCategoryId=$("#courseCategoryId");
	courseCategoryId.val(categoryId);
	showCourse();
}

function checkFindCourseCategory(categoryId){
	var courseCategoryId=$("#courseCategoryId");
	courseCategoryId.val(categoryId);
	loadFindCourse();
}

function showCourse(){
	var studyStatusVal=$("#studyStatus").val();
	var courseTypeIdVal=$("#courseTypeId").val();
	var courseCategoryIdVal=$("#courseCategoryId").val();
	var id=$("#tagContent").attr("id");
	var url="<s:url value ='/resedu/student/showStuCourse'/>?studyStatus="+studyStatusVal+"&courseTypeId="+courseTypeIdVal+"&courseCategoryId="+courseCategoryIdVal;
	jboxLoad(id,url,true);
}

function loadFindCourse(){
	$("#CourseName").val($("#courseName").val());
	var courseCategoryIdVal=$("#courseCategoryId").val();
	var data=$("#findCourseCondition").serialize();
	var url="<s:url value='/resedu/student/findCourse'/>?courseCategoryId="+courseCategoryIdVal;
	jboxPost(url,data,function(resp){
		$("#tagContent").html(resp);
	},null,false);
		
}
function changeSort(sort){
	$("#sortType").val(sort);
	loadFindCourse();
}
function toPageFindCourse(page){
	$("#currentPage").val(page);
	loadFindCourse();
}
function loadStudyRecord(){
	var url="<s:url value='/resedu/student/studyRecord'/>";
	jboxPost(url,$("#studyRecordForm").serialize(),function(resp){
		$("#tagContent").html(resp);
	},null,false);
}
</script>
</head>
<body style="background:#fff;">
<div class="mainright">
  <div class="content" style="margin-top: 10px;">
  	<ul id="tags">
		<li><a onclick="selectTag('<s:url value='/resedu/student/showStuCourse'/>','myCourse');" href="javascript:void(0)"  id="myCourse">我的课程</a></li>
		<li><a onclick="selectTag('<s:url value='/resedu/student/findCourse'/>','findCourse');" href="javascript:void(0)" id="findCourse">发现课程</a></li>
		<li><a onclick="selectTag('<s:url value='/resedu/student/studyRecord'/>','studyRecord');" href="javascript:void(0)" id="studyRecord">学习记录</a></li>
		<input type="button" class="search" value="返&#12288;回" onclick="doBack();"/>
    </ul>
     <input type="hidden" id="studyStatus"/>
     <input type="hidden" id="courseTypeId"/>
     <input type="hidden" id="courseCategoryId"/>
     <form id="findCourseCondition">
     <input type="hidden" id="sortType" name="order" value="${param.order }"/>
     <input type="hidden" id="CourseName" name="courseName" value="${param.CourseName }"/>
     <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage }"/>
     </form>
    <div id="tagContent">
       
    </div>
  </div>
</div>
</body>
</html>