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
<c:set  var="attrWidth" value="100px"/>
<c:set  var="attrCodeWidth" value="150px"/>
<c:if test="${ empty columnCount || (columnCount == '1')}">
	<c:set  var="attrWidth" value=""/>
</c:if>
<table  class="reptb" >
         <tr>
         		<th width="50px">序号</th> 
         		<th></th>
         </tr>
          <tbody id="${elementCode }_TBODY">
        <c:set var="seqValueMap" value="${elementSerialSeqValueMap[elementCode]}"></c:set>
        <c:choose>
           <c:when test="${fn:length(seqValueMap)>0}">
           <c:forEach items="${seqValueMap }" var="valueMapRecord">
	           <tr >
	           		<td><div>${valueMapRecord.key }</div></td>
	           			<td>
	           			<table>
						<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
						<c:if test="${empty columnCount}">
								<c:set  var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
						</c:if>
						<c:if test="${status.index % columnCount eq 0}">
							<tr>
								<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr"  begin="${status.index}" end="${status.index+columnCount-1}">
									<c:set var="dataItem" value="${sessionScope.projDescForm.elementMap[elementCode].elementName }.${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"/>
									<c:set  var="emptyDataKey" value="${patientVisitForm.edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_${valueMapRecord.key }_${attr.attrCode}"/>
									<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,patientVisitForm.edcPatientVisit.inputOperFlow ,patientVisitForm.edcPatientVisit) }"></c:set>
									<!-- 转换代码 -->
									<c:set var="value" value="${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
									<c:set var="emptyValueWarning" value=""/>
									<c:if test="${empty value }">
												<c:set var="value" value="未录入"/>
											<c:set var="emptyValueWarning" value="red"/>
									</c:if>
									
									<c:set var="recordFlow" value="${valueMapRecord.value[attr.attrCode].recordFlow }"/>
									<c:if test="${empty recordFlow }"> 
										<c:set var="recordFlow" value="${emptyDataKey}"/>
									</c:if>
									<!-- 强制换行 -->
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNewLine eq  GlobalConstant.FLAG_Y 
										or columnCount == '1'}">
											<div style="clear: both !important" attrName="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"></div>
									</c:if>
									<c:set  var="attrCodeColor" value=""/>
									<c:set  var="key" value="${patientFlow}_${visitFlow}_${ attr.attrCode}_${valueMapRecord.key }"/>
									<c:if test="${attrSDVQueryMap[key] }">
										<c:set  var="attrCodeColor" value="pink"/>
									</c:if>
									<div style="float:left;display:inline-block;min-width:250px;height: 40px;text-align: left;padding-left: 5px;"> 
										<a href="javascript:doSdv('${recordFlow }','${emptyDataKey }','${key }','${dataItem }');">${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：<font style="color: ${emptyValueWarning}">${value }</font></a>
									</div>
								</c:forEach>
								<div style="clear: both !important" ></div>
						</c:if>
						</c:forEach>
						</table>
					</td>				
	           </tr>
	           </c:forEach>
	       </c:when>
	       <c:otherwise><!-- 默认存在一条空记录 -->
	       <tr >
	           	<td>未录入</td>
	           </tr>
	       </c:otherwise>
	       </c:choose>
         </tbody>
 </table>
 </body>