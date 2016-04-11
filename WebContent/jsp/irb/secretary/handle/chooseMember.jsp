<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
</head>
<script type="text/javascript">
function save() {
	if(false==$("#saveForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("确定保存主审委员/独立顾问？",function(){
		var url="<s:url value='/irb/secretary/saveChooseMember'/>";
		jboxPost(url,$("#saveForm").serialize(),function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				if ('edit' == '${param.operType}') {
					doBack();
				} else {
					window.location.href="<s:url value='/irb/secretary/list'/>?irbStageId=${irbStageEnumHandle.id}";
				}
			}
		},null,true);
	},null);
}
function showDlgw(){
	$("#dlgwId").removeAttr("disabled");
	$("#dlgw_td").attr("rowspan","2");
	$("#dlgwTr").show();
}
function hideDlgw(){
	$("#dlgwId").attr("disabled","disabled");
	$("#dlgw_td").attr("rowspan","1");
	$("#dlgwTr").hide();
}

function userMain(){
	jboxOpen("<s:url value='/irb/secretary/userMain'/>","选择独立顾问",650,500);
}

function doSelect(){
	jboxClose();
	jboxEndLoading();
}

function doBack(){
	window.location.href="<s:url value='/irb/researcher/process'/>?projFlow=${curIrbApply.projFlow}&roleScope=${param.roleScope}&irbFlow=${param.irbFlow}";
}

$(document).ready(function(){
	if ($("#dlgw0").attr("checked") == "checked") {
		hideDlgw();
	}
});
</script>
<div class="title1 clearfix">
<form id="saveForm">
	<div class="content">
		<table class="xllist">
				<tr>
					<th  colspan="2" align="left">选择主审委员/独立顾问</th>
				</tr>
				<c:if test="${curIrbApply.irbTypeId==irbTypeEnumInit.id }">
					<tr>
						<td width="200px" >主审委员：方案<input type="hidden" name="authId" value="${irbAuthTypeEnumCommitteePRO.id }"></td>
						<td style="text-align: left;">&#12288;
							<c:if test="${empty committeePROList || 'edit' eq param.operType}">
								<c:forEach items="${ndUsers}" var="user" varStatus="statu"> 
									<input id="${user.userFlow}" class="validate[required]" name="userFlow_fa" type="checkbox" value="${user.userFlow}"
									<c:if test="${committeePROFlowList.indexOf(user.userFlow)>-1 }">checked</c:if> />
									<label for="${user.userFlow}">${user.userName}</label>&#12288;
								</c:forEach>
							</c:if>
							<c:if test="${committeePROList != null && 'edit' != param.operType}">
								<c:forEach items="${committeePROList}" var="irbUser" varStatus="statu">
									${irbUser.userName}
									<c:if test="${fn:length(committeePROList)>1&&!statu.last}">、</c:if>
								</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr>
						<td width="200px" >主审委员：知情同意书<input type="hidden" name="authId" value="${irbAuthTypeEnumCommitteeICF.id }"></td>
						<td style="text-align: left;">&#12288;
							<c:if test="${curIrbApply.irbStageId == irbStageEnumHandle.id || 'edit' eq param.operType}">
							<!-- 
								<select name="userFlow_zqty">
									<option value="">请选择</option>
								<c:forEach items="${ndUsers}" var="user">
									<option value="${user.userFlow}" <c:if test="${user.userFlow == committeeICF.userFlow}">selected</c:if>>${user.userName}</option>
								</c:forEach>
							</select>
							 -->
							<c:forEach items="${ndUsers}" var="user">
							<label >
									<input id="${user.userFlow}" class="validate[required]" name="userFlow_zqty" type="radio" value="${user.userFlow}"
									<c:if test="${user.userFlow == committeeICF.userFlow}">checked</c:if> />
									${user.userName}</label>&#12288;
							</c:forEach>
							
							</c:if>
							<c:if test="${curIrbApply.irbStageId != irbStageEnumHandle.id && 'edit' != param.operType}">
								<c:if test="${empty committeeICF }">无</c:if>
								<c:if test="${!empty committeeICF }">
								${committeeICF.userName }
								</c:if>
							</c:if>
						</td>
					</tr>
				</c:if>
				<c:if test="${curIrbApply.irbTypeId!=irbTypeEnumInit.id }">
					<tr>
						<td width="200px" >主审委员<input type="hidden" name="authId" value="${irbAuthTypeEnumCommittee.id }"></td>
						<td style="text-align: left;padding: 5px 0;">&#12288;
							<c:if test="${empty committeeList || 'edit' eq param.operType}">
							<!-- 
								<select name="userFlow_zswy"  multiple="multiple" style="height: 100px;width: 167px;">
									<c:forEach items="${ndUsers}" var="user" varStatus="statu">
										<option value="${user.userFlow}" <c:if test="${statu.first}">selected="selected"</c:if> >${user.userName}</option>
									</c:forEach>
								</select><span style="color: red;padding-left: 10px; vertical-align: bottom;">(按住ctrl键可多选)</span>
							 -->
								<c:forEach items="${ndUsers}" var="user" varStatus="statu"> 
									<input id="${user.userFlow}" class="validate[required]" name="userFlow_zswy" type="checkbox" value="${user.userFlow}"
									<c:if test="${committeeFlowList.indexOf(user.userFlow)>-1 }">checked</c:if> />
									<label for="${user.userFlow}">${user.userName}</label>&#12288;
								</c:forEach>
							</c:if>
							<c:if test="${committeeList != null && 'edit' != param.operType}">
								<c:forEach items="${committeeList}" var="irbUser" varStatus="statu">
								${irbUser.userName}
								<c:if test="${fn:length(committeeList)>1&&!statu.last}">、</c:if>
							</c:forEach>
							</c:if>
						</td>
					</tr>
				</c:if>
				<tr>
					<td id="dlgw_td" width="200px">独立顾问</td>
					<td style="text-align: left;">
					&nbsp;&#12288;<input type="radio" name="dlgw" <c:if test="${empty consultant}">checked</c:if> id="dlgw0" value="${GlobalConstant.RECORD_STATUS_N }"  onclick="hideDlgw();"><label for="dlgw0">无&#12288;</label><input type="radio" onclick="showDlgw();" id="dlgw1" name="dlgw" value="${GlobalConstant.RECORD_STATUS_Y }" <c:if test="${!empty consultant}">checked</c:if>><label for="dlgw1">有</label>
					<span style="display: ;" id="dlgwTr">
					<p>&nbsp;&#12288;姓&#12288;&#12288;名：<input type="hidden"  name="authId" value="${irbAuthTypeEnumConsultant.id }" >
						<c:if test="${!empty consultant}">
							<span id="consultantSpan">${consultant.userName }</span>
						</c:if>
						<c:if test="${empty consultant}">
							<span id="consultantSpan"></span>
						</c:if>
						<c:if test="${empty consultant || 'edit' eq param.operType}">
						<!-- 
							<select name="userFlow_dlgw" class="" id="dlgwId" disabled="disabled">
								<c:forEach items="${dUsers}" var="user">
									<option value="${user.userFlow}">${user.userName}</option>
								</c:forEach>
							</select>
						 -->
						 	<input type="hidden" id="dlgwId" name="userFlow_dlgw" value="${consultant.userFlow }">
							&#12288;<img title="选择独立顾问" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="userMain();" />
						</c:if>
						</p>
						<p>&nbsp;&#12288;咨询问题：<textarea rows="3" style="width: 500px" name="authNote" id="authNote">${authNote }</textarea></p>
					</span>
					</td>
				</tr>
		</table>
		<div class="button" style="width:100%">
			<input type="hidden" name="irbFlow" id="irbFlow" value="${param.irbFlow}"/>
			<input type="hidden" name="operType" value="${param.operType}"/>
			<c:if test="${curIrbApply.irbStageId == irbStageEnumHandle.id || 'edit' eq param.operType}">
				<input type="button" class="search" value="确&#12288;认" onclick="save();" />	
			</c:if>
			<c:if test="${'edit' eq param.operType}">
				<input type="button" class="search" value="返&#12288;回" onclick="doBack();" />	
			</c:if>
		</div>
	</div>
	</form>
	</div>