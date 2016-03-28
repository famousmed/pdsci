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
		initUE("edc_reg_email_content");
	}
	if ('randomCfg'=="${param.tagId }") {
		initUE("edc_random_assign_email_content");
	}
});
</script>
<div class="mainright">
	<div class="content">
 		<form id="saveCfgForm" >
 		<div class="title1 clearfix">
 			<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"/>
			<c:if test="${'systemFuncs'==param.tagId }">
			<fieldset>
			<legend>用户激活配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">用户激活访问地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="edc_reg_email_url">
							<input type="text" class="xltext" name="edc_reg_email_url" value="${sysCfgMap['edc_reg_email_url']}" style="width: 400px;"/>
							<br><font color="red">必须为http://ip地址或域名:访问端口<s:url value="/reg/edc/go"/></font>
							<input type="hidden" name="edc_reg_email_url_ws_id"  value="edc">		
						<input type="hidden" name="edc_reg_email_url_desc"  value="用户激活访问地址">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">邀请邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="edc_reg_email_tile">
							<input type="text" class="xltext" name="edc_reg_email_tile"  value="${sysCfgMap['edc_reg_email_tile']}" style="width: 400px;"/>
							<input type="hidden" name="edc_reg_email_tile_ws_id"  value="edc">		
						<input type="hidden" name="edc_reg_email_tile_desc"  value="邀请邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">邀请邮件内容：</td>
					<td style="text-align: left;padding-left: 5p">
						<input type="hidden" name="cfgCode" value="edc_reg_email_content">
						<%-- <textarea name="edc_reg_email_content" class="xltxtarea">${sysCfgMap['edc_reg_email_content']}</textarea> --%>
						<script id="edc_reg_email_content" name="edc_reg_email_content" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['edc_reg_email_content']}</script>
						<input type="hidden" name="edc_reg_email_content_ws_id"  value="edc">		
						<input type="hidden" name="edc_reg_email_content_desc"  value="邀请邮件内容">
					</td>
				</tr>
			</table>
			</fieldset>
			<fieldset>
			<legend>数据录入配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">多次录入横向展示最大属性个数：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="edc_serial_attr_count">
							<select name="edc_serial_attr_count" class="xlselect">
								<option></option>
								<option value="5" <c:if test="${sysCfgMap['edc_serial_attr_count'] =='5'}">selected</c:if>>5</option>
								<option value="6" <c:if test="${sysCfgMap['edc_serial_attr_count'] =='6'}">selected</c:if>>6</option>
								<option value="7" <c:if test="${sysCfgMap['edc_serial_attr_count'] =='7'}">selected</c:if>>7</option>
								<option value="8" <c:if test="${sysCfgMap['edc_serial_attr_count'] =='8'}">selected</c:if>>8</option>
								<option value="9" <c:if test="${sysCfgMap['edc_serial_attr_count'] =='9'}">selected</c:if>>9</option>
								<option value="10" <c:if test="${sysCfgMap['edc_serial_attr_count'] =='10'}">selected</c:if>>10</option>
							</select>
							
							<input type="hidden" name="edc_serial_attr_count_ws_id"  value="edc">		
						<input type="hidden" name="edc_serial_attr_count_desc"  value="连续录入列表展示最大属性数">
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
						<input type="hidden" name="cfgCode" value="ecrf_default_remind_days">
						<input type="text" name="ecrf_default_remind_days" value="${sysCfgMap['ecrf_default_remind_days']}" class="xltext validate[custom[integer]]"/>
						<input type="hidden" name="ecrf_default_remind_days_ws_id"  value="edc">		
						<input type="hidden" name="ecrf_default_remind_days_desc"  value="ecrf随访提醒默认天数">
					</td>
				</tr>
			</table>
			</fieldset>
			</c:if>
			<c:if test="${'randomCfg'==param.tagId }">
			<fieldset>
			<legend>随机申请配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tr>
					<td style="text-align: right" width="100px">随机入组申请是否填写纳入/排除：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="edc_include_exclude">
						<input type="radio"  name="edc_include_exclude" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['edc_include_exclude']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
						<input type="radio"  name="edc_include_exclude" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['edc_include_exclude']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
						<input type="hidden" name="edc_include_exclude"  value="edc">		
						<input type="hidden" name="edc_include_exclude"  value="随机入组申请是否填写纳入/排除">		
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">随机申请邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="edc_random_assign_email_title">
						<input type="text" class="xltext" name="edc_random_assign_email_title" style="width: 400px;" value="${sysCfgMap['edc_random_assign_email_title']  }"/>
						<input type="hidden" name="edc_random_assign_email_title_ws_id"  value="edc">		
						<input type="hidden" name="edc_random_assign_email_title_desc"  value="随机申请邮件标题">
					</td>
				</tr>	
				<tr>
					<td style="text-align: right" width="100px">随机申请邮件内容：</td>
					<td style="text-align: left;padding-left: 5px">
							<input type="hidden" name="cfgCode" value="edc_random_assign_email_content">
							<%-- <textarea class="xltxtarea" name="edc_random_assign_email_content" >${sysCfgMap['edc_random_assign_email_content']  }
							</textarea> --%>
							<script id="edc_random_assign_email_content" name="edc_random_assign_email_content" type="text/plain" style="width:80%;height:200px;position:relative;">${sysCfgMap['edc_random_assign_email_content']}</script>
							<input type="hidden" name="edc_random_assign_email_content_ws_id"  value="edc">		
						<input type="hidden" name="edc_random_assign_email_content_desc"  value="随机申请邮件内容">
					</td>
				</tr>
			</table>
			</fieldset>
			</c:if>
			<c:if test="${'appCfg'==param.tagId }">
			<fieldset>
			<legend>App配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">Ios版本：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="edc_app_ios_version_name">
						<input type="text" class="xltext" name="edc_app_ios_version_name" style="width: 400px;" value="${sysCfgMap['edc_app_ios_version_name']  }"/>
						<input type="hidden" name="edc_app_ios_version_name_ws_id"  value="edc">		
						<input type="hidden" name="edc_app_ios_version_name_desc"  value="App版本号">		
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">Ios更新路径：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="edc_app_ios_update_path">
						<input type="text" class="xltext" name="edc_app_ios_update_path" style="width: 400px;" value="${sysCfgMap['edc_app_ios_update_path']  }"/>
						<input type="hidden" name="edc_app_ios_update_path_ws_id"  value="edc">		
						<input type="hidden" name="edc_app_ios_update_path_desc"  value="App版本更新路径">		
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">Android版本：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="edc_app_android_version_code">
						<input type="text" class="xltext" name="edc_app_android_version_code" style="width: 400px;" value="${sysCfgMap['edc_app_android_version_code']  }"/>
						<input type="hidden" name="edc_app_android_version_code_ws_id"  value="edc">		
						<input type="hidden" name="edc_app_android_version_code_desc"  value="App版本代码">		
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">Android更新路径：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="edc_app_android_update_path">
						<input type="text" class="xltext" name="edc_app_android_update_path" style="width: 400px;" value="${sysCfgMap['edc_app_android_update_path']  }"/>
						<input type="hidden" name="edc_app_android_update_path_ws_id"  value="edc">		
						<input type="hidden" name="edc_app_android_update_path_desc"  value="App版本更新路径">		
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