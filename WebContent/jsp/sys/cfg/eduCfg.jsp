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
	if ('systemFuncs'=="${param.tagId }") {
		initUE("edu_reg_email_content");
	}
});

</script>
<div class="mainright">
	<div class="content">
	<form id="saveCfgForm" >
 		<div class="title1 clearfix">
 		<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"></jsp:include>
			<c:if test="${'eduRoleCfg'==param.tagId }">
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
					<td style="text-align: right" width="100px">学生角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="student_role_flow">
						<select name="student_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['edu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['student_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="student_role_flow_ws_id"  value="edu">		
						<input type="hidden" name="student_role_flow_desc"  value="学生角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">教师角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="teacher_role_flow">
						<select name="teacher_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['edu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['teacher_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="teacher_role_flow_ws_id"  value="edu">		
						<input type="hidden" name="teacher_role_flow_desc"  value="教师角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">学校管理员角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="admin_role_flow">
						<select name="admin_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['edu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['admin_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="admin_role_flow_ws_id"  value="edu">		
						<input type="hidden" name="admin_role_flow_desc"  value="学校管理员角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">系统管理员角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="system_role_flow">
						<select name="system_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['edu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['system_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="system_role_flow_ws_id"  value="edu">		
						<input type="hidden" name="system_role_flow_desc"  value="系统管理员角色">
					</td>
				</tr>
			</table>
			</fieldset>
			</c:if>
			<c:if test="${'systemFuncs'==param.tagId }">
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
					<input type="hidden" name="cfgCode" value="edu_reg_email_title">
					<input type="text" name="edu_reg_email_title"  value="${sysCfgMap['edu_reg_email_title']}" class="xltext"/>
					<input type="hidden" name="edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="edu_reg_email_title_desc"  value="邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="edu_reg_email_content">
							<script id="edu_reg_email_content" name="edu_reg_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['edu_reg_email_content']}</script>
							<input type="hidden" name="edu_reg_email_content_ws_id"  value="edu">		
						<input type="hidden" name="edu_reg_email_content_desc"  value="邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活码有效期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="edu_effective_time">
					<input type="text" name="edu_effective_time"  value="${sysCfgMap['edu_effective_time']}" class="xltext"/>小时
					<input type="hidden" name="edu_effective_time_ws_id"  value="edu">		
					<input type="hidden" name="edu_effective_time_desc"  value="激活码有效期">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="edu_effective_url">
					<input type="text" name="edu_effective_url"  value="${sysCfgMap['edu_effective_url']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="edu_effective_url_ws_id"  value="edu">		
					<input type="hidden" name="edu_effective_url_desc"  value="激活链接地址">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>视频观看配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">强制顺序播放：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="edu_force_order_play">
					<input type="radio" name="edu_force_order_play" id="edu_force_order_play_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['edu_force_order_play']==GlobalConstant.FLAG_Y || empty sysCfgMap['edu_force_order_play'] }">checked="checked"</c:if>  /><label for="edu_force_order_play_y" >是</label>&nbsp;
					<input type="radio" name="edu_force_order_play" id="edu_force_order_play_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['edu_force_order_play']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="edu_force_order_play_n" >否</label>
					<input type="hidden" name="edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="edu_reg_email_title_desc"  value="强制顺序播放">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">显示播放器控制：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="edu_player_control">
					<input type="radio" name="edu_player_control" id="edu_player_control_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['edu_player_control']==GlobalConstant.FLAG_Y }">checked="checked"</c:if>  /><label for="edu_player_control_y" >是</label>&nbsp;
					<input type="radio" name="edu_player_control" id="edu_player_control_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['edu_player_control']==GlobalConstant.FLAG_N || empty sysCfgMap['edu_player_control'] }">checked="checked"</c:if>  /><label for="edu_player_control_n" >否</label>
					<input type="hidden" name="edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="edu_reg_email_title_desc"  value="显示播放器控制">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">播放时校验：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="edu_play_validation">
					<input type="radio" name="edu_play_validation" id="edu_play_validation_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['edu_play_validation']==GlobalConstant.FLAG_Y || empty sysCfgMap['edu_play_validation']  }">checked="checked"</c:if>  /><label for="edu_play_validation_y" >是</label>&nbsp;
					<input type="radio" name="edu_play_validation" id="edu_play_validation_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['edu_play_validation']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="edu_play_validation_n" >否</label>
					<input type="hidden" name="edu_reg_email_title_ws_id"  value="edu">		
					<input type="hidden" name="edu_reg_email_title_desc"  value="播放时校验">
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