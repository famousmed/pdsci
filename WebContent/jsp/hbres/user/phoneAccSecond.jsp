<script>
$(document).ready(function(){
	$("#step1").removeClass("current");
	$("#step1").addClass("done");
	$("#step2").addClass("current");
});

function step2(){
	if(false==$("#step2Form").validationEngine("validate")){
		return ;
	}
	var newPhone = $("#newPhone").val();
	if (newPhone=="${user.userPhone}") {
		jboxTip("新手机号不能和原手机号相同，请重新输入！");
		$("#newPhone").val("");
		return;
	}
	jboxPost("<s:url value='/hbres/singup/user/checkPhoneAccSecond'/>?userPhone="+newPhone,null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/hbres/singup/user/phoneAccThird'/>?userFlow=${user.userFlow}&userPhone="+newPhone);
		}else{
			jboxTip(resp);
		}
	},null,false);
}
</script>
<div class="main_bd">
<div class="div_table">
    <div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step2Form" style="position:relative;">
		<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;">
				<tr>
					<td style="text-align: right;width: 150px;">新手机号：</td>
					<td style="text-align: left;">
						<input type="text" class="validate[required,custom[mobile]] input" id="newPhone" value="">
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<a onclick="step2();" class="btn_blue" style="margin-left: 5px;">下一步</a>
					</td>
				</tr>	
			</table>
		</form>
		</div>
		</div>
	</div>
        </div>
