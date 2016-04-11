<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
</head>
<body>
<c:set var="columnNum" value="${sysCfgMap['edc_serial_attr_count'] }"/>
<c:set  var="patientFlow" value="${param.patientFlow }"/>
<c:set  var="visitFlow" value="${param.visitFlow }"/>
<c:set  var="commAttrCode" value="${param.commAttrCode }"/>
<c:set  var="elementCode" value="${param.elementCode }"/>
 <table  class="reptb" >
         <tr>
         	<th width="50px">序号</th> 
        	<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
				<th width="150px;">${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}</th>
			</c:forEach>
			<c:forEach  begin="1" end="${columnNum- fn:length(sessionScope.projDescForm.visitElementAttributeMap[commAttrCode])}" >
				<th  width="150px;"></th>
			</c:forEach>
         </tr>
          <tbody id="${elementCode }_TBODY">
        <c:set var="seqValueMap" value="${elementSerialSeqValueMap[elementCode]}"></c:set>
        <c:choose>
           	<c:when test="${fn:length(seqValueMap)>0}">
           <c:forEach items="${seqValueMap }" var="valueMapRecord">
	           <tr >
	           		<td><div>${valueMapRecord.key }</div></td>
					<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
					<c:set var="dataItem" value="${sessionScope.projDescForm.elementMap[elementCode].elementName }.${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"/>
					<c:set var="emptyDataKey" value="${patientVisitForm.edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_${valueMapRecord.key }_${attr.attrCode}"/>
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
					<c:set  var="attrCodeColor" value=""/>
					<c:set  var="key" value="${patientFlow}_${visitFlow}_${ attr.attrCode}_${valueMapRecord.key }"/>
					<c:if test="${attrSDVQueryMap[key] }">
					<c:set  var="attrCodeColor" value="pink"/>
					</c:if>
					<td  id="${key}" bgcolor="${attrCodeColor}"  class="sdvDiv ">
	 					<a href="javascript:doSdv('${recordFlow }','${emptyDataKey }','${key }','${dataItem }');" style="color: ${emptyValueWarning}">${value }</a>
					</td>				
					</c:forEach>	
					<c:forEach  begin="1" end="${columnNum- fn:length(sessionScope.projDescForm.visitElementAttributeMap[commAttrCode])}" >
						<td ></td>
					</c:forEach>           	
	           </tr>
	           </c:forEach>
	           </c:when>
	           <c:otherwise><!-- 默认存在一条空记录 -->
	           	<tr>
	           		<td>未录入</td>
	           </tr>
	           </c:otherwise>
	           </c:choose>
         </tbody>
 </table>
 </body>