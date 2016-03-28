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
$(document).ready(function(){
	if ('systemFuncs'=="${param.tagId}"){
		initUE("gcp_sponsor_notice");
	}
});
</script>
<div class="mainright">
	<div class="content">
	<form id="saveCfgForm" >
 		<div class="title1 clearfix">
 			<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"></jsp:include>
		<c:if test="${'roleCfg'==param.tagId }">
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
					<td style="text-align: right" width="100px">主要研究者角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="researcher_role_flow">
						<select name="researcher_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['gcp'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['researcher_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="researcher_role_flow_ws_id"  value="gcp">		
						<input type="hidden" name="researcher_role_flow_desc"  value="主要研究者角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">申办方角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="declarer_role_flow">
						<select name="declarer_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['gcp'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['declarer_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="declarer_role_flow_ws_id"  value="gcp">		
						<input type="hidden" name="declarer_role_flow_desc"  value="申办方角色">
					</td>
				</tr>
			</table>
			</fieldset>
		</c:if>
		<c:if test="${'qcCfg'==param.tagId }">
			<fieldset>
			<legend>质控配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">质控表单来源：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="qc_form_category">
						<select name="qc_form_category" class="xlselect">
							<option></option>
							<option value="product" <c:if test="${sysCfgMap['qc_form_category'] =='product'}">selected</c:if>>产品</option>
						</select>
						<input type="hidden" name="qc_form_category_ws_id"  value="gcp">		
						<input type="hidden" name="qc_form_category_desc"  value="质控表单来源">
					</td>
				</tr>
			</table>
			</fieldset>
		</c:if>
		<c:if test="${'systemFuncs'==param.tagId }">
			<fieldset>
			<legend>伦理系统配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
			<tr>
					<td style="text-align: right" width="100px">伦理系统开关：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="gcp_irb_sys_on">
					<input type="radio"  name="gcp_irb_sys_on" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['gcp_irb_sys_on']==GlobalConstant.FLAG_Y}">checked="checked"</c:if> />已开通
					<input type="radio"  name="gcp_irb_sys_on" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['gcp_irb_sys_on']==GlobalConstant.FLAG_N}">checked="checked"</c:if> />未开通
					<input type="hidden" name="gcp_irb_sys_on_ws_id"  value="gcp">		
					<input type="hidden" name="gcp_irb_sys_on_desc"  value="伦理系统开关">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>经费配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<c:forEach items="${gcpFundScaleEnumList}" var="gcpFundScale" varStatus="vs">
				<tr>
						<c:if test="${vs.first }">
						<td style="text-align: right" width="100px" rowspan="4">经费分配比例：</td>
						</c:if>
						<td style="text-align: left;padding-left: 5px" width="200px">
						<c:set var="key" value="gcp_fund_scale_${gcpFundScale.id}"></c:set>
						<input type="hidden" name="cfgCode" value="gcp_fund_scale_${gcpFundScale.id}">
						<div style="width: 50px;float: left;">${gcpFundScale.name }</div>&#12288;<input type="text" name="gcp_fund_scale_${gcpFundScale.id}" value="${sysCfgMap[key]}" class="xltext"> %
						<input type="hidden" name="gcp_fund_scale_${gcpFundScale.id}_ws_id"  value="gcp">		
						<input type="hidden" name="gcp_fund_scale_${gcpFundScale.id}_desc"  value="经费分配比例_${gcpFundScale.name}">
						</td>
				</tr>
					</c:forEach>
			</table>
			</fieldset>
			<fieldset>
			<legend>机构主视图配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">最新消息数目：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="gcp_org_info_count">
					<input type="text" name="gcp_org_info_count"  value="${sysCfgMap['gcp_org_info_count']}" class="xltext"/>
					<input type="hidden" name="gcp_org_info_count_ws_id"  value="gcp">		
					<input type="hidden" name="gcp_org_info_count_desc"  value="最新消息数目">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">默认的机构：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="gcp_default_org">
					<select name="gcp_default_org" class="xlselect">
						<option></option>
						<c:forEach items="${applicationScope.sysOrgList }" var="org">
							<option value="${org.orgFlow }" <c:if test="${sysCfgMap['gcp_default_org'] == org.orgFlow }">selected</c:if>>${org.orgName }</option>
						</c:forEach>
					</select>
					<input type="hidden" name="gcp_default_org_ws_id"  value="gcp">		
					<input type="hidden" name="gcp_default_org_desc"  value="默认的机构">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>随访提醒配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">默认提醒天数：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="default_remind_days">
						<input type="text" name="default_remind_days" value="${sysCfgMap['default_remind_days']}" class="xltext validate[custom[integer]]"/>
						<input type="hidden" name="default_remind_days_ws_id"  value="gcp">		
						<input type="hidden" name="default_remind_days_desc"  value="随访提醒默认天数">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
				<legend>临床试验需知</legend>
				<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
					<td style="text-align: right" width="100px">临床试验需知：</td>
					<td style="text-align: left;padding-left: 5px">
							<input type="hidden" name="cfgCode" value="gcp_sponsor_notice">
							<script id="gcp_sponsor_notice" name="gcp_sponsor_notice_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['gcp_sponsor_notice']}</script>
							<input type="hidden" name="gcp_sponsor_notice_ws_id"  value="gcp">		
							<input type="hidden" name="gcp_sponsor_notice_desc"  value="临床试验需知">		
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