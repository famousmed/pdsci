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
function reloadVerifyCode() {
	jboxPost("<s:url value='/sys/user/auth/captchaAuth'/>?random="+Math.random(),null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			$("#verifyCodeBtn").hide();
			$("#verifyCode").show();
			$("#reReloadSpan").show();
			countDown(60);
		} else {
			jboxTip("获取失败，请重新获取");
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

function userPhoneAuth(){
	if(false==$("#authForm").validationEngine("validate")){
		return ;
	}
	if ($("#verifyCode").val()=="") {
		jboxTip("请先获取校验码！");
		return;
	}
	$("#authBtn").attr("disabled",true);
	jboxPost("<s:url value='/sys/user/auth/userPhoneAuth'/>?verifyCode="+$("#verifyCode").val(),null,function(resp){
		$("#errorMessage").html("");
		var result = resp['result'];
		if(result=="${GlobalConstant.FLAG_Y}"){
			jboxTip("认证成功！");
			setTimeout(function(){
				window.parent.frames['mainIframe'].location.reload(true);
				jboxClose();
			},1000);
		}else if(result=="${GlobalConstant.FLAG_N}"){
			jboxTip("${GlobalConstant.OPRE_FAIL}");
			$("#authBtn").removeAttr("disabled");
		}else if(result=="${GlobalConstant.FLAG_F}"){
			$("#errorMessage").html(resp['errorMessage']);
			$("#authBtn").removeAttr("disabled");
		}
	},null,false);
}
</script>
</head>
<body>

<div class="content">
	<div class="title1 clearfix">
	<div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="authForm" style="position:relative;">
			<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;font-size: 15px;">
				<tr>
					<td style="text-align: right;width: 130px;">手机号：</td>
					<td style="text-align: left;">${user.userPhone}</td>
				</tr>
				<tr>
					<td style="text-align: right;width: 130px;vertical-align: top;line-height: 35px;">校验码：</td>
					<td style="text-align: left;line-height: 35px;">
						<input type="button" id="verifyCodeBtn" value="点此免费获取" onclick="reloadVerifyCode();" style="width: 100px;"/>
						<input type="text" id="verifyCode" class="validate[required] input_kuang address" placeholder="6位数字" value="" style="width: 120px;display: none;"/>
						<span id="jumpSpan" style="display: none;font-size: 13px;">&#12288;没收到短信校验码？<span id="jumpTo" style="color:#558abe;float: none;">60</span>秒后请尝试重新获取</span>
	            		<input type="button" id="reVerifyCodeBtn" value="点此免费获取" onclick="reloadVerifyCode();" style="width: 100px;margin: 0 0 0 15px;display:none;" />
						<br/><span id="reReloadSpan" style="font-size: 13px;display: none;">
						<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" style="margin: 0 5px 0 0;"/>校验码已发送到你的手机，${sysCfgMap['sys_phone_effective_time']}分钟内有效，请勿泄露。
						</span>
						<br/><span style="color:red;" id="errorMessage"></span>
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<input class="search" id="authBtn" type="button" value="认&#12288;证" onclick="userPhoneAuth();" />
					</td>
				</tr>	
			</table>
		</form>
		</div>
		</div>
	</div>
</div>
</body>
</html>