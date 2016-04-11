<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)},
    "projFlow": ${pdfn:toJsonString(projFlow)},
    "projName": ${pdfn:toJsonString(projName)},
     "orgFlow": ${pdfn:toJsonString(orgFlow)},
    "orgName": ${pdfn:toJsonString(orgName)}
    <c:if test="${resultId eq '200' }">
    ,
    "patientList":[
	   <c:forEach items="${patientList }" var="patient" varStatus="status">
	   		 {
	            "patientFlow": "${patient.patientFlow}",
	            "patientName": "${patient.patientName}",
	            "sexName": "${patient.sexName }",
	            "pack":"${!empty randomMap[patient.patientFlow] ? randomMap[patient.patientFlow].drugPack:''}",
	            <c:if test="${!empty randomMap[patient.patientFlow]}">
		            <c:choose>
		            	<c:when test="${projParam.blindTypeId=='N'}">
		            		 "group":"${randomMap[patient.patientFlow].drugGroup}",
		            	</c:when>
		            	<c:when test="${projParam.blindTypeId=='Y' && randomMap[patient.patientFlow].promptStatusId eq edcRandomPromptStatusEnumPrompted.id}">
		            		 "group":"${randomMap[patient.patientFlow].drugGroup}",
		            	</c:when>
		            	<c:otherwise>
		            		 "group":"",
		            	</c:otherwise>
	            	</c:choose>
	            </c:if>
	            "inDate": "${pdfn:transDate(patient.inDate)}"
        	}
        <c:if test="${not status.last }">
				,
		</c:if>
	   </c:forEach>
    ]
    </c:if>
})