<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)},
    "visitFlow": ${pdfn:toJsonString(visitFlow)}
    <c:if test="${resultId eq '200' }">
    ,
    "recordFlow":"${edcPatientVisit.recordFlow }",
    "sdvOperName":"${edcPatientVisit.sdvOperName }",
    "sdvOperStatusName":"${edcPatientVisit.sdvOperStatusName}",
    "sdvOperTime":"${pdfn: transDateTime(edcPatientVisit.sdvOperTime)}",
    "modules":[ 
	    <c:forEach items="${projDescForm.visitModuleMap[visitFlow]}" var="module" varStatus="status">
   		  <c:set var="commCode" value="${visitFlow}_${module.moduleCode }"/>
	    	{
	    		"moduleCode": "${module.moduleCode}",
	    		"moduleName":"${projDescForm.moduleMap[module.moduleCode].moduleName}",
	    		"elements":[
	    		<c:forEach items="${projDescForm.visitModuleElementMap[commCode]}" var="element" varStatus="status1">
	    			 {
				        "elementCode": "${element.elementCode}",
				        "elementName": "${projDescForm.elementMap[element.elementCode].elementName}",
				        "elementSerial": "${projDescForm.elementMap[element.elementCode].elementSerial}",
				        <c:choose>
				        	<c:when test="${projDescForm.elementMap[element.elementCode].elementSerial=='N'}">
				       	"attributes":[
				       		<c:set var="commAttrCode" value="${visitFlow}_${module.moduleCode}_${element.elementCode}"/>
				       		 <c:forEach items="${projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" varStatus="status2">
				       		 <c:set var="record" value="${elementSerialSeqValueMap[element.elementCode]['1'][attr.attrCode]}"/>
				       		 	{
				       		 		"recordFlow":"${record.recordFlow}",
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
					       		  <c:if test="${not status2.last }">
									,
								  </c:if>
				       		 </c:forEach>
				       	]
				        	</c:when>
				        	<c:otherwise>
				        		"elementSerialNum":${fn:length(elementSerialSeqValueMap[element.elementCode])}
				        	</c:otherwise>
				        </c:choose>
		    		}
		    		 <c:if test="${not status1.last }">
								,
						</c:if>
		    		</c:forEach>
	    		]
	    	}
  		     <c:if test="${not status.last }">
						,
			</c:if>
	 	</c:forEach>
    ]
    </c:if>
})
