<script>
function step1(){
	if(false==$("#step1Form").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/hbres/singup/user/checkPhoneAccFirst'/>",$('#step1Form').serialize(),function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/hbres/singup/user/phoneAccSecond'/>?userFlow=${param.userFlow}");
		}else{
			$("#errorMessage").html("&#12288;&#12288;验证信息失败："+resp);
		}
	},null,false);
}
</script>
<div class="main_bd">
<div class="div_table">
    <div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<form id="step1Form" style="position:relative;">
		<table border="0" cellspacing="0" cellpadding="0" style="line-height: 50px;">
				<tr>
					<td style="text-align: right;width: 150px;">姓名：</td>
					<td style="text-align: left;">
						<input type="text" name="userName" placeholder="姓名" class="validate[required,custom[chinese]] input"  value="" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">身份证号：</td>
					<td style="text-align: left;">
						<input type="text" name="idNo" placeholder="身份证号" class="validate[required,custom[chinaIdLoose]] input"  value="" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">所在机构：</td>
					<td style="text-align: left;">
						<select class="validate[required] select" name="orgFlow" style="width:160px;margin-left: 5px; ">
							<option value="">请选择</option>
							<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
							<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==param.orgFlow }">selected</c:if>>${sysOrg.orgName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">登录密码：</td>
					<td style="text-align: left;">
						<input type="password" name="userPasswd" placeholder="" class="validate[required] input"  value="" />
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<input type="hidden" name="userFlow" value="${param.userFlow }"/> 
						<a onclick="step1();" class="btn_blue" style="margin-left: 5px;">下一步</a>         
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
