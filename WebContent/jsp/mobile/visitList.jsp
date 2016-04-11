<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId eq '200' }">
    ,
    "visitList":[
	   <c:forEach items="${visitList}" var="visit" varStatus="status">
	   		 {
	            "visitFlow": "${visit.visitFlow}",
	            "visitName": "${visit.visitName}",
	            <c:if test="${!empty edcVisitMap[visit.visitFlow]}">
		            <c:choose>
		            	<c:when test="${edcVisitMap[visit.visitFlow].inputOper1Flow==userFlow }">
		            		"inputStatusId":"${edcVisitMap[visit.visitFlow].inputOper1StatusId}",
		            	</c:when>
		            	<c:when test="${edcVisitMap[visit.visitFlow].inputOper2Flow==userFlow }">
		            		"inputStatusId":"${edcVisitMap[visit.visitFlow].inputOper2StatusId}",
	            		</c:when>
	            		<c:otherwise>
	            			"inputStatusId":"",
	            		</c:otherwise>
		            </c:choose>
	            </c:if>
	            "moduleList":[
	            <c:forEach items="${visitModuleListMap[visit.visitFlow]}" var="module" varStatus="status1">
	            	{
	            		"moduleCode":"${module.moduleCode }",
	            		"moduleName":"${module.moduleName }"
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