<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
<link rel="stylesheet" href="<s:url value='/js/jquery-mobile/jquery.mobile-1.3.2.min.css'/>">
<head>
<script type="text/javascript">
$(document).ready(function(){
	//window.frames['mainIframe'].location.href="<s:url value="/app/crs/login"/>";
});
</script>
</head>
<body>
<!-- <iframe id="mainIframe" name="mainIframe" src="about:blank" data-role="page"></iframe> -->
<jsp:forward page="login.jsp"></jsp:forward>
</body>
</html>