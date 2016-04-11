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
	$(document).ready(function(){  
	    $(document).bind("contextmenu",function(e){  
	        return false;  
	    });  
	}); 

	function reloadVerifyCode() {
		if ($("#userPhone").val()=="") {
			jboxTip("请先输入手机号！");
			return;
		}
		jboxPost("<s:url value='/sys/user/forget/captchaPhone'/>?random="+Math.random()+"&userPhone="+$("#userPhone").val(),null,function(resp){
			$("#errorMessage").html("");
			$("#errTip").hide();
			if(resp=="${GlobalConstant.FLAG_N}"){
				$("#errTip").show();
			} else if(resp=="${GlobalConstant.FLAG_Y}"){
				$("#userPhone").attr("readonly",true);
				$("#verifyCodeBtn").hide();
				$("#verifyCode").show();
				$("#successTip").show();
				countDown(60);
			}
		},null,false);
	}
	
	function countDown(secs){     
		 var jumpTo = document.getElementById('jumpTo');
		 jumpTo.innerHTML=secs;  
		 if(--secs>0){
			 $("#reVerifyCodeBtn").hide();
			 $("#jumpSpan").show();
			 setTimeout("countDown("+secs+")",1000);
		 }else{      
			 $("#jumpSpan").hide();
		     $("#reVerifyCodeBtn").show(); 
		 }     
	}
	
	function checkVerifyCodePhone(){
		if(false==$("#forgetForm").validationEngine("validate")){
			return ;
		}
		if ($("#verifyCode").val()=="") {
			jboxTip("请先获取校验码！");
			return;
		}
		jboxPost("<s:url value='/sys/user/forget/checkVerifyCodePhone'/>?userPhone="+$("#userPhone").val()
				+"&verifyCode="+$("#verifyCode").val(),null,function(resp){
			$("#errorMessage").html("");
			$("#errTip").hide();
			var result = resp['result'];
			if(result=="${GlobalConstant.FLAG_Y}"){
				window.location.href="<s:url value='/sys/user/forget/thrid'/>?actionId="+resp['actionId'];
			}else if(result=="${GlobalConstant.FLAG_N}"){
				$("#errTip").show();
			}else if(result=="${GlobalConstant.FLAG_F}"){
				$("#errorMessage").html(resp['errorMessage']);
			}
		},null,false);
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
	<h1 class="reg_title">忘记密码--第一步--手机号校验</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <div class="quyu clearfix">
    	<dl>   
			<form id="forgetForm" style="position:relative;">
	            <dt class="dt_l">手机号：</dt>
	            <dd class="dd_r clearfix">
	            <input id="userPhone" type="text" placeholder="请填写您的手机号：" class="validate[required] input_kuang address" value=""/>
	            <span style="display: none;color:red;" id="errTip">
			      	&#12288;用户不存在，请确认填写信息无误
			    </span>
	            </dd>
	            <dt class="dt_l" style="padding-top: 10px;">校验码：</dt>
	            <dd class="dd_r clearfix" style="vertical-align: top;padding-top: 10px;">
	                <input type="button" id="verifyCodeBtn" value="点此免费获取" onclick="reloadVerifyCode();" style="width: 100px;margin-top: 10px;display:;" />
					<input type="text" id="verifyCode" value="" placeholder="6位数字" class="validate[required] input_kuang address" style="width: 120px;display:none;"/>				
	            	<span id="jumpSpan" style="display: none;margin-top: 5px;">&#12288;没收到短信校验码？<span id="jumpTo" style="color:#558abe;float: none;">60</span>秒后请尝试重新获取</span>
	            	<input type="button" id="reVerifyCodeBtn" value="点此免费获取" onclick="reloadVerifyCode();" style="width: 100px;margin: 10px 0 0 15px;display:none;" />
	            </dd>
	            <dt class="dt_l" style="line-height: 15px;height:28px;margin-bottom: 0;">&nbsp;</dt>
	  		   <dd class="dd_r clearfix" style="font-size: 13px;line-height: 15px;height:28px;margin-bottom: 0;">
					<span id="successTip" style="display:none;line-height: 15px;">
						<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" style="margin: 0 5px 0 0;"/>
						校验码已发送到你的手机，${sysCfgMap['sys_phone_effective_time']}分钟内有效，请勿泄露。
					</span>
	           </dd>
	           <dt class="dt_l" style="line-height: 10px;height:28px;margin-bottom: 10px;">&nbsp;</dt>
	  		   <dd class="dd_r clearfix" style="line-height: 10px;height:28px;margin-bottom: 10px;">
					<span style="color:red;" id="errorMessage"></span>
	           </dd>
	           <dt class="dt_l">&nbsp;</dt>
	  		   <dd class="dd_r clearfix">
	             <div class="sub_login">       
	             	<input class="no_bg" type="button" value="下一步" onclick="checkVerifyCodePhone();"/>
	             </div>
	           </dd>
			</form>
        </dl>
    </div>
    </div>
</div>

<div id="footer"></div>
</div>
</body>
</html>