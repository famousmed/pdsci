<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
</head>
<style>
.edit3{text-align: left;border:none;}
</style>
<script type="text/javascript">
	function showProjOrg() {
		jboxGet("<s:url value='/irb/researcher/projOrgList?projFlow='/>" + $("#projectFlow").val()
				, null, function(resp) {
			$("#projOrgDiv").html(resp);
		}, null, false);
	}
	
	$(document).ready(function() {
		showProjOrg();
	});
	
	function saveProj(){
		if(false==$("#projForm").validationEngine("validate")){
			return ;
		}
		if("${roleFlow}"==""){
			jboxTip("请联系管理员维护主要研究者角色!");
			return;
		}
		if($("#researcherFlow").val()==""){
			jboxTip("主要研究者不能为空!");
			return;
		}
		$("#saveBtn").attr("disabled",true);
		jboxStartLoading();
		var data = $('#projForm').serialize();
		jboxPost("<s:url value='/irb/researcher/saveProj'/>", data,function(projFlow){
			$("#projectFlow").val(projFlow);
			$("#projFlow").val(projFlow);
			jboxTip('${GlobalConstant.OPRE_SUCCESSED}');
			jboxEndLoading();
			$("#saveBtn").attr("disabled",false);
		},null,false);
	}
	
	function userMain(){
		jboxOpen("<s:url value='/irb/researcher/userMain'/>?deptFlow="+$("#applyDeptFlow").val(),"选择主要研究者",650,500);
	}
	
	function editProjOrg(){
		if ($("#projectFlow").val() == '') {
			jboxTip("请先保存项目信息！");
			return;
		}
		jboxOpen("<s:url value='/irb/researcher/editProjOrg'/>","编辑临床研究单位",650,450);
	}
	function doSelect(){
		jboxClose();
		jboxEndLoading();
	}

	function changeStyle(obj,stylename){
		$(obj).removeClass(stylename);
	}

	function addStyle(obj,stylename){
		$(obj).addClass(stylename);
	}
	
	function leaderContent(obj){
		if ('${projOrgTypeEnumLeader.id}'== $(obj).val()) {
			//组长单位主要研究者
			if ($("#leaderOrgLinkMan").val() == "") {
				$("#leaderOrgLinkMan").val("${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userName:projInfoForm.proj.applyUserName }");
			}
			if ($("#leaderOrgLinkManPhone").val() == "") {
				$("#leaderOrgLinkManPhone").val("${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userPhone:projInfoForm.researcherPhone }");
			}
			if ($("#leaderOrgLinkManEmail").val() == "") {
				$("#leaderOrgLinkManEmail").val("${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userEmail:projInfoForm.researcherEmail }");
			}
			//组长单位伦理委员会联系人
			if ('${irbInfo}'!=null) {
				if ($("#leaderOrgIrbLinkMan").val() == "") {
					$("#leaderOrgIrbLinkMan").val("${irbInfo.contactUser }");
				}
				if ($("#leaderOrgIrbLinkManPhone").val() == "") {
					$("#leaderOrgIrbLinkManPhone").val("${irbInfo.contactMobile }");
				}
				if ($("#leaderOrgIrbLinkManEmail").val() == "") {
					$("#leaderOrgIrbLinkManEmail").val("${irbInfo.contactEmail }");
				}
			}
		} else if ('${projOrgTypeEnumParti.id}'== $(obj).val()) {
			//组长单位主要研究者
			if ($("#leaderOrgLinkMan").val() != "" && "${projInfoForm.leaderOrgLinkMan}" == "") {
				$("#leaderOrgLinkMan").val("");
			}
			if ($("#leaderOrgLinkManPhone").val() != "" && "${projInfoForm.leaderOrgLinkManPhone}" == "") {
				$("#leaderOrgLinkManPhone").val("");
			}
			if ($("#leaderOrgLinkManEmail").val() != "" && "${projInfoForm.leaderOrgLinkManEmail}" == "") {
				$("#leaderOrgLinkManEmail").val("");
			}
			//组长单位伦理委员会联系人
			if ($("#leaderOrgIrbLinkMan").val() != "" && "${projInfoForm.leaderOrgIrbLinkMan}" == "") {
				$("#leaderOrgIrbLinkMan").val("");
			}
			if ($("#leaderOrgIrbLinkManPhone").val() != "" && "${projInfoForm.leaderOrgIrbLinkManPhone}" == "") {
				$("#leaderOrgIrbLinkManPhone").val("");
			}
			if ($("#leaderOrgIrbLinkManEmail").val() != "" && "${projInfoForm.leaderOrgIrbLinkManEmail}" == "") {
				$("#leaderOrgIrbLinkManEmail").val("");
			}
		}
	}
	
</script>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="projForm" style="position: relative;"> 
				<input type="hidden" id="projectFlow" name="projFlow" value="${projInfoForm.proj.projFlow }">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;项目信息</th>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">项目名称：</td>
						<td colspan="5"><input type="text" class="validate[required]" name="projName" style="width: 54%" value="${projInfoForm.proj.projName }"/>
						<font color="red" >*</font>
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">项目简称：</td>
						<td width="20%">
							<input type="text" class="validate[required]" name="projShortName" value='${projInfoForm.proj.projShortName }' style="width: 153px"/>
							<font color="red">*</font>
						</td>
						<td width="13%" style="text-align: right;">期类别：</td>
						<td width="20%">
							<select id="projSubTypeId" name="projSubTypeId" class="validate[required]" style="width: 156px">
								<option value="">请选择</option>
								<c:forEach items="${gcpProjSubTypeEnumList}" var="projSubType"> 
								<option value="${projSubType.id }" <c:if test="${projInfoForm.proj.projSubTypeId == projSubType.id }">selected</c:if>>${projSubType.name }</option>
								</c:forEach>
							</select>
							<font color="red">*</font>
						</td>
						<td width="13%" style="text-align: right;">项目编号：</td>
						<td width="20%"><input type="text"   name="projNo" value='${projInfoForm.proj.projNo }' style="width: 153px"/></td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">项目类别：</td>
						<td width="20%">
							<select  name="projTypeId" style="width: 156px">
		          		  		<option value="">请选择</option>
		                       	<c:forEach var="dictEnuProjType" items="${dictTypeEnumGcpProjTypeList}">
		                       		<option value="${dictEnuProjType.dictId}" <c:if test='${projInfoForm.proj.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}
		                       		</option>
		                       	</c:forEach>
	          		  		</select> 
						</td>
						<td width="13%" style="text-align: right;">注册分类：</td>
						<td width="20%">
							<input type="text"  name="registCategory" value="${projInfoForm.registCategory }" style="width: 153px"/>
						</td>
						<td width="13%" style="text-align: right;">CFDA批件号：</td>
						<td width="20%"><input type="text"  name="cfdaNo" value="${projInfoForm.proj.cfdaNo }" style="width: 153px"/></td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">组长/参加：</td>
						<td width="20%">
							<select  name="isLeader" onchange="leaderContent(this);" style="width: 156px">
								<option value="">请选择</option>
								<option value="${projOrgTypeEnumLeader.id}" <c:if test="${projInfoForm.isLeader eq projOrgTypeEnumLeader.id}">selected="selected"</c:if>>${projOrgTypeEnumLeader.name }</option>
		          		  		<option value="${projOrgTypeEnumParti.id}" <c:if test="${projInfoForm.isLeader eq projOrgTypeEnumParti.id}">selected="selected"</c:if>>${projOrgTypeEnumParti.name }</option>
	          		  		</select>
						</td>
						<td width="13%" style="text-align: right;">国际多中心：</td>
						<td width="20%">
							<select name="interMulCenter" style="width: 156px">
		          		  		<option value="">请选择</option>
		          		  		<option value="1" <c:if test='${projInfoForm.interMulCenter==1}'>selected="selected"</c:if>>是</option>
		          		  		<option value="2" <c:if test='${projInfoForm.interMulCenter==2}'>selected="selected"</c:if>>否</option>
	          		  		</select>
						</td>
						<td width="13%" style="text-align: right;"></td>
						<td width="20%">
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">预期时间：</td>
						<td colspan="5">
							<input type="text"  name="projStartTime" value="${projInfoForm.proj.projStartTime }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 153px"/>
							~&#12288;<input type="text"  name="projEndTime" value="${projInfoForm.proj.projEndTime }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 153px"/>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;申办者</th>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">项目来源全称：</td>
						<td colspan="5"><input type="text" class="validate[required]" name="projDeclarer" style="width: 54%" value="${projInfoForm.proj.projDeclarer }"/>
						<font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">项目来源简称：</td>
						<td width="20%"><input type="text"  class="validate[required]" name="projShortDeclarer" value='${projInfoForm.proj.projShortDeclarer }' style="width: 153px"/>
						<font color="red">*</font></td>
						<td width="13%" style="text-align: right;">地址：</td>
						<td width="20%"><input type="text"   name="declarerAddress" value='${projInfoForm.declarerAddress }' style="width: 153px"/></td>
						<td width="13%" style="text-align: right;">邮编：</td>
						<td width="20%">
							<input type="text"   name="declarerZip" value='${projInfoForm.declarerZip }' style="width: 153px"/>
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">（项目来源）联系人：</td>
						<td width="20%">
							<input type="text"   name="dLinkMan" value='${projInfoForm.dLinkMan }' style="width: 153px"/>
						</td>
						<td width="13%" style="text-align: right;">手机：</td>
						<td width="20%">
							<input type="text"   name="dLinkManPhone" value='${projInfoForm.dLinkManPhone }' style="width: 153px"/>
						</td>
						<td width="13%" style="text-align: right;">邮件：</td>
						<td width="20%">
							<input type="text"   name="dLinkManEmail" value='${projInfoForm.dLinkManEmail }' style="width: 153px"/>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;CRO</th>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">CRO：</td>
						<td colspan="5"><input type="text"  name="CROName" style="width: 54%" value="${projInfoForm.CROName }"/>
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">法人代表：</td>
						<td width="20%"><input type="text"   name="CROLegalRepresent" value='${projInfoForm.CROLegalRepresent }' style="width: 153px"/></td>
						<td width="13%" style="text-align: right;">地址：</td>
						<td width="20%"><input type="text"   name="CROAddress" value='${projInfoForm.CROAddress }' style="width: 153px"/></td>
						<td width="13%" style="text-align: right;">邮编：</td>
						<td width="20%">
							<input type="text"   name="CROZip" value='${projInfoForm.CROZip }' style="width: 153px"/>
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">（CRO）联系人：</td>
						<td width="20%">
							<input type="text"   name="CROLinkMan" value='${projInfoForm.CROLinkMan }' style="width: 153px"/>
						</td>
						<td width="13%" style="text-align: right;">手机：</td>
						<td width="20%">
							<input type="text"   name="CROLinkManPhone" value='${projInfoForm.CROLinkManPhone }' style="width: 153px"/>
						</td>
						<td width="13%" style="text-align: right;">邮件：</td>
						<td width="20%">
							<input type="text"   name="CROLinkManEmail" value='${projInfoForm.CROLinkManEmail }' style="width: 153px"/>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;研究者信息</th>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">承担科室：</td> 
						<td width="20%">
						<c:choose>
							<c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
								<select id="applyDeptFlow" name="applyDeptFlow" class="validate[required]" style="width: 156px">
									<option></option>
									<c:forEach items="${deptList }" var="dept">
									<option value="${dept.deptFlow }" <c:if test="${projInfoForm.proj.applyDeptFlow == dept.deptFlow }">selected</c:if>>${dept.deptName }</option>
									</c:forEach>
								</select>
							</c:when>
							<c:when test="${param.roleScope ==  GlobalConstant.PROJ_STATUS_SCOPE_LOCAL }">
								${sessionScope.currUser.deptName }
								<input type="hidden" id="applyDeptFlow" name="applyDeptFlow" value="${sessionScope.currUser.deptFlow }"/>
								<input type="hidden" name="applyDeptName" value="${sessionScope.currUser.deptName }"/>
							</c:when>
							<c:otherwise>
								${projInfoForm.proj.applyDeptName }
							</c:otherwise>
						</c:choose>
						<font color="red">*</font>
						</td>
						<td width="13%" style="text-align: right;">科主任：</td>
						<td colspan="3">
							<input type="text"  name="director" value="${projInfoForm.director }" style="width: 153px"/>
						</td>
					</tr>
					<tr>
						<td width="13%" style="text-align: right;">主要研究者：</td>
						<td width="20%">
							<span id="researcherTd">
								<c:choose>
									<c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_LOCAL }">
										${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userName:projInfoForm.proj.applyUserName }
										<c:set var="researcherFlow" value="${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userFlow:projInfoForm.proj.applyUserFlow }"/>
									</c:when>
									<c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL }">
										${projInfoForm.proj.applyUserName}
										<c:set var="researcherFlow" value="${projInfoForm.proj.applyUserFlow }"/>
									</c:when>
									<c:otherwise>
										${projInfoForm.proj.applyUserName}
										<c:set var="researcherFlow" value="${projInfoForm.proj.applyUserFlow }"/>
									</c:otherwise>
								</c:choose>
							</span>
							&#12288;
							<c:if test="${param.type != 'show' && param.roleScope ==  GlobalConstant.USER_LIST_GLOBAL}">
								<img title="选择主要研究者" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="userMain();" />
							</c:if>
							<input type="hidden" id="researcherFlow" name="researcherFlow" value="${researcherFlow }">
						</td>
						<td width="13%" style="text-align: right;">手机：</td>
						<td width="20%" id="researcherPhoneTd">
								<c:choose>
									<c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_LOCAL }">
										${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userPhone:projInfoForm.researcherPhone }
									</c:when>
									<c:otherwise>
										${projInfoForm.researcherPhone}
									</c:otherwise>
								</c:choose>
						</td>
						<td width="13%" style="text-align: right;">邮件：</td>
						<td width="20%" id="researcherEmailTd">
								<c:choose>
									<c:when test="${param.roleScope ==  GlobalConstant.USER_LIST_LOCAL }">
										${empty projInfoForm.proj.applyUserFlow?sessionScope.currUser.userEmail:projInfoForm.researcherEmail }
									</c:when>
									<c:otherwise>
										${projInfoForm.researcherEmail}
									</c:otherwise>
								</c:choose>
						</td>
					</tr>
					<tr>
						<th colspan="6" style="text-align: left;">&#12288;临床研究单位
						<c:if test="${param.type != 'show' && projInfoForm.proj.projStatusId != gcpProjStatusEnumPassed.id}">
						&#12288;<input type="button" title="编辑临床研究单位"style="cursor: pointer;" value="&nbsp;临床研究单位&nbsp;" onclick="editProjOrg();" />
						</c:if>
						</th>
					</tr>
					<tr>
						<td colspan="6" style="padding-left: 0;">
						<div id="projOrgDiv">
						</div>
						</td>
					</tr>
					<tr>
						<td style="border: 0;text-align:right;" colspan="6">
						组长单位主要研究者：<input type="text" class="edit3" id="leaderOrgLinkMan" name="leaderOrgLinkMan" style="width: 80px;" onfocus="changeStyle(this,'edit3');" onblur="addStyle(this,'edit3');" value="${projInfoForm.leaderOrgLinkMan }">&#12288;
						联系电话：<input type="text" class="edit3" id="leaderOrgLinkManPhone" name="leaderOrgLinkManPhone" style="width: 120px;" onfocus="changeStyle(this,'edit3');" onblur="addStyle(this,'edit3');" value="${projInfoForm.leaderOrgLinkManPhone }">&#12288;
						邮件：<input type="text" class="edit3" id="leaderOrgLinkManEmail" name="leaderOrgLinkManEmail" style="width: 200px;" onfocus="changeStyle(this,'edit3');" onblur="addStyle(this,'edit3');" value="${projInfoForm.leaderOrgLinkManEmail }">&#12288;
						</td>
					</tr>
					<tr>
						<td style="border: 0;text-align:right;" colspan="6">
						组长单位伦理委员会联系人：<input type="text" class="edit3" id="leaderOrgIrbLinkMan" name="leaderOrgIrbLinkMan" style="width: 80px;" onfocus="changeStyle(this,'edit3');" onblur="addStyle(this,'edit3');" value="${projInfoForm.leaderOrgIrbLinkMan }">&#12288;
						联系电话：<input type="text" class="edit3" id="leaderOrgIrbLinkManPhone" name="leaderOrgIrbLinkManPhone" style="width: 120px;" onfocus="changeStyle(this,'edit3');" onblur="addStyle(this,'edit3');" value="${projInfoForm.leaderOrgIrbLinkManPhone }">&#12288;
						邮件：<input type="text" class="edit3" id="leaderOrgIrbLinkManEmail" name="leaderOrgIrbLinkManEmail" style="width: 200px;" onfocus="changeStyle(this,'edit3');" onblur="addStyle(this,'edit3');" value="${projInfoForm.leaderOrgIrbLinkManEmail }">&#12288;
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<c:if test="${(empty sessionScope.currIrb || sessionScope.currIrb.irbStageId==irbStageEnumApply.id || 'edit' eq param.operType) && projInfoForm.proj.projStatusId != gcpProjStatusEnumPassed.id}" >
				<input class="search" type="button" value="保&#12288;存" id="saveBtn" onclick="saveProj();" />
			</c:if>
		</div>
</div></div></div>
</body>
</html>