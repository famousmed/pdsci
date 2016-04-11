<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
</jsp:include>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		课程名称：${course.courseName }&#12288;
		课程类别：${course.courseCategoryName }&#12288;
		发布科室：${course.deptName }
	</div>
	<table class="xllist">
		<tr>
			<th width="7%">学员姓名</th>
			<th width="7%">工号</th>
			<th width="7%">职称</th>
			<th width="10%">基地</th>
			<th width="7%">人员类别</th>
			<th width="7%">当前科室</th>
			<th width="7%">开始学习时间</th>
			<th width="7%">完成学习时间</th>
			<th width="7%">考生得分</th>
			<th width="7%">试卷总分</th>
			<th width="7%">合格分数线</th>
			<th width="7%">考试时间</th>
		</tr>
		<c:forEach items="${stuCourses}" var="stuCourse">
			<c:set var="userFlow"  value="${stuCourse.userFlow }"/>
			<tr>
				<td>${userMap[userFlow].userName }</td>
				<td>${doctorMap[userFlow].doctorCode }</td>
				<td>${userMap[userFlow].titleName }</td>
				<td>${doctorMap[userFlow].orgName }</td>
				<td>${doctorMap[userFlow].doctorCategoryName }</td>
				<td>${doctorMap[userFlow].deptName }</td>
				<td>${stuCourse.startStudyTime }</td>
				<td>${stuCourse.completeStudyTime }</td>
				<td>${stuCourse.courseGrade }</td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</c:forEach>
		<c:if test="${empty stuCourses }">
			<tr>
				<td colspan="12">无记录</td>
			</tr>
		</c:if>
	</table>
	</div>
	</div>
</body>
</html>