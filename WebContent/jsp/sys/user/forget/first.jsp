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
	function sendResetPassEmail(){
		if(false==$("#forgetForm").validationEngine("validate")){
			return ;
		}
		jboxPost("<s:url value='/sys/user/forget/sendResetPassEmail'/>?userEmail="+$("#userEmail").val()
				+"&verifyCode="+$("#verifyCode").val(),null,function(resp){
			$("#userEmail").val("");
			$("#verifyCode").val("");
			$("#errorMessage").html("");
			$("#errTip").hide();
			var result = resp['result'];
			if(result=="${GlobalConstant.FLAG_Y}"){
				$("#operDiv").hide();
				$("#errTip").hide();
				$("#successTip").show();
				$("#userEmailSpan").html(resp['userEmail']);
			}else if(result=="${GlobalConstant.FLAG_N}"){
				$("#successTip").hide();
				$("#errTip").show();
			}else if(result=="${GlobalConstant.FLAG_F}"){
				$("#errorMessage").html(resp['errorMessage']);
			}
		},null,false);
	}
	
	function reloadVerifyCode() {
		$("#verifyImage").attr("src","<s:url value='/captcha'/>?random="+Math.random());
	}
</script>
</head>
<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<div class="mainright">
  <div id="content">
   <div id="operDiv">
	<h1 class="reg_title">忘记密码--第一步--输入账户信息</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <div class="quyu clearfix">
    	<dl>   
			<form id="forgetForm" style="position:relative;">
	            <dt class="dt_l">用户名/手机号/Email：</dt>
	            <dd class="dd_r clearfix">
	            <input id="userEmail" type="text" placeholder="请填写您的用户名或手机号或Email：" class="validate[required] input_kuang address" value="${param.forgetName}"/>
	            <span style="display: none;color:red;" id="errTip">
			      	&#12288;用户不存在，请确认填写信息无误
			    </span>
	            </dd>
	            <dt class="dt_l">验证码：</dt>
	            <dd class="dd_r clearfix">
	            	<input id="verifyCode" type="text" class="validate[required] input_kuang address"
											style="width: 120px;" />
					<img id="verifyImage" src="<s:url value='/captcha'/>" style="cursor:pointer;" onclick="reloadVerifyCode();" title="点击更换验证码" alt="看不清，换一张" />
	                  <span class="check_tips succ_tips"></span>
	                  <span style="color:red;" id="errorMessage"></span>
	            </dd>
	            <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix"></dd>
	           <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix">
	             <div class="sub_login">       
	             	<input class="no_bg" type="button" value="找回密码" onclick="sendResetPassEmail();"/>
	             </div>
	           </dd>
			</form>
        </dl>
    </div>
    </div>
    <div style="display: none;margin: 40px;line-height: 30px;" id="successTip">
		<font style="font-weight: bold;font-size: 15px;">系统已发送一封邮件到您的邮箱&nbsp;<font color="#ff8b0f" id="userEmailSpan"></font></font><br/>
		请登录邮箱，点击重置密码链接修改密码.<br/>
	</div>
</div>

<div id="footer"></div>
</div>
</body>
</html>