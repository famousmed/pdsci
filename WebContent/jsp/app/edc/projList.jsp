<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
<link rel="stylesheet" href="<s:url value='/js/jquery-mobile/jquery.mobile-1.3.2.min.css'/>">
</head>
<body>
<div data-role="page">
	<jsp:include page="/jsp/common/page-common-mobile.jsp"></jsp:include>
	<div data-role="header" data-position="fixed" data-theme="b">
		<a href="<s:url value="/app/edc/login"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>我的项目列表</h1>
	    <a href="<s:url value="/app/edc/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		<ul data-role="listview" data-filter="true" data-filter-placeholder="搜索项目名">
		  	<!-- <li data-role="list-divider"><h5>我的项目列表</h5></li> -->
		  	
		  	<c:forEach items="${projList}" var="proj">
			<li data-theme="c">
				<a href="<s:url value="/app/edc/patientList?projFlow=${proj['projFlow']}&userFlow=${userFlow}"/>" data-transition="slide">${proj['projName']}</a>
			</li>
			</c:forEach>
			
		  	<c:if test="${empty projList || fn:length(projList) ==0 }"> 
			<li>无记录！</li>
			</c:if>
		</ul>
	</div>
	
	<%-- <div data-role="footer" data-position="fixed">
		<div data-role="navbar">
      		<ul>
		      	<li><a href="<s:url value="/app/crs/login"/>" class="ui-btn-active ui-state-persist" data-icon="home" data-transition="slide" data-direction="reverse">退出</a></li>
      		</ul>
    	</div>
	</div> --%>
</div>
</body>
</html>