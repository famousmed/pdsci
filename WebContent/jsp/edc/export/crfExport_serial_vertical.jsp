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
<c:set  var="attrCodeWidth" value="150px"/>
<c:if test="${ empty columnCount || (columnCount == '1')}">
	<c:set  var="attrWidth" value=""/>
</c:if>
 <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">	
         <tr>
         		<th width="50px">序号</th> 
         		<th></th>
         </tr>
          <tbody id="${elementCode }_TBODY">
        <c:set var="seqValueMap" value="${patientCrfDataMap[visitFlow][elementCode]}"></c:set>
         <c:choose>
           	<c:when test="${fn:length(seqValueMap)>0}">
           <c:forEach items="${seqValueMap }" var="valueMapRecord">
	           <tr >
	           		<td><div>${valueMapRecord.key }</div></td>
	           		<td >
	           		<table>
						<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
						<c:if test="${empty columnCount}">
							<c:set  var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
						</c:if>
						<c:if test="${status.index % columnCount eq 0}">
							<tr>
								<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr"  begin='${status.index}' end="${status.index+columnCount-1}">
								<c:set  var="emptyDataKey" value="${edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_${valueMapRecord.key }_${attr.attrCode}"/>
								<c:set var="recordFlow" value="${patientCrfDataMap[visitFlow][elementCode][valueMapRecord.key][attr.attrCode].recordFlow }"/>
								<c:if test="${empty recordFlow }"> 
									<c:set var="recordFlow" value="${emptyDataKey}"/>
								</c:if>
								<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,edcPatientVisit.inputOperFlow ,edcPatientVisit) }"></c:set>
								<c:if test="${empty value && sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
									<c:set var="value" value="${sessionScope.projDescForm.elementStandardUnitMap[elementCode] }" />
								</c:if>
				 					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
				 					<td style="width:${attrWidth};text-align: right ;border: none;line-height:25px;" id="${recordFlow }">
				 					${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }:
				 					</td>
				 					</c:if>
				 					<td style="width:${attrCodeWidth};text-align: left ;border: none;line-height:25px;">
				 					${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }&#12288;&#12288;
								</td>
								</c:forEach>
							</tr>	
						</c:if>
						</c:forEach>
					</table>          	
					</td>				
	           </tr>
	           </c:forEach>
	           </c:when>
	           <c:otherwise><!-- 默认存在一条空记录 -->
	           	<tr >
	           		<td><div>1</div></td>
	           		<td >
	           		<table>
						<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
						<c:if test="${empty columnCount}">
							<c:set  var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
						</c:if>
						<c:if test="${status.index % columnCount eq 0}">
							<tr>
								<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr"  begin='${status.index}' end="${status.index+columnCount-1}">
								<c:set  var="emptyDataKey" value="${edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_1_${attr.attrCode}"/>
								<c:set var="recordFlow" value="${patientCrfDataMap[visitFlow][elementCode][1][attr.attrCode].recordFlow }"/>
								<c:if test="${empty recordFlow }"> 
									<c:set var="recordFlow" value="${emptyDataKey}"/>
								</c:if>
								<c:set var="value" value=""></c:set>
				 					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
				 					<td style="width:${attrWidth};text-align: right ;border: none;line-height:25px;" id="${recordFlow }">
				 					${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }:
				 					</td>
				 					</c:if>
				 					<td style="width:${attrCodeWidth};text-align: left ;border: none;line-height:25px;">
				 					${value }&#12288;&#12288;
								</td>
								</c:forEach>
							</tr>	
						</c:if>
						</c:forEach>
					</table>          	
					</td>				
	           </tr>
	           </c:otherwise>
	           </c:choose>
         </tbody>
 </table>
 </body>