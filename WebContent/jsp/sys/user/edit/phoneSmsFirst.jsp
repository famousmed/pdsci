<script type="text/javascript">
function reloadVerifyCode() {
	jboxPost("<s:url value='/sys/user/edit/captchaEditPhone'/>?userPhone=${user.userPhone}",null,function(resp){
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

function step1(){
	if(false==$("#step1Form").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/sys/user/edit/checkPhoneSmsFirst'/>",$('#step1Form').serialize(),function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/sys/user/edit/phoneAccSecond'/>?userFlow=${user.userFlow}");
		}else{
			$("#errorMessage").html("&#12288;&#12288;验证信息失败："+resp);
		}
	},null,false);
}
</script>
<div class="content">
	<div class="title1 clearfix">
	<div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step1Form" style="position:relative;">
		<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;font-size: 15px;">
				<tr>
					<td style="text-align: right;width: 150px;">原手机号：</td>
					<td style="text-align: left;">${user.userPhone }</td>
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
						<input type="text" name="verifyCode" class="validate[required] xltext" placeholder="6位数字" value="" style="width: 120px;"/>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">登录密码：</td>
					<td style="text-align: left;">
						<input type="password" name="userPasswd" placeholder="" class="validate[required] xltext"  value="">
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<input type="hidden" name="userFlow" value="${user.userFlow }"/>          
						<input class="search" id="authBtn" type="button" value="下一步" onclick="step1();" />
				       	<span style="color:red;" id="errorMessage">							
						</span>
					</td>
				</tr>	
			</table>
		</form>
		</div>
		</div>
	</div>
</div>
