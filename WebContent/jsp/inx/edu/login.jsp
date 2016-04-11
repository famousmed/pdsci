<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>医学教育知识平台</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="register" value="true"/>
	<jsp:param name="cookie" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function login(){
	if(false == $("#loginForm").validationEngine("validate")){
		return false;
	}/*
	if($("#rmbUser").attr("checked")){
		 $.cookie("rmbUser", "true", { expires: 7 }); 
         $.cookie("userCode", $("#userCode").val(), { expires: 7 });
         $.cookie("userPasswd",  $("#userPasswd").val(), { expires: 7 });
	}*/
	$("#loginForm").submit();
}
$(function(){
	if("${message}" != ""){
		jboxTip("${message}");
		<c:remove var="message"/>
	}
});

function keyLogin(){
	 if (event.keyCode==13)  
	  $(".btn_y").click(); 
}
/*
$(document).ready(function () {
    if ($.cookie("rmbUser") == "true") {
    	 $("#userCode").val($.cookie("userCode"));
         $("#userPasswd").val($.cookie("userPasswd"));
    	$("#loginForm").submit();
    }
});*/
</script>
</head>
<body  onkeydown="keyLogin();">
<div class="loginbar">
  <div class="mainlogin mainh">
   <div class="close"><a href="<s:url value='/inx/edu' />"><img src="<s:url value='/jsp/edu/css/images/close.png'/>"/></a></div>
    <h1>&nbsp;</h1>
     <form id="loginForm" action="<s:url value='/inx/edu/login'/>" class="login ft"  style="position: relative;" method="post">
       <h2><img src="<s:url value='/jsp/edu/css/images/usermane.png'/>"/><input type="text" class="loginsr validate[required]" style="width:244px;" name="userCode" id="userCode" value="${param.userCode}" placeholder="请输入您的账号/邮箱"/></h2>
       <h2><img src="<s:url value='/jsp/edu/css/images/password.png'/>"/><input type="password" class="loginsr validate[required]" style="width:244px;" name="userPasswd" id="userPasswd" placeholder="请输入您的密码"/></h2>
       <!-- <h3><input name="rmbUser" id="rmbUser" type="checkbox" value="true" />&nbsp;&nbsp;自动登录 &#12288;<a href="#" style="color: #65aede;;float: right">忘记密码?</a></h3> -->
       <h4><button class="btn_y" type="button" onclick="login();">登&nbsp;&nbsp;录</button></h4>
       <h5>如无帐户，请&nbsp;<a href="<s:url value='/inx/edu/register'/>"><span style="color: #308de3;">注册</span></a></h5>
	</form>
  </div>
</div>
</body>
</html>