<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId eq '200' }">
    ,
    "images": [
          <c:forEach items="${dataList}" var="dataMap" varStatus="status">
	     	{
	     		"imageFlow": ${pdfn:toJsonString(dataMap.imageFlow)},
				"imageUrl": ${pdfn:toJsonString(dataMap.imageUrl)},
				"thumbUrl":${pdfn:toJsonString(dataMap.thumbUrl)},
				"time":${pdfn:toJsonString(dataMap.time)},
				"note":${pdfn:toJsonString(dataMap.note)}
			}
			<c:if test="${not status.last }">
				,
			</c:if>
    	 </c:forEach>
    ]
    </c:if>
}
)
