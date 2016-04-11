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
		课程类别：${course.courseCategoryName }
	</div>
	<table class="xllist">
		<tr>
			<th width="5%">序号</th>
			<th width="20%">修改时间</th>
			<th width="15%">科室</th>
			<th width="15%">修改人</th>
			<th width="10%">类别</th>
			<th width="40%">操作内容</th>
		</tr>
		<c:forEach items="${logs}" var="log" varStatus="status">
			<tr>
				<td>${status.index+1 }</td>
				<td>${pdfn:transDateForPattern(log.logTime,'yyyy-MM-dd HH:mm:ss') }</td>
				<td>${log.deptName }</td>
				<td>${log.userName }</td>
				<td>${log.reqTypeName }</td>
				<td>${log.logDesc }</td>
			</tr>
		</c:forEach>
		<c:if test="${empty logs }">
			<tr>
				<td colspan="6">无记录</td>
			</tr>
		</c:if>
	</table>
	</div>
	</div>
</body>
</html>