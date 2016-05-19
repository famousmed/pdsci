<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript" >
function reloadVerifyCode()
{
	$("#verifyImage").attr("src","<s:url value='/captcha'/>?random="+Math.random());
}
function checkForm(){
	if(false==$("#loginForm").validationEngine("validate")){
		return false;
	}
	return true;
}
</script>
<script Language=JavaScript> 
     function Click(){ 
     alert('南京迈拓医药科技有限公司版权所有'); 
     window.event.returnValue=false; 
     } 
     document.oncontextmenu=Click; 
</script>
</head>
<body style="background: #EAEAEA url(css/img/nydefy.jpg) no-repeat top center;">
<div class="m">
<div class="bg">
<div class="bgt"><font color="#FFFFFF">
<c:if test="${not empty applicationScope.sysCfgMap['sys_login_img']}">临床试验项目管理系统
	  </c:if>								
								<c:if test="${empty applicationScope.sysCfgMap['sys_login_img']}">临床试验管理系统
								</c:if></font>
</div>
<div class="bgform">
<form name="loginForm" action="<s:url value='/login'/>" method="post">
								<table align="left" cellpadding="0"
									cellspacing="0">
									<tr>
										<td height="50">用户名：</td>
										<td colspan="2" align="left"><input name="userCode" type="text"
											class="validate[required] logo_text" placeholder="用户名/手机

号/Email" value="${param.userCode}"/></td>
									</tr>
									<tr>
										<td height="50">密&#12288;码：</td>
										<td colspan="2" align="left"><input name="userPasswd" type="password"
											class="validate[required] logo_text" placeholder=""/></td>
									</tr>
									<tr>
										<td height="50">验证码：</td>
										<td align="left"><input name="verifyCode" type="text" class="validate

[required] logo_text"
											style="width: 100px;" placeholder=""/></td>
										<td><img id="verifyImage" src="<s:url value='/captcha'/>" 

style="cursor:pointer;" onClick="reloadVerifyCode();" title="点击更换验证码" alt="看不清，换一张" /></td>
									</tr>
									<tr>
										<td colspan="4">
											<input class="denglu" type="submit" value="登&#12288;录" 

onClick="return checkForm();"/>
											&#12288;&#12288;<a href="#">忘记密码?</a>
										</td>
									</tr>
									<tr>
										<td colspan="4">
											<c:if test="${not empty loginErrorMessage}">
										       	<span style="color:red;">
													登录失败：${loginErrorMessage}
												</span>
											</c:if>
										</td>
									</tr>
								</table>
</form></div></div>
<div class="footer">
<p><a href="http://www.jsnydefy.com/" target="_blank">南京医科大学第二附属医院</a> | <a href="http://www.jsnydefy.com/default.php?mod=article&do=detail&tid=673563" target="_blank">南医大二附院药物临床试验机构</a> | <a href="http://www.jsnydefy.com/default.php?mod=article&do=detail&tid=673564" target="_blank">南医大二附院医学伦理委员会</a></p>
<p>机构电话：<strong style="color:#F60; font-size:18px">025-58509670</strong><br/>Copyright © <a href="http://www.pharmasun.cn" target="_blank">法默生临床试验信息化解决方案</a> v2015.3  <img src="css/img/logos.png" width="16" height="16"> 南京迈拓医药科技有限公司 技术咨询：4000-5577-19</p></div>
</div>
</body>
</html>
