<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<img alt="看不清?请点击刷新!" title="看不清?请点击刷新!" src="${ctxPath}/captcha" onclick="this.src=this.src'">
<img alt="看不清?请点击刷新!" title="看不清?请点击刷新!" src="${ctxPath}/jcaptcha" onclick="this.src=this.src'">
</body>
</html>