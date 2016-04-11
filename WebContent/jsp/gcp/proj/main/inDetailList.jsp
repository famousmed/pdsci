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

<script type="text/javascript">
	$(document).ready(function(){
		dataCount();
		var listHeight = document.body.clientHeight - 68;
		$("#listDiv").css({
			height:listHeight,
			overflow:"auto"
		});
		<c:if test="${not empty param.type}">
		selPatientStage("${param.type}");
		</c:if>
	});
	
	function dataCount(){
		if($(".data").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
	
	function selPatientStage(patientStage){
		if(patientStage != "" && patientStage != null && $(".selOne:checked").length>0){
			$(".selOne[value != '"+patientStage+"']").attr("checked",false);
			$(".data").hide();
			$("."+patientStage).show();
			if ("${patientStageEnumIn.id}" == patientStage) {
				$(".${patientStageEnumFinish.id}").show();
				$(".${patientStageEnumOff.id}").show();
			}
		}else{
			$(".data").show();
		}
		dataCount();
	}
</script>
</head>
	<body>
	<div class="content">
			<div class="title1 clearfix">
				&#12288;<font style="font-weight: bold;">当前机构：</font>${sessionScope.currUser.orgName}
				&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumIn.id}" onclick="javascript:selPatientStage(this.value)" ${param.type eq patientStageEnumIn.id || empty param.type?"checked":""}/>入组</label>
				&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumOff.id}" onclick="javascript:selPatientStage(this.value)" ${param.type eq patientStageEnumOff.id?"checked":""}/>脱落</label>
				&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumFinish.id}" onclick="javascript:selPatientStage(this.value)" ${param.type eq patientStageEnumFinish.id?"checked":""}/>完成</label>
			</div>
			<div id="listDiv">
					<table class="xllist">
						<thead>
						<tr id="top">
							<th width="13%">受试者编号</th>
							<th width="15%">受试者姓名缩写</th>
							<th width="10%">性别</th>
							<th width="10%">年龄</th>
							<th width="25%">入组日期</th>
							<th width="15%">入组医师</th>
							<th width="10%">状态</th>
						</tr>
						</thead>
						<tbody>
							<c:forEach items="${patientList}" var="patient">
								<tr class="data ${patient.patientStageId}">
									<td width="13%">${patient.patientCode}</td>
									<td width="15%">${patient.patientNamePy}</td>
									<td width="10%">${patient.sexName}</td>
									<td width="10%">${patient.patientAge}</td>
									<td width="22%">${pdfn:transDateTime(patient.inDate)}</td>
									<td width="15%">${patient.inDoctorName}</td>
									<td width="10%">${patient.patientStageName}</td>
								</tr>
							</c:forEach>
							<tr id='dataFoot'><td align="center" colspan="8">无记录</td></tr>
						</tbody>
					</table>
				</div>
			</div>
</body>
</html>