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
		<a href="<s:url value="/app/edc/patientList?userFlow=${param.userFlow}&projFlow=${param.projFlow}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${patientInfo.name}</h1>
	    <a href="<s:url value="/app/edc/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

  <div data-role="content">
    <h2>访视列表：</h2>
     <ul data-role="listview" data-inset="true">
    <c:forEach items="${visitList}" var="visit">
      <li><a href="<s:url value="/app/edc/input?projFlow=${param.projFlow}&visitFlow=${visit.visitFlow}&userFlow=${userFlow }&patientFlow=${patientInfo['patientFlow']}"/>" <c:if test="${!empty patientVisitMap[visit.visitFlow] }">data-icon="check"</c:if>" >${visit.visitName }</a>
      	<a href="<s:url value="/app/edc/input?projFlow=${param.projFlow}&visitFlow=${visit.visitFlow}&userFlow=${userFlow }&patientFlow=${patientInfo['patientFlow']}"/>" <c:if test="${!empty patientVisitMap[visit.visitFlow] }">data-icon="check"</c:if>></a>
      </li>
     </c:forEach>
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