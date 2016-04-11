<script>
function reloadVerifyCode() {
	jboxPost("<s:url value='/hbres/singup/user/captchaEmail'/>?userFlow=${user.userFlow}"+"&userEmail="+$("#newEmail").val(),null,function(resp){
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

function step2(){
	if(false==$("#step2Form").validationEngine("validate")){
		return ;
	}
	var newEmail = $("#newEmail").val();
	if (newEmail=="${user.userEmail}") {
		jboxTip("新邮箱不能和原邮箱相同，请重新输入！");
		$("#newEmail").val("");
		return;
	}
	jboxPost("<s:url value='/hbres/singup/user/checkNewEmail'/>?userEmail="+newEmail,null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			$("#step3Div").show();
			$("#newEmailTd").html($("#newEmail").val());
			$("#step2Div").hide();
			$("#step2").removeClass("current");
			$("#step2").addClass("done");
			$("#step3").addClass("current");
		}else{
			jboxTip(resp);
		}
	},null,false);
}

function step3(){
	if(false==$("#step3Form").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/hbres/singup/user/editUserEmail'/>?userFlow=${user.userFlow}"
			+"&userEmail="+$("#newEmail").val()+"&verifyCode="+$("#verifyCode").val(),null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			$("#step3Div").hide();
			$("#step4Div").show();
			$("#newEmailSpan").html($("#newEmail").val());
			$("#step3").removeClass("current");
			$("#step3").addClass("done");
			$("#step4").addClass("lasted");
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
		<div id="step2Div" style="display: ">
		<form id="step2Form" style="position:relative;">
		<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;">
				<tr>
					<td style="text-align: right;">邮箱地址：</td>
					<td style="text-align: left;">
						<input type="text" class="validate[required,custom[email]] inp" id="newEmail" value="" style="width: 180px;"/>&#12288;此邮箱可作为登录邮箱，请选择常用邮箱，避免遗忘
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<a onclick="step2();" class="btn_blue">下一步</a>
					</td>
				</tr>	
			</table>
		</form>
		</div>
		<div id="step3Div" style="display: none;">
		<form id="step3Form" style="position:relative;">
			<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;">
				<tr>
					<td style="text-align: right;width: 130px;">新邮箱：</td>
					<td style="text-align: left;" id="newEmailTd"></td>
				</tr>
				<tr>
					<td></td>
					<td style="text-align: left;line-height: 35px;">
						<input type="button" id="verifyCodeBtn" value="免费获取验证码" onclick="reloadVerifyCode();" style="width: 125px;"/>
						<span id="reReloadSpan" style="font-size: 13px;display: none;">
						<button type="button" id="verifyCodeBtn" onclick="reloadVerifyCode();" style="width: 130px;">
						<span id="jumpTo" style="color:#558abe;float: none;">60</span>秒后可重新发送
						</button>
						<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" style="margin: 0 5px 0 10px;"/>验证码已发送至新邮箱！
						</span>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;width: 130px;">验证码：</td>
					<td style="text-align: left;">
						<input type="text" id="verifyCode" class="validate[required] inp" placeholder="6位数字" value="" style="width: 120px;"/>
						<span style="color:red;" id="errorMessage"></span>
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<a onclick="step3();" class="btn_blue">下一步</a>
					</td>
				</tr>	
			</table>
		</form>
		</div>
		<div id="step4Div" style="display:none ;">
			<table border="0" cellspacing="0" cellpadding="0" style="line-height: 35px;">
				<tr>
					<td style="text-align: right;width: 50px;">
					<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" style="margin: 0 5px 0 10px;"/>
					</td>
					<td style="text-align: left;font-weight: bold;">恭喜您，<span id="newEmailSpan"></span>绑定成功！</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td style="text-align: left;font-size: 13px;">此邮箱可作为登录账户，直接登录系统</td>
				</tr>	
			</table>
		</div>
		</div>
		</div>
	</div>
        </div>
