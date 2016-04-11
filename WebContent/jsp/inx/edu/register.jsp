<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="register" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function reloadVerifyCode(){
	$("#verifyImage").attr("src","<s:url value='/captcha'/>?random="+Math.random());
}

function register(){
	if(false == $("#registerForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/inx/edu/register'/>";
	jboxPost(url,$("#registerForm").serialize(),
			function(resp){
				if(resp == "${GlobalConstant.USER_REG_SUCCESSED}"){
					//var userCode = $("input[name='userCode']").val();
					var userEmail = $("input[name='userEmail']").val();
					var url ="<s:url value='/inx/edu/sendEmail'/>?userEmail=" + userEmail;
					window.location.href = url;
				}
			},
			null,true);
	
}

function checkPasswd(){
	var userPasswd = $("input[name='userPasswd']").val();
	var userPasswd2 = $("input[name='userPasswd2']").val();
	if(userPasswd != "" && userPasswd2 != ""){
		if(userPasswd != userPasswd2){
			jboxTip("密码不一致！");
			$("input[name='userPasswd2']").focus();
		}
	}
}

</script>
</head>
<body>
<div class="loginbar">
  <div class="mainregsiter mainh">
    <div class="close"><a href="<s:url value='/inx/edu' />"><img src="<s:url value='/jsp/edu/css/images/close.png'/>"/></a></div>
    <h1>&nbsp;</h1>
      <form id="registerForm" style="position: relative;" method="post" class="regsiter ft">
       <%--  <h2><input type="text" class="loginsr validate[required,minSize[3],maxSize[16]]" style="width:342px;" name="userCode" value="${param.userCode}" placeholder="用户名（3-16位数字、字母或汉字的组合）"/></h2> --%>
        <h2><input type="text" class="loginsr validate[required,custom[email]]" style="width:342px;" name="userEmail" placeholder="邮箱" /></h2>
        <h2><input type="password" class="loginsr validate[required,minSize[6],maxSize[16]]" style="width:342px;" name="userPasswd" placeholder="密码（6-16位字母、数字或符号的组合）" onchange="checkPasswd()"/></h2>
        <h2><input type="password" class="loginsr validate[required,minSize[6],maxSize[16]]" style="width:342px;" name="userPasswd2" placeholder="确认密码（6-16位字母、数字或符号的组合）" onchange="checkPasswd()"/></h2>
        <h3>
        	<span class="code">
        		<input name="verifyCode" type="text" class="validate[required] loginsr" style="width:145px;" placeholder="验证码" />
        	</span>
        	<img id="verifyImage" src="<s:url value='/captcha'/>" style="margin-top:5px; float: left;" />
        	<a href="javascript:void(0)" onclick="reloadVerifyCode();"><font>看不清<br/>换一张</font></a>
        </h3>
        <h4><button class="btn_y" type="button" onclick="register();">同意协议并注册</button></h4>
        <h5><span class="rl">如已有帐户，请<a href="<s:url value='/inx/edu/login'/>">&nbsp;登录</a></span>&#12288;<!--  <span class="rr">查看<a href="#">&nbsp;用户协议</a></span>--></h5>
      </form>
  </div>
</div>
</body>
</html>