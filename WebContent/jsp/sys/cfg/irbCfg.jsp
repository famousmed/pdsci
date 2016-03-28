<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function save() {
	if(false==$("#saveCfgForm").validationEngine("validate")){
		return ;
	}
	var url = "<s:url value='/sys/cfg/save'/>";
	var data = $('#saveCfgForm').serialize();
	jboxPost(url, data, function() {
		window.location.href="<s:url value='/sys/cfg/main'/>?tagId=${param.tagId}";
	});
}

</script>
<div class="mainright">
	<div class="content">
	<form id="saveCfgForm" >
 		<div class="title1 clearfix">
 		<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
 		<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"></jsp:include>
 		<c:if test="${'irbFormCfg'==param.tagId }">
 			<fieldset>
			<legend>伦理审查表单配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">伦理审查申请/工作表单来源：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="irb_form_category">
							<select name="irb_form_category" class="xlselect">
								<option></option>
								<option value="product" <c:if test="${sysCfgMap['irb_form_category'] =='product'}">selected</c:if>>产品</option>
							</select>
							
							<input type="hidden" name="irb_form_category_ws_id"  value="irb">		
						<input type="hidden" name="irb_form_category_desc"  value="伦理审查申请/工作表单来源">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">快审审查地点：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="irb_review_address">
							<input type="text" class="xltext" name="irb_review_address"  value="${sysCfgMap['irb_review_address']}" style="width: 400px;"/>
							<br><font color="red"></font>
							<input type="hidden" name="irb_review_address_ws_id"  value="irb">		
						<input type="hidden" name="irb_review_address_desc"  value="快审审查地点">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">批件审查意见：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="irb_approvals_content">
							<textarea class="xltxtarea" name="irb_approvals_content_big_value" rows="10" cols="62">${sysCfgMap['irb_approvals_content']}</textarea>
							<br><font color="red"></font>
							<input type="hidden" name="irb_approvals_content_ws_id"  value="irb">		
						<input type="hidden" name="irb_approvals_content_desc"  value="批件审查意见">
					</td>
				</tr>
				<c:forEach items="${irbTypeEnumList }" var="dict">
				<c:set var="suggestKey" value="irb_suggest_content_${dict.id }"></c:set>
					<tr>
						<td style="text-align: right" width="100px">${dict.name}审查意见：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
								<input type="hidden" name="cfgCode" value="irb_suggest_content_${dict.id }">
								<textarea class="xltxtarea" name="irb_suggest_content_${dict.id }_big_value" rows="10" cols="62">${sysCfgMap[suggestKey]}</textarea>
								<br><font color="red"></font>
								<input type="hidden" name="irb_suggest_content_${dict.id }_ws_id"  value="irb">		
							<input type="hidden" name="irb_suggest_content_${dict.id }_desc"  value="${dict.name}意见审查意见">
						</td>
					</tr>
				</c:forEach>
			</table>
			</fieldset>
 		</c:if>
 		<c:if test="${'irbRoleCfg'==param.tagId }">
 			<fieldset>
					<legend>角色配置</legend>
					<table class="xllist">
						<thead>
							<tr>
								<th width="20%">配置项</th>
								<th width="80%">配置内容</th>
							</tr>
						</thead>	
						<tr>
							<td style="text-align: right" width="100px">伦理审查签字角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="irb_sign_role_flow">
									<select name="irb_sign_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['irb'] }" var="role">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['irb_sign_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:forEach>
									</select>
									
									<input type="hidden" name="irb_sign_role_flow_ws_id"  value="irb">		
								<input type="hidden" name="irb_sign_role_flow_desc"  value="伦理审查签字角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">主要研究者角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="researcher_role_flow">
									<select name="researcher_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['gcp'] }" var="role">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['researcher_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:forEach>
									</select>
									
									<input type="hidden" name="researcher_role_flow_ws_id"  value="irb">		
								<input type="hidden" name="researcher_role_flow_desc"  value="主要研究者角色">
							</td>
						</tr>
						<c:forEach items="${applicationScope.sysRoleWsMap['irb'] }" var="role">
							<tr>
								<td style="text-align: right" width="100px">
									${role.roleName }：
								</td>
								<td style="text-align: left;">
									<c:set var="key" value="vote_flag_${role.roleFlow }"></c:set>
									&nbsp;&nbsp;是否需要投票&#12288; <input type="radio" name="vote_flag_${role.roleFlow }" id="${role.roleFlow }_Y" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap[key] == GlobalConstant.FLAG_Y}">checked</c:if>/><label for="${role.roleFlow }_Y">是</label>
									&#12288;<input type="radio" name="vote_flag_${role.roleFlow }" id="${role.roleFlow }_N" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap[key] == GlobalConstant.FLAG_N}">checked</c:if>/><label for="${role.roleFlow }_N">否</label>
									<input type="hidden" name="cfgCode" value="vote_flag_${role.roleFlow}">
									<input type="hidden" name="vote_flag_${role.roleFlow }_ws_id"  value="irb">		
									<input type="hidden" name="vote_flag_${role.roleFlow }_desc"  value="${role.roleName }是否参加投票">
								</td>
							</tr>
						</c:forEach>
					</table>
			</fieldset>
 		</c:if>
		<c:if test="${'systemFuncs'==param.tagId }">
			<fieldset>
					<legend>跟踪审查配置</legend>
					<table class="xllist">
						<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
						<tr>
					<td style="text-align: right" width="100px">跟踪审查提醒日期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="irb_track_remaind">
							<select name="irb_track_remaind" class="xlselect">
								<option></option>
								<option value="30" <c:if test="${sysCfgMap['irb_track_remaind'] ==30 }">selected</c:if>>30天</option>
								<option value="20" <c:if test="${sysCfgMap['irb_track_remaind'] ==20 }">selected</c:if>>20天</option>
								<option value="10" <c:if test="${sysCfgMap['irb_track_remaind'] ==10 }">selected</c:if>>10天</option>
							</select>
							<input type="hidden" name="irb_track_remaind_ws_id"  value="irb">		
						<input type="hidden" name="irb_track_remaind_desc"  value="跟踪审查提醒间隔">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">批件有效期提醒日期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="irb_validity_remaind">
							<select name="irb_validity_remaind" class="xlselect">
								<option></option>
								<option value="30" <c:if test="${sysCfgMap['irb_validity_remaind'] ==30 }">selected</c:if>>30天</option>
								<option value="20" <c:if test="${sysCfgMap['irb_validity_remaind'] ==20 }">selected</c:if>>20天</option>
								<option value="10" <c:if test="${sysCfgMap['irb_validity_remaind'] ==10 }">selected</c:if>>10天</option>
							</select>
							
							<input type="hidden" name="irb_validity_remaind_ws_id"  value="irb">		
						<input type="hidden" name="irb_validity_remaind_desc"  value="批件有效期提醒日期">
					</td>
				</tr>
					</table>
			</fieldset>
			<fieldset>
			<legend>伦理审查配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">列表是否显示项目编号：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="irb_projno_flag">
						<input type="radio" name="irb_projno_flag" id="irb_projno_flag_Y" value="${GlobalConstant.FLAG_Y }" <c:if test="${GlobalConstant.FLAG_Y == sysCfgMap['irb_projno_flag'] }">checked</c:if>/><label for="irb_projno_flag_Y">是</label>
						&nbsp;<input type="radio" name="irb_projno_flag" id="irb_projno_flag_N" value="${GlobalConstant.FLAG_N }" <c:if test="${GlobalConstant.FLAG_N == sysCfgMap['irb_projno_flag']}">checked</c:if>/><label for="irb_projno_flag_N">否</label>
						
						<input type="hidden" name="irb_projno_flag_ws_id"  value="irb">		
						<input type="hidden" name="irb_projno_flag_desc"  value="列表是否显示项目编号">
					</td>
				</tr>
			</table>
			</fieldset>
			</c:if>
			<div class="button" >
				<input type="button" class="search" onclick="save();" value="保&#12288;存">
			</div>
		</div>	
		</form>
	</div> 
</div>