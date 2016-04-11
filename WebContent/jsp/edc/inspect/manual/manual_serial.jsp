<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
</head>
<body>
<c:set var="columnNum" value="${sysCfgMap['edc_serial_attr_count'] }"/>
<c:set  var="visitFlow" value="${param.visitFlow}"/>
<c:set  var="commAttrCode" value="${param.commAttrCode }"/>
<c:set  var="elementCode" value="${param.elementCode }"/>
<c:set var="edcPatientVisit" value="${patientSubmitVisitMap[visitFlow].edcPatientVisit }"/>
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
        <c:set var="seqValueMap" value="${patientCrfDataMap[visitFlow][elementCode]}"></c:set>
        <c:choose>
           	<c:when test="${fn:length(seqValueMap)>0}">
            <c:forEach items="${seqValueMap }" var="valueMapRecord">
	           <tr >
	           		<td><div>${valueMapRecord.key }</div></td>
					<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
					<c:set  var="emptyDataKey" value="${edcPatientVisit.recordFlow }_${param.moduleCode}_${elementCode }_${valueMapRecord.key }_${attr.attrCode}"/>
					<c:set var="recordFlow" value="${patientCrfDataMap[visitFlow][elementCode][valueMapRecord.key][attr.attrCode].recordFlow }"/>
					<c:if test="${empty recordFlow }">
						<c:set var="recordFlow" value="${emptyDataKey}"/>
					</c:if>
					<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,edcPatientVisit.inputOperFlow ,edcPatientVisit) }"></c:set>
	 				<!-- 转换代码 -->
					<c:set var="value" value="${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
					<c:set var="emptyValueWarning" value=""/>
					<c:if test="${empty value }">
							<c:set var="value" value="未录入"/>
							<c:set var="emptyValueWarning" value="red"/>
					</c:if>	
	 				<td>
	 					${value}
						<c:set var="queryTitle" value="${sessionScope.projDescForm.visitMap[visitFlow].visitName}_${sessionScope.projDescForm.moduleMap[param.moduleCode].moduleName }_${sessionScope.projDescForm.elementMap[elementCode].elementName }
						_${valueMapRecord.key }_${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}_${pdfn:getAttrValue(sessionScope.projDescForm,attr.attrCode,value) }"/>
						&#12288;&#12288;<input type="checkbox" queryTitle="${queryTitle }"  name="recordFlow" value="${recordFlow}"  onclick="addSelectedClass(this);"/> 
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