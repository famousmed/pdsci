<script type="text/javascript">
function step1(){
	if(false==$("#step1Form").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/sys/user/edit/checkPhoneAccFirst'/>",$('#step1Form').serialize(),function(resp){
		if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
			reloadContent("<s:url value='/sys/user/edit/phoneAccSecond'/>?userFlow=${param.userFlow}");
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
					<td style="text-align: right;width: 150px;">姓名：</td>
					<td style="text-align: left;">
						<input type="text" name="userName" placeholder="姓名" class="validate[required,custom[chinese]] xltext"  value="">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">身份证号：</td>
					<td style="text-align: left;">
						<input type="text" name="idNo" placeholder="身份证号" class="validate[required,custom[chinaIdLoose]] xltext"  value="">
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">所在机构：</td>
					<td style="text-align: left;">
						<select class="validate[required] xlselect" name="orgFlow">
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
						<input type="password" name="userPasswd" placeholder="" class="validate[required] xltext"  value="">
					</td>
				</tr>
				<tr>
					<td style="line-height: 70px;">&nbsp;</td>
					<td style="text-align: left;">
						<input type="hidden" name="userFlow" value="${param.userFlow }"/>          
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
