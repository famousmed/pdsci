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
		selPatientStage($(".selOne:checked").val());
		var listWidth = document.body.clientWidth - 30;
		var listHeight = document.body.clientHeight - 68;
		$("#listDiv").css({
			width:listWidth,
			height:listHeight,
			overflow:"auto"
		});
	});
	
	function dataCount(){
		if($(".data").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
</script>
</head>
	<body>
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="15%">序号</th>
					<th width="15%">受试者编号</th>
					<th width="20%">受试者姓名缩写</th>
					<th width="30%">入组日期</th>
					<th width="20%">状态</th>
				</tr>
				</thead>
				<tbody>
					<c:forEach items="${patientList}" var="patient">
						<tr class="data ${patient.patientStageId}">
							<td>${patient.patientSeq}</td>
							<td>${patient.patientCode}</td>
							<td>${patient.patientNamePy}</td>
							<td>${pdfn:transDateTime(patient.inDate)}</td>
							<td>${patient.patientStageName}</td>
						</tr>
					</c:forEach>
					<tr id='dataFoot'><td align="center" colspan="5">无记录</td></tr>
				</tbody>
			</table>
</body>
</html>