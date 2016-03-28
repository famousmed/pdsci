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
	if ('hbResCfg'=="${param.tagId }" ) {
		initUE("res_reg_email_content");
		initUE("res_resetpasswd_email_content");
		initUE("res_audit_success_email_content");
		initUE("res_audit_fail_email_content");
		initUE("res_reedit_email_content");
	}
	if ('sczyResCfg'=="${param.tagId }") {
		initUE("res_reg_email_content");
		initUE("res_resetpasswd_email_content");
	}
});
function selectSpes(cfgCode){
	var url =  "<s:url value='/sys/cfg/speMainPage'/>?cfgCode="+cfgCode;
	jboxOpen(url ,"选择审核专业",900,500);
}


</script>
<div class="mainright">
	<div class="content">
 		<form id="saveCfgForm" >
 		<div class="title1 clearfix">
			<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"/>
			<c:if test="${'resRoleCfg'==param.tagId }">
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
							<td style="text-align: right" width="100px">平台：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_global_role_flow">
									<select name="res_global_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_global_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_charge_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_charge_role_flow_desc"  value="省级部门角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">医院管理员角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_admin_role_flow">
									<select name="res_admin_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_admin_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_admin_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_admin_role_flow_desc"  value="医院管理员角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">基地主任角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_manager_role_flow">
									<select name="res_manager_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_manager_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_admin_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_admin_role_flow_desc"  value="医院管理员角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">科主任角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_head_role_flow">
									<select name="res_head_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
											<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
												<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_head_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
											</c:if>
										</c:forEach>
									</select>
									<input type="hidden" name="res_head_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_head_role_flow_desc"  value="科主任角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">科秘角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_secretary_role_flow">
									<select name="res_secretary_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
											<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
												<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_secretary_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
											</c:if>
										</c:forEach>
									</select>
									<input type="hidden" name="res_secretary_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_secretary_role_flow_desc"  value="科秘角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">带教老师角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_teacher_role_flow">
									<select name="res_teacher_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_teacher_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_teacher_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_teacher_role_flow_desc"  value="带教老师角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">导师角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_tutor_role_flow">
									<select name="res_tutor_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res']}" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_tutor_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_tutor_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_tutor_role_flow_desc"  value="导师角色">
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">学员角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_doctor_role_flow">
									<select name="res_doctor_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_doctor_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_doctor_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_doctor_role_flow_desc"  value="住院医师角色">
							</td>
						</tr>
					</table>
			</fieldset>
			</c:if>
			
			<c:if test="${'resFormCfg'==param.tagId }">
				<fieldset>
				<legend>住院医师表单配置</legend>
				<table class="xllist">
					<thead>
						<tr>
							<th width="20%">配置项</th>
							<th width="80%">配置内容</th>
						</tr>
					</thead>
					<tr>
						<td style="text-align: right" width="100px">默认表单来源：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_form_category">
							<select name="res_form_category" class="xlselect">
								<option></option>
								<c:forEach items="${applicationScope.resFormDictList}" var="formDict">
									<option value="${formDict.dictId}" <c:if test="${sysCfgMap['res_form_category'] eq formDict.dictId}">selected</c:if>>${formDict.dictDesc}</option>
								</c:forEach>
							</select>
							
							<input type="hidden" name="res_form_category_ws_id"  value="res">		
							<input type="hidden" name="res_form_category_desc"  value="住院医师表单来源配置">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">登记手册：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_manual_url">
							<select name="res_manual_url" class="xlselect">
									<option value="/res/doc/registryNoteBook" <c:if test="${sysCfgMap['res_manual_url']=='/res/doc/registryNoteBook'}">selected</c:if>>产品</option>
							</select>
							<input type="hidden" name="res_manual_url_desc_ws_id"  value="res">		
							<input type="hidden" name="res_manual_url_desc"  value="登记手册">
						</td>
					</tr>
<%-- 					<c:forEach items="${applicationScope.sysOrgList}" var="org"> --%>
<!-- 					<tr> -->
<%-- 						<td style="text-align: right" width="100px">${org.orgName}：</td> --%>
<!-- 						<td style="text-align: left;padding-left: 5px" width="200px"> -->
<%-- 							<c:set var="key" value="res_form_category_${org.orgFlow}"/> --%>
<%-- 							<input type="hidden" name="cfgCode" value="${key}"> --%>
<%-- 							<select name="${key}"> --%>
<!-- 								<option></option> -->
<%-- 								<option value="product" <c:if test="${sysCfgMap[key] eq 'product'}">selected</c:if>>产品</option> --%>
<%-- 								<option value="njglyy" <c:if test="${sysCfgMap[key] eq 'njglyy'}">selected</c:if>>南京鼓楼医院</option> --%>
<!-- 							</select> -->
							
<%-- 							<input type="hidden" name="${key}_ws_id"  value="res">		 --%>
<%-- 							<input type="hidden" name="${key}_desc"  value="${org.orgName}表单来源配置"> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 					</c:forEach> --%>
				</table>
			</fieldset>
			</c:if>
			
			<c:if test="${'hbResCfg'==param.tagId }">
				<fieldset>
			<legend>邮件激活配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_reg_email_title">
					<input type="text" name="res_reg_email_title"  value="${sysCfgMap['res_reg_email_title']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_reg_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_reg_email_title_desc"  value="邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="res_reg_email_content">
							<script id="res_reg_email_content" name="res_reg_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_reg_email_content']}</script>
							<input type="hidden" name="res_reg_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_reg_email_content_desc"  value="邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活码有效期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_effective_time">
					<input type="text" name="res_effective_time"  value="${sysCfgMap['res_effective_time']}" class="xltext"/>小时
					<input type="hidden" name="res_effective_time_ws_id"  value="res">		
					<input type="hidden" name="res_effective_time_desc"  value="激活码有效期">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_effective_url">
					<input type="text" name="res_effective_url"  value="${sysCfgMap['res_effective_url']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_effective_url_ws_id"  value="res">		
					<input type="hidden" name="res_effective_url_desc"  value="激活链接地址">
					</td>
				</tr>
			</table>
			</fieldset>
			
			
			<fieldset>
			<legend>湖北招录审核邮件通知配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_audit_email_title">
					<input type="text" name="res_audit_email_title"  value="${sysCfgMap['res_audit_email_title']}" class="xltext" style="width: 500px;"/>
					<input type="hidden" name="res_audit_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_audit_email_title_desc"  value="邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right">审核通过邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
						<input type="hidden" name="cfgCode" value="res_audit_success_email_content">
						<script id="res_audit_success_email_content" name="res_audit_success_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_audit_success_email_content']}</script>
						<input type="hidden" name="res_audit_success_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_audit_success_email_content_desc"  value="审核通过邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right">审核不通过邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="res_audit_fail_email_content">
							<script id="res_audit_fail_email_content" name="res_audit_fail_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_audit_fail_email_content']}</script>
							<input type="hidden" name="res_audit_fail_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_audit_fail_email_content_desc"  value="审核不通过邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right">退回邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="res_reedit_email_content">
							<script id="res_reedit_email_content" name="res_reedit_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_reedit_email_content']}</script>
							<input type="hidden" name="res_reedit_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_reedit_email_content_desc"  value="退回邮件内容">
					</td>
				</tr>
			</table>
			</fieldset>
			
			<fieldset>
			<legend>忘记密码配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_resetpasswd_email_title">
					<input type="text" name="res_resetpasswd_email_title"  value="${sysCfgMap['res_resetpasswd_email_title']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_resetpasswd_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_resetpasswd_email_title_desc"  value="重置密码邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="res_resetpasswd_email_content">
							<script id="res_resetpasswd_email_content" name="res_resetpasswd_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_resetpasswd_email_content']}</script>
							<input type="hidden" name="res_resetpasswd_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_resetpasswd_email_content_desc"  value="重置密码邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">重置密码链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_resetpasswd_url">
					<input type="text" name="res_resetpasswd_url"  value="${sysCfgMap['res_resetpasswd_url']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_resetpasswd_url_ws_id"  value="res">		
					<input type="hidden" name="res_resetpasswd_url_desc"  value="重置密码链接地址">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>报名设置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
				    <td>报名年份</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				        <input type="hidden" name="cfgCode" value="res_reg_year">
				        <select name="res_reg_year" class="xlselect">
				        	  <option value="">请选择</option>
				            <option value="${pdfn:getCurrYear()}" <c:if test="${sysCfgMap['res_reg_year'] eq pdfn:getCurrYear()}"> selected="selected"</c:if>>${pdfn:getCurrYear()}</option>
				            <option value="${pdfn:getCurrYear()+1}" <c:if test="${sysCfgMap['res_reg_year'] eq pdfn:getCurrYear()+1}"> selected="selected"</c:if>>${pdfn:getCurrYear()+1}</option>
				        </select>
					<input type="hidden" name="res_reg_year_ws_id"  value="res">		
					<input type="hidden" name="res_reg_year_desc"  value="报名年份">
				    </td>
				</tr>
				<tr>
				    <td>是否允许重填报名</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				        <input type="hidden" name="cfgCode" value="res_rereg">
				        <select name="res_rereg" class="xlselect">
				            <option value="">请选择</option>
				            <option value="Y" <c:if test="${sysCfgMap['res_rereg'] eq 'Y'}"> selected="selected"</c:if>>是</option>
				            <option value="N" <c:if test="${sysCfgMap['res_rereg'] eq 'N'}"> selected="selected"</c:if>>否</option>
				        </select>
					<input type="hidden" name="res_rereg_ws_id"  value="res">		
					<input type="hidden" name="res_rereg_desc"  value="是否允许重填报名">
				    </td>
				</tr>
				<tr>
				    <td>邮件发送是否显示邮件内容</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				        <input type="hidden" name="cfgCode" value="res_show_mail_content">
				        <select name="res_show_mail_content" class="xlselect">
				            <option value="">请选择</option>
				            <option value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_show_mail_content'] eq GlobalConstant.FLAG_Y}"> selected="selected"</c:if>>是</option>
				            <option value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_show_mail_content'] eq GlobalConstant.FLAG_N}"> selected="selected"</c:if>>否</option>
				        </select>
					<input type="hidden" name="res_show_mail_content_ws_id"  value="res">		
					<input type="hidden" name="res_show_mail_content_desc"  value="邮件发送是否显示邮件内容">
				    </td>
				</tr>
				<tr>
				    <td>往届毕业生是否统一考点</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				        <input type="hidden" name="cfgCode" value="res_alumni_unify_site">
				        <select name="res_alumni_unify_site" class="xlselect">
				            <option value="">请选择</option>
				            <option value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_alumni_unify_site'] eq GlobalConstant.FLAG_Y}"> selected="selected"</c:if>>是</option>
				            <option value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_alumni_unify_site'] eq GlobalConstant.FLAG_N}"> selected="selected"</c:if>>否</option>
				        </select>
					<input type="hidden" name="res_alumni_unify_site_ws_id"  value="res">		
					<input type="hidden" name="res_alumni_unify_site_desc"  value="往届毕业生是否统一考点">
				    </td>
				</tr>
			</table>	
			</fieldset>
			
			<fieldset>
			<legend>湖北招录管理配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">复试通知邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_retest_notice_email_title">
					<input type="text" name="res_retest_notice_email_title"  value="${sysCfgMap['res_retest_notice_email_title']}" class="xltext" style="width: 500px;"/>
					<input type="hidden" name="res_retest_notice_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_retest_notice_email_title_desc"  value="邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">录取通知邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_admit_notice_email_title">
					<input type="text" name="res_admit_notice_email_title"  value="${sysCfgMap['res_admit_notice_email_title']}" class="xltext" style="width: 500px;"/>
					<input type="hidden" name="res_admit_notice_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_admit_notice_email_title_desc"  value="邮件标题">
					</td>
				</tr>
			</table>
			</fieldset>
			
			<fieldset>
				<legend>招录配置</legend>
				<table class="xllist">
					<thead>
						<tr>
							<th width="20%">配置项</th>
							<th width="80%">配置内容</th>
						</tr>
					</thead>
					<tr>
						<td style="text-align: right" width="100px">开启基地特殊操作：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_specified_hospital_oper">
							<input type="radio" value='Y' name='res_specified_hospital_oper' <c:if test="${sysCfgMap['res_specified_hospital_oper'] eq 'Y'}">checked="checked"</c:if>/>是
							<input type="radio" value='N' name='res_specified_hospital_oper' <c:if test="${sysCfgMap['res_specified_hospital_oper'] eq 'N'}">checked="checked"</c:if>/>否
							<input type="hidden" name="res_specified_hospital_oper_ws_id"  value="res">		
							<input type="hidden" name="res_specified_hospital_oper_desc"  value="开启基地特殊操作">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">住培对接是否开放：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_hbres_on">
							<input type="radio" value='${GlobalConstant.FLAG_Y }' name='res_hbres_on' <c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap['res_hbres_on']}">checked="checked"</c:if>/>是
							<input type="radio" value='${GlobalConstant.FLAG_N }' name='res_hbres_on' <c:if test="${GlobalConstant.FLAG_N eq sysCfgMap['res_hbres_on']}">checked="checked"</c:if>/>否
							<input type="hidden" name="res_hbres_on_ws_id"  value="res">		
							<input type="hidden" name="res_hbres_on_desc"  value="住培对接是否开放">
						</td>
					</tr>
			    </table>
			</fieldset>
			
			</c:if>
			<c:if test="${'sczyResCfg'==param.tagId }">
				<fieldset>
			<legend>邮件激活配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_reg_email_title">
					<input type="text" name="res_reg_email_title"  value="${sysCfgMap['res_reg_email_title']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_reg_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_reg_email_title_desc"  value="邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="res_reg_email_content">
							<script id="res_reg_email_content" name="res_reg_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_reg_email_content']}</script>
							<input type="hidden" name="res_reg_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_reg_email_content_desc"  value="邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活码有效期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_effective_time">
					<input type="text" name="res_effective_time"  value="${sysCfgMap['res_effective_time']}" class="xltext"/>小时
					<input type="hidden" name="res_effective_time_ws_id"  value="res">		
					<input type="hidden" name="res_effective_time_desc"  value="激活码有效期">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_effective_url">
					<input type="text" name="res_effective_url"  value="${sysCfgMap['res_effective_url']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_effective_url_ws_id"  value="res">		
					<input type="hidden" name="res_effective_url_desc"  value="激活链接地址">
					</td>
				</tr>
			</table>
			</fieldset>
			
			<fieldset>
			<legend>忘记密码配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_resetpasswd_email_title">
					<input type="text" name="res_resetpasswd_email_title"  value="${sysCfgMap['res_resetpasswd_email_title']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_resetpasswd_email_title_ws_id"  value="res">		
					<input type="hidden" name="res_resetpasswd_email_title_desc"  value="重置密码邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="res_resetpasswd_email_content">
							<script id="res_resetpasswd_email_content" name="res_resetpasswd_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['res_resetpasswd_email_content']}</script>
							<input type="hidden" name="res_resetpasswd_email_content_ws_id"  value="res">		
						<input type="hidden" name="res_resetpasswd_email_content_desc"  value="重置密码邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">重置密码链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_resetpasswd_url">
					<input type="text" name="res_resetpasswd_url"  value="${sysCfgMap['res_resetpasswd_url']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="res_resetpasswd_url_ws_id"  value="res">		
					<input type="hidden" name="res_resetpasswd_url_desc"  value="重置密码链接地址">
					</td>
				</tr>
			</table>
			</fieldset>
				<fieldset>
			<legend>报名设置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
				    <td>报名年份</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				        <input type="hidden" name="cfgCode" value="res_reg_year">
				        <select name="res_reg_year" class="xlselect">
				        	  <option value="">请选择</option>
				            <option value="${pdfn:getCurrYear()}" <c:if test="${sysCfgMap['res_reg_year'] eq pdfn:getCurrYear()}"> selected="selected"</c:if>>${pdfn:getCurrYear()}</option>
				            <option value="${pdfn:getCurrYear()+1}" <c:if test="${sysCfgMap['res_reg_year'] eq pdfn:getCurrYear()+1}"> selected="selected"</c:if>>${pdfn:getCurrYear()+1}</option>
				        </select>
					<input type="hidden" name="res_reg_year_ws_id"  value="res">		
					<input type="hidden" name="res_reg_year_desc"  value="报名年份">
				    </td>
				</tr>
			</table>	
			</fieldset>
			</c:if>
			
			
			<c:if test="${'systemFuncs'==param.tagId }">
			<fieldset>
			<legend>学习中心配置</legend>
			<table class="xllist">
			   <thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
				   <td style="text-align: right" width="100px">课程默认图片路径：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="res_edu_course_img">
				      <input type="text" class="xltext" name="res_edu_course_img" value="${sysCfgMap['res_edu_course_img']}" style="width: 90%;text-align: left;"/>
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的视频格式：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="res_edu_chapter_file_type">
				      <input type="text" class="xltext" name="res_edu_chapter_file_type" value="${sysCfgMap['res_edu_chapter_file_type']}" style="width: 90%;text-align: left;" placeholder="用英文状态下的逗号分隔（如wmv,mp4）"/>
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的图片格式：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="res_edu_course_img_type">
				      <input type="text" class="xltext" name="res_edu_course_img_type" value="${sysCfgMap['res_edu_course_img_type']}" style="width: 90%;text-align: left;" placeholder="用英文状态下的逗号分隔（如jpeg2000,jpg）"/>
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的视频大小：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="res_edu_chapter_file_size">
				      <input type="text" class="xltext" name="res_edu_chapter_file_size" value="${sysCfgMap['res_edu_chapter_file_size']}" style="width: 90%;text-align: left;"/>&#12288;MB
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的图片大小：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="res_edu_course_img_size">
				      <input type="text" class="xltext" name="res_edu_course_img_size" value="${sysCfgMap['res_edu_course_img_size']}" style="width: 90%;text-align: left;"/>&#12288;MB
				   </td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">强制顺序播放：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_edu_force_order_play">
					<input type="radio" name="res_edu_force_order_play" id="res_edu_force_order_play_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['res_edu_force_order_play']==GlobalConstant.FLAG_Y || empty sysCfgMap['edu_force_order_play'] }">checked="checked"</c:if>  /><label for="res_edu_force_order_play_y" >是</label>&nbsp;
					<input type="radio" name="res_edu_force_order_play" id="res_edu_force_order_play_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['res_edu_force_order_play']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="res_edu_force_order_play_n" >否</label>
					<input type="hidden" name="res_edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="res_edu_reg_email_title_desc"  value="强制顺序播放">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">显示播放器控制：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_edu_player_control">
					<input type="radio" name="res_edu_player_control" id="res_edu_player_control_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['res_edu_player_control']==GlobalConstant.FLAG_Y }">checked="checked"</c:if>  /><label for="res_edu_player_control_y" >是</label>&nbsp;
					<input type="radio" name="res_edu_player_control" id="res_edu_player_control_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['res_edu_player_control']==GlobalConstant.FLAG_N || empty sysCfgMap['res_edu_player_control'] }">checked="checked"</c:if>  /><label for="res_edu_player_control_n" >否</label>
					<input type="hidden" name="res_edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="res_edu_reg_email_title_desc"  value="显示播放器控制">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">播放时校验：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_edu_play_validation">
					<input type="radio" name="res_edu_play_validation" id="res_edu_play_validation_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['res_edu_play_validation']==GlobalConstant.FLAG_Y || empty sysCfgMap['res_edu_play_validation']  }">checked="checked"</c:if>  /><label for="res_edu_play_validation_y" >是</label>&nbsp;
					<input type="radio" name="res_edu_play_validation" id="res_edu_play_validation_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['res_edu_play_validation']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="res_edu_play_validation_n" >否</label>
					<input type="hidden" name="res_edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="res_edu_reg_email_title_desc"  value="播放时校验">
					</td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">考试系统对接地址：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="res_edu_test_i">
				      <input type="text" class="xltext" name="res_edu_test_i" value="${sysCfgMap['res_edu_test_i']}" style="width: 90%;text-align: left;"/>
				   </td>
				</tr>     
			</table>
			</fieldset>
			<fieldset>
			<legend>学籍配置</legend>
			<table class="xllist">
			   <thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
				   <td style="text-align: right" width="100px">当前学年：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="xjgl_curr_year"/>
				      <input type="text" class="xltext" name="xjgl_curr_year" value="${sysCfgMap['xjgl_curr_year']}" style="width: 90%;text-align: left;"/>
				   </td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>学员轮转视图配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
					<th colspan="2" style="text-align: left;padding-left: 10px;">入科</th>
				</tr>
				<c:forEach items="${preRecTypeEnumList}" var="pre">
					<tr>
						<td style="text-align: right" width="100px">是否显示${pre.name}：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
						<c:set var="preKey" value="res_${pre.id}_form_flag"/>
						<input type="hidden" name="cfgCode" value="${preKey}">
						<input type="radio"  name="${preKey}" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap[preKey]== GlobalConstant.FLAG_Y}">checked</c:if> />是
						<input type="radio"  name="${preKey}" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap[preKey]== GlobalConstant.FLAG_N}">checked</c:if> />否
						<input type="hidden" name="${preKey}_ws_id"  value="res">		
						<input type="hidden" name="${preKey}_desc"  value="是否显示${pre.name}">
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td style="text-align: right" width="100px">是否显示入科考试：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_inExam_flag">
					<input type="radio"  name="res_inExam_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_inExam_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
					<input type="radio"  name="res_inExam_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_inExam_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
					<input type="hidden" name="res_inExam_flag_ws_id"  value="res">		
					<input type="hidden" name="res_inExam_flag_desc"  value="是否显示入科考试">
					</td>
				</tr>
<!-- 				<tr> -->
<!-- 					<td style="text-align: right" width="100px">是否显示入科学习-附件：</td> -->
<!-- 					<td style="text-align: left;padding-left: 5px" width="200px"> -->
<!-- 					<input type="hidden" name="cfgCode" value="res_study_file_flag"> -->
<%-- 					<input type="radio"  name="res_study_file_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_study_file_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是 --%>
<%-- 					<input type="radio"  name="res_study_file_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_study_file_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否 --%>
<!-- 					<input type="hidden" name="res_study_file_flag_ws_id"  value="res">		 -->
<!-- 					<input type="hidden" name="res_study_file_flag_desc"  value="是否显示入科学习-附件"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr>
					<td style="text-align: right" width="100px">是否显示入科学习-课程：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_study_course_flag">
					<input type="radio"  name="res_study_course_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_study_course_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
					<input type="radio"  name="res_study_course_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_study_course_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
					<input type="hidden" name="res_study_course_flag_ws_id"  value="res">		
					<input type="hidden" name="res_study_course_flag_desc"  value="是否显示入科学习-课程">
					</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align: left;padding-left: 10px;">在培</th>
				</tr>	
				<tr>
					<td style="text-align: right" width="100px">是否显示登记比例：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="res_reg_pre_flag">
					<input type="radio"  name="res_reg_pre_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_reg_pre_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
					<input type="radio"  name="res_reg_pre_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_reg_pre_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
					<input type="hidden" name="res_reg_pre_flag_ws_id"  value="res">		
					<input type="hidden" name="res_reg_pre_flag_desc"  value="是否显示登记比例">
					</td>
				</tr>
				<tr>
					<th colspan="2" style="text-align: left;padding-left: 10px;">出科</th>
				</tr>
				<c:forEach items="${afterRecTypeEnumList}" var="after">
					<tr>
						<td style="text-align: right" width="100px">是否显示${after.name}：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
						<c:set var="afterKey" value="res_${after.id}_form_flag"/>
						<input type="hidden" name="cfgCode" value="${afterKey}">
						<input type="radio"  name="${afterKey}" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap[afterKey]== GlobalConstant.FLAG_Y}">checked</c:if> />是
						<input type="radio"  name="${afterKey}" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap[afterKey]== GlobalConstant.FLAG_N}">checked</c:if> />否
						<input type="hidden" name="${afterKey}_ws_id"  value="res">		
						<input type="hidden" name="${afterKey}_desc"  value="是否显示${after.name}">
						</td>
					</tr>
				</c:forEach>
<!-- 				<tr> -->
<!-- 					<td style="text-align: right" width="100px">是否显示出科考核表：</td> -->
<!-- 					<td style="text-align: left;padding-left: 5px" width="200px"> -->
<!-- 					<input type="hidden" name="cfgCode" value="res_after_evaluation_flag"> -->
<%-- 					<input type="radio"  name="res_after_evaluation_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_after_evaluation_flag']== GlobalConstant.FLAG_Y}">checked</c:if> />是 --%>
<%-- 					<input type="radio"  name="res_after_evaluation_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_after_evaluation_flag']== GlobalConstant.FLAG_N}">checked</c:if> />否 --%>
<!-- 					<input type="hidden" name="res_after_evaluation_flag_ws_id"  value="res">		 -->
<!-- 					<input type="hidden" name="res_after_evaluation_flag_desc"  value="是否显示出科考核表"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td style="text-align: right" width="100px">是否显示出科小结：</td> -->
<!-- 					<td style="text-align: left;padding-left: 5px" width="200px"> -->
<!-- 					<input type="hidden" name="cfgCode" value="res_after_summary_flag"> -->
<%-- 					<input type="radio"  name="res_after_summary_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['res_after_summary_flag']== GlobalConstant.FLAG_Y}">checked</c:if> />是 --%>
<%-- 					<input type="radio"  name="res_after_summary_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['res_after_summary_flag']== GlobalConstant.FLAG_N}">checked</c:if> />否 --%>
<!-- 					<input type="hidden" name="res_after_summary_flag_ws_id"  value="res">		 -->
<!-- 					<input type="hidden" name="res_after_summary_flag_flag_desc"  value="是否显示出科小结"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
			</table>
			</fieldset>
			<fieldset>
			<legend>学员人员类型配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<c:forEach items="${recDocCategoryEnumList}" var="category">
					<tr>
					<td style="text-align: right" width="100px">${category.name }：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					是否启用:&#12288;
					<input type="hidden" name="cfgCode" value="res_doctor_category_${category.id }">
					<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }"/>
					<input type="radio"  name="res_doctor_category_${category.id }" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
					<input type="radio"  name="res_doctor_category_${category.id }" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
					<input type="hidden" name="res_doctor_category_${category.id }_ws_id"  value="res">		
					<input type="hidden" name="res_doctor_category_${category.id }_desc"  value="系统使用学员类型_${category.name }">
					&#12288;&#12288;是否轮转(排班):&#12288;
					<input type="hidden" name="cfgCode" value="res_doctor_category_${category.id }_sch">
					<c:set var="res_doctor_category_key" value="res_doctor_category_${category.id }_sch"/>
					<input type="radio"  name="res_doctor_category_${category.id }_sch" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
					<input type="radio"  name="res_doctor_category_${category.id }_sch" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap[res_doctor_category_key]==GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
					<input type="hidden" name="res_doctor_category_${category.id }_sch_ws_id"  value="res">		
					<input type="hidden" name="res_doctor_category_${category.id }_sch_desc"  value="系统使用学员类型_${category.name }_是否排班">
					</td>
				</tr>
				</c:forEach>
			</table>
			</fieldset>
			<fieldset>
			<legend>学员登记类型配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<c:forEach items="${registryTypeEnumList}" var="registryType">
					<tr>
						<td style="text-align: right" width="100px">${registryType.name}：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_registry_type_${registryType.id}">
							<c:set var="res_registry_type_key" value="res_registry_type_${registryType.id }"/>
							<label>
								<input type="radio"  
								name="res_registry_type_${registryType.id }" 
								value="${GlobalConstant.FLAG_Y }" 
								<c:if test="${sysCfgMap[res_registry_type_key]==GlobalConstant.FLAG_Y}">checked</c:if> 
								/>
								是
							</label>
							<label>
								<input type="radio"  
								name="res_registry_type_${registryType.id }" 
								value="${GlobalConstant.FLAG_N }" 
								<c:if test="${sysCfgMap[res_registry_type_key]==GlobalConstant.FLAG_N}">checked</c:if> 
								/>
								否
							</label>
							<input type="hidden" name="res_registry_type_${registryType.id }_ws_id"  value="res">		
							<input type="hidden" name="res_registry_type_${registryType.id }_desc"  value="轮转登记数据类型_${registryType.name}">
						</td>
					</tr>
				</c:forEach>
			</table>
			</fieldset>
			<fieldset>
			<legend>全局数据登记类型配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<c:forEach items="${globalRecTypeEnumList}" var="registryType">
					<tr>
						<td style="text-align: right" width="100px">${registryType.name}：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_registry_type_${registryType.id}">
							<c:set var="res_registry_type_key" value="res_registry_type_${registryType.id }"/>
							<label>
								<input type="radio"  
								name="res_registry_type_${registryType.id }" 
								value="${GlobalConstant.FLAG_Y }" 
								<c:if test="${sysCfgMap[res_registry_type_key]==GlobalConstant.FLAG_Y}">checked</c:if> 
								/>
								是
							</label>
							<label>
								<input type="radio"  
								name="res_registry_type_${registryType.id }" 
								value="${GlobalConstant.FLAG_N }" 
								<c:if test="${sysCfgMap[res_registry_type_key]==GlobalConstant.FLAG_N}">checked</c:if> 
								/>
								否
							</label>
							<input type="hidden" name="res_registry_type_${registryType.id }_ws_id"  value="res">		
							<input type="hidden" name="res_registry_type_${registryType.id }_desc"  value="轮转登记数据类型_${registryType.name}">
						</td>
					</tr>
				</c:forEach>
			</table>
			</fieldset>
			
<!-- 			<fieldset> -->
<!-- 			<legend>系统使用版本配置</legend> -->
<!-- 			<table class="xllist"> -->
<!-- 				<thead> -->
<!-- 					<tr> -->
<!-- 						<th width="20%">配置项</th> -->
<!-- 						<th width="80%">配置内容</th> -->
<!-- 					</tr> -->
<!-- 				</thead> -->
<!-- 				<tr> -->
<!-- 					<td style="text-align: right" width="100px">系统版本：</td> -->
<!-- 					<td style="text-align: left;padding-left: 5px" width="200px"> -->
<!-- 						<input type="hidden" name="cfgCode" value="res_for_use"> -->
<!-- 						<label> -->
<!-- 							<input type="radio"   -->
<!-- 							name="res_for_use"  -->
<!-- 							value="global"  -->
<%-- 							<c:if test="${sysCfgMap['res_for_use']=='global'}">checked</c:if>  --%>
<!-- 							/> -->
<!-- 							平台版 -->
<!-- 						</label> -->
<!-- 						<label> -->
<!-- 							<input type="radio"   -->
<!-- 							name="res_for_use"  -->
<!-- 							value="local"  -->
<%-- 							<c:if test="${sysCfgMap['res_for_use']=='local'}">checked</c:if>  --%>
<!-- 							/> -->
<!-- 							医院版 -->
<!-- 						</label> -->
<!-- 						<input type="hidden" name="res_for_use_ws_id"  value="res">		 -->
<!-- 						<input type="hidden" name="res_for_use_desc"  value="系统使用版本"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 			</fieldset> -->
			
			<fieldset>
				<legend>轮转配置</legend>
				<table class="xllist">
					<thead>
						<tr>
							<th width="20%">配置项</th>
							<th width="80%">配置内容</th>
						</tr>
					</thead>
					<tr>
						<td style="text-align: right" width="100px">轮转时间单位：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_rotation_unit">
							
							<c:forEach items="${schUnitEnumList}" var="unit">
								<label>
								<input 
								type="radio" 
								name="res_rotation_unit" 
								value="${unit.id}" 
								<c:if test="${sysCfgMap['res_rotation_unit'] eq unit.id}">checked</c:if>
								/>${unit.name}
								</label>
							</c:forEach>
							
							<input type="hidden" name="res_rotation_unit_ws_id"  value="res">		
							<input type="hidden" name="res_rotation_unit_desc"  value="轮转时间单位配置">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">允许学员选科：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_doc_seldept">
							<label>
							<input 
							type="radio" 
							name="res_doc_seldept" 
							value="${GlobalConstant.FLAG_Y}" 
							<c:if test="${sysCfgMap['res_doc_seldept'] eq GlobalConstant.FLAG_Y}">checked</c:if>
							/>是
							</label>
							
							<label>
							<input 
							type="radio" 
							name="res_doc_seldept" 
							value="${GlobalConstant.FLAG_N}" 
							<c:if test="${sysCfgMap['res_doc_seldept'] eq GlobalConstant.FLAG_N}">checked</c:if>
							/>否
							</label>
							
							<input type="hidden" name="res_doc_seldept_ws_id"  value="res">		
							<input type="hidden" name="res_doc_seldept_desc"  value="允许学员选科">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">允许学员排班：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_doc_rostering">
							<label>
							<input 
							type="radio" 
							name="res_doc_rostering" 
							value="${GlobalConstant.FLAG_Y}" 
							<c:if test="${sysCfgMap['res_doc_rostering'] eq GlobalConstant.FLAG_Y}">checked</c:if>
							/>是
							</label>
							
							<label>
							<input 
							type="radio" 
							name="res_doc_rostering" 
							value="${GlobalConstant.FLAG_N}" 
							<c:if test="${sysCfgMap['res_doc_rostering'] eq GlobalConstant.FLAG_N}">checked</c:if>
							/>否
							</label>
							
							<input type="hidden" name="res_doc_rostering_ws_id"  value="res">		
							<input type="hidden" name="res_doc_rostering_desc"  value="允许学员排班">
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td style="text-align: right" width="100px">允许学员操作出科：</td> -->
<!-- 						<td style="text-align: left;padding-left: 5px" width="200px"> -->
<!-- 							<input type="hidden" name="cfgCode" value="res_doc_oper_after"> -->
<!-- 							<label> -->
<!-- 							<input  -->
<!-- 							type="radio"  -->
<!-- 							name="res_doc_oper_after"  -->
<%-- 							value="${GlobalConstant.FLAG_Y}"  --%>
<%-- 							<c:if test="${sysCfgMap['res_doc_oper_after'] eq GlobalConstant.FLAG_Y}">checked</c:if> --%>
<!-- 							/>是 -->
<!-- 							</label> -->
							
<!-- 							<label> -->
<!-- 							<input  -->
<!-- 							type="radio"  -->
<!-- 							name="res_doc_oper_after"  -->
<%-- 							value="${GlobalConstant.FLAG_N}"  --%>
<%-- 							<c:if test="${sysCfgMap['res_doc_oper_after'] eq GlobalConstant.FLAG_N}">checked</c:if> --%>
<!-- 							/>否 -->
<!-- 							</label> -->
							
<!-- 							<input type="hidden" name="res_doc_oper_after_ws_id"  value="res">		 -->
<!-- 							<input type="hidden" name="res_doc_oper_after_desc"  value="允许学员操作出科"> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr>
						<td style="text-align: right" width="100px">允许学员自己入科：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_doc_in_by_self">
							<label>
							<input 
							type="radio" 
							name="res_doc_in_by_self" 
							value="${GlobalConstant.FLAG_Y}" 
							<c:if test="${sysCfgMap['res_doc_in_by_self'] eq GlobalConstant.FLAG_Y}">checked</c:if>
							/>是
							</label>
							
							<label>
							<input 
							type="radio" 
							name="res_doc_in_by_self" 
							value="${GlobalConstant.FLAG_N}"
							<c:if test="${sysCfgMap['res_doc_in_by_self'] eq GlobalConstant.FLAG_N}">checked</c:if>
							/>否
							</label>
							
							<input type="hidden" name="res_doc_in_by_self_ws_id"  value="res">		
							<input type="hidden" name="res_doc_in_by_self_desc"  value="允许学员自己入科">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">学员是否按顺序入科：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_doc_in_order">
							<label>
							<input 
							type="radio" 
							name="res_doc_in_order" 
							value="${GlobalConstant.FLAG_Y}" 
							<c:if test="${sysCfgMap['res_doc_in_order'] eq GlobalConstant.FLAG_Y}">checked</c:if>
							/>是
							</label>
							
							<label>
							<input 
							type="radio" 
							name="res_doc_in_order" 
							value="${GlobalConstant.FLAG_N}"
							<c:if test="${sysCfgMap['res_doc_in_order'] eq GlobalConstant.FLAG_N}">checked</c:if>
							/>否
							</label>
							
							<input type="hidden" name="res_doc_in_order_ws_id"  value="res">		
							<input type="hidden" name="res_doc_in_order_desc"  value="允许学员操作出科">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">允许学员登记分数：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_doc_reg_score">
							<label>
							<input 
							type="radio" 
							name="res_doc_reg_score" 
							value="${GlobalConstant.FLAG_Y}" 
							<c:if test="${sysCfgMap['res_doc_reg_score'] eq GlobalConstant.FLAG_Y}">checked</c:if>
							/>是
							</label>
							
							<label>
							<input 
							type="radio" 
							name="res_doc_reg_score" 
							value="${GlobalConstant.FLAG_N}" 
							<c:if test="${sysCfgMap['res_doc_reg_score'] eq GlobalConstant.FLAG_N}">checked</c:if>
							/>否
							</label>
							
							<input type="hidden" name="res_doc_reg_score_ws_id"  value="res">		
							<input type="hidden" name="res_doc_reg_score_desc"  value="允许学员登记分数">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">轮转计划锁定日期：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_plan_locked_date">
							<input type="text" name="res_plan_locked_date" value="${sysCfgMap['res_plan_locked_date']}" class="validate[custom[integer],min[1],max[31]] xltext"/>
							
							<input type="hidden" name="res_plan_locked_date_ws_id"  value="res">		
							<input type="hidden" name="res_plan_locked_date_desc"  value="轮转计划锁定日期">每月X号后锁定学员排班计划不可变更！
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">允许老师一键审核：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_doc_key_audit">
							<label>
							<input 
							type="radio" 
							name="res_doc_key_audit" 
							value="${GlobalConstant.FLAG_Y}" 
							<c:if test="${sysCfgMap['res_doc_key_audit'] eq GlobalConstant.FLAG_Y}">checked</c:if>
							/>是
							</label>
							
							<label>
							<input 
							type="radio" 
							name="res_doc_key_audit" 
							value="${GlobalConstant.FLAG_N}" 
							<c:if test="${sysCfgMap['res_doc_key_audit'] eq GlobalConstant.FLAG_N}">checked</c:if>
							/>否
							</label>
							
							<input type="hidden" name="res_doc_key_audit_ws_id"  value="res">		
							<input type="hidden" name="res_doc_key_audit_desc"  value="允许老师一键审核">
						</td>
					</tr>
				</table>
			</fieldset>
			
			<fieldset>
				<legend>请假相关配置</legend>
				<table class="xllist">
					<thead>
						<tr>
							<th width="20%">配置项</th>
							<th width="80%">配置内容</th>
						</tr>
					</thead>
					<tr>
						<td style="text-align: right" width="100px">允许最大请假天数：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_absence_max_day">
							<input type="text" name="res_absence_max_day"  value="${sysCfgMap['res_absence_max_day']}" class="validate[custom[integer]] xltext"/>
							<input type="hidden" name="res_absence_max_day_ws_id"  value="res">		
							<input type="hidden" name="res_absence_max_day_desc"  value="允许最大请假天数">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">带教老师审批最小天数：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_absence_teacher_day">
							<input type="text" name="res_absence_teacher_day"  value="${sysCfgMap['res_absence_teacher_day']}" class="validate[custom[integer]] xltext"/>
							<input type="hidden" name="res_absence_teacher_day_ws_id"  value="res">		
							<input type="hidden" name="res_absence_teacher_day_desc"  value="带教老师审批最小天数">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">科主任审批最小天数：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="res_absence_head_day">
							<input type="text" name="res_absence_head_day"  value="${sysCfgMap['res_absence_head_day']}" class="validate[custom[integer]] xltext"/>
							<input type="hidden" name="res_absence_head_day_ws_id"  value="res">		
							<input type="hidden" name="res_absence_head_day_desc"  value="科主任审批最小天数">
						</td>
					</tr>
					<tr>
						<td style="text-align: right" width="100px">管理员审批：</td>
						<td style="text-align: left;padding-left: 5px" width="200px">
							<script type="text/javascript">
								function auditdayCtrl(val){
									$("[name='res_absence_manage_day']").attr("readonly",!(val=="${GlobalConstant.FLAG_Y}"));
								}
								$(function(){
									$("[name='res_absence_manage_audit']:checked").change();
								});
							</script>
							医院管理员是否审核：
							<input type="hidden" name="cfgCode" value="res_absence_manage_audit">
							<label>
								<input onchange="auditdayCtrl(this.value);" type="radio" name="res_absence_manage_audit" <c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">checked</c:if> value="${GlobalConstant.FLAG_Y}"/>
								是
							</label>
							<input type="hidden" name="res_absence_manage_audit_ws_id"  value="res">		
							<input type="hidden" name="res_absence_manage_audit_desc"  value="医院管理员是否审核">
							
							<input type="hidden" name="cfgCode" value="res_absence_manage_audit">
							<label>
								<input onchange="auditdayCtrl(this.value);" type="radio" name="res_absence_manage_audit" <c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_N}">checked</c:if> value="${GlobalConstant.FLAG_N}"/>
								否
							</label>
							<input type="hidden" name="res_absence_manage_audit_ws_id"  value="res">		
							<input type="hidden" name="res_absence_manage_audit_desc"  value="医院管理员是否审核">
							&#12288;
							医院管理员审批最小天数：
							<input type="hidden" name="cfgCode" value="res_absence_manage_day">
							<input type="text" name="res_absence_manage_day"  value="${sysCfgMap['res_absence_manage_day']}" class="validate[custom[integer]] xltext"/>
							<input type="hidden" name="res_absence_manage_day_ws_id"  value="res">		
							<input type="hidden" name="res_absence_manage_day_desc"  value="医院管理员审批最小天数">
						</td>
					</tr>
				</table>
			</fieldset>
			</c:if>
			
			<c:if test="${'jsResCfg'==param.tagId }">
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
							<td style="text-align: right" width="100px">中医管理局：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_zyglj_role_flow">
									<select name="res_zyglj_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_zyglj_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName}</option>
										</c:if>
										</c:forEach>
									</select>
									<input type="hidden" name="res_zyglj_role_flow_ws_id"  value="res">		
								    <input type="hidden" name="res_zyglj_role_flow_desc"  value="中医管理局">
<!-- 								    <a onclick="selectSpes('res_zyglj_role_flow');" style="cursor: pointer;">[审核专业]</a>  -->
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">全科中心：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_qkzx_role_flow">
									<select name="res_qkzx_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_qkzx_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									<input type="hidden" name="res_qkzx_role_flow_ws_id"  value="res">		
								    <input type="hidden" name="res_qkzx_role_flow_desc"  value="全科中心">
<!-- 								    <a onclick="selectSpes('res_qkzx_role_flow');" style="cursor: pointer;">[审核专业]</a>  -->
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">毕教委：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_bjw_role_flow">
									<select name="res_bjw_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_bjw_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									<input type="hidden" name="res_bjw_role_flow_ws_id"  value="res">		
									<input type="hidden" name="res_bjw_role_flow_desc"  value="毕教委">
<!-- 								    <a onclick="selectSpes('res_bjw_role_flow');" style="cursor: pointer;">[审核专业]</a>  -->
							</td>
						</tr>
						<tr>
							<td style="text-align: right" width="100px">主管部门角色：</td>
							<td style="text-align: left;padding-left: 5px" width="200px">
									<input type="hidden" name="cfgCode" value="res_charge_role_flow">
									<select name="res_charge_role_flow" class="xlselect">
										<option></option>
										<c:forEach items="${applicationScope.sysRoleWsMap['res'] }" var="role">
										<c:if test="${GlobalConstant.RECORD_STATUS_Y eq role.recordStatus}">
											<option value="${role.roleFlow }" <c:if test="${sysCfgMap['res_charge_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
										</c:if>
										</c:forEach>
									</select>
									
									<input type="hidden" name="res_charge_role_flow_ws_id"  value="res">		
								<input type="hidden" name="res_charge_role_flow_desc"  value="上级主管部门角色">
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