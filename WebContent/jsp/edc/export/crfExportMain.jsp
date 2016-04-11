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
<style type="text/css">
.selected {
background-color:pink;
}
</style>
</head>
<script type="text/javascript">
function search(type){
	window.location.href="<s:url value='/edc/export/crfExport?orgFlow='/>"+$("#orgFlow").val()+"&patientFlow="+$("#patientFlow").val()+"&type="+type;
}

function exportEmptyCrf(){
	window.location.href="<s:url value='/edc/visit/exportEmptyCrf'/>?soureType=patient&orgFlow="+$("#orgFlow").val()+"&patientFlow="+$("#patientFlow").val();
}
</script>
<body>

<div class="title1 clearfix" style="width: 100%"> 
	<table width="100%" >
		<tr>
			<td style="width: 600px">
				&#12288;&#12288;参与机构：
			<select id="orgFlow"  name="orgFlow" class="xlname" style="width:200px;" onchange="search('org');">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select>
		     	&#12288;&#12288;受试者编号：
				 <select id="patientFlow"  name="patientFlow"  style="width:100px;" onchange="search('patient');">
					<option value=""></option>
					<c:forEach items="${patientList}" var="patient">
						<option value="${patient.patientFlow}" <c:if test="${patient.patientFlow==patientFlow }">selected</c:if>>${patient.patientCode}</option>
					</c:forEach>
				</select> 
				<c:choose>
					 <c:when test="${empty orgFlow}">
					 	<font color=red>&#12288;请选择参与机构和受试者编号！</font>
					 </c:when>
					 <c:when test="${empty patientFlow}">
					 	<font color=red>&#12288;请选择受试者编号！</font>
					 </c:when>
				 </c:choose> 
				 <c:if test="${!empty sessionScope.projDescForm.visitList}">
				 	&#12288;<input type="button" value="导&#12288;出" class="search" onclick="exportEmptyCrf();"/>
				 </c:if>
		</td>
		</tr>
	</table>
	<hr/>
</div>
<div class="main_fix">
<div id="main">
<div>
<form id="manualForm" style="height: 100%;position: relative;">
<c:set var="submitVisitNum" value="0"></c:set>
<c:forEach items="${sessionScope.projDescForm.visitList}" var="visit">
<c:if test="${!empty patientSubmitVisitMap[visit.visitFlow] }">
<c:set var="submitVisitNum" value="${submitVisitNum+1 }"></c:set>
<div align="center" style="font-size: 15px;font-weight:bold;">访视：<font color="blue">${visit.visitName }</font></div>
<div>
 <c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
 <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
 <c:set var="commCode" value="${visit.visitFlow }_${moduleCode }"></c:set>
 <fieldset>
 	<legend>${visitModule.moduleName}</legend>
 		<table class="basic" width="100%" >
	 		<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<!-- 设置moduleCode -->
	 		<c:if test="${!empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitElement.moduleCode }"></c:set>
	 		</c:if>
	 		<c:if test="${empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
	 		</c:if>
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}"></c:set>
	 		<c:set var="columnCount" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].columnCount }"></c:set>	
	 		<c:if test="${empty sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId || moduleStyleEnumSingle.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr>
	 				<th width="15%"> 
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
	 				</th>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="crfExport_single.jsp" flush="true"> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.elementAttrMap[visitElement.elementCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
	 				<td>
	 					<jsp:include page="crfExport_serial.jsp" flush="true"> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 					</jsp:include>
	 				</td>
	 				</c:when>
	 				<c:otherwise>
	 					<td>
	 					<jsp:include page="crfExport_serial_vertical.jsp" flush="true"> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 					</jsp:include>
	 				</td>
	 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
	 		</c:if>
	 		<c:if test="${moduleStyleEnumDouble.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr>
	 				<th style="text-align: left;padding-left: 10px;"> 
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }
	 				</th>
	 			</tr>
	 			<tr>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="crfExport_single.jsp" flush="true"> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.elementAttrMap[visitElement.elementCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
	 				<td>
	 					<jsp:include page="crfExport_serial.jsp" flush="true"> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 					</jsp:include>
	 				</td>
	 				</c:when>
	 				<c:otherwise>
	 					<td>
	 					<jsp:include page="crfExport_serial_vertical.jsp" flush="true"> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 					</jsp:include>
	 				</td>
	 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
	 		</c:if>
	 		</c:forEach>
 		</table></fieldset>
 </c:forEach>
</div>
 </c:if>
</c:forEach>
<c:if test="${submitVisitNum eq 0 && !empty orgFlow && !empty patientFlow}">
	 <div align="center" style="font-size: 14px;"><font color=red>该受试者尚无录入完成的访视！</font></div>
</c:if>
</form>
</div>
</div></div>
</body>
</html>