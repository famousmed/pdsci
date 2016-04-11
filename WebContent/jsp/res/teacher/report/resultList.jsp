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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				医师姓名：
				&#12288;
				届数：${doctor.sessionNumber}
				&#12288;
				培训专业：${doctor.trainingSpeName}
				&#12288;
				轮转方案：${doctor.rotationName}
			</div>
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th>轮转科室</th>
					<th>轮转届数</th>
					<th>开始时间</th>
					<th>结束时间</th>
					
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result">
					<tr>
						<td>${result.schDeptName}</td>
						<td>${result.schYear}</td>
						<td>${result.schStartDate}</td>
						<td>${result.schEndDate}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${empty resultList}">
				<tr><td colspan="9">无记录</td></tr>
			</c:if>
		</table>
		<div align="center" style="margin-top: 10px;">
			<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
		</div>
	</div>
</div>
</body>
</html>