<script type="text/javascript">
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
	jboxPost("<s:url value='/sys/user/edit/checkPhoneAccSecond'/>?userPhone="+newPhone,null,function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/sys/user/edit/phoneAccThird'/>?userFlow=${user.userFlow}&userPhone="+newPhone);
		}else{
			jboxTip(resp);
		}
	},null,false);
}
</script>
<div class="content">
	<div class="title1 clearfix">
	<div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step2Form" style="position:relative;">
		<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;font-size: 15px;">
				<tr>
					<td style="text-align: right;width: 150px;">新手机号：</td>
					<td style="text-align: left;">
						<input type="text" class="validate[required,custom[mobile]] xltext" id="newPhone" value="">
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<input class="search" id="authBtn" type="button" value="下一步" onclick="step2();" />
					</td>
				</tr>	
			</table>
		</form>
		</div>
		</div>
	</div>
</div>
