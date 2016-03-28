<script type="text/javascript">
$(document).ready(function(){
	$("#step2").removeClass("current");
	$("#step2").addClass("done");
	$("#step3").addClass("current");
});

function reloadVerifyCode() {
	jboxPost("<s:url value='/sys/user/edit/captchaEditPhone'/>?userPhone=${param.userPhone}",null,function(resp){
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
	jboxPost("<s:url value='/sys/user/edit/checkPhoneAccThird'/>?userFlow=${param.userFlow}"
			+"&verifyCode="+$("#verifyCode").val(),null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/sys/user/edit/phoneAccFourth'/>?userFlow=${param.userFlow}");
		}else{
			$("#errorMessage").html(resp);
		}
	},null,false);
}
</script>
<div class="content">
	<div class="title1 clearfix">
	<div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step3Form" style="position:relative;">
			<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;font-size: 15px;">
				<tr>
					<td style="text-align: right;width: 150px;">新手机：</td>
					<td style="text-align: left;">${param.userPhone }</td>
				</tr>
				<tr>
					<td></td>
					<td style="text-align: left;line-height: 35px;">
						<input type="button" id="verifyCodeBtn" value="免费获取验证码" onclick="reloadVerifyCode();" style="width: 100px;"/>
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
						<input type="text" id="verifyCode" class="validate[required] xltext" placeholder="6位数字" value="" style="width: 120px;"/>
						<span style="color:red;" id="errorMessage"></span>
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<input class="search" id="authBtn" type="button" value="下一步" onclick="step3();" />
					</td>
				</tr>	
			</table>
		</form>
		</div>
		</div>
	</div>
</div>
