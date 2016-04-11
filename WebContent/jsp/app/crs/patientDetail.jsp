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
		<a href="<s:url value="/app/crs/patient?userFlow=${param.userFlow}&projFlow=${param.projFlow}&patientFlow=${patientInfo['patientFlow']}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${projName}</h1>
	    <a href="<s:url value="/app/crs/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		<c:if test="${applyForFollow=='Y' }">
		<p><a href="<s:url value='/app/crs/visit'/>?projFlow=${param.projFlow}&userFlow=${param.userFlow}&patientFlow=${param.patientFlow}" data-role="button" data-transition="slide">随访申请</a></p>
		</c:if>
		<h3>${patientInfo['namePy']}[${patientInfo['sex']}-${patientInfo['birthday']}]&nbsp;的申请记录</h3>
		<ul data-role="listview" data-theme="c">
		  	<c:forEach items="${applyRecordList}" var="applyRecord">
		  	<li>
	  			<span><h4>&#12288;药物编码：${applyRecord['pack']}</h4></span>
				
				<span>&#12288;&#12288;申请人：${applyRecord['assigner']}</span>
				<br/>
				<span>&#12288;&#12288;申请时间：${applyRecord['assignTime']}</span>
			</li>
			</c:forEach>
			
		  	<c:if test="${empty applyRecordList || fn:length(applyRecordList)==0 }"> 
			<li>无记录！</li>
			</c:if>
		</ul>
		
		<c:if test="${applyForFollow=='Y' and fn:length(applyRecordList)>4 }">
		<p><br><a href="<s:url value='/app/crs/visit'/>?projFlow=${param.projFlow}&userFlow=${param.userFlow}&patientFlow=${param.patientFlow}" data-role="button" data-transition="slide">随访申请</a></p>
		</c:if>
	</div>
</div>
</body>
</html>