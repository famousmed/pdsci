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
</head>
<body>
	<table class="xllist FixedTables">
		<c:forEach items="${projOrgList}" var="projOrg">
		<c:set var="leaderOrgName" value=""></c:set>
			<tr>
				<td style="text-align:center;" width="8%">${projOrg.centerNo }</td>
				<td style="text-align:center;" width="10%">${projOrg.orgTypeName }</td>
				<td style="text-align:left;" width="30%">${projOrg.orgName }</td>
				<td style="text-align:left;" width="25%">承担病例数：${projOrg.patientCount }</td>
				<td style="text-align:left;" width="27%">主要研究者：${projOrg.researcher }
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>