<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>发送邮件</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="complete" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	if("${reSend}"=="${GlobalConstant.FLAG_Y}"){
		alert("${GlobalConstant.OPERATE_SUCCESSED}");
	}
});
</script>
</head>
<body>
<div class="rbody">
	<div class="registerLogo"><img src="<s:url value="/jsp/edu/css/images/registerLogo.png"/>"  /></div>
    <div class="register-t">新用户注册</div>
    <div class="registerInfo">
    	<h3>请验证您的邮箱完成注册...<i></i></h3>
        <p>
        	我们已经发送邮件到您的邮箱：${userEmail }<br/>
            请点击邮件中的激活链接完成注册，开始体验您的学习之旅
        </p>
        <c:set var="mailArray" value="${fn:split(userEmail,'@') }"/>
        <input type="button" value="进入邮箱查看" onclick="window.location.href='http://mail.${mailArray[1]}'" />
        <dl>
        	<dt>收不到邮件？</dt>
        	<dd><span>*</span>有可能您的邮箱设置屏蔽了我们的邮件，建议设置xxx.com为白名单域名<br/>腾讯企业邮箱和QQ邮箱用户，请确保将xxx.com加入白名单域名，否则可能收不到激活邮件</dd>
            <dd><span>*</span>有可能被误判为垃圾邮件了，请到垃圾文件夹找找</dd>
            <dd><span>*</span>用注册邮箱发邮件到xxxx.com，并注明未收到激活邮件</dd>
            <dd><span>*</span>客服QQ：12345678</dd>
            <dd><span>*</span>拨打客服电话：400-000-0000</dd>
            <dd><span>*</span>有可能您的邮箱设置屏蔽了我们的邮件，建议设置xxx.com为白名单域名</dd>
        </dl>
        <br/>
       <%--  <a href="<s:url value='/inx/edu/sendEmail'/>?reSend=${GlobalConstant.FLAG_Y}&userEmail=${userEmail}">重发邮件</a> --%>
    </div>
</div>
</body>
</html>