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
</jsp:include>
<style type="text/css">
table.basic b {text-decoration: none;cursor: text;}
</style>

<script type="text/javascript">
	function auditRec(recFlow){//,processFlow,rotationFlow
		var width=(window.screen.width)*0.6;
		var height = 500;
		var url = "<s:url value='/res/teacher/showAudit'/>";
		if(${param.recTypeId eq resRecTypeEnumAfterEvaluation.id || param.recTypeId eq resRecTypeEnumAfterSummary.id}){
			url = "<s:url value='/res/rec/showRegistryForm'/>";
			width = 1000;
		}
		url+=("?recFlow="+recFlow+"&recTypeId=${param.recTypeId}&roleFlag=${param.roleFlag}&processFlow=${param.processFlow}&operUserFlow=${param.doctorFlow}&schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}");
		jboxLoad("auditContent",url,true);
	}
	
	function loadAppeal(appealFlow){
		var url = "<s:url value='/res/rec/editAppeal'/>?appealFlow="+appealFlow+"&recTypeId=${param.recTypeId}&doctorFlow=${param.doctorFlow}&schDeptFlow=${param.schDeptFlow}&roleFlag=${param.roleFlag}";
		jboxLoad("auditContent",url,true);
	}
	
	function recReLoad(){
		//window.parent.frames["mainIframe"].window.$(".selectTag a").click();
		window.parent.frames["mainIframe"].search();
		location.reload(true);
	}
	
	function selTr(tr){
		$("#recContent tr,#appealContent tr").css("background-color","");
		$(tr).css("background-color","pink");
	}
	
	$(function(){
		if($("#recContent tr").length>0){
			$("#recContent tr:eq(0)").click();
		}else{
			$("#appealContent tr:eq(0)").click();
		}
		setData(window.parent.frames['mainIframe'].countData);
		if(!$(".needAudit").length){
			$("#oneKeyAudit").hide();
		}
	});
	
	function setData(data){
		$("#finish").text(data["${doctor.doctorFlow}${param.schDeptFlow}${param.recTypeId}finish"]);
		$("#req").text(data["${doctor.doctorFlow}${param.schDeptFlow}${param.recTypeId}req"]);
		$("#appeal").text(data["${doctor.doctorFlow}${param.schDeptFlow}${param.recTypeId}appeal"]);
	}

	function oneKeyAudit(){
		var title = "确认一键审核通过";
		if($("#appealDiv").length){
			title+="(包括申述)";
		}
		title+="？";
		jboxConfirm(title,function(){
			jboxPost("<s:url value='/res/teacher/oneKeyAudit'/>",{
				recTypeId:"${param.recTypeId}",
				operUserFlow:"${param.doctorFlow}",
				schDeptFlow:"${param.schDeptFlow}"
			},function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					location.reload(true);
				}
			},null,false);
		},null);
	}
	
	//重新载入
	function reloadRecType(typeId){
		var url="<s:url value='/res/teacher/recAuditList' />?recTypeId="+typeId+"&roleFlag=${param.roleFlag}&doctorFlow=${doctor.doctorFlow}&schDeptFlow=${param.schDeptFlow}&processFlow=${param.processFlow}&rotationFlow=${param.rotationFlow}";
		location.href = url;
	}
	
	function closeFunc(){
		top.document.mainIframe.location.reload();
		jboxClose();
// 		jboxMessagerClose();
	}
</script>
</head>
<body>
<div class="mainright" style="overflow: hidden;">
	<div class="content">
		<div class="title1 clearfix">
			<table class="basic" width="100%">
				<tr>
					<td>
						住院医师：<b>${doctor.doctorName}</b>
						&#12288;
						轮转科室：<b>${process.schDeptName}</b>
						&#12288;
						类别：
						<select onchange="reloadRecType(this.value);">
							<c:forEach items="${registryTypeEnumList}" var="registryType">
								<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
								<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
									<option <c:if test="${param.recTypeId eq registryType.id}">selected</c:if> value="${registryType.id}">${registryType.name}</option>
								</c:if>
							</c:forEach>
						</select>
						&#12288;
						完成数：<b id="finish">0</b>
						<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getRegistryTypeEnumById(param.recTypeId).haveReq}">
							<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getRegistryTypeEnumById(param.recTypeId).haveAppeal}">
								&#12288;
								申述数：<b id="appeal">0</b>
							</c:if>
							&#12288;
							要求数：<b id="req">0</b>
						</c:if>
						&#12288;
						<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap['res_doc_key_audit']}">
							<input id="oneKeyAudit" type="button" class="search" value="一键审核" onclick="oneKeyAudit();" style="float: right;margin-top: 4px;margin-right: 10px;">
						</c:if>
					</td>
				</tr>
			</table>
		</div>
		<table class="basic" style="width: 100%;">
			<tr>
				<td style="padding-top: 10px;">
				<div style="width: 30%;float: left;">
					<div id="recDiv" style="max-height: 250px;overflow: auto;">
						<table class="xllist" style="width: 245px;">
							<thead>
								<tr>
								    <th width="60%">填写时间</th>
								    <th>审核情况</th>
								</tr>
							</thead>
							<tbody id="recContent">
								<c:forEach items="${recList}" var="rec">
									<tr style="cursor: pointer;" onclick="selTr(this);auditRec('${rec.recFlow}');">
										<td>${pdfn:transDateTime(rec.operTime)}</td>
										<td class="${empty rec.auditStatusId?'needAudit':''}">
											<c:if test="${empty rec.auditStatusId}">
												待审核
											</c:if>
											<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
												审核通过
											</c:if>
											<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditN.id}">
												审核不通过
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<c:if test="${empty recList}">
								<tr><td colspan="6">无记录</td></tr>
							</c:if>
						</table>
					</div>
					<c:if test="${param.recTypeId eq resRecTypeEnumDiseaseRegistry.id || param.recTypeId eq resRecTypeEnumOperationRegistry.id || param.recTypeId eq resRecTypeEnumSkillRegistry.id}">
						<div id="appealDiv" style="max-height: 250px;overflow: auto;margin-top: 10px;">
							<table class="xllist" style="width: 245px;">
								<tr>
									<th width="60%">申述对象(申述数)</th>
									<th>审核情况</th>
								</tr>
								<tbody id="appealContent"><!-- String recTypeId,String appealFlow,String schDeptFlow,String doctorFlow -->
									<c:forEach items="${appealList}" var="appeal">
										<tr style="cursor: pointer;" onclick="selTr(this);loadAppeal('${appeal.appealFlow}');">
											<td>${appeal.itemName}(${appeal.appealNum})</td>
											<td class="${empty appeal.auditStatusId?'needAudit':''}">
												<c:if test="${empty appeal.auditStatusId}">
													待审核
												</c:if>
												<c:if test="${appeal.auditStatusId eq recStatusEnumTeacherAuditY.id}">
													审核通过
												</c:if>
												<c:if test="${appeal.auditStatusId eq recStatusEnumTeacherAuditN.id}">
													审核不通过
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<c:if test="${empty appealList}">
									<tr><td colspan="2">无记录</td></tr>
								</c:if>
							</table>
						</div>
					</c:if>
				</div>
				<div id="auditContent" style="float: right;width: 68%;height: 400px;overflow: auto;">
					
				</div>
				</td>
			</tr>
		</table>
		<div style="margin-top: 10px;width: 100%;float: left;text-align: center;">
			<input type="button" class="search" value="关&#12288;闭" onclick="closeFunc();"/>
		</div>
	</div>
</div>
</body>
</html>