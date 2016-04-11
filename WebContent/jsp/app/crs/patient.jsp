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
		<h3>${patientInfo['namePy']}的详细信息</h3>
		
   		<c:if test="${applyForFollow=='Y' }">
			<a href="<s:url value='/app/crs/visit'/>?projFlow=${param.projFlow}&userFlow=${param.userFlow}&patientFlow=${patientInfo['patientFlow']}" data-role="button" data-transition="slide">
			随访申请
			</a>
		</c:if>
		
		<div><h4>性别：</h4></div>
		<div><span>&#12288;${patientInfo['sex']}</span></div>
		
		<div><h4>出生年月日：</h4></div>
		<div><span>&#12288;${patientInfo['birthday']}</span></div>
    			
	  	<div><h4>药物编码:</h4></div>
	  	<div><span>&#12288;${patientInfo['pack']}</span></div>

		<c:if test="${not empty patientInfo['group']}">
	  	<div><h4>药物组别：</h4></div>
	  	<div><span>&#12288;${patientInfo['group']}</span></div>
	  	</c:if>

	  	<div><h4>入组时间：</h4></div>
	  	<div><span>&#12288;${patientInfo['assignTime']}</span></div>

	  	<div><h4>申请人：</h4></div>
	  	<div><span>&#12288;${patientInfo['assigner']}</span></div>
		
		<br/>
   		<a href="<s:url value="/app/crs/patientDetail?projFlow=${param.projFlow}&userFlow=${param.userFlow}&patientFlow=${patientInfo['patientFlow']}"/>" data-role="button" data-mini="true" data-inline="true" data-icon="grid" data-transition="slide">
    		查看申请记录
  		</a>
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