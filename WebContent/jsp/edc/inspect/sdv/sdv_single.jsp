<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
</head> 
<body>
<c:set  var="patientFlow" value="${param.patientFlow }"/>
<c:set  var="visitFlow" value="${param.visitFlow }"/>
<c:set  var="commAttrCode" value="${param.commAttrCode }"/>
<c:set  var="elementCode" value="${param.elementCode }"/>
<c:set  var="columnCount" value="${param.columnCount }"/>
<c:set var="fixWidth" value="${param.fixWidth }" />
<c:set var="moduleFlow" value="${param.moduleFlow}" />
<!-- 设置宽度 -->
<c:set var="attrWidth" value="120px" />
	<c:set var="attrCodeWidth" value="150px" />
<c:if test="${ empty columnCount || (columnCount == '1')}">
	<c:set var="attrWidth" value="" />
</c:if>
 <c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
	<c:if test="${empty columnCount}">
		<c:set  var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
	</c:if>
	<c:if test="${status.index % columnCount eq 0}">
		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" begin='${status.index}' end="${status.index+columnCount-1}" >
			<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[elementCode]['1'],patientVisitForm.edcPatientVisit.inputOperFlow ,patientVisitForm.edcPatientVisit) }"></c:set>
			<!-- 转换代码 -->
			<c:set var="value" value="${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
			<c:set var="emptyValueWarning" value=""/>
			<c:if test="${empty value }">
					<c:set var="value" value="未录入"/>
					<c:set var="emptyValueWarning" value="red"/>
			</c:if>
			
			<c:set var="dataItem" value="${sessionScope.projDescForm.elementMap[elementCode].elementName }.${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"/>
			<c:set var="emptyDataKey" value="${patientVisitForm.edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_1_${attr.attrCode}"/>
			<c:set var="recordFlow" value="${elementSerialSeqValueMap[elementCode]['1'][attr.attrCode].recordFlow }"/>
			<c:if test="${empty recordFlow }"> 
				<c:set var="recordFlow" value="${emptyDataKey}"/>
			</c:if>
			<!-- 强制换行 -->
			<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNewLine eq  GlobalConstant.FLAG_Y 
				or columnCount == '1'}">
					<div style="clear: both !important" attrName="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"></div>
			</c:if>
			<div style="float:left;display:inline-block;min-width:250px;height: 40px;"> 
				<c:set  var="attrCodeColor" value=""/>
				<c:set  var="key" value="${patientFlow}_${ visitFlow}_${ attr.attrCode}_1"/>
				<c:if test="${attrSDVQueryMap[key] }">
					<c:set  var="attrCodeColor" value="pink"/>
				</c:if>
				<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y || true}">
					<span width="${attrWidth }" bgcolor="${attrCodeColor}"> 
						<a href="javascript:doSdv('${recordFlow }','${emptyDataKey }','${key }','${dataItem }');" >${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：<font style="color: ${emptyValueWarning}">${value}</font></a>
					</span>
				</c:if>	
			</div>
		</c:forEach> 
		<div style="clear: both !important" ></div>
	</c:if>
</c:forEach>
 </body>