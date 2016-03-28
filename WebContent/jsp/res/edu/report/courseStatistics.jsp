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
function scoreDetail(courseFlow){
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	var url = "<s:url value='/resedu/report/scoreDetail'/>?courseFlow="+courseFlow;
	jboxOpen(url, "成绩情况", width, 500);
}

function updateLog(courseFlow){
	var url = "<s:url value='/resedu/report/updateLog'/>?courseFlow="+courseFlow;
	jboxOpen(url, "历史修改记录", 800, 400);
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="searchForm" action="<s:url value='/resedu/report/courseStatistics/${sessionScope[GlobalConstant.USER_LIST_SCOPE]}'/>" method="post">
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
		<input type="hidden" id="currentPage" name="currentPage"/>
		课程名称：<input type="text" name="courseName" class="xltext" value="${param.courseName }"/>
		课程类别：<select class="xlselect" name="courseCategoryName">
						<option value="">请选择</option>
						<option value="普通培训" <c:if test="${param.courseCategoryName=='普通培训'}">selected="selected"</c:if>>普通培训</option>
						<option value="岗前培训" <c:if test="${param.courseCategoryName=='岗前培训'}">selected="selected"</c:if>>岗前培训</option>
				</select>
		<%-- 更新时间：<input type="text" name="startDate"  value="${param.startDate }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~&nbsp;
				<input type="text" name="endDate" value="${param.endDate }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/>  --%>
		<input type="button" class="search" onclick="search();" value="查&#12288;询">
		<!-- <input type="button" class="search" value="导&#12288;出"> -->
	</div>
	
	</form>
	 <table class="xllist">
		<tr>
			<th width="15%">课程名称</th>
			<th width="15%">课程类别</th>
			<th width="10%">必修人数</th>
			<th width="10%">必修完成人数</th>
			<th width="10%">必修未完成人数</th>
			<th width="10%">参加学习人数</th>
			<th width="10%">已学完人数</th>
			<th width="10%">未通过人数</th>
		</tr>
		<c:forEach items="${eduCourseList}" var="eduCourse">
			<%-- <c:set var="courseFlow" value="${form.courseFlow }"/>
			<c:set var="require" value="require_${courseFlow }"/>
			<c:set var="crequire" value="crequire_${courseFlow }"/>
			<c:set var="study" value="study_${courseFlow }"/>
			<c:set var="cstudy" value="cstudy_${courseFlow }"/> --%>
			<tr>
				<td>${eduCourse.courseName}</td>
				<td>${eduCourse.courseCategoryName}</td>
				<td><c:out value="${studentCourseMap['requiredMap'][eduCourse.courseFlow]}" default="0"/></td>	
				<td><c:out value="${studentCourseMap['completeRequiredMap'][eduCourse.courseFlow]}" default="0"/></td>
				<td><c:out value="${studentCourseMap['notCompleteRequiredMap'][eduCourse.courseFlow]}" default="0"/></td>
				<td><c:out value="${studentCourseMap['StudyMap'][eduCourse.courseFlow]}" default="0"/></td>
				<td><c:out value="${studentCourseMap['CompleteMap'][eduCourse.courseFlow]}" default="0"/></td>
				<td><c:out value="${studentCourseMap['notCompleteMap'][eduCourse.courseFlow]}" default="0"/></td>
				
			</tr>
		</c:forEach>
		<c:if test="${empty eduCourseList }">
		   <tr>
		      <td colspan="11">无记录</td>
		   </tr>
		</c:if>	
	</table>
	<c:set var="pageView" value="${pdfn:getPageView(eduCourseList)}" scope="request"></c:set>
	<pd:pagination toPage="toPage"/>
</div>
</div>
</div>
</body>