<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
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
</jsp:include>
<script type="text/javascript">
function editCourse(courseFlow){
	var page=$("#currentPage").val();
	var url = "<s:url value='/resedu/manage/course/editCourse'/>?courseFlow="+courseFlow+"&page="+page;
	window.location.href=url;
}
function setCourseInfo(courseFlow){
	var page=$("#currentPage").val();
	var url = "<s:url value='/resedu/manage/course/editCourse'/>?courseFlow="+courseFlow+"&type=local&page="+page;
	window.location.href=url;
}
function addCourse(){
	var url = "<s:url value='/resedu/manage/course/editCourse'/>";
	window.location.href=url;
}
function search(){
	$("#searchForm").submit();
}
function changeCourseStatus(courseFlow,flag){
	var msg = "";
	var statusId="";
	if (flag == 'publish') {
		msg = "发布";
		statusId='${eduCourseStatusEnumPublish.id}';
	} else if (flag == 'start') {
		msg = "启用";
		statusId='${eduCourseStatusEnumPublish.id}';
	}else if (flag == 'stop') {
		msg = "停用";
		statusId='${eduCourseStatusEnumDisabled.id}';
	}
	msg = "确认" + msg + "课程吗？";
	jboxConfirm(msg,function () {
		var url = "<s:url value='/resedu/manage/course/changeCourseStatus'/>?courseFlow=" + courseFlow + "&statusId=" + statusId;
		jboxPost(url, null,function(resp){
		 search();	
		},null,true);	
	});
}
function checkedView(courseFlow){
	$.each($(".courseTr"),function(i,n){
		$(n).css("background-color","");
	});
	$("#courseTr_"+courseFlow).css("background-color","pink");
}
function courseInfo(courseFlow){
	var page=$("#currentPage").val();
	var url = "<s:url value='/resedu/manage/course/courseInfo'/>?courseFlow="+courseFlow+"&page="+page;
	window.location.href=url;
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
function searchTestList(courseFlow){
	var url="<s:url value='/resedu/manage/course/testList'/>?courseFlow="+courseFlow;
    window.location.href=url;
}
function setChapterInfo(courseFlow){
	var url = "<s:url value='/resedu/manage/course/chapterList'/>?courseFlow=" + courseFlow;
	window.location.href=url;
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="searchForm" action="<s:url value='/resedu/manage/course/courseList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }'/>" method="post">
	  <div>
	            课程名称：<input type="text" name="courseName" class="xltext" value="${param.courseName }"/>
		上传日期：<input type="text" name="upLoadTimeStart" value="${param.upLoadTimeStart }"  class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~&nbsp;
				<input type="text" name="upLoadTimeEnd" value="${param.upLoadTimeEnd }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/> 
	  </div>
	  <div style="margin-top: 10px;margin-bottom: 10px;">
	            上传科室：<select class="xlselect" name="deptFlow" style="width: 100px;">
	                <option value="">请选择</option>
	              <c:forEach items="${deptList }" var="dept">
	                <option value="${dept.deptFlow }" <c:if test="${param.deptFlow eq dept.deptFlow }"></c:if>>${dept.deptName }</option>
	              </c:forEach>
	           </select>
	    课程类别：<select class="xlselect" name="courseCategoryId" style="width: 100px;">
					<option value="">请选择</option>
					<c:forEach items="${eduCourseCategoryEnumList }" var="category">
					  <option value="${category.id }"<c:if test="${param.courseCategoryId eq category.id }">selected</c:if>>${category.name }</option>
					</c:forEach>
				</select>
	    <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage }"/>
	    <input type="button" class="search" onclick="search();" value="查&#12288;询">
		<input type="button" class="search" onclick="addCourse();" value="新&#12288;增">
	  </div>
	</form>
	 <table class="xllist">
	   <c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL}">
	        <col width="15%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="15%">
	   </c:if>	
		<tr>
			<th>课程名称</th>
			<th>课程类别</th>
			<th>主讲人</th>
			<th>学分</th>
			<th>学时</th>
			<th>上传科室</th>
			<th>上传日期</th>
			<th>课程状态</th>
			<th>操作</th>
		</tr>
	   
	   	
		<c:forEach items="${courseList }" var="course">
		<tr id="courseTr_${course.courseFlow }" class="courseTr" <c:if test="${param.courseFlow eq course.courseFlow }">style="background-color:pink;"</c:if>>
			<td>
			  <c:choose>
			   <c:when test="${(course.courseStatusId eq eduCourseStatusEnumPublish.id) or (course.courseStatusId eq eduCourseStatusEnumDisabled.id)}">
			   <a href="<s:url value='/resedu/course/courseMain?courseFlow=${course.courseFlow }'/>" target="_blank">${course.courseName }</a>
			   </c:when>
			   <c:otherwise>
			    ${course.courseName }
			   </c:otherwise> 
			  </c:choose> 
			</td>
			<td>${course.courseCategoryName }</td>
			<td>${course.courseSpeaker }</td>
			<td>${course.courseCredit }</td>
			<td>${course.coursePeriod }</td>
			<td>${course.deptName }</td>
			<td>${pdfn:transDateTimeForPattern(course.uploadTime,"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd") }</td>
			<td>${course.courseStatusName }</td>
			<td> 
			    <c:if test="${course.courseStatusId eq eduCourseStatusEnumNoPublish.id }">
			    [<a href="javascript:checkedView('${course.courseFlow }');" onclick="editCourse('${course.courseFlow }');">编辑</a>]
			    </c:if>
			    <c:if test="${course.courseStatusId != eduCourseStatusEnumNoPublish.id }">
			    [<a href="javascript:checkedView('${course.courseFlow }');" onclick="courseInfo('${course.courseFlow }');">查看</a>]
			    </c:if>
			     <c:if test="${course.courseStatusId eq eduCourseStatusEnumNoPublish.id }">
			       |&nbsp;[<a href="javascript:checkedView('${course.courseFlow }');" onclick="changeCourseStatus('${course.courseFlow }','publish');">发布</a>]
			     </c:if>
			     <c:if test="${course.courseStatusId eq eduCourseStatusEnumPublish.id }">
			       |&nbsp;[<a href="javascript:checkedView('${course.courseFlow }');" onclick="setCourseInfo('${course.courseFlow }');">设置</a>]
			     </c:if>
			    <c:if test="${course.courseStatusId eq eduCourseStatusEnumDisabled.id }">
			    |&nbsp;[<a href="javascript:checkedView('${course.courseFlow }');" onclick="changeCourseStatus('${course.courseFlow }','start');">启用</a>]
			    </c:if>
			    <c:if test="${course.courseStatusId eq eduCourseStatusEnumPublish.id }">
			    |&nbsp;[<a href="javascript:checkedView('${course.courseFlow }');" onclick="changeCourseStatus('${course.courseFlow }','stop');">停用</a>]
			    </c:if>
			     |&nbsp;[<a href="javascript:checkedView('${course.courseFlow }');" onclick="setChapterInfo('${course.courseFlow }');">章节信息</a>]
			</td>
		</tr>
		</c:forEach>
		<c:if test="${empty courseList and sessionScope[GlobalConstant.USER_LIST_SCOPE] != GlobalConstant.USER_LIST_LOCAL}">
		   <tr>
		      <td colspan="9">无记录</td>
		   </tr>
		</c:if>
		<c:if test="${empty courseList and sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL}">
		   <tr>
		      <td colspan="11">无记录</td>
		   </tr>
		</c:if>		
	</table>
	<c:set var="pageView" value="${pdfn:getPageView(courseList)}" scope="request"></c:set>
	     <pd:pagination toPage="toPage"/>
</div>
</div>
</div>
</body>