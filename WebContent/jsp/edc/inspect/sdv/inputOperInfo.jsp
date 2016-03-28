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
</head>
<body>
<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
		<table class="xllist">
			<tr>
				<th width="100px">录入员</th>
				<th width="100px">录入状态</th>
				<th width="150px">最后录入时间</th>
			</tr>
				<tr style="height: 20px">
					<td>${edcPatientVisit.inputOper1Name}</td>
					<td>${edcPatientVisit.inputOper1StatusName}</td>
					<td>${pdfn:transDateTime(edcPatientVisit.inputOper1Time)}</td>
				</tr>
				<c:if test="${inputTypeId eq projInputTypeEnumDouble.id && (!empty edcPatientVisit.inputOper2Name )}"> 
				<tr style="height: 20px">
					<td>${edcPatientVisit.inputOper2Name}</td>
					<td>${edcPatientVisit.inputOper2StatusName}</td>
					<td>${pdfn:transDateTime(edcPatientVisit.inputOper2Time)}</td>
				</tr>
				</c:if>
		</table>
		</div></div></div>
</body>
</html>