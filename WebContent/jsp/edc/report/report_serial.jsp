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
<c:set  var="seq" value="${param.seq }"/>
 <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">	
         <tr>
         		<th width="50px">序号</th> 
         		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
            	<th >${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }</th>
              </c:forEach>
         </tr>
          <tbody id="${elementCode }_TBODY">
        <c:set var="seqValueMap" value="${elementSerialSeqValueMap[elementCode]}"></c:set>
           <c:forEach items="${seqValueMap }" var="valueMapRecord">
	          <c:if test="${valueMapRecord.key == seq}">
	          	 <tr >
	           		<td><div>${valueMapRecord.key }</div></td>
					<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
					<c:set  var="emptyDataKey" value="${patientVisitForm.edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_${valueMapRecord.key }_${attr.attrCode}"/>
					<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,patientVisitForm.edcPatientVisit.inputOperFlow ,patientVisitForm.edcPatientVisit) }"></c:set>
					
					<!-- 转换代码 -->
					<c:set var="value" value="${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
					<c:if test="${empty value }">
							<c:set var="value" value="&#12288;"/>
					</c:if>
					
					<c:set var="recordFlow" value="${valueMapRecord.value[attr.attrCode].recordFlow }"/>
					<c:if test="${empty recordFlow }"> 
						<c:set var="recordFlow" value="${emptyDataKey}"/>
					</c:if>
					<c:set  var="attrCodeColor" value=""/>
					<c:set  var="key" value="${patientFlow}_${visitFlow}_${ attr.attrCode}_${valueMapRecord.key }"/>
					<c:if test="${attrSDVQueryMap[key] }">
					<c:set  var="attrCodeColor" value="pink"/>
					</c:if>
					<td>
	 					${value }
					</td>				
					</c:forEach>	           	
	           </tr>
	          </c:if>
	           </c:forEach>
         </tbody>
 </table>
 </body>