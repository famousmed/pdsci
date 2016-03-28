<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId==200 }">
    ,
     "sdvOperName":"${edcPatientVisit.sdvOperName }",
    "sdvOperStatusName":"${edcPatientVisit.sdvOperStatusName}",
    "sdvOperTime":"${pdfn: transDateTime(edcPatientVisit.sdvOperTime)}"
    </c:if>
})
