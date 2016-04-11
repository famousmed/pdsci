<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
${callback}({
    "resultId": ${resultId},
    "resultName": ${pdfn:toJsonString(resultName)}
    <c:if test="${resultId eq '200' }">
    ,
    "userInfo": {
        "userFlow": ${pdfn:toJsonString(userinfo.userFlow)},
        "userName": ${pdfn:toJsonString(userinfo.userName)},
        "userPhone": ${pdfn:toJsonString(userinfo.userPhone)},
        "userEmail": ${pdfn:toJsonString(userinfo.userEmail)},
        "orgName": ${pdfn:toJsonString(userinfo.orgName)},
        "roleId": ${pdfn:toJsonString(roleId)},
        "roleName": ${pdfn:toJsonString(roleName)},
        "userSex": "${userinfo.sexName}"
    }
    </c:if>
})
