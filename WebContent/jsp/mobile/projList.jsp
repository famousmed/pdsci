<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId eq '200' }">
    ,
    "projList":[
	   <c:forEach items="${projList }" var="proj" varStatus="status">
	   		 {
	            "projFlow": "${proj.projFlow}",
	            "projName": "${proj.projName}",
	            "projNo": "${proj.projNo}",
            	"randomTypeName": "${projMap[proj.projFlow]['randomTypeName']}",
            	"blindTypeName": "${projMap[proj.projFlow]['blindTypeName']}",
            	"visitNum": "${projMap[proj.projFlow]['visitNum']}",
            	"totalPatientCount": "${projMap[proj.projFlow]['totalPatientCount']}",
            	"totalInSum": "${projMap[proj.projFlow]['totalInSum']}",
	            "projSubTypeName": "${proj.projSubTypeName}",
	            "projDeclarer":"${proj.projDeclarer}",
	            "orgList":[
	            <c:forEach items="${projOrgMap[proj.projFlow]}" var="org" varStatus="status1">
	            	{
	            		"orgFlow":"${org.orgFlow }",
	            		"orgName":"${org.centerNo }.${org.orgName }",
	            		"inCount":"${projOrgCountMap[proj.projFlow][org.orgFlow]}" 
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