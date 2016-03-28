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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>

<script type="text/javascript">
	
</script>
</head>
	<body>
		<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div style="text-align: center;padding-top: 10px;">
				<b>受试者编号：</b>${patient.patientCode }&#12288;<b>受试者姓名缩写：</b>${patient.patientNamePy }&#12288;
				<b>性别：</b>${patient.sexName }&#12288;<b>年龄：</b>${patient.patientAge }&#12288;
				<b>入组日期：</b>${pdfn:transDate(patient.inDate)}&#12288;
			</div>
			<div class="title1" style="margin-top: 10px;">
			<table class="xllist">
				<thead>
				<tr>
					<th width="30%">访视名称</th>
					<th width="30%">访视窗</th>
					<th width="20%">访视日期</th>
					<th width="10%">是否超窗</th>
					<th width="10%">超窗天数</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${visitList}" var="visit">
					<c:set value="${windowMap[visit.visitFlow]}" var="window"/>
					<tr>
						<td width="30%">${visit.visitName}</td>
						<td width="30%">
							${!empty window.windowLeft?'计划：':''}${window.windowLeft}${!empty window.windowLeft?'~':''}${window.windowRight}
							<br>
							${!empty window.windowVisitLeft?'实际：':''}${window.windowVisitLeft}${!empty window.windowVisitLeft?'~':''}${window.windowVisitRight}
						</td>
						<td width="20%">${window.visitDate}</td>
						<td width="10%">${!empty window.visitDate?(empty window.outWindowTypeName?'否':window.outWindowTypeName):''}</td>
						<td width="10%">${window.outWindowDays}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table></div>
			<div align="center">
				<input type="button" value="关&#12288闭" class="search" onclick="jboxClose();"/>
			</div>
		</div></div></div>
</body>
</html>