<script>
$(document).ready(function(){
	$("#step2").removeClass("current");
	$("#step2").addClass("done");
	$("#step3").addClass("current");
});

function reloadVerifyCode() {
	jboxPost("<s:url value='/hbres/singup/user/captchaEditPhone'/>?userPhone=${param.userPhone}",null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			$("#verifyCodeBtn").hide();
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
		 setTimeout("countDown("+secs+")",1000);
	 }else{      
		 $("#verifyCodeBtn").show();
	     $("#reReloadSpan").hide(); 
	 }     
}

function step3(){
	if(false==$("#step3Form").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/hbres/singup/user/checkPhoneAccThird'/>?userFlow=${param.userFlow}"
			+"&verifyCode="+$("#verifyCode").val(),null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/hbres/singup/user/phoneAccFourth'/>?userFlow=${param.userFlow}");
		}else{
			$("#errorMessage").html(resp);
		}
	},null,false);
}
</script>
<div class="main_bd">
<div class="div_table">
    <div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step3Form" style="position:relative;">
			<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;">
				<tr>
					<td style="text-align: right;width: 150px;">新手机：</td>
					<td style="text-align: left;">${param.userPhone }</td>
				</tr>
				<tr>
					<td></td>
					<td style="text-align: left;line-height: 35px;">
						<input type="button" id="verifyCodeBtn" value="&nbsp;免费获取验证码&nbsp;" onclick="reloadVerifyCode();"/>
						<span id="reReloadSpan" style="font-size: 13px;display: none;">
						<button type="button" id="verifyCodeBtn" onclick="reloadVerifyCode();" style="width: 130px;">
						<span id="jumpTo" style="color:#558abe;float: none;">60</span>秒后可重新发送
						</button>
						<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" style="margin: 0 5px 0 10px;"/>验证码已发送！
						</span>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;width: 130px;">验证码：</td>
					<td style="text-align: left;">
						<input type="text" id="verifyCode" class="validate[required] input" placeholder="6位数字" value=""/>
						<span style="color:red;" id="errorMessage"></span>
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<a onclick="step3();" class="btn_blue" style="margin-left: 5px;">下一步</a>
					</td>
				</tr>	
			</table>
		</form>
		</div>
		</div>
	</div>
        </div>
