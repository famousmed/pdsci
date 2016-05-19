<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_cxselect" value="true"/>
</jsp:include>
<script type="text/javascript">

function testEmail() {
	jboxOpen("<s:url value='/sys/cfg/testEmail'/>","测试Email工具", 900, 300);
}

$(document).ready(function(){
	if ('systemCfg'=="${param.tagId}"){
		initUE("online_notice_ueditor");
	}
	
	if ('forgerPsswd'=="${param.tagId}") {
		initUE("sys_resetpasswd_email_content");
	}
	
	if ('securityCenter'=="${param.tagId}") {
		initUE("user_email_auth_email_content");
		initUE("sys_edit_email_content");
	}
});

$(document).ready(function(){
	jboxGet("<s:url value='/sys/cfg/getErrorMsg'/>?msgTypeId=${msgTypeEnumEmail.id}",null,function(resp){
		$("#emailErrorCount").html(resp);
	},null,false);
	jboxGet("<s:url value='/sys/cfg/getErrorMsg'/>?msgTypeId=${msgTypeEnumWeixin.id}",null,function(resp){
		$("#weixinErrorCount").html(resp);
	},null,false);
	jboxGet("<s:url value='/sys/cfg/getErrorMsg'/>?msgTypeId=${msgTypeEnumSms.id}",null,function(resp){
		$("#smsErrorCount").html(resp);
	},null,false);
});
</script>
<c:if test="${'systemCfg'==param.tagId }">
<c:if test="${sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
<fieldset>
<legend>首页配置</legend>
<table class="xllist">
<thead>
	<tr>
		<th width="20%">配置项</th>
		<th width="80%">配置内容</th>
	</tr>
</thead>
<tr>
	<td style="text-align: right" width="100px">系统版本号：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_version">
			<select name="sys_version" class="xlselect">
				<option value="">请选择</option>
				<option value="1.0.1.76" <c:if test="${sysCfgMap['sys_version']=='1.0.1.76'}">selected="selected"</c:if>>1.0.1.76</option>
			</select>
			<input type="hidden" name="sys_version_ws_id"  value="sys">		
			<input type="hidden" name="sys_version_desc"  value="首页地址">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">系统皮肤：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_skin">
			<select name="sys_skin" class="xlselect">
				<option value="">请选择</option>
				<option value="Blue" <c:if test="${sysCfgMap['sys_skin']=='Blue'}">selected="selected"</c:if>>Blue</option>
				<option value="LightBlue" <c:if test="${sysCfgMap['sys_skin']=='LightBlue'}">selected="selected"</c:if>>LightBlue</option>
				<option value="Yellow" <c:if test="${sysCfgMap['sys_skin']=='Yellow'}">selected="selected"</c:if>>Yellow</option>
			</select>
			<input type="hidden" name="sys_skin_ws_id"  value="sys">		
			<input type="hidden" name="sys_skin_desc"  value="系统皮肤">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">弹框皮肤：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_jbox">
			<select name="sys_jbox" class="xlselect">
				<option value="">请选择</option>
				<option value="jbox" <c:if test="${sysCfgMap['sys_jbox']=='jbox'}">selected="selected"</c:if>>jbox</option>
				<option value="art" <c:if test="${sysCfgMap['sys_jbox']=='art'}">selected="selected"</c:if>>art</option>
			</select>
			<input type="hidden" name="sys_jbox_ws_id"  value="sys">		
			<input type="hidden" name="sys_jbox_desc"  value="弹框皮肤">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">首页地址：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_index_url">
			<input type="radio"  name="sys_index_url" value="/login" <c:if test="${sysCfgMap['sys_index_url']=='/login'}">checked="checked"</c:if> />默认登录页面
			<input type="radio"  name="sys_index_url" value="/inx/pharmasun" <c:if test="${sysCfgMap['sys_index_url']=='/inx/pharmasun'}">checked="checked"</c:if> />法默生
			<input type="radio"  name="sys_index_url" value="/inx/enso" <c:if test="${sysCfgMap['sys_index_url']=='/inx/enso'}">checked="checked"</c:if> />恩索
			<input type="radio"  name="sys_index_url" value="/inx/jshtcm" <c:if test="${sysCfgMap['sys_index_url']=='/inx/jshtcm'}">checked="checked"</c:if> />江苏省中
			<input type="radio"  name="sys_index_url" value="/inx/zxyyy" <c:if test="${sysCfgMap['sys_index_url']=='/inx/zxyyy'}">checked="checked"</c:if> />中西医结合
			<input type="hidden" name="sys_index_url_ws_id"  value="sys">		
			<input type="hidden" name="sys_index_url_desc"  value="首页地址">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">LOGO图片：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_login_img">
			<!-- 
			<input type="radio"  name="sys_login_img"  value="sci" <c:if test="${sysCfgMap['sys_login_img']=='sci'}">checked="checked"</c:if> />一体化
			<input type="radio"  name="sys_login_img" value="edc" <c:if test="${sysCfgMap['sys_login_img']=='edc'}">checked="checked"</c:if> />E-CRF
			<input type="radio"  name="sys_login_img"  value="gcp" <c:if test="${sysCfgMap['sys_login_img']=='gcp'}">checked="checked"</c:if> />GCP
			<input type="radio"  name="sys_login_img" value="irb" <c:if test="${sysCfgMap['sys_login_img']=='irb'}">checked="checked"</c:if> />IRB
			 -->
			 <input type="radio"  name="sys_login_img" value="pharmasun_ctms" <c:if test="${sysCfgMap['sys_login_img']=='pharmasun_ctms'}">checked="checked"</c:if> />pharmasun-ctms
			 <input type="radio"  name="sys_login_img" value="pharmasun_edc" <c:if test="${sysCfgMap['sys_login_img']=='pharmasun_edc'}">checked="checked"</c:if> />pharmasun-edc
			<input type="radio"  name="sys_login_img" value="pharmasun_irb" <c:if test="${sysCfgMap['sys_login_img']=='pharmasun_irb'}">checked="checked"</c:if> />pharmasun-irb
			<input type="radio"  name="sys_login_img" value="medroad" <c:if test="${sysCfgMap['sys_login_img']=='medroad'}">checked="checked"</c:if> />medroad
			<input type="radio"  name="sys_login_img" value="jshtcm" <c:if test="${sysCfgMap['sys_login_img']=='jshtcm'}">checked="checked"</c:if> />江苏省中
			<input type="hidden" name="sys_login_img_ws_id"  value="sys">		
			<input type="hidden" name="sys_login_img_desc"  value="登录图片">		
	</td>
</tr>	
<!-- 
<tr>
	<td style="text-align: right" width="100px">登录页面图片：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_favicon_img">
				<input type="radio"  name="sys_favicon_img"  value="sczy" <c:if test="${sysCfgMap['sys_favicon_img']=='sczy'}">checked="checked"</c:if> />四川省中医招录
			<input type="hidden" name="sys_favicon_img_desc"  value="favicon图片">		
	</td>
</tr>
 -->
<tr>
	<td style="text-align: right" width="100px">系统标题名称：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_title_name">
			<input type="text" class="xltext" name="sys_title_name"  value="${sysCfgMap['sys_title_name']}" style="width: 400px;"/>
			<input type="hidden" name="sys_title_name_ws_id"  value="sys">		
			<input type="hidden" name="sys_title_name_desc"  value="系统标题名称">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">浏览器下载路径：</td>
	<td style="text-align: left;padding-left: 5px">
			<input type="hidden" name="cfgCode" value="chrome_download_url">
			<input type="text" class="xltext" name="chrome_download_url"  value="${sysCfgMap['chrome_download_url']}" style="width: 400px;" placeholder="例如：http://localhost:9080${ctxPath }upload/**.zip"/>
		<input type="hidden" name="chrome_download_url_desc"  value="浏览器下载路径">每个项目配置的专用浏览器。
	</td>
</tr>
</table>
</fieldset>
</c:if>
<fieldset>
<legend>分页配置</legend>
<table class="xllist">
<thead>
	<tr>
		<th width="20%">配置项</th>
		<th width="80%">配置内容</th>
	</tr>
</thead>
<tr>
		<td style="text-align: right" width="100px">分页样式：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_page_style">
				<input type="radio"  name="sys_page_style" id="sys_page_style_select" value="select" <c:if test="${sysCfgMap['sys_page_style']=='select'}">checked="checked"</c:if> /><label for="sys_page_style_select">下拉框</label>
				<input type="radio"  name="sys_page_style" id="sys_page_style_input" value="input" <c:if test="${sysCfgMap['sys_page_style']=='input'}">checked="checked"</c:if> /><label for="sys_page_style_input">文本框</label>
				<input type="hidden" name="sys_page_style_ws_id"  value="sys">		
				<input type="hidden" name="sys_page_style_desc"  value="分页样式">		
		</td>
</tr>
<tr>
		<td style="text-align: right" width="100px">分页每页条数设置：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_page_size_cfg">
				<input type="radio"  name="sys_page_size_cfg" id="sys_page_size_cfg_Y" value="Y" <c:if test="${sysCfgMap['sys_page_size_cfg']=='Y'}">checked="checked"</c:if> /><label for="sys_page_size_cfg_Y">开</label>
				<input type="radio"  name="sys_page_size_cfg" id="sys_page_size_cfg_N" value="N" <c:if test="${sysCfgMap['sys_page_size_cfg']=='N'}">checked="checked"</c:if> /><label for="sys_page_size_cfg_N">关</label>
				<input type="hidden" name="sys_page_size_cfg_ws_id"  value="sys">		
				<input type="hidden" name="sys_page_size_cfg_desc"  value="分页每页条数设置">		
		</td>
</tr>
</table>
</fieldset>
<fieldset>
<legend>在线客服</legend>
<table class="xllist">
<thead>
	<tr>
		<th width="20%">配置项</th>
		<th width="80%">配置内容</th>
	</tr>
</thead>

<tr>
	<td style="text-align: right" width="100px">在线客服：</td>
	<td style="text-align: left;padding-left: 5px">
			<input type="hidden" name="cfgCode" value="online_service">
			<input type="radio"  name="online_service" value="Y" <c:if test="${sysCfgMap['online_service']=='Y'}">checked="checked"</c:if> />开
			<input type="radio"  name="online_service" value="N" <c:if test="${sysCfgMap['online_service']=='N'}">checked="checked"</c:if> />关
			<input type="hidden" name="online_service_ws_id"  value="sys">		
			<input type="hidden" name="online_service_desc"  value="在线客服">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">客服QQ1：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="online_service_qq1">
			<input type="text" class="xltext" name="online_service_qq1"  value="${sysCfgMap['online_service_qq1']}" style="width: 400px;"/>
			<input type="hidden" name="online_service_qq1_ws_id"  value="sys">		
			<input type="hidden" name="online_service_qq1_desc"  value="客服QQ1">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">客服QQ2：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="online_service_qq2">
			<input type="text" class="xltext" name="online_service_qq2"  value="${sysCfgMap['online_service_qq2']}" style="width: 400px;"/>
			<input type="hidden" name="online_service_qq2_ws_id"  value="sys">		
			<input type="hidden" name="online_service_qq2_desc"  value="客服QQ2">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">客服电话1：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="online_service_phone1">
			<input type="text" class="xltext" name="online_service_phone1"  value="${sysCfgMap['online_service_phone1']}" style="width: 400px;"/>
			<input type="hidden" name="online_service_phone1_ws_id"  value="sys">		
			<input type="hidden" name="online_service_phone1_desc"  value="客服电话1">		
	</td>
</tr>
<tr>
	<td style="text-align: right" width="100px">客服电话2：</td>
	<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="online_service_phone2">
			<input type="text" class="xltext" name="online_service_phone2"  value="${sysCfgMap['online_service_phone2']}" style="width: 400px;"/>
			<input type="hidden" name="online_service_phone2_ws_id"  value="sys">		
			<input type="hidden" name="online_service_phone2_desc"  value="客服电话2">		
	</td>
</tr>
</table>
</fieldset>
<fieldset>
<legend>更新通知</legend>
<table class="xllist">
<thead>
	<tr>
		<th width="20%">配置项</th>
		<th width="80%">配置内容</th>
	</tr>
</thead>
<tr>
	<td style="text-align: right" width="100px">更新通知：</td>
	<td style="text-align: left;padding-left: 5px">
			<input type="hidden" name="cfgCode" value="online_notice">
			<input type="hidden" name="online_notice" value="">
			<script id="online_notice_ueditor" name="online_notice_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['online_notice']}</script>
			<input type="hidden" name="online_notice_ws_id"  value="sys">		
			<input type="hidden" name="online_notice_desc"  value="更新通知">		
	</td>
</tr>
</table>
</fieldset>
</c:if>
<c:if test="${'emailWeixin'==param.tagId }">
<fieldset>
<legend>短信相关配置</legend>
<table class="xllist">
	<thead>
		<tr>
			<th width="20%">配置项</th>
			<th width="80%">配置内容</th>
		</tr>
	</thead>
	<tr>
		<td style="text-align: right" width="100px">系统发送短信开关：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_sysSmsSendJob">
				<input type="radio"  name="sys_sysSmsSendJob" value="Y" <c:if test="${sysCfgMap['sys_sysSmsSendJob']=='Y'}">checked="checked"</c:if> />开
				<input type="radio"  name="sys_sysSmsSendJob" value="N" <c:if test="${sysCfgMap['sys_sysSmsSendJob']=='N'}">checked="checked"</c:if> />关
				<input type="hidden" name="sys_sysSmsSendJob_ws_id"  value="sys">		
				<input type="hidden" name="sys_sysSmsSendJob_desc"  value="系统发送短信开关">		
		</td>
	</tr>
	
	<tr>
		<td style="text-align: right" width="100px">发送状态：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
		未发送短信数：<span id="smsErrorCount"></span>&#12288;&#12288;未发送邮件数：<span id="emailErrorCount"></span>&#12288;&#12288;	未发送微信数：<span id="weixinErrorCount"></span>
		</td>
	</tr>
</table>
</fieldset>
<fieldset>
<legend>邮件相关配置 <input class="search" type="button" value="测&#12288;试" onclick="testEmail();" /></legend>
<table class="xllist">
	<thead>
		<tr>
			<th width="20%">配置项</th>
			<th width="80%">配置内容</th>
		</tr>
	</thead>
	<tr>
		<td style="text-align: right" width="100px">系统发送邮件开关：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_sysEmailSendJob">
				<input type="radio"  name="sys_sysEmailSendJob" value="Y" <c:if test="${sysCfgMap['sys_sysEmailSendJob']=='Y'}">checked="checked"</c:if> />开
				<input type="radio"  name="sys_sysEmailSendJob" value="N" <c:if test="${sysCfgMap['sys_sysEmailSendJob']=='N'}">checked="checked"</c:if> />关
				<input type="hidden" name="sys_sysEmailSendJob_ws_id"  value="sys">		
				<input type="hidden" name="sys_sysEmailSendJob_desc"  value="系统发送邮件开关">		
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮件服务器IP：端口：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_mail_host">
				<input type="text" class="xltext" name="sys_mail_host"  value="${sysCfgMap['sys_mail_host']}" style="width: 120px;margin-right: 0px;"/>:<input type="text" class="xltext" name="sys_mail_port"  value="${sysCfgMap['sys_mail_port']}" style="width: 20px;"/>
				<input type="hidden" name="sys_mail_host_ws_id"  value="sys">		
				<input type="hidden" name="sys_mail_host_desc"  value="邮件服务器IP">	
				<input type="hidden" name="cfgCode" value="sys_mail_port">
				<input type="hidden" name="sys_mail_port_ws_id"  value="sys">		
				<input type="hidden" name="sys_mail_port_desc"  value="邮件服务器端口">	
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮件发件人：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_mail_from">
				<input type="text" class="xltext" name="sys_mail_from"  value="${sysCfgMap['sys_mail_from']}" style="width: 200px;"/>
				<input type="hidden" name="sys_mail_from_ws_id"  value="sys">		
				<input type="hidden" name="sys_mail_from_desc"  value="邮件发件人">		
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮件账号：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_mail_username">
				<input type="text" class="xltext" name="sys_mail_username"  value="${sysCfgMap['sys_mail_username']}" style="width: 200px;"/>
				<input type="hidden" name="sys_mail_username_ws_id"  value="sys">		
				<input type="hidden" name="sys_mail_username_desc"  value="邮件账号">		
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮件密码：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_mail_password">
				<input type="text" class="xltext" name="sys_mail_password"  value="${sysCfgMap['sys_mail_password']}" style="width: 200px;"/>
				<input type="hidden" name="sys_mail_password_ws_id"  value="sys">		
				<input type="hidden" name="sys_mail_password_desc"  value="邮件密码">		
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">最大允许错误发送次数：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_mail_max_error_times">
				<input type="text" class="xltext" name="sys_mail_max_error_times"  value="${sysCfgMap['sys_mail_max_error_times']}" style="width: 200px;"/>
				<input type="hidden" name="sys_mail_max_error_times_ws_id"  value="sys">		
				<input type="hidden" name="sys_mail_max_error_times_desc"  value="最大允许错误发送次数">		
		</td>
	</tr>
</table>
</fieldset>
</c:if>
<c:if test="${'emailWeixin'==param.tagId }">
<fieldset>
<legend>微信企业号配置</legend>
<table class="xllist">
	<thead>
		<tr>
			<th width="20%">配置项</th>
			<th width="80%">配置内容</th>
		</tr>
	</thead>	
	<tr>
		<td style="text-align: right" width="100px">是否开启微信企业号：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_weixin_qiye_flag">
			<input type="radio"  name="sys_weixin_qiye_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['sys_weixin_qiye_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="sys_weixin_qiye_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['sys_weixin_qiye_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="sys_weixin_qiye_flag"  value="sys">		
			<input type="hidden" name="sys_weixin_qiye_flag"  value="是否开启微信企业号">		
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">微信企业号CorpID：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_weixin_qiye_corp_id">
				<input type="text" name="sys_weixin_qiye_corp_id" style="width: 400px;" value="${sysCfgMap['sys_weixin_qiye_corp_id']  }"/>
				<input type="hidden" name="sys_weixin_qiye_corp_id_ws_id"  value="sys">		
			<input type="hidden" name="sys_weixin_qiye_corp_id_desc"  value="微信企业号CorpID">
		</td>
	</tr>					
	<tr>
		<td style="text-align: right" width="100px">微信企业号Secret：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_weixin_qiye_secret">
				<input type="text" name="sys_weixin_qiye_secret" style="width: 400px;" value="${sysCfgMap['sys_weixin_qiye_secret']  }"/>
				<input type="hidden" name="sys_weixin_qiye_secret_ws_id"  value="sys">		
			<input type="hidden" name="sys_weixin_qiye_secret_desc"  value="微信企业号Secret">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">微信企业号DeptId：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_weixin_qiye_dept_id">
				<input type="text" name="sys_weixin_qiye_dept_id" style="width: 400px;" value="${sysCfgMap['sys_weixin_qiye_dept_id']  }"/>
				<input type="hidden" name="sys_weixin_qiye_dept_id_ws_id"  value="sys">		
			<input type="hidden" name="sys_weixin_qiye_dept_id_desc"  value="微信企业号DeptId">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">微信企业号AppId：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="sys_weixin_qiye_app_id">
				<input type="text" name="sys_weixin_qiye_app_id" style="width: 400px;" value="${sysCfgMap['sys_weixin_qiye_app_id']  }"/>
				<input type="hidden" name="sys_weixin_qiye_app_id_ws_id"  value="sys">		
			<input type="hidden" name="sys_weixin_qiye_app_id_desc"  value="微信企业号AppId">
		</td>
	</tr>
</table>
</fieldset>
</c:if>
<c:if test="${'editorCfg'==param.tagId }">
<fieldset>
<legend>编辑器配置</legend>
<table class="xllist">
	<thead>
		<tr>
			<th width="20%">配置项</th>
			<th width="80%">配置内容</th>
		</tr>
	</thead>
	<tr>
		<td style="text-align: right" width="100px">流媒体服务器访问根地址：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="upload_stream_url">
			<input type="text" class="xltext" name="upload_stream_url"  value="${sysCfgMap['upload_stream_url']}" style="width: 400px;" placeholder="例如：http://localhost:9080${ctxPath }upload"/>
			<input type="hidden" name="upload_stream_url_desc"  value="上传图片访问地址">用于流媒体视频的访问地址。
			<input type="hidden" name="upload_stream_url_ws_id"  value="sys">
		</td>
	</tr>	
	<tr>
		<td style="text-align: right" width="100px">流媒体服务器上传保存物理路径：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="upload_stream_dir">
			<input type="text" class="xltext" name="upload_stream_dir"  value="${sysCfgMap['upload_stream_dir']}" style="width: 400px;" placeholder="例如：D:\Tomcat-7.0.47\webapps\upload"/>
			<input type="hidden" name="upload_stream_dir_desc"  value="上传图片保存物理路径">用于流媒体视频的实际存储文件夹。
			<input type="hidden" name="upload_stream_dir_ws_id"  value="sys">
		</td>
	</tr>	
	<tr>
		<td style="text-align: right" width="100px">上传访问根地址：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="upload_base_url">
			<input type="text" class="xltext" name="upload_base_url"  value="${sysCfgMap['upload_base_url']}" style="width: 400px;" placeholder="例如：http://localhost:9080${ctxPath }upload"/>
			<input type="hidden" name="upload_base_url_desc"  value="上传图片访问地址">用于资讯标题图片，编辑器上传图片，文件，视频的访问地址。
			<input type="hidden" name="upload_base_url_ws_id"  value="sys">
		</td>
	</tr>	
	<tr>
		<td style="text-align: right" width="100px">上传保存物理路径：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="upload_base_dir">
			<input type="text" class="xltext" name="upload_base_dir"  value="${sysCfgMap['upload_base_dir']}" style="width: 400px;" placeholder="例如：D:\Tomcat-7.0.47\webapps\upload"/>
			<input type="hidden" name="upload_base_dir_desc"  value="上传图片保存物理路径">用于资讯标题图片，编辑器上传图片，文件，视频的实际存储文件夹。
			<input type="hidden" name="upload_base_dir_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">允许上传图片类型：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="inx_image_support_mime">
				<c:if test="${not empty sysCfgMap['inx_image_support_mime']}">
				<input type="text" class="xltext" name="inx_image_support_mime"  value="${sysCfgMap['inx_image_support_mime']}" style="width: 400px;" placeholder="例如：image/bmp,image/gif,image/jpeg,image/png"/>
				</c:if>
				<c:if test="${empty sysCfgMap['inx_image_support_mime']}">
				<input type="text" class="xltext" name="inx_image_support_mime"  value="image/bmp,image/gif,image/jpeg,image/png" style="width: 400px;" placeholder="例如：image/bmp,image/gif,image/jpeg,image/png"/>
				</c:if>
			<input type="hidden" name="inx_image_support_mime_desc"  value="允许上传图片类型">
			<input type="hidden" name="inx_image_support_mime_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">允许上传图片文件后缀名：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="inx_image_support_suffix">
				<c:if test="${not empty sysCfgMap['inx_image_support_suffix']}">
				<input type="text" class="xltext" name="inx_image_support_suffix"  value="${sysCfgMap['inx_image_support_suffix']}" style="width: 400px;" placeholder="例如：.bmp,.gif,.jpg,.png"/>
				</c:if>
				<c:if test="${empty sysCfgMap['inx_image_support_suffix']}">
				<input type="text" class="xltext" name="inx_image_support_suffix"  value=".bmp,.gif,.jpg,.png" style="width: 400px;" placeholder="例如：.bmp,.gif,.jpg,.png"/>
				</c:if>
			<input type="hidden" name="inx_image_support_suffix_desc"  value="允许上传图片文件后缀名">
			<input type="hidden" name="inx_image_support_suffix_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">允许上传图片大小(M)：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
				<input type="hidden" name="cfgCode" value="inx_image_limit_size">
				<c:if test="${not empty sysCfgMap['inx_image_limit_size']}">
				<input type="text" class="xltext" name="inx_image_limit_size"  value="${sysCfgMap['inx_image_limit_size']}" style="width: 400px;" placeholder="例如：2"/>
				</c:if>
				<c:if test="${empty sysCfgMap['inx_image_limit_size']}">
				<input type="text" class="xltext" name="inx_image_limit_size"  value="2" style="width: 400px;" placeholder="例如：2"/>
				</c:if>
			    <input type="hidden" name="inx_image_limit_size_desc"  value="允许上传图片大小(k)">
			    <input type="hidden" name="inx_image_limit_size_ws_id"  value="sys">
		</td>
	</tr>
</table>
</fieldset>
</c:if>
<c:if test="${'loginCfg'==param.tagId }">
<fieldset>
<legend>登录配置</legend>
<table class="xllist">
	<thead>
		<tr>
			<th width="20%">配置项</th>
			<th width="80%">配置内容</th>
		</tr>
	</thead>	
	<tr>
		<td style="text-align: right" width="100px">是否强制修改默认密码：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="req_complex_passwd">
			<input type="radio"  name="req_complex_passwd" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['req_complex_passwd']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="req_complex_passwd" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['req_complex_passwd']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="req_complex_passwd_desc"  value="是否强制复杂密码">
			<input type="hidden" name="req_complex_passwd_ws_id"  value="sys">
		</td>
	</tr>	
	<tr>
		<td style="text-align: right" width="100px">是否唯一登录：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="unique_login_flag">
			<input type="radio"  name="unique_login_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['unique_login_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="unique_login_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['unique_login_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="unique_login_flag_desc"  value="是否唯一登录">
			<input type="hidden" name="unique_login_flag_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">人员是否多可关联多部门：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_user_dept_flag">
			<input type="radio"  name="sys_user_dept_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['sys_user_dept_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="sys_user_dept_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['sys_user_dept_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="sys_user_dept_flag_desc"  value="人员是否多可关联多部门">
			<input type="hidden" name="sys_user_dept_flag_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">人员是否可以删除：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_user_delete_flag">
			<input type="radio"  name="sys_user_delete_flag" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['sys_user_delete_flag']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="sys_user_delete_flag" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['sys_user_delete_flag']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="sys_user_delete_flag_desc"  value="人员是否可以删除">
			<input type="hidden" name="sys_user_delete_flag_ws_id"  value="sys">
		</td>
	</tr>	
	<tr>
		<td style="text-align: right" width="100px">机构默认地区：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
	 		<div id="provCityAreaId">
	 			<input type="hidden" name="cfgCode" value="srm_default_orgProvId">
				<select id="orgProvId" name="srm_default_orgProvId" class="province xlselect" data-value="${sysCfgMap['srm_default_orgProvId']}" data-first-title="选择省"></select>	
				<input type="hidden" name="srm_default_orgProvId_desc"  value="默认省">
				<input type="hidden" name="srm_default_orgProvId_ws_id"  value="sys">							
	 			<input type="hidden" name="cfgCode" value="srm_default_orgCityId">
				<select id="orgCityId" name="srm_default_orgCityId" class="city xlselect" data-value="${sysCfgMap['srm_default_orgCityId']}" data-first-title="选择市"></select>
				<input type="hidden" name="srm_default_orgCityId_desc"  value="默认市">
				<input type="hidden" name="srm_default_orgCityId_ws_id"  value="sys">		
			</div>
			<script type="text/javascript">
				// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
				$.cxSelect.defaults.nodata = "none"; 

				$("#provCityAreaId").cxSelect({ 
					selects : ["province", "city"], 
					nodata : "none",
					firstValue : ""
				}); 
			</script>	
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">人员是否展示履历：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_user_show_resum">
			<label>
			<input type="radio"  name="sys_user_show_resum" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['sys_user_show_resum']== GlobalConstant.FLAG_Y}">checked</c:if> />是
			</label>
			<label>
			<input type="radio"  name="sys_user_show_resum" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['sys_user_show_resum']== GlobalConstant.FLAG_N}">checked</c:if> />否
			</label>
			<input type="hidden" name="sys_user_show_resum_desc"  value="人员是否展示履历">
			<input type="hidden" name="sys_user_show_resum_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">是否验证用户名格式：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_user_check_user_code">
			<label>
			<input type="radio"  name="sys_user_check_user_code" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['sys_user_check_user_code']== GlobalConstant.FLAG_Y}">checked</c:if> />是
			</label>
			<label>
			<input type="radio"  name="sys_user_check_user_code" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['sys_user_check_user_code']== GlobalConstant.FLAG_N}">checked</c:if> />否
			</label>
			<input type="hidden" name="sys_user_check_user_code_desc"  value="是否验证用户名格式">
			<input type="hidden" name="sys_user_check_user_code_ws_id"  value="sys">
		</td>
	</tr>
</table>
</fieldset>
</c:if>
<c:if test="${'forgerPsswd'==param.tagId }">
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
					<td style="text-align: right" width="100px">是否显示忘记密码：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="sys_forget_password">
							<input type="radio"  name="sys_forget_password" id="sys_forget_password_Y" value="Y" <c:if test="${sysCfgMap['sys_forget_password']=='Y'}">checked="checked"</c:if> /><label for="sys_forget_password_Y">是</label>
							<input type="radio"  name="sys_forget_password" id="sys_forget_password_N" value="N" <c:if test="${sysCfgMap['sys_forget_password']=='N'}">checked="checked"</c:if> /><label for="sys_forget_password_N">否</label>
							<input type="hidden" name="sys_forget_password_ws_id"  value="sys">		
							<input type="hidden" name="sys_forget_password_desc"  value="是否显示忘记密码">		
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">找回密码方式：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
						<input type="hidden" name="cfgCode" value="sys_forget_password_type">
						<input type="radio"  name="sys_forget_password_type" value="email" <c:if test="${sysCfgMap['sys_forget_password_type']== 'email'}">checked="checked"</c:if> />邮件重置密码
						<input type="radio"  name="sys_forget_password_type" value="phone" <c:if test="${sysCfgMap['sys_forget_password_type']== 'phone'}">checked="checked"</c:if> />手机发送验证码
						<input type="radio"  name="sys_forget_password_type" value="userinfo" <c:if test="${sysCfgMap['sys_forget_password_type']== 'userinfo'}">checked="checked"</c:if> />账号信息校验
						<input type="hidden" name="sys_forget_password_type_desc"  value="找回密码方式">
						<input type="hidden" name="sys_forget_password_type_ws_id"  value="sys">
					</td>
				</tr>	
				<tr>
					<td style="text-align: right" width="100px">邮件标题：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="sys_resetpasswd_email_title">
					<input type="text" name="sys_resetpasswd_email_title"  value="${sysCfgMap['sys_resetpasswd_email_title']}" class="xltext"/>
					<font color="red">例：密码重置</font>
					<input type="hidden" name="sys_resetpasswd_email_title_ws_id"  value="sys">		
					<input type="hidden" name="sys_resetpasswd_email_title_desc"  value="重置密码邮件标题">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >邮件内容：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="sys_resetpasswd_email_content">
							<script id="sys_resetpasswd_email_content" name="sys_resetpasswd_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['sys_resetpasswd_email_content']}</script>
							<font color="red">例：你好!<br/>
&#12288;&#12288;你的登录邮箱为：$!{linkEmail}。请点击以下链接重置密码：$!{linkUrl}<br/>
&#12288;&#12288;如果以上链接无法点击，请将上面的地址复制到你的浏览器(如IE)的地址栏进入系统。</font>
							<input type="hidden" name="sys_resetpasswd_email_content_ws_id"  value="sys">		
						<input type="hidden" name="sys_resetpasswd_email_content_desc"  value="重置密码邮件内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">重置密码链接地址：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="sys_resetpasswd_url">
					<input type="text" name="sys_resetpasswd_url"  value="${sysCfgMap['sys_resetpasswd_url']}" class="xltext" style="width:400px"/>
					<br/><font color="red">必须为http://ip地址或域名:访问端口${ctxPath }/sys/user/forget/thrid</font>
					<input type="hidden" name="sys_resetpasswd_url_ws_id"  value="sys">		
					<input type="hidden" name="sys_resetpasswd_url_desc"  value="重置密码链接地址">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" >手机校验码内容：</td>
					<td style="text-align: left;padding-left: 5px" >
						<input type="hidden" name="cfgCode" value="sys_resetpasswd_phone_content">
						<input type="text" name="sys_resetpasswd_phone_content"  value="${sysCfgMap['sys_resetpasswd_phone_content']}" class="xltext" style="width: 400px;"/>
						<br/><font color="red">例：验证码$!{verifyCodePhone}用于修改密码，请勿泄露。</font>
						<input type="hidden" name="sys_resetpasswd_phone_content_ws_id"  value="sys">		
						<input type="hidden" name="sys_resetpasswd_phone_content_desc"  value="手机校验码内容">
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">手机校验码有效期：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
					<input type="hidden" name="cfgCode" value="sys_phone_effective_time">
					<input type="text" name="sys_phone_effective_time"  value="${sysCfgMap['sys_phone_effective_time']}" class="xltext"/>分钟
					<input type="hidden" name="sys_phone_effective_time_ws_id"  value="sys">		
					<input type="hidden" name="sys_phone_effective_time_desc"  value="手机校验码有效期">
					</td>
				</tr>
</table>
</fieldset>
</c:if>

<c:if test="${'securityCenter'==param.tagId }">
<fieldset>
<legend>安全中心配置</legend>
<table class="xllist">
	<thead>
		<tr>
			<th width="20%">配置项</th>
			<th width="80%">配置内容</th>
		</tr>
	</thead>	
	<tr>
		<td style="text-align: right" width="100px">个人信息是否能修改邮箱：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="user_edit_mail">
			<input type="radio"  name="user_edit_mail" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['user_edit_mail']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="user_edit_mail" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['user_edit_mail']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="user_edit_mail_desc"  value="个人信息修改邮箱">
			<input type="hidden" name="user_edit_mail_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">个人信息是否能修改手机号：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="user_edit_phone">
			<input type="radio"  name="user_edit_phone" value="${GlobalConstant.FLAG_Y }" <c:if test="${sysCfgMap['user_edit_phone']== GlobalConstant.FLAG_Y}">checked="checked"</c:if> />是
			<input type="radio"  name="user_edit_phone" value="${GlobalConstant.FLAG_N }" <c:if test="${sysCfgMap['user_edit_phone']== GlobalConstant.FLAG_N}">checked="checked"</c:if> />否
			<input type="hidden" name="user_edit_phone_desc"  value="个人信息修改手机号">
			<input type="hidden" name="user_edit_phone_ws_id"  value="sys">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮箱认证邮件标题：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="user_email_auth_email_title">
			<input type="text" name="user_email_auth_email_title"  value="${sysCfgMap['user_email_auth_email_title']}" class="xltext"/>
			<font color="red">例：系统邮箱验证</font>
			<input type="hidden" name="user_email_auth_email_title_ws_id"  value="sys">		
			<input type="hidden" name="user_email_auth_email_title_desc"  value="邮箱认证邮件标题">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" >邮箱认证邮件内容：</td>
		<td style="text-align: left;padding-left: 5px" >
				<input type="hidden" name="cfgCode" value="user_email_auth_email_content">
				<script id="user_email_auth_email_content" name="user_email_auth_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['user_email_auth_email_content']}</script>
				<font color="red">例：你好! <br/>
&#12288;&#12288;你正在邮箱验证，请点击以下链接完成邮箱验证：$!{linkUrl}<br/>
&#12288;&#12288;如果以上链接无法点击，请将上面的地址复制到你的浏览器(如IE)的地址栏进入系统。</font>
				<input type="hidden" name="user_email_auth_email_content_ws_id"  value="sys">		
				<input type="hidden" name="user_email_auth_email_content_desc"  value="邮箱认证邮件内容">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮箱认证链接地址：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="user_email_auth_url">
			<input type="text" name="user_email_auth_url"  value="${sysCfgMap['user_email_auth_url']}" class="xltext" style="width:400px"/>
			<br/><font color="red">必须为http://ip地址或域名:访问端口${ctxPath }/sys/user/auth/userEmailAuth</font>
			<input type="hidden" name="user_email_auth_url_ws_id"  value="sys">		
			<input type="hidden" name="user_email_auth_url_desc"  value="邮箱认证链接地址">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" width="100px">邮箱修改邮件标题：</td>
		<td style="text-align: left;padding-left: 5px" width="200px">
			<input type="hidden" name="cfgCode" value="sys_edit_email_title">
			<input type="text" name="sys_edit_email_title"  value="${sysCfgMap['sys_edit_email_title']}" class="xltext"/>
			<font color="red">例：邮箱验证</font>
			<input type="hidden" name="sys_edit_email_title_ws_id"  value="sys">		
			<input type="hidden" name="sys_edit_email_title_desc"  value="邮箱修改邮件标题">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" >邮箱修改邮件内容：</td>
		<td style="text-align: left;padding-left: 5px" >
			<input type="hidden" name="cfgCode" value="sys_edit_email_content">
			<script id="sys_edit_email_content" name="sys_edit_email_content_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['sys_edit_email_content']}</script>
			<font color="red">例：你好! <br/>
&#12288;&#12288;你正在邮箱验证，请在校验码输入框中输入：$!{verifyCode}，以完成操作。<br/>
&#12288;&#12288;注意：此操作可能会修改你的登录邮箱。如非本人操作，请及时登录并修改密码以保证账户安全。</font>
			<input type="hidden" name="sys_edit_email_content_ws_id"  value="sys">		
			<input type="hidden" name="sys_edit_email_content_desc"  value="邮箱修改邮件内容">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" >手机认证校验码内容：</td>
		<td style="text-align: left;padding-left: 5px" >
			<input type="hidden" name="cfgCode" value="sys_auth_phone_content">
			<input type="text" name="sys_auth_phone_content"  value="${sysCfgMap['sys_auth_phone_content']}" class="xltext" style="width: 400px;"/>
			<br/><font color="red">例：验证码$!{verifyCodeAuth}用于手机认证，请勿泄露。</font>
			<input type="hidden" name="sys_auth_phone_content_ws_id"  value="sys">		
			<input type="hidden" name="sys_auth_phone_content_desc"  value="手机认证校验码内容">
		</td>
	</tr>
	<tr>
		<td style="text-align: right" >手机修改校验码内容：</td>
		<td style="text-align: left;padding-left: 5px" >
			<input type="hidden" name="cfgCode" value="sys_edit_phone_content">
			<input type="text" name="sys_edit_phone_content"  value="${sysCfgMap['sys_edit_phone_content']}" class="xltext" style="width: 400px;"/>
			<br/><font color="red">例：验证码$!{verifyCodeAuth}用于手机修改，请勿泄露。</font>
			<input type="hidden" name="sys_edit_phone_content_ws_id"  value="sys">		
			<input type="hidden" name="sys_edit_phone_content_desc"  value="手机修改校验码内容">
		</td>
	</tr>	
</table>
</fieldset>
</c:if>
