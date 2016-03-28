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
<!-- 设置宽度 -->
<c:set  var="attrWidth" value="120px"/>
<c:set  var="attrCodeWidth" value="150px"/>
<c:if test="${ empty columnCount || (columnCount == '1')}">
	<c:set  var="attrWidth" value=""/>
</c:if>
<table>
 <c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
	<c:if test="${empty columnCount}">
		<c:set  var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
	</c:if>
	<c:if test="${status.index % columnCount eq 0}"> 
		<tr>
		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" begin='${status.index}' end="${status.index+columnCount-1}" >
			<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[elementCode]['1'],patientVisitForm.edcPatientVisit.inputOperFlow ,patientVisitForm.edcPatientVisit) }"></c:set>
			<!-- 转换代码 -->
			<c:set var="value" value="${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
			<c:if test="${empty value }">
					<c:set var="value" value="&#12288;"/>
			</c:if>
			
			<c:set  var="emptyDataKey" value="${patientVisitForm.edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_1_${attr.attrCode}"/>
			<c:set var="recordFlow" value="${elementSerialSeqValueMap[elementCode]['1'][attr.attrCode].recordFlow }"/>
			<c:if test="${empty recordFlow }"> 
				<c:set var="recordFlow" value="${emptyDataKey}"/>
			</c:if>
			<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
				<td style="width:${attrWidth};text-align: right ;border: none;" >
				${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
				</td>
			</c:if>	
			<td style="width:${attrCodeWidth};text-align: left ;border: 0;vertical-align:middle;" >
				${value}
			</td> 
		</c:forEach> 
		</tr>
	</c:if>
</c:forEach>
</table>
 </body>