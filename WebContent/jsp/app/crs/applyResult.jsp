<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<head> 
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
</head>  
<body>  
<div data-role="page">
	<jsp:include page="/jsp/common/page-common-mobile.jsp"></jsp:include>
	<div data-role="header" data-position="fixed">
		<a href="<s:url value="/app/crs/patientList?userFlow=${param.userFlow}&projFlow=${param.projFlow}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${projName}</h1>
	    <a href="<s:url value="/app/crs/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		<h3>入组申请结果</h3>
		${applyResult}<br/>
	</div>
</div>
</body>  
</html>  