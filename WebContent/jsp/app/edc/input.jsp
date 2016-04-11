<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
<link rel="stylesheet" href="<s:url value='/js/jquery-mobile/jquery.mobile-1.3.2.min.css'/>">
</head>
<body>
<div data-role="page" >
	<jsp:include page="/jsp/common/page-common-mobile.jsp"></jsp:include>
	<div data-role="header" data-position="fixed" data-theme="b">
		<a href="<s:url value="/app/edc/visitList?userFlow=${param.userFlow}&projFlow=${param.projFlow}&patientFlow=${patientInfo.patientFlow}"/>" data-icon="back" data-transition="slide" data-direction="reverse">返回</a>
	    <h1>${patientInfo.name}
	    </h1>
	    <a href="<s:url value="/app/edc/login"/>" data-icon="home" data-transition="slide" data-direction="reverse">退出</a>
	</div>

  <div data-role="content" >
    <form method="post" action="demoform.asp">
      <fieldset data-role="collapsible"  data-inset="true">
        <legend>点击我 - 我可以折叠！</legend>
          <label for="name">全名：</label>
          <input type="text" name="text" id="name">
          <p>喜爱的颜色：</p>
        <div data-role="controlgroup">
          <label for="red">红色</label>
          <input type="checkbox" name="favcolor" id="red" value="red">
          <label for="green">绿色</label>
          <input type="checkbox" name="favcolor" id="green" value="green">
          <label for="blue">蓝色</label>
          <input type="checkbox" name="favcolor" id="blue" value="blue">
        </div>	
      
      </fieldset>
<input type="submit" data-inline="true" value="提交">
    </form>
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