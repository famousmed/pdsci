<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId eq '200' }">
    ,
    "signature": "${sign["signature"]}",
    "jsapi_ticket":"${sign.jsapi_ticket}",
     "noncestr": "${sign.nonceStr }",
     "timestamp": "${sign.timestamp }",
     "url":"${sign.url }"
    </c:if>
})
