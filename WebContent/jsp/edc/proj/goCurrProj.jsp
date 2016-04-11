<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID}">
<c:choose>
	<c:when test="${pdfn:contain(sessionScope.currModuleId, sessionScope.currUserModuleIdList)}">
		window.parent.location.href="<s:url value='/main/edc/${sessionScope.currModuleId}'/>?time="+new Date();
	</c:when>
	<c:otherwise>
		window.parent.location.href="<s:url value='/main/edc/'/>?time="+new Date();
	</c:otherwise>
</c:choose>
</c:if>
<c:if test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID}">
window.parent.location.href="<s:url value='/main/gcp/'/>?time="+new Date();
</c:if>
