<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
	<jsp:param name="jquery_cxselect" value="true"/>
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
	if ('srmProcessCfg'=="${param.tagId }") {
		initUE("ueditor1");
		initUE("ueditor2");
		initUE("ueditor3");
		initUE("ueditor4");
		initUE("ueditor5");
	}
if ('systemFuncs'=="${param.tagId }") {
	initUE("ueditor6");
	initUE("ueditor7");
}
});
</script>
<div class="mainright">
	<div class="content">
 	<form id="saveCfgForm" action="<s:url value="/sys/cfg/edit" />" method="post" >
 		<div class="title1 clearfix">
 		<div><font color="red">&#12288;&#12288;所有参数保存后，需刷新内存才能生效!!!</font></div>
			<jsp:include page="/jsp/sys/cfg/sysCfg.jsp"></jsp:include>
			<c:if test="${'srmVersionCfg'==param.tagId }">
			<fieldset>
			<legend>
					<input type="radio" id="srm_for_use_global" name="srm_for_use"  value="global" <c:if test="${sysCfgMap['srm_for_use']=='global'}">checked="checked"</c:if> /><label for="srm_for_use_global">卫生局版</label>
					<input type="hidden" name="cfgCode" value="srm_for_use">
					<input type="hidden" name="srm_for_use_desc"  value="科研适用版本">
			</legend>
			<table class="xllist">		
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>		
				<tr>
					<td style="text-align: right" width="100px">主管部门是否适用：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
	 					<input type="hidden" name="cfgCode" value="srm_for_charge_use">
						<input type="radio"  name="srm_for_charge_use"  value="Y" <c:if test="${sysCfgMap['srm_for_charge_use']=='Y'}">checked="checked"</c:if> />适用
	 					<input type="radio"  name="srm_for_charge_use" value="N" <c:if test="${sysCfgMap['srm_for_charge_use']=='N'}">checked="checked"</c:if> />不适用
						<input type="hidden" name="srm_for_charge_use_desc"  value="主管部门是否适用">		
					</td>
				</tr>		
				<tr>
				    <td style="text-align: right" width="100px">顶级单位流水号：</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				       <input type="hidden" name="cfgCode" value="global_org_flow">
				       <select name="global_org_flow" class="xlselect">
				               <option value=''>请选择</option>
                           <c:forEach items="${applicationScope.sysOrgList}" var="org">
                               <option value="${org.orgFlow}" <c:if test="${org.orgFlow eq sysCfgMap['global_org_flow']}">selected="selected"</c:if> >${org.orgName}</option>
                           </c:forEach>
				       </select>
				       <input type="hidden" name="global_org_flow_desc"  value="顶级单位流水号">
				    </td>
				</tr>
				<tr>
				    <td style="text-align: right" width="100px">机构人员是否可以新增：</td>
				    <td style="text-align: left;padding-left: 5px" width="200px">
				       <input type="hidden" name="cfgCode" value="srm_add_user_flag">
				       <input type="radio"  name="srm_add_user_flag"  value="Y" <c:if test="${sysCfgMap['srm_add_user_flag']=='Y'}">checked="checked"</c:if> />可以
	 				   <input type="radio"  name="srm_add_user_flag" value="N" <c:if test="${sysCfgMap['srm_add_user_flag']=='N'}">checked="checked"</c:if> />不可以（接口导入）
				       <input type="hidden" name="srm_add_user_flag_desc"  value="机构人员是否可以新增">
				    </td>
				</tr>
				</table>
			</fieldset>
			
			<fieldset>
			<legend>
				<input type="radio" id="srm_for_use_local" name="srm_for_use" value="local" <c:if test="${sysCfgMap['srm_for_use']=='local'}">checked="checked"</c:if> /><label for="srm_for_use_local">医院版</label>
			</legend>
			<table class="xllist">		
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>		
				</table>
			</fieldset>
			</c:if>
			<c:if test="${'srmRoleCfg'==param.tagId }">
			<!-- 角色配置 用于消息引擎 -->
			<fieldset>
			    <legend>角色配置</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td>医院管理员</td>
				    		<td style="text-align: left;padding-left: 5px">
				    		    <input type="hidden" name="cfgCode" value="srm_local_manager_role">
				    		    <input type="hidden" name="srm_local_manager_role_desc" value="医院管理员">
				    		    <select name="srm_local_manager_role" class="xlselect">
				    		        <option>请选择</option>
				    		        <c:forEach items="${applicationScope.sysRoleWsMap['srm'] }" var="role">
								        <option value="${role.roleFlow }" <c:if test="${sysCfgMap['srm_local_manager_role'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							        </c:forEach>
				    		    </select>
				    		</td>
				    	</tr>
				    	
				    	<tr>
				    		<td>区卫生局管理员</td>
				    		<td style="text-align: left;padding-left: 5px">
				    		    <input type="hidden" name="cfgCode" value="srm_charge_manager_role">
				    		    <input type="hidden" name="srm_charge_manager_role_desc" value="区卫生局管理员">
				    		    <select name="srm_charge_manager_role" class="xlselect">
				    		        <option>请选择</option>
				    		        <c:forEach items="${applicationScope.sysRoleWsMap['srm'] }" var="role">
								        <option value="${role.roleFlow }" <c:if test="${sysCfgMap['srm_charge_manager_role'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							        </c:forEach>
				    		    </select>
				    		</td>
				    	</tr>
				    	
				    	<tr>
				    		<td>卫生局管理员</td>
				    		<td style="text-align: left;padding-left: 5px">
				    		    <input type="hidden" name="cfgCode" value="srm_global_manager_role">
				    		    <input type="hidden" name="srm_global_manager_role_desc" value="卫生局管理员">
				    		    <select name="srm_global_manager_role" class="xlselect">
				    		        <option>请选择</option>
				    		        <c:forEach items="${applicationScope.sysRoleWsMap['srm'] }" var="role">
								        <option value="${role.roleFlow }" <c:if test="${sysCfgMap['srm_global_manager_role'] ==role.roleFlow }">selected</c:if>>${role.roleName }</option>
							        </c:forEach>
				    		    </select>
				    		</td>
				    	</tr>
				    </tbody>		
				</table>
			</fieldset>
			</c:if>
			<c:if test="${'srmFormCfg'==param.tagId }">
			<fieldset>
			    <legend>补录项目表单选择配置</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    <!-- 
				    	<tr>
				    		<td>重点人才</td>
				    		<td style="text-align: left;padding-left: 5px" >
				    		 <input type="hidden" name="cfgCode" value="srm_aidproj_rc">
				    		 <input type="hidden" name="srm_aidproj_rc_desc" value="重点人才项目补录">
				    		 <select name="srm_aidproj_rc" class="xlselect">
				    		     <option>请选择</option>
				    		 </select>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>重点学科</td>
				    		<td style="text-align: left;padding-left: 5px" >
				    		 <input type="hidden" name="cfgCode" value="srm_aidproj_xk">
				    		 <input type="hidden" name="srm_aidproj_xk_desc" value="重点学科项目补录">
				    		 <select name="srm_aidproj_xk" class="xlselect">
				    		     <option>请选择</option>
				    		 </select>
				    		</td>
				    	</tr>
				    	 -->
				    	<tr>
				    		<td>需要审核的补录项目类型</td>
				    		<td style="text-align: left;padding-left: 5px" >
								<input type="hidden" name="cfgCode" value="srm_aid_needAudit_category">
								<input type="hidden" name="srm_aid_needAudit_category_desc" value="需要审核的补录项目类型">
								<select name="srm_aid_needAudit_category" class="xlselect">
									<option value=''>请选择</option>
									<c:forEach items="${dictTypeEnumAidProjTypeList}" var="aidProjType">
										<option value='${aidProjType.dictId}'  <c:if test="${sysCfgMap['srm_aid_needAudit_category'] eq aidProjType.dictId}">selected="selected"</c:if> >${aidProjType.dictName}</option>
									</c:forEach>
								</select>
				    		</td>
				    	</tr>
				    </tbody>		
				</table>
			</fieldset>
			<fieldset>
			<legend>打印项配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">水印 草稿：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="srm_watermark_n">
							<input type="text" class="xltext" name="srm_watermark_n"  value="${sysCfgMap['srm_watermark_n']}" style="width: 400px;" placeholder=""/>
						<input type="hidden" name="srm_watermark_n_desc"  value="水印 草稿  内容">水印 草稿 内容。
					</td>
				</tr>		
				<tr>
					<td style="text-align: right" width="100px">水印 正式稿：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
							<input type="hidden" name="cfgCode" value="srm_watermark_y">
							<input type="text" class="xltext" name="srm_watermark_y"  value="${sysCfgMap['srm_watermark_y']}" style="width: 400px;" placeholder=""/>
						<input type="hidden" name="srm_watermark_y_desc"  value="水印 正式稿  内容">水印 正式稿 内容。
					</td>
				</tr>	
			</table>
			</fieldset>
			</c:if>
			<c:if test="${'srmProcessCfg'==param.tagId }">
			<fieldset>
			<legend>审核流程配置</legend>
			<table class="xllist">		
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>
				<tbody>
				    <tr>
				        <td>审核退回流程</td>
				        <td style="text-align: left;padding-left: 5px" width="200px">
				            <input type="hidden" name="cfgCode" value="srm_back_apply_user">
				    		<input type="hidden" name="srm_back_apply_user_desc" value="审核退回流程">
				    		<input type="radio"  name="srm_back_apply_user" value="Y" <c:if test='${sysCfgMap["srm_back_apply_user"] eq "Y"}'>checked="checked"</c:if> />直接退回负责人
				    		<input type="radio" name="srm_back_apply_user" value="N" <c:if test='${sysCfgMap["srm_back_apply_user"] eq "N"}'>checked="checked"</c:if> />逐级退回(卫生局-主管部门-机构-负责人)
				        </td>
				    </tr>
				    <tr>
				        <td>合同拨款使用下拨内容</td>
				        <td style="text-align: left;padding-left: 5px" width="200px">
				            <input type="hidden" name="cfgCode" value="srm_contract_use_fundPlan">
				    		<input type="hidden" name="srm_contract_use_fundPlan_desc" value="合同拨款使用下拨内容">
				    		<input type="radio"  name="srm_contract_use_fundPlan" value="Y" <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] eq "Y"}'>checked="checked"</c:if> />使用
				    		<input type="radio" name="srm_contract_use_fundPlan" value="N" <c:if test='${sysCfgMap["srm_contract_use_fundPlan"] eq "N" or empty sysCfgMap["srm_contract_use_fundPlan"]}'>checked="checked"</c:if> />不使用
				        </td>
				    </tr>
				</tbody>		
				</table>
			</fieldset>
			<fieldset>
			<legend>流程图引导语配置</legend>
			<table class="xllist">
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>	
				<tr>
					<td style="text-align: right" width="100px">项目申请引导语：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="srm_ky_guide_1">
							<input type="hidden" name="srm_ky_guide_1_ws_id"  value="sys">		
							<input type="hidden" name="srm_ky_guide_1_desc"  value="项目申请引导语">		
							<script id="ueditor1" name="srm_ky_guide_1_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['srm_ky_guide_1']}</script>
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">项目立项引导语：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="srm_ky_guide_2">
							<input type="hidden" name="srm_ky_guide_2_ws_id"  value="sys">		
							<input type="hidden" name="srm_ky_guide_2_desc"  value="项目立项引导语">		
							<script id="ueditor2" name="srm_ky_guide_2_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['srm_ky_guide_2']}</script>
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">项目合同引导语：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="srm_ky_guide_3">
							<input type="hidden" name="srm_ky_guide_3_ws_id"  value="sys">		
							<input type="hidden" name="srm_ky_guide_3_desc"  value="项目合同引导语">		
							<script id="ueditor3" name="srm_ky_guide_3_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['srm_ky_guide_3']}</script>
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">项目进展引导语：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="srm_ky_guide_4">
							<input type="hidden" name="srm_ky_guide_4_ws_id"  value="sys">		
							<input type="hidden" name="srm_ky_guide_4_desc"  value="项目进展引导语">		
							<script id="ueditor4" name="srm_ky_guide_4_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['srm_ky_guide_4']}</script>
					</td>
				</tr>
				<tr>
					<td style="text-align: right" width="100px">项目验收引导语：</td>
					<td style="text-align: left;padding-left: 5px" >
							<input type="hidden" name="cfgCode" value="srm_ky_guide_5">
							<input type="hidden" name="srm_ky_guide_5_ws_id"  value="sys">		
							<input type="hidden" name="srm_ky_guide_5_desc"  value="项目验收引导语">		
							<script id="ueditor5" name="srm_ky_guide_5_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['srm_ky_guide_5']}</script>
					</td>
				</tr>
			</table>
			</fieldset>
			</c:if>
			
			<c:if test="${'systemFuncs'==param.tagId }">
			<fieldset>
			<legend>超级IP</legend>
			<table class="xllist">		
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>		
				<tr>
					<td style="text-align: right" width="100px">超级IP：</td>
					<td style="text-align: left;padding-left: 5px">
						<input type="hidden" name="cfgCode" value="super_ip">
						<input type="text" class="xltext" name="super_ip"  value="${sysCfgMap['super_ip']}" style="width: 400px;" placeholder=""/>
						<input type="hidden" name="super_ip_desc"  value="超级IP">超级IP。
					</td>
				</tr>
				</table>
			</fieldset>
			<fieldset>
			    <legend>服务协议配置</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td>服务协议</td>
				    		<td style="text-align: left;padding-left: 5px">
				    			<input type="hidden" name="cfgCode" value="sys_agreement">
								<input type="hidden" name="sys_agreement_ws_id"  value="sys">		
								<input type="hidden" name="sys_agreement_desc"  value="系统标题名称">		
								<script id="ueditor7" name="sys_agreement_big_value" type="text/plain" style="width:78%;height:400px;position:relative;">${sysCfgMap['sys_agreement']}</script>
				    		</td>
				    	</tr>
				    </tbody>		
				</table>
			</fieldset>
			
			<!-- 教育对接配置 -->
			<fieldset>
			    <legend>教育对接配置</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td>住院医师访问路径</td>
				    		<td style="text-align: left;padding-left: 5px" width="200px">
				    		 <input type="hidden" name="cfgCode" value="srm_zyys_url">
				    		 <input type="hidden" name="srm_zyys_url_desc" value="住院医师访问地址">
				    		 <input name="srm_zyys_url"  type="text" value="${sysCfgMap['srm_zyys_url']}"  class="xltext" style="width: 400px;" placeholder="请以http://开头"/>
				    		</td>
				    	</tr>
				    </tbody>		
				</table>
			</fieldset>
			<!-- 教育对接配置结束 -->
			
			<fieldset>
			<legend>成果项配置[控制在视图中是否显示]</legend>
			<table class="xllist">
				<tr>
					<th width="20%">配置项</th>
					<th width="80%">配置内容</th>
				</tr>
				<c:forEach items="${achTypeEnumList}" var="achType">
					<c:set var='achTypeId' value="srm_useAchType_${achType.id}"></c:set>
					<tr>
		               	<td>
		                   	${achType.name }
		               	</td>
		               	<td>
		               		<input type="hidden" name="cfgCode" value="${achTypeId}">
							<input type="radio"  name="${achTypeId}" value="Y" <c:if test="${sysCfgMap[achTypeId] eq 'Y'}">checked="checked"</c:if> />开
							<input type="radio"  name="${achTypeId}" value="N" <c:if test="${sysCfgMap[achTypeId] eq 'N'}">checked="checked"</c:if> />关
							<input type="hidden" name="${achTypeId}_desc"  value="${achType.name}">
		               	</td>
	                </tr>
                </c:forEach>	
			</table>
			</fieldset>
			
			<fieldset>
			    <legend>网评专家通知配置</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td>专家通知模板内容</td>
				    		<td>
				    		 <input type="hidden" name="cfgCode" value="srm_expert_notice">
				    		 <input type="hidden" name="srm_expert_notice_desc" value="专家通知模板内容">
				    		 <script id="ueditor6" name="srm_expert_notice_big_value" type="text/plain" style="width:78%;height:200px;position:relative;">${sysCfgMap['srm_expert_notice']}</script>
				    		</td>
				    	</tr>
				    </tbody>		
				</table>
			</fieldset>
			
			<fieldset>
			<legend>其他配置</legend>
			<table class="xllist">		
				<thead>
					<tr>
						<th width="20%">配置项</th>
						<th width="80%">配置内容</th>
					</tr>
				</thead>		
				<tr>
					<td style="text-align: right" width="100px">机构默认地区：</td>
					<td style="text-align: left;padding-left: 5px" width="200px">
	 					<div id="provCityAreaId">
	 						<input type="hidden" name="cfgCode" value="srm_default_orgProvId">
							<select id="orgProvId" name="srm_default_orgProvId" class="province xlselect" data-value="${sysCfgMap['srm_default_orgProvId']}" data-first-title="选择省"></select>	
							<input type="hidden" name="srm_default_orgProvId_desc"  value="默认省">							
	 						<input type="hidden" name="cfgCode" value="srm_default_orgCityId">
							<select id="orgCityId" name="srm_default_orgCityId" class="city xlselect" data-value="${sysCfgMap['srm_default_orgCityId']}" data-first-title="选择市"></select>
							<input type="hidden" name="srm_default_orgCityId_desc"  value="默认市">		
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
				</table>
			</fieldset>
				<fieldset>
			    <legend>限报配置</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td>项目基本信息日期锁定</td>
				    		<td>
				    		 <input type="hidden" name="cfgCode" value="srm_projInfo_start_time">
				    		 <input type="hidden" name="srm_projInfo_start_time_desc" value="项目基本信息日期锁定开始时间">
				    		    开始时间：<input name="srm_projInfo_start_time"  type="text" value="${sysCfgMap['srm_projInfo_start_time']}" class="inputText ctime" style="width: 160px;"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				    		 <input type="hidden" name="cfgCode" value="srm_projInfo_end_time">
				    		 <input type="hidden" name="srm_projInfo_end_time_desc" value="项目基本信息日期锁定结束时间"> 
				    		    结束时间：<input name="srm_projInfo_end_time"  type="text" value="${sysCfgMap['srm_projInfo_end_time']}" class="inputText ctime" style="width: 160px;"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>合同信息日期锁定</td>
				    		<td>
				    		 <input type="hidden" name="cfgCode" value="srm_contract_start_time">
				    		 <input type="hidden" name="srm_contract_start_time_desc" value="合同信息日期锁定开始时间">
				    		    开始时间：<input name="srm_contract_start_time"  type="text" value="${sysCfgMap['srm_contract_start_time']}" class="inputText ctime" style="width: 160px;"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				    		 <input type="hidden" name="cfgCode" value="srm_contract_end_time">
				    		 <input type="hidden" name="srm_contract_end_time_desc" value="合同信息日期锁定结束时间">  
				    		    结束时间：<input name="srm_contract_end_time"  type="text" value="${sysCfgMap['srm_contract_end_time']}" class="inputText ctime" style="width: 160px;"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				    		</td>
				    	</tr>
			    		<tr>
				    		<td>项目负责人年度科研项目限报</td>
				    		<td style="text-align:left; padding-left: 20px;">
				    			<input type="hidden" name="cfgCode" value="researcher_apply_limit_ky">
				    			<input type="hidden" name="researcher_apply_limit_ky_desc" value="项目负责人年度科研项目限报">
								<select name="researcher_apply_limit_ky" class="xlselect">
									<option value="">请选择</option>
									<option value="1" <c:if test="${sysCfgMap['researcher_apply_limit_ky'] == 1}">selected="selected"</c:if> >1</option>
									<option value="2" <c:if test="${sysCfgMap['researcher_apply_limit_ky'] == 2}">selected="selected"</c:if> >2</option>
									<option value="3" <c:if test="${sysCfgMap['researcher_apply_limit_ky'] == 3}">selected="selected"</c:if> >3</option>
									<option value="4" <c:if test="${sysCfgMap['researcher_apply_limit_ky'] == 4}">selected="selected"</c:if> >4</option>
									<option value="5" <c:if test="${sysCfgMap['researcher_apply_limit_ky'] == 5}">selected="selected"</c:if> >5</option>
								</select>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>项目负责人年度重点学科限报</td>
				    		<td style="text-align:left; padding-left: 20px;">
				    			<input type="hidden" name="cfgCode" value="researcher_apply_limit_xk">
				    			<input type="hidden" name="researcher_apply_limit_xk_desc" value="项目负责人年度重点学科限报">
								<select name="researcher_apply_limit_xk" class="xlselect">
									<option value="">请选择</option>
									<option value="1" <c:if test="${sysCfgMap['researcher_apply_limit_xk'] == 1}">selected="selected"</c:if> >1</option>
									<option value="2" <c:if test="${sysCfgMap['researcher_apply_limit_xk'] == 2}">selected="selected"</c:if> >2</option>
									<option value="3" <c:if test="${sysCfgMap['researcher_apply_limit_xk'] == 3}">selected="selected"</c:if> >3</option>
									<option value="4" <c:if test="${sysCfgMap['researcher_apply_limit_xk'] == 4}">selected="selected"</c:if> >4</option>
									<option value="5" <c:if test="${sysCfgMap['researcher_apply_limit_xk'] == 5}">selected="selected"</c:if> >5</option>
								</select>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>项目负责人年度重点人才限报</td>
				    		<td style="text-align:left; padding-left: 20px;">
				    			<input type="hidden" name="cfgCode" value="researcher_apply_limit_rc">
				    			<input type="hidden" name="researcher_apply_limit_rc_desc" value="项目负责人年度重点人才限报">
								<select name="researcher_apply_limit_rc" class="xlselect">
									<option value="">请选择</option>
									<option value="1" <c:if test="${sysCfgMap['researcher_apply_limit_rc'] == 1}">selected="selected"</c:if> >1</option>
									<option value="2" <c:if test="${sysCfgMap['researcher_apply_limit_rc'] == 2}">selected="selected"</c:if> >2</option>
									<option value="3" <c:if test="${sysCfgMap['researcher_apply_limit_rc'] == 3}">selected="selected"</c:if> >3</option>
									<option value="4" <c:if test="${sysCfgMap['researcher_apply_limit_rc'] == 4}">selected="selected"</c:if> >4</option>
									<option value="5" <c:if test="${sysCfgMap['researcher_apply_limit_rc'] == 5}">selected="selected"</c:if> >5</option>
								</select>
				    		</td>
				    	</tr>
				    </tbody>		
				</table>
			</fieldset>
			
			<fieldset>
			    <legend>评审专家是否需要完善信息</legend>
			    <table class="xllist">		
				    <thead>
					    <tr>
						    <th width="20%">配置项</th>
						    <th width="80%">配置内容</th>
					    </tr>
				    </thead>
				    <tbody>
				    	<tr>
				    		<td>是否需要完善信息</td>
				    		<td>
				    		    <input type="hidden" name="cfgCode" value="srm_expert_need_finish_info">
				    			<input type="hidden" name="srm_expert_need_finish_info_desc" value="评审专家是否需要完善信息">
								<input type='radio' name='srm_expert_need_finish_info' value='Y' <c:if test='${sysCfgMap["srm_expert_need_finish_info"] eq "Y"}'>checked="checked"</c:if>/>是
								<input type='radio' name='srm_expert_need_finish_info' value='N' <c:if test='${sysCfgMap["srm_expert_need_finish_info"] eq "N"}'>checked="checked"</c:if>/>否
				    		</td>
				    	</tr>
				    </tbody>
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