<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
</head> 
<body>
<c:set  var="visitFlow" value="${param.visitFlow}"/>
<c:set  var="commAttrCode" value="${param.commAttrCode }"/>
<c:set  var="elementCode" value="${param.elementCode }"/>
<c:set var="edcPatientVisit" value="${patientSubmitVisitMap[visitFlow].edcPatientVisit }"/>
<c:set  var="columnCount" value="${param.columnCount }"/>
<!-- 设置宽度 -->
<c:set  var="attrWidth" value="120px"/>
<c:set var="attrCodeWidth" value="150px" />
<c:if test="${ empty columnCount || (columnCount == '1')}">
	<c:set  var="attrWidth" value=""/>
</c:if>
<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
	<c:if test="${empty columnCount}">
		<c:set  var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
	</c:if>
	<c:if test="${status.index % columnCount eq 0}">
		 <c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" begin='${status.index}' end="${status.index+columnCount-1}">
			<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,patientCrfDataMap[visitFlow][elementCode]['1'],edcPatientVisit.inputOperFlow,edcPatientVisit) }"></c:set>
			<!-- 转换代码 -->
			<c:set var="value" value="${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
			<c:set var="emptyValueWarning" value=""/>
			<c:if test="${empty value }">
					<c:set var="value" value="未录入"/>
					<c:set var="emptyValueWarning" value="red"/>
			</c:if>
			
			<c:set  var="emptyDataKey" value="${edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_1_${attr.attrCode}"/>
			<c:set var="recordFlow" value="${patientCrfDataMap[visitFlow][elementCode]['1'][attr.attrCode].recordFlow }"/>
			<c:if test="${empty recordFlow }"> 
				<c:set var="recordFlow" value="${emptyDataKey}"/>
			</c:if>
			
			<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNewLine eq  GlobalConstant.FLAG_Y 
				or columnCount == '1'}">
					<div style="clear: both !important" attrName="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"></div>
			</c:if>
			<div style="float:left;display:inline-block;min-width:250px;height: 40px;"> 
				<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y || true}">
					<span width="${attrWidth }" id="${recordFlow }" >
						${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：<font style="color: ${emptyValueWarning}">${value}</font>
					</span>
				</c:if>	
			<c:set var="queryTitle" value="${sessionScope.projDescForm.visitMap[visitFlow].visitName}_${sessionScope.projDescForm.moduleMap[param.moduleCode].moduleName }_${sessionScope.projDescForm.elementMap[elementCode].elementName }
			_1_${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}_${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
				&#12288;&#12288;<input type="checkbox" queryTitle="${queryTitle }"  name="recordFlow" value="${recordFlow}" onclick="addSelectedClass(this);"/>
			</div>
		</c:forEach>
		<div style="clear: both !important" ></div>
	</c:if>
</c:forEach>
 </body>