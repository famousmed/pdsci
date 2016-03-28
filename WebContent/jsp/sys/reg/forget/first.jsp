<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	function doForget(){
		if(false==$("#forgetForm").validationEngine("validate")){
			return ;
		}
		$('#forgetForm').submit();		
	}
	function reloadVerifyCode()
	{
		$("#verifyImage").attr("src","<s:url value='/captcha'/>?random="+Math.random());
	}
	function doSelect(){
		var forgetType = $("input[name='forgetType']:checked").val();
	}
</script>
<style>
.dt_l {
width: 220px;
}
</style>
</head>

<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<div class="mainright">
  <div id="content">
	<h1 class="reg_title">忘记密码--第一步--选择找回密码方式</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <div class="quyu clearfix">
    	<dl>    		
			<form id="forgetForm" name="forgetForm" action="<s:url value='/reg/forget/checkFirst'/>" method="post" style="position:relative;">
	            <dt class="dt_l">选择找回密码方式：</dt>
	            <dd class="radio clearfix">
	            	<input id="userCode" type="radio" name="forgetType" class="validate[required]" value="userCode" onclick="doSelect();" <c:if test="${param.forgetType == 'userCode'}">checked</c:if>/><label for="userCode">用户名</label>&#12288; 
		            <input id="userPhone" type="radio" name="forgetType" class="validate[required]" value="userPhone" onclick="doSelect();" <c:if test="${param.forgetType == 'userPhone'}">checked</c:if>/><label for="userPhone">手机号</label>&#12288;
		            <input id="userEmail" type="radio" name="forgetType" class="validate[required]" value="userEmail" onclick="doSelect();" <c:if test="${param.forgetType == 'userEmail'}">checked</c:if>/><label for="userEmail">Email</label>&#12288;       
	            	<input id="idNo" type="radio" name="forgetType" class="validate[required]" value="idNo" onclick="doSelect();" <c:if test="${param.forgetType == 'userId'}">checked</c:if>/><label for="idNo">身份证号</label>
	            </dd>
	            <dt class="dt_l">用户名/手机号/Email/身份证号：</dt>
	            <dd class="dd_r clearfix"><input id="forgetName" name="forgetName" type="text" placeholder="请填写您的用户名或手机号或Email或身份证号：" style="width: 310px" class="validate[required] input_kuang address" value="${param.forgetName}"/>
	                  </dd>
	            <dt class="dt_l">验证码：</dt>
	            <dd class="dd_r clearfix">
	            	<input name="verifyCode" type="text" class="validate[required] input_kuang address"
											style="width: 120px;" />
					<img id="verifyImage" src="<s:url value='/captcha'/>" style="cursor:pointer;" onclick="reloadVerifyCode();" title="点击更换验证码" alt="看不清，换一张" />
	                  <span class="check_tips succ_tips"></span></dd>
	            <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix"></dd>
	           <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix">
	             <div class="sub_login">       
	             	<input class="no_bg" type="button" value="找回密码" onclick="doForget();"/>
	             	<c:if test="${not empty forgetErrorMessage}">
				       	<span style="color:red;">
							&#12288;找回密码失败：${forgetErrorMessage}
						</span>
					</c:if>
	             </div></dd>
			</form>
        </dl>
    </div>
</div>

<div id="footer"></div>
</div>
</body>
</html>