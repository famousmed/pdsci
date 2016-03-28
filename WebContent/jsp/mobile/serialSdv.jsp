<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)},
    "visitFlow" :${pdfn:toJsonString(visitFlow)},
    "moduleCode":"${module.moduleCode }",
    "moduleName":"${module.moduleName }",
    "elementCode":"${elementCode}",
    "elementName":"${elementName}",
    "serialNum":"${serialNum }",
    "recordFlow":"${recordFlow}",
    "moduleShortName":"${module.moduleShortName }"
    <c:if test="${resultId eq '200' }">
    ,
    <c:set var="commCode" value="${visitFlow}_${module.moduleCode }"/>
   	"attributes":[
   			<c:set var="commAttrCode" value="${visitFlow}_${module.moduleCode}_${elementCode}"/>
     		 <c:forEach items="${projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" varStatus="status1">
     		  <c:set var="record" value="${elementSerialSeqValueMap[elementCode][serialNum][attr.attrCode]}"/>
     		 	{
     		 		"recordFlow":"${record.recordFlow }",
     		 		"attrCode": "${attr.attrCode}",
     		 		"attrName": "${projDescForm.attrMap[attr.attrCode].attrName}",
     		 		"isViewName": "${projDescForm.attrMap[attr.attrCode].isViewName}",
     		 		<c:set var="commCodeFlow" value="${commAttrCode}_${attr.attrCode}"/>
		 			<c:choose>
	 					<c:when test="${!empty projDescForm.visitAttrCodeMap[commCodeFlow]}">
	 						<c:set var="value_ch" value="${pdfn:getAttrValue(projDescForm,attr.attrCode,record.attrValue) }"/>
	 						"inputValue":"${value_ch}"
	 					</c:when>
	 					<c:otherwise>
	 						"inputValue":"${record.attrValue}"
	 					</c:otherwise>
	 				</c:choose>
     		 	}	
     		  <c:if test="${not status1.last }">
				,
			  </c:if>
		 
  		 </c:forEach>
  		 ]
    </c:if>
})
