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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
		$(".teacherCheck").attr("disabled",true);
		$(".docCheck").change(function(){
			var selStatus = this.checked;
			$(".docCheck[name='"+this.name+"']").attr("checked",false);
			this.checked = selStatus;
		});
	</c:if>
	
	<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER}">
		$(".docCheck").attr("disabled",true);
		$(".teacherCheck").change(function(){
			var selStatus = this.checked;
			$(".teacherCheck[name='"+this.name+"']").attr("checked",false);
			this.checked = selStatus;
		});
	</c:if>
	
	<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
		$("#saveBtn").hide();
		$(".teacherCheck,.docCheck").attr("disabled",true);
		$(":text").attr("disabled",false).css("background","rgba(255,255,255,0)");
	</c:if>
});

function save(){
	jboxConfirm("确认保存？保存后将不可修改！",function(){
		jboxPost("<s:url value='/res/rec/savePreTrainForm'/>",$("#preTrainForm").serialize(),function(resp){
			if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
				top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
				jboxClose();
			}
		},null,false);
	},null);
}

function print(userFlow){
	jboxTip("打印中,请稍等...");
	var url = "<s:url value='/res/doc/printPreTrainForm'/>?resultFlow=${param.resultFlow}";
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
						<input type="hidden" name="resultFlow" value="${param.resultFlow}"/>
						<input type="hidden" name="roleFlag" value="${roleFlag}"/>
						<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
					 	<table class="xllist"  style="margin-top: 10px;">
					 		<colgroup>
					 			<col width="30%"/>
					 			<col width="25%"/>
					 			<col width="25%"/>
					 			<col width="20%"/>
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
									<label><input name="deptManager" <c:if test="${dataMap.doctor.deptManager eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="deptManager" <c:if test="${dataMap.doctor.deptManager eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="deptManager" <c:if test="${dataMap.teacher.deptManager eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="deptManager" <c:if test="${dataMap.teacher.deptManager eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
					 		<tr>
								<td>工作范围</td>
								<td>
									<label><input name="workArea" <c:if test="${dataMap.doctor.workArea eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="workArea" <c:if test="${dataMap.doctor.workArea eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="workArea" <c:if test="${dataMap.teacher.workArea eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="workArea" <c:if test="${dataMap.teacher.workArea eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>劳动纪律</td>
								<td>
									<label><input name="workDiscipline" <c:if test="${dataMap.doctor.workDiscipline eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="workDiscipline" <c:if test="${dataMap.doctor.workDiscipline eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="workDiscipline" <c:if test="${dataMap.teacher.workDiscipline eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="workDiscipline" <c:if test="${dataMap.teacher.workDiscipline eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>岗位职责</td>
								<td>
									<label><input name="jobResponsibility" <c:if test="${dataMap.doctor.jobResponsibility eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="jobResponsibility" <c:if test="${dataMap.doctor.jobResponsibility eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="jobResponsibility" <c:if test="${dataMap.teacher.jobResponsibility eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="jobResponsibility" <c:if test="${dataMap.teacher.jobResponsibility eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>质量改进</td>
								<td>
									<label><input name="qualityImprovement" <c:if test="${dataMap.doctor.qualityImprovement eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="qualityImprovement" <c:if test="${dataMap.doctor.qualityImprovement eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="qualityImprovement" <c:if test="${dataMap.teacher.qualityImprovement eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="qualityImprovement" <c:if test="${dataMap.teacher.qualityImprovement eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>环境设备及安全条例</td>
								<td>
									<label><input name="safeReg" <c:if test="${dataMap.doctor.safeReg eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="safeReg" <c:if test="${dataMap.doctor.safeReg eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="safeReg" <c:if test="${dataMap.teacher.safeReg eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="safeReg" <c:if test="${dataMap.teacher.safeReg eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>工作流程系统培训</td>
								<td>
									<label><input name="workTrain" <c:if test="${dataMap.doctor.workTrain eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="workTrain" <c:if test="${dataMap.doctor.workTrain eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="workTrain" <c:if test="${dataMap.teacher.workTrain eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="workTrain" <c:if test="${dataMap.teacher.workTrain eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>操作规程系统培训</td>
								<td>
									<label><input name="operTrain" <c:if test="${dataMap.doctor.operTrain eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="docCheck">是</label>
									&#12288;&#12288;
									<label><input name="operTrain" <c:if test="${dataMap.doctor.operTrain eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="docCheck">否</label>
								</td>
								<td>
									<label><input name="operTrain" <c:if test="${dataMap.teacher.operTrain eq GlobalConstant.FLAG_Y}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_Y}" class="teacherCheck">是</label>
									&#12288;&#12288;
									<label><input name="operTrain" <c:if test="${dataMap.teacher.operTrain eq GlobalConstant.FLAG_N}">checked</c:if> type="checkbox" value="${GlobalConstant.FLAG_N}" class="teacherCheck">否</label>
								</td>
								<td></td>
							</tr>
							<tr height="140px" style="font-weight: bold;">
								<td colspan="4">综合评估：该员工已经培训考核合格，可上岗或独立工作</td>
							</tr>
							<tr height="40px" style="font-weight: bold;">
								<td colspan="2" style="text-align: left;padding-left: 10px;border-right: 0;">
									本人签名/日期：
									<font style="font-weight: normal;"><c:out value="${dataMap.doctor.doctorName}" default="${currUser.userName}"/></font>
									<input class="docCheck" type="hidden" name="doctorName" value="${currUser.userName}"/>
									<input class="docCheck inputText" type="text" name="operDate" value="${empty dataMap.doctor.operDate?(pdfn:getCurrDate()):dataMap.doctor.operDate}" readonly="readonly" 
									<c:if test="${!(rec.auditStatusId eq recStatusEnumTeacherAuditY.id)}">
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
									</c:if>
									style="width: 100px;"
									/>
								</td>
								<td colspan="2" style="text-align: left;padding-right: 20px;">
									带教签名/日期：
									<c:if test="${roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TEACHER || rec.auditStatusId eq recStatusEnumTeacherAuditY.id}">
										<font style="font-weight: normal;"><c:out value="${dataMap.teacher.doctorName}" default="${currUser.userName}"/></font>
										<input class="teacherCheck" type="hidden" name="teacherName" value="${currUser.userName}"/>
										<input class="teacherCheck inputText" type="text" name="operDate" value="${empty dataMap.teacher.operDate?(pdfn:getCurrDate()):dataMap.teacher.operDate}" readonly="readonly" 
										<c:if test="${!(rec.auditStatusId eq recStatusEnumTeacherAuditY.id)}">
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"
										</c:if>
										style="width: 100px;"
										/>
									</c:if>
								</td>
							</tr>
					 		</table>
					</form>
					<div style="text-align: center;margin-top: 20px;">
						<input id="printBtn" type="button" value="打&#12288;印" class="search" onclick="print();"/>
						<input id="saveBtn" type="button" value="保&#12288;存" class="search" onclick="save();"/>
						<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
					</div>
				</div> 	
			</div>
		</div>
</body>
</html>