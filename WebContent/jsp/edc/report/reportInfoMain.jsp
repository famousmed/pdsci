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
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
</head>
<body>
<div style="margin-top: -30px" class="main_fix">
 <c:forEach items="${sessionScope.projDescForm.visitModuleMap[visitFlow]}" var="visitModule" >
 <c:set var="commCode" value="${visitFlow}_${moduleCode}"></c:set>
 <c:if test="${visitModule.moduleCode eq param.moduleCode}">
<div align="center" style="font-size: 15px;font-weight:bold;">访视：<font color="blue">${visit.visitName }</font></div>
 <fieldset>
 	<legend>${visitModule.moduleName}</legend>
 		<table class="basic" width="100%" height="100%">
	 		<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${visitModule.moduleCode }_${ visitElement.elementCode}"></c:set>
	 		<c:set var="columnCount" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].columnCount }"></c:set>
	 		<c:if test="${empty sessionScope.projDescForm.moduleMap[moduleCode].moduleStyleId || moduleStyleEnumSingle.id eq sessionScope.projDescForm.moduleMap[moduleCode].moduleStyleId}">
	 			<tr>
	 				<th width="10%">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
	 				</th>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="report_single.jsp" flush="true">
		 						<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.elementAttrMap[visitElement.elementCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
	 				<td>
	 					<jsp:include page="report_serial.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 							<jsp:param name="seq" value="${seq }" />
	 					</jsp:include>
	 				</td>
	 				</c:when>
	 				<c:otherwise>
	 					<td>
	 					<jsp:include page="report_serial_vertical.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 							<jsp:param name="seq" value="${seq }" />
	 					</jsp:include>
	 				</td>
	 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
			</c:if>
			<c:if test="${moduleStyleEnumDouble.id eq sessionScope.projDescForm.moduleMap[moduleCode].moduleStyleId}">
				<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName };
	 				</th>
	 			</tr>
	 			<tr>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="report_single.jsp" flush="true">
		 						<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.elementAttrMap[visitElement.elementCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
	 				<td>
	 					<jsp:include page="report_serial.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 							<jsp:param name="seq" value="${seq }" />
	 					</jsp:include>
	 				</td>
	 				</c:when>
	 				<c:otherwise>
	 					<td>
	 					<jsp:include page="report_serial_vertical.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 							<jsp:param name="seq" value="${seq }" />
	 					</jsp:include>
	 				</td>
	 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
			</c:if>	
	 		</c:forEach>
 		</table></fieldset>
 		</c:if>
 </c:forEach>
</div>
</body>
</html>