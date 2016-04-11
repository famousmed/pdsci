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
		initUE("njmuedu_reg_email_content");
	}
});
</script>
<div class="mainright">
	<div class="content">
	<form id="saveCfgForm" >
 		<div class="title1 clearfix">
			<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"/>
			<c:if test="${'njmueduRoleCfg'==param.tagId }">
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
						<input type="hidden" name="cfgCode" value="njmuedu_student_role_flow">
						<select name="njmuedu_student_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['njmuedu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['njmuedu_student_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="njmuedu_student_role_flow_ws_id"  value="njmuedu">		
						<input type="hidden" name="njmuedu_student_role_flow_desc"  value="学生角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">教师角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="njmuedu_teacher_role_flow">
						<select name="njmuedu_teacher_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['njmuedu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['njmuedu_teacher_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="njmuedu_teacher_role_flow_ws_id"  value="njmuedu">		
						<input type="hidden" name="njmuedu_teacher_role_flow_desc"  value="教师角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">学校管理员角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="njmuedu_admin_role_flow">
						<select name="njmuedu_admin_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['njmuedu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['njmuedu_admin_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="njmuedu_admin_role_flow_ws_id"  value="njmuedu">		
						<input type="hidden" name="njmuedu_admin_role_flow_desc"  value="学校管理员角色">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">系统管理员角色：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="njmuedu_system_role_flow">
						<select name="njmuedu_system_role_flow" class="xlselect">
							<option></option>
							<c:forEach items="${applicationScope.sysRoleWsMap['njmuedu'] }" var="role">
								<option value="${role.roleFlow }" <c:if test="${sysCfgMap['njmuedu_system_role_flow'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							</c:forEach>
						</select>
						<input type="hidden" name="njmuedu_system_role_flow_ws_id"  value="njmuedu">		
						<input type="hidden" name="njmuedu_system_role_flow_desc"  value="系统管理员角色">
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
					<input type="hidden" name="cfgCode" value="njmuedu_reg_email_title">
					<input type="text" name="njmuedu_reg_email_title"  value="${sysCfgMap['njmuedu_reg_email_title']}" class="xltext"/>
					<input type="hidden" name="njmuedu_reg_email_title_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_reg_email_title_desc"  value="邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="njmuedu_reg_email_content">
							<script id="njmuedu_reg_email_content" name="njmuedu_reg_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['njmuedu_reg_email_content']}</script>
							<input type="hidden" name="njmuedu_reg_email_content_ws_id"  value="njmuedu">		
						<input type="hidden" name="njmuedu_reg_email_content_desc"  value="邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活码有效期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="njmuedu_effective_time">
					<input type="text" name="njmuedu_effective_time"  value="${sysCfgMap['njmuedu_effective_time']}" class="xltext"/>小时
					<input type="hidden" name="njmuedu_effective_time_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_effective_time_desc"  value="激活码有效期">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">激活链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="njmuedu_effective_url">
					<input type="text" name="njmuedu_effective_url"  value="${sysCfgMap['njmuedu_effective_url']}" class="xltext" style="width:400px"/>
					<input type="hidden" name="njmuedu_effective_url_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_effective_url_desc"  value="激活链接地址">
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
				   <td style="text-align: right" width="100px">课程默认图片路径：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="njmuedu_course_img">
				      <input type="text" class="xltext" name="njmuedu_course_img" value="${sysCfgMap['njmuedu_course_img']}" style="width: 90%;text-align: left;"/>
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的视频格式：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="njmuedu_chapter_file_type">
				      <input type="text" class="xltext" name="njmuedu_chapter_file_type" value="${sysCfgMap['njmuedu_chapter_file_type']}" style="width: 90%;text-align: left;" placeholder="用英文状态下的逗号分隔（如wmv,mp4）"/>
				      <input type="hidden" name="njmuedu_chapter_file_type_ws_id"  value="njmuedu">		
					  <input type="hidden" name="njmuedu_chapter_file_type_desc"  value="允许上传的视频格式">
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的图片格式：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="njmuedu_course_img_type">
				      <input type="text" class="xltext" name="njmuedu_course_img_type" value="${sysCfgMap['njmuedu_course_img_type']}" style="width: 90%;text-align: left;" placeholder="用英文状态下的逗号分隔（如jpeg2000,jpg）"/>
				      <input type="hidden" name="njmuedu_course_img_type_ws_id"  value="njmuedu">		
					  <input type="hidden" name="njmuedu_course_img_type_desc"  value="允许上传的图片格式">
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的视频大小：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="njmuedu_chapter_file_size">
				      <input type="text" class="xltext" name="njmuedu_chapter_file_size" value="${sysCfgMap['njmuedu_chapter_file_size']}" style="width: 90%;text-align: left;"/>&#12288;MB
				      <input type="hidden" name="njmuedu_chapter_file_size_ws_id"  value="njmuedu">		
					  <input type="hidden" name="njmuedu_chapter_file_size_desc"  value="允许上传的视频大小">
				   </td>
				</tr>
				<tr>
				   <td style="text-align: right" width="100px">允许上传的图片大小：</td>
				   <td style="text-align: left;">
				      <input type="hidden" name="cfgCode" value="njmuedu_course_img_size">
				      <input type="text" class="xltext" name="njmuedu_course_img_size" value="${sysCfgMap['njmuedu_course_img_size']}" style="width: 90%;text-align: left;"/>&#12288;MB
				      <input type="hidden" name="njmuedu_course_img_size_ws_id"  value="njmuedu">		
					  <input type="hidden" name="njmuedu_course_img_size_desc"  value="允许上传的图片大小">
				   </td>
				</tr>	
				<tr>
					<td style="text-align: right" width="100px">强制顺序播放：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="njmuedu_force_order_play">
					<input type="radio" name="njmuedu_force_order_play" id="njmuedu_force_order_play_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['njmuedu_force_order_play']==GlobalConstant.FLAG_Y || empty sysCfgMap['njmuedu_force_order_play'] }">checked="checked"</c:if>  /><label for="njmuedu_force_order_play_y" >是</label>&nbsp;
					<input type="radio" name="njmuedu_force_order_play" id="njmuedu_force_order_play_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['njmuedu_force_order_play']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="njmuedu_force_order_play_n" >否</label>
					<input type="hidden" name="njmuedu_force_order_play_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_force_order_play_desc"  value="强制顺序播放">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">显示播放器控制：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="njmuedu_player_control">
					<input type="radio" name="njmuedu_player_control" id="njmuedu_player_control_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['njmuedu_player_control']==GlobalConstant.FLAG_Y }">checked="checked"</c:if>  /><label for="njmuedu_player_control_y" >是</label>&nbsp;
					<input type="radio" name="njmuedu_player_control" id="njmuedu_player_control_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['njmuedu_player_control']==GlobalConstant.FLAG_N || empty sysCfgMap['njmuedu_player_control'] }">checked="checked"</c:if>  /><label for="njmuedu_player_control_n" >否</label>
					<input type="hidden" name="njmuedu_player_control_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_player_control_desc"  value="显示播放器控制">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">播放时校验：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="njmuedu_play_validation">
					<input type="radio" name="njmuedu_play_validation" id="njmuedu_play_validation_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['njmuedu_play_validation']==GlobalConstant.FLAG_Y || empty sysCfgMap['njmuedu_play_validation']  }">checked="checked"</c:if>  /><label for="njmuedu_play_validation_y" >是</label>&nbsp;
					<input type="radio" name="njmuedu_play_validation" id="njmuedu_play_validation_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['njmuedu_play_validation']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="njmuedu_play_validation_n" >否</label>
					<input type="hidden" name="njmuedu_play_validation_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_play_validation_desc"  value="播放时校验">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>视频质量配置</legend>
			<table class="xllist">
				<tr>
					<th width="20%">[默认]配置项<input type="hidden" name="cfgCode" value="njmuedu_acquiesce_video"></th>
					<th width="20%">规格</th>
					<th width="60%">配置内容</th>
				</tr>
				<c:forEach items="${njmuEduVideoLevelEnumList}" var="videoLevel">
					<c:set var='videoLevelId' value="njmuedu_video_level_${videoLevel.id}"></c:set>
					<tr>
		               	<td>
		               	    <input type="radio" name="njmuedu_acquiesce_video" value="${videoLevel.id }" <c:if test="${sysCfgMap['njmuedu_acquiesce_video'] eq videoLevel.id}">checked="checked"</c:if>/>
		                   	${videoLevel.name }
		               	</td>
		               	<td><input type="text"  class="xltext" name="${videoLevelId}_desc"  value="${sysCfgDescMap[videoLevelId]}"></td>
		               	<td>
		               		<input type="hidden" name="cfgCode" value="${videoLevelId}">
							<input type="radio"  name="${videoLevelId}" value="Y" <c:if test="${sysCfgMap[videoLevelId] eq 'Y'}">checked="checked"</c:if> />开
							<input type="radio"  name="${videoLevelId}" value="N" <c:if test="${sysCfgMap[videoLevelId] eq 'N'}">checked="checked"</c:if> />关
							
		               	</td>
	                </tr>
                </c:forEach>
			</table>
			</fieldset>
			<fieldset>
			<legend>随堂测试配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">强制视频播放完成后测试：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="njmuedu_finish_vedio_test">
					<input type="radio" name="njmuedu_finish_vedio_test" id="njmuedu_finish_vedio_test_y"  value="${GlobalConstant.FLAG_Y}" <c:if test="${sysCfgMap['njmuedu_finish_vedio_test']==GlobalConstant.FLAG_Y }">checked="checked"</c:if>  /><label for="njmuedu_finish_vedio_test_y" >是</label>&nbsp;
					<input type="radio" name="njmuedu_finish_vedio_test" id="njmuedu_finish_vedio_test_n"  value="${GlobalConstant.FLAG_N}" <c:if test="${sysCfgMap['njmuedu_finish_vedio_test']==GlobalConstant.FLAG_N }">checked="checked"</c:if>  /><label for="njmuedu_finish_vedio_test_n" >否</label>
					<input type="hidden" name="njmuedu_finish_vedio_test_ws_id"  value="njmuedu">		
					<input type="hidden" name="njmuedu_finish_vedio_test_desc"  value="强制顺序播放">
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