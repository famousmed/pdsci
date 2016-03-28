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
<script type="text/javascript">
	function searchPatient(orgFlow) {
		jboxGet("<s:url value='/edc/proj/inDetailList'/>?orgFlow="+orgFlow, null, function(resp) {
			$("#listDiv").html(resp);
		}, null, false);
	}
	
	$(document).ready(function() {
			searchPatient('');
	});
	
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
				&#12288;参与机构：
			<select id="orgFlow" name="orgFlow" class="xlname" style="width: 200px;" onchange="searchPatient(this.value)">
				<option value=""></option>
					<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}">
						${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}
					</option>
					</c:forEach>
			</select>
			&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumFilter.id}" onclick="javascript:selPatientStage(this.value)"/>筛选</label>
			&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumIn.id}" onclick="javascript:selPatientStage(this.value)"/>入组</label>
			&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumOff.id}" onclick="javascript:selPatientStage(this.value)"/>脱落</label>
			&#12288;<label><input class="selOne" type="checkbox" value="${patientStageEnumFinish.id}" onclick="javascript:selPatientStage(this.value)"/>完成</label>
			</div>
			<hr />
			<div id="listDiv"></div>
		</div>
</body>
</html>