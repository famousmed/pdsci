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
		<a href="<s:url value="/app/edc/projList?userFlow=${param.userFlow}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${projName}</h1>
	    <a href="<s:url value="/app/edc/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

	<div data-role="content">
		<p style="display: none"><a href="<s:url value='/app/crs/apply'/>?projFlow=${param.projFlow}&userFlow=${param.userFlow}" data-role="button" data-transition="slide">入组申请</a></p>
		<h4>受试者列表</h4>
		
		<ul data-role="listview" <%-- data-autodividers="true" data-divider-theme="c" --%> data-filter="true" data-filter-placeholder="搜索姓名拼音首字母">
			<c:forEach items="${patientInfoList}" var="patientInfo">
	       		<li data-filtertext="">
					<a href="<s:url value="/app/edc/visitList?projFlow=${param.projFlow}&userFlow=${param.userFlow}&&patientFlow=${patientInfo['patientFlow']}"/>" data-transition="slide">
		      			<div class="ui-grid-c">
							<div class="ui-block-a" style="text-align: left; width: 40%;"><span>${patientInfo['name']}</span></div>
							<div class="ui-block-b" style="text-align: right; width: 40%;display: none;"><span>${patientInfo['birthday']}</span></div>
							<div class="ui-block-c" style="text-align: right; width: 20%;display: none;"><span>${patientInfo['sex']}</span></div>
						</div>
					</a>
				</li>
			</c:forEach>
			
		  	<c:if test="${patientInfoList == null || patientInfoList.size()==0 }"> 
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