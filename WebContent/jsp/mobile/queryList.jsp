<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId eq '200' }">
    ,
    "queryList":[
	   <c:forEach items="${queryList }" var="query" varStatus="status">
	   		 {
	            "queryFlow": "${query.queryFlow}",
	            "sendWayName":"${query.sendWayName}",
	            "solveStatusId": "${query.solveStatusId}",
	            "solveStatusName": "${query.solveStatusName}",
	             "sendUserName": "${query.sendUserName}",
	             "solveTime": "${pdfn:transDate(query.solveTime)}",
	             "solveUserName": "${query.solveUserName}",
	            "queryTypeName": "${query.queryTypeName}",
	            "sendTime":"${pdfn:transDateTime(query.sendTime) }",
	            "sendUserName":"${query.sendUserName }",
	            "data":[
	            	<c:forEach items="${queryEventMap[query.queryFlow] }" var="data" varStatus="status1">
	            		{
	            			"moduleName":"${data.moduleName }",
	            			"elementName":"${data.elementName }",
	            			"elementSerialSeq":"${data.elementSerialSeq}",
	            			"attrName":"${data.attrName }",
	            			"attrValue":"${data.attrValue }",
	            			"attrEventValue":"${data.attrEventValue }"
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