<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
<link rel="stylesheet" href="<s:url value='/js/jquery-mobile/jquery.mobile-1.3.2.min.css'/>">
<head>
</head>  
<body>  
<div data-role="page">
	<jsp:include page="/jsp/common/page-common-mobile.jsp"></jsp:include>
	<div data-role="header" data-position="fixed" data-theme="b">
		<a href="javascript:window.history.back(-1);" data-role="button">返回</a>
	    <h1>出错了</h1>
	    <a href="<s:url value="/app/edc/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		出错了：${resultName }！
		<br/>
		<br/>
		<a href="javascript:window.history.back(-1);" data-role="button">返回</a>
	</div>

</div>
</body>  
</html>  