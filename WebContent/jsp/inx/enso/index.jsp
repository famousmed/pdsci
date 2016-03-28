<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript" src="<s:url value='/jsp/inx/enso/js/bootstrap.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/inx/enso/js/jquery-1.11.1.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/inx/enso/css/font-awesome.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/inx/enso/css/bootstrap.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/inx/enso/css/bootstrap-theme.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/inx/enso/css/bootstrap-social.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/inx/enso/css/templatemo_style.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>

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
<title>医路临床科研信息化管理系统 | medroad</title>
<script Language=JavaScript> 
     function Click(){ 
     alert('江苏法迈生医学科技有限公司版权所有'); 
     window.event.returnValue=false; 
     } 
     document.oncontextmenu=Click; 
</script>
</head>
<style>
.enso{background: #EAEAEA url(<s:url value='/css/img/medroad.jpg' />) no-repeat top center;}
</style>
<body class="templatemo-bg-image-1">
	<div class="container">
		<div class="col-md-12">			
			<form name="loginForm" action="<s:url value='/login'/>" method="post">
				<input type="hidden" name="errorLoginPage" value="inx/enso/index"/>
				<div class="row">
					<div class="col-md-12">
						<h1>临床科研信息化管理系统</h1>
					</div>
				</div>
				<div class="row">
					<div class="templatemo-one-signin col-md-6">
				        <div class="form-group">
				          <div class="col-md-12">		          	
				            <label for="username" class="control-label">用户名：</label>
				            <div class="templatemo-input-icon-container">
				            	<i class="fa fa-user"></i>
				            	<input name="userCode" type="text" class="form-control validate[required]" id="username" placeholder="用户名/手机号/Email" value="${param.userCode}"/>
				            </div>		            		            		            
				          </div>              
				        </div>
				        <div class="form-group">
				          <div class="col-md-12">
				            <label for="password" class="control-label">密&#12288;码：</label>
				            <div class="templatemo-input-icon-container">
				            	<i class="fa fa-lock"></i>
				            	<input name="userPasswd" type="password" class="form-control validate[required]" id="password" placeholder="">
				            </div>
				          </div>
				        </div>
				       <div class="form-group">
				          <div class="col-md-12">
				            <label for="verifyCode" class="control-label">验证码：</label>
				            <div class="templatemo-input-icon-container">
				            	<i class="fa fa-lock"></i>
				            	<input name="verifyCode" type="text" class="form-control validate[required]" id="password" style="width: 100px;" placeholder=""> <img id="verifyImage" src="<s:url value='/captcha'/>" style="cursor:pointer;" onClick="reloadVerifyCode();" title="点击更换验证码" alt="看不清，换一张" />
				            </div>
				          </div>
				        </div>
				        <div class="form-group">
				          <div class="col-md-12">
				          <input class="denglu" type="submit" value="登&#12288;录" onClick="return checkForm();"/>
				          </div>
				        </div>
				        <div class="form-group">
				          	<div class="col-md-12">
				        		<c:if test="${not empty loginErrorMessage}"><span style="color:red;">登录失败：${loginErrorMessage}</span></c:if>
				       	 	</div>
				    	</div>
					</div>
					<div class="templatemo-other-signin col-md-6">
						<label class="margin-bottom-15">
							适用于临床研究机构
						</label>
					</div>   
				</div>				 	
		      </form>		      		      
		</div>
	</div>
</body>
</html>
