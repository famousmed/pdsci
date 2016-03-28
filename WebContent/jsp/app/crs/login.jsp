<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype-mobile.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead-mobile.jsp"></jsp:include>
</head>
<body>
<div data-role="page">
	<jsp:include page="/jsp/common/page-common-mobile.jsp"></jsp:include>
	<script>
	function doLogin(){
		var option = {
				type:"get" , 
				data: $("#loginForm").serialize() ,
				showLoadMsg:true,
				transition: "slide",
				reverse: false,
				changeHash: true,
				reloadpage:true
			};
		$.mobile.changePage("<s:url value='/app/crs/doLogin'/>",option);
	}
	</script>
	<div data-role="header" data-position="fixed">
	    <h1>中央随机系统</h1>
	</div>

	<div data-role="content">
		<form id="loginForm" name="loginForm" data-transition="slide">
			<div data-role="fieldcontain">
				<label for="userPhone">手机号:</label>
				<input id="userPhone" name="userPhone" type="text" placeholder="手机号" value="" class="validate[required,custom[mobile]]"/>
				<label for="userPasswd">登录密码:</label>
				<input id="userPasswd" name="userPasswd" type="password" placeholder="登录密码" value="" class="validate[required]"/>
				<br>
				<button id="loginBtn" type="button" data-shadow="true" onclick="doLogin();">登&#12288;录</button>
			</div>
		</form>
	</div>
	
</div>
</body>
</html>