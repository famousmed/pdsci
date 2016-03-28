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
	function resultList(doctorFlow){
		jboxOpen("<s:url value='/res/teacher/resultList'/>?doctorFlow="+doctorFlow,"轮转计划",600,350);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			待入科人数：<font color="red">${count+0}</font>
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th>住院医师</th>
					<th >当前轮转科室</th>
					<th >预计出科时间</th>
					<th >出科考核表</th>
					<th >出科小结</th>
					<th >带教老师</th>
					<th >科主任</th>
					<th >预计入科时间</th>
					<th >轮转计划</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${doctorProcessList}" var="doctorProcess">
					<c:if test="${!empty resultMap[doctorProcess.userFlow]['nextResult']}">
					<tr>
						<td>${resultMap[doctorProcess.userFlow]['currentResult'].doctorName}</td>
						<td>${doctorProcess.schDeptName}</td>
						<td>${resultMap[doctorProcess.userFlow]['currentResult'].schEndDate}</td>
						<td><a href="#" style="color: blue">出科考核表(90分)</a></td>
						<td><a href="#" style="color: blue">出科小结</a></td>
						<td >${doctorProcess.teacherUserName}</td>
						<td>${doctorProcess.headUserName}</td>
						<td>${resultMap[doctorProcess.userFlow]['nextResult'].schStartDate}</td>
						<td><a href="javascript:resultList('${doctorProcess.userFlow}')" style="color: blue">TA的轮转计划</a></td>
					</tr>
					</c:if>
				</c:forEach>
			</tbody>
			<c:if test="${empty count}">
				<tr><td colspan="9">无记录</td></tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>