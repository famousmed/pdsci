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
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	$(".${param.roleFlag}").change(function(){
		var thisStatus = this.checked;
		$("[name='"+this.name+"']").attr("checked",false);
		this.checked = thisStatus;
	});
	<c:if test="${!empty rec.auditStatusId}">
		$("#saveBtn").hide();
		$(":text").attr("disabled",false).css("background","rgba(255,255,255,0)");
		$(".toggleView,.toggleView2,.toggleView3").toggle();
	</c:if>
	
	$(".Input").attr("readonly",true);
	$(".Input.${param.roleFlag}").attr("readonly",false);
	$(".ctrlInput").attr("disabled",true);
	$(".ctrlInput.${param.roleFlag}").attr("disabled",false);
	
});

function save(){
	<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
	jboxConfirm("确认保存？保存后将不可修改！",function(){
	</c:if>
		if($("#preTrainForm").validationEngine("validate")){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$("#preTrainForm").serialize(),function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
					<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
						window.parent.document.mainIframe.location.reload(true);
					</c:if>
					<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
						window.parent.document.mainIframe.$(".box.selected").click();
					</c:if>
					top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					jboxClose();
				}				
			},null,false);
		}
	<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
	},null);
	</c:if>
}

function print(userFlow){
	jboxTip("打印中,请稍等...");
	var url = "<s:url value='/res/doc/printPreTrainForm'/>?processFlow=${currRegProcess.processFlow}";
	window.location.href = url;
}
</script>
</head>
<body>	
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
					<div style="text-align: center;font-size: 16px;font-weight: bold;">${result.schDeptName}岗前培训记录表</div>
					<form id="preTrainForm">
						<input type="hidden" name="formFileName" value="${formFileName}"/>
					    <input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
						<input type="hidden" name="resultFlow" value="${param.resultFlow}"/>
						<input type="hidden" name="roleFlag" value="${param.roleFlag}"/>
						<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
						<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
					  <c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
						 <input type="hidden" name="auditStatusId" value="${recStatusEnumTeacherAuditY.id}"/>
					 </c:if>
					 	<table class="xllist"  style="margin-top: 10px; width: 100%;">
					 		<colgroup>
					 			<col width="25%"/>
					 			<col width="25%"/>
					 			<col width="25%"/>
					 			<col width="25%"/>
					 		</colgroup>
					 		<tr>
								<th>科室岗前培训内容</th>
								<th>是否参加培训</th>
								<th>是否考核合格</th>
								<th>备注</th>
							</tr>
							<tr>
								<td>科室管理制度</td>
								<td>
									<label><input name="systemTrain" <c:if test="${formDataMap['systemTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox"  value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['systemTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView"><span style="text-align: center;">是</span></label>
									</c:if>
									&#12288;&#12288;
									<label><input name="systemTrain" <c:if test="${formDataMap['systemTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['systemTrain']}">
											<label style="display: none; margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="systemTrain" value="${formDataMap['systemTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="systemAssessment" <c:if test="${formDataMap['systemAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['systemAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="systemAssessment" <c:if test="${formDataMap['systemAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['systemAssessment']}">
											<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td style="text-align: center;">
									 <input type="text"  style="width: 140px;" name="systemRemark" value="${formDataMap['systemRemark']}" class="toggleView3 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['systemRemark']}</label>
								</td>
							</tr>
					 		<tr>
								<td>工作范围</td>
								<td>
									<label><input name="workAreaTrain" <c:if test="${formDataMap['workAreaTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${ GlobalConstant.FLAG_Y eq formDataMap['workAreaTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="workAreaTrain" <c:if test="${formDataMap['workAreaTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['workAreaTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="workAreaTrain" value="${formDataMap['workAreaTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="workAreaAssessment" <c:if test="${formDataMap['workAreaAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${ GlobalConstant.FLAG_Y eq formDataMap['workAreaAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="workAreaAssessment" <c:if test="${formDataMap['workAreaAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['workAreaAssessment']}">
											<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td>
									<input type="text" name="workAreaRemark" style="width: 140px;" value="${formDataMap['workAreaRemark']}" class="toggleView3  ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['workAreaRemark']}</label>
								</td>
							</tr>
							<tr>
								<td>劳动纪律</td>
								<td>
									<label><input name="workDisciplineTrain" <c:if test="${formDataMap['workDisciplineTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['workDisciplineTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="workDisciplineTrain" <c:if test="${formDataMap['workDisciplineTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['workDisciplineTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="workDisciplineTrain" value="${formDataMap['workDisciplineTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="workDisciplineAssessment" <c:if test="${formDataMap['workDisciplineAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${ GlobalConstant.FLAG_Y eq formDataMap['workDisciplineAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="workDisciplineAssessment" <c:if test="${formDataMap['workDisciplineAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['workDisciplineAssessment']}">
											<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td>
									<input type="text" name="workDisciplineRemark" style="width: 140px;" value="${formDataMap['workDisciplineRemark']}" class="toggleView3  ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['workDisciplineRemark']}</label>
								</td>
							</tr>
							<tr>
								<td>岗位职责</td>
								<td>
									<label><input name="jobResponsibilityTrain" <c:if test="${formDataMap['jobResponsibilityTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${ GlobalConstant.FLAG_Y eq formDataMap['jobResponsibilityTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="jobResponsibilityTrain" <c:if test="${formDataMap['jobResponsibilityTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['jobResponsibilityTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="jobResponsibilityTrain" value="${formDataMap['jobResponsibilityTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="jobResponsibilityAssessment" <c:if test="${formDataMap['jobResponsibilityAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${ GlobalConstant.FLAG_Y eq formDataMap['jobResponsibilityAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="jobResponsibilityAssessment" <c:if test="${formDataMap['jobResponsibilityAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${GlobalConstant.FLAG_N eq formDataMap['jobResponsibilityAssessment']}">
											<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td>
									<input type="text" name="jobResponsibilityRemark" style="width: 140px;" value="${formDataMap['workDisciplineRemark']}" class="toggleView3  ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['jobResponsibilityRemark']}</label>
								</td>
							</tr>
							<tr>
								<td>质量改进</td>
								<td>
									<label><input name="qualityImprovementTrain" <c:if test="${formDataMap['qualityImprovementTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['qualityImprovementTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="qualityImprovementTrain" <c:if test="${formDataMap['qualityImprovementTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${GlobalConstant.FLAG_N eq formDataMap['qualityImprovementTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="qualityImprovementTrain" value="${formDataMap['qualityImprovementTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="qualityImprovementAssessment" <c:if test="${formDataMap['qualityImprovementAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['qualityImprovementAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="qualityImprovementAssessment" <c:if test="${formDataMap['qualityImprovementAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['qualityImprovementAssessment']}">
											<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td>
									<input type="text" name="qualityImprovementRemark" style="width: 140px;" value="${formDataMap['qualityImprovementRemark']}" class="toggleView3  ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['qualityImprovementRemark']}</label>
								</td>
							</tr>
							<tr>
								<td>环境设备及安全条例</td>
								<td>
									<label><input name="safeRegTrain" <c:if test="${formDataMap['safeRegTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['safeRegTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="safeRegTrain" <c:if test="${formDataMap['safeRegTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${GlobalConstant.FLAG_N  eq formDataMap['safeRegTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="safeRegTrain" value="${formDataMap['safeRegTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="safeRegAssessment" <c:if test="${formDataMap['safeRegAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${ GlobalConstant.FLAG_Y eq formDataMap['safeRegAssessment']}">
										<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="safeRegAssessment" <c:if test="${formDataMap['safeRegAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['safeRegAssessment']}">
											<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td>
									<input type="text" name="safeRegRemark" style="width: 140px;" value="${formDataMap['safeRegRemark']}" class="toggleView3  ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['safeRegRemark']}</label>
								</td>
							</tr>
							<tr>
								<td>工作流程系统培训</td>
								<td>
									<label><input name="workTrain" <c:if test="${formDataMap['workTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['workTrain']}">
											<label style="display: none;margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="workTrain" <c:if test="${formDataMap['workTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${ GlobalConstant.FLAG_N  eq formDataMap['workTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="workTrain" value="${formDataMap['workTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="workAssessment" <c:if test="${formDataMap['workAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y  eq formDataMap['workAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="workAssessment" <c:if test="${formDataMap['workAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
									<c:if test="${GlobalConstant.FLAG_N  eq formDataMap['workAssessment']}">
											<label style="display: none; margin-right: 30px;" class="toggleView2">否</label>
									</c:if>
								</td>
								<td>
									<input type="text" name="workRemark" style="width: 140px;" value="${formDataMap['workRemark']}" class="toggleView3 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['workRemark']}</label>
								</td>
							</tr>
							<tr>
								<td>操作规程系统培训</td>
								<td>
									<label><input name="operTrain" <c:if test="${formDataMap['operTrain'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['operTrain']}">
											<label style="display: none; margin-left: 30px;" class="toggleView">是</label>
									</c:if>
									&#12288;&#12288;
									<label><input name="operTrain" <c:if test="${formDataMap['operTrain'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView ${GlobalConstant.RES_ROLE_SCOPE_DOCTOR} ctrlInput"><span class="toggleView">否</span></label>
									<c:if test="${GlobalConstant.FLAG_N  eq formDataMap['operTrain']}">
											<label style="display: none;margin-right: 30px;" class="toggleView">否</label>
									</c:if>
									<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
										<input type="hidden" name="operTrain" value="${formDataMap['operTrain']}"/>
									</c:if>
								</td>
								<td>
									<label><input name="operAssessment" <c:if test="${formDataMap['operAssessment'] eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">是</span></label>
									<c:if test="${GlobalConstant.FLAG_Y eq formDataMap['operAssessment']}">
											<label style="display: none;margin-left: 30px;" class="toggleView2">是</label>
									</c:if>
									&#12288;&#12288;
									<label>
										<input name="operAssessment" <c:if test="${formDataMap['operAssessment'] eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="toggleView2 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} ctrlInput"><span class="toggleView2">否</span></label>
										<c:if test="${ GlobalConstant.FLAG_N eq formDataMap['operAssessment']}">
												<label style="display: none;margin-right: 30px;" class="toggleView2">否</label>
										</c:if>
								</td>
								<td>
									<input type="text" name="operRemark"style="width: 140px;"  value="${formDataMap['operRemark']}" class="toggleView3 ${GlobalConstant.RES_ROLE_SCOPE_TEACHER} Input"/>
									<label style="display: none;" class="toggleView3">${formDataMap['operRemark']}</label>
								</td>
							</tr>
							<tr height="140px" style="font-weight: bold;">
								<td colspan="4">综合评估：该员工已经培训考核合格，可上岗或独立工作</td>
							</tr>
							<tr height="40px" style="font-weight: bold;">
								<td colspan="2" style="text-align: left;padding-left: 10px;border-right: 0; width: 50%;" >
								<div style="margin-bottom: 4px;"> 
<!-- 									<div style="width: 160px;float: right;"> -->
								<span style="margin-left: 20px;">本人签名：
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<input type="text" class="toggleView validate[required]" name="doctorName" value="${empty formDataMap['doctorName']?sessionScope.currUser.userName:formDataMap['doctorName']}" style="width: 100px;"/>
									<label style="display: none;" class="toggleView">${formDataMap['doctorName']}</label>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<label>${formDataMap['doctorName']}</label>
									<input type="hidden" name="doctorName" value="${formDataMap['doctorName']}"/>
								</c:if>
								</span>
									<br>
								<span style="margin-left: 20px;">签名时间：
<!-- 								</div> -->
<!-- 								<div style="width: 180px;"> -->
								
								<c:if test="${ param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
									<input type="text" class="toggleView  validate[required]" name="doctorDate" value="${empty formDataMap['doctorDate']?pdfn:getCurrDate():formDataMap['doctorDate']}" style="width: 100px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
									<label style="display: none;" class="toggleView">${formDataMap['doctorDate']}</label>
								</c:if>
								<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_DOCTOR }">
									<label>${formDataMap['doctorDate']}</label>
									<input type="hidden" name="doctorDate" value="${formDataMap['doctorDate']}"/>
								</c:if>
								</span>
 								</div> 
<!-- 									</div> -->
								</td>
								<td colspan="2" style="text-align: left;width:50%; padding-right: 20px;">
								<div style="margin-bottom: 4px;"> 
<!-- 									<div style="width: 150px;float: right;"> -->
									<span style="margin-left: 20px;">带教签名：
										<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
											<input type="text"  class="toggleView2 validate[required]" name="teacherName" style="width: 100px;" value="${empty formDataMap['teacherName']?sessionScope.currUser.userName:formDataMap['teacherName']}"/>
											<label style="display: none;" class="toggleView2">${formDataMap['teacherName']}</label>
										</c:if>
										<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER }">
											<label>${formDataMap['teacherName']}</label>
											<input type="hidden" name="teacherName" value="${formDataMap['teacherName']}"/>
										</c:if></span>	
									<br>
<!-- 										</div> -->
<!-- 									<div style="width: 200px;"> -->
									<span style="margin-left: 20px;">
										签名时间：
										<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
											<input type="text" class="toggleView2 validate[required]" name="teacherDate" style="width: 100px;" value="${empty formDataMap['teacherDate']?pdfn:getCurrDate():formDataMap['teacherDate']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
											<label style="display: none;" class="toggleView2">${formDataMap['teacherDate']}</label>
										</c:if>
										<c:if test="${param.roleFlag!=GlobalConstant.RES_ROLE_SCOPE_TEACHER }">
											<label>${formDataMap['teacherDate']}</label>
											<input type="hidden" name="teacherDate" value="${formDataMap['teacherDate']}"/>
										</c:if>
									</span>
										</div>
<!-- 									</div> -->
								</td>
							</tr>
					 		</table>
					</form>
					<div style="text-align: center;margin-top: 20px;">
						<input id="printBtn" type="button" value="打&#12288;印" class="search" onclick="print();"/>
<%-- 						<c:if test="${empty formDataMap['doctorName'] && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR }"> --%>
						<c:if test="${empty formDataMap['teacherName'] && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<input id="saveBtn" type="button" value="保&#12288;存" class="search" onclick="save();"/>
						</c:if>
<!-- 							<input id="saveBtn" type="button" value="保&#12288;存" class="search" onclick="save();"/> -->
						<c:if test="${empty formDataMap['teacherName'] && param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER }">
							<input id="saveBtn" type="button" value="保&#12288;存" class="search" onclick="save();"/>
						</c:if>
						<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>	
					</div>
				</div> 	
			</div>
		</div>
</body>
</html>