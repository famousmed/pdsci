<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
})
