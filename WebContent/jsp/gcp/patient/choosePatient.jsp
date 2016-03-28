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
		<c:if test="${empty sessionScope.gcpCurrProj}">
			selectProj();
		</c:if>
		countData();
		<c:if test="${not empty param.type}">
			selPatient("${param.type}");
		</c:if>
	});
	
	function selectProj(){
		jboxOpen("<s:url value='/gcp/researcher/userProjList'/>", "选择项目", 800, 600,false);
	}
	
	function selPatient(type){
		$(".selPatientBox[value!='"+type+"']").attr("checked",false);
		if($(".selPatientBox:checked").length>0){
			$("#data tr").hide();
			if(type == "${patientStageEnumIn.id}"){
				$("._${patientStageEnumFinish.id}").show();
				$("._${patientStageEnumOff.id}").show();
			}
			$("._"+type).show();
		}else{
			$("#data tr").show();
		}
		countData();
	}
	
	function countData(){
		if($("#data tr").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
	
	function refresh(type){
		location.href = "<s:url value='/gcp/researcher/patientList'/>?type="+type;
	}
	function record(){
		jboxOpen("<s:url value='/jsp/gcp/patient/drugRecord.jsp'/>","发药记录",700,400);
	}
	
	function addAe(patientFlow, orgFlow, patientCode, patientNamePy,backFlag){
		var url = "<s:url value='/gcp/researcher/editAe'/>?type=GCP&patientFlow=" + patientFlow + "&orgFlow=" + orgFlow +"&patientCode=" +patientCode + "&patientNamePy=" + patientNamePy;
		if(backFlag == ""){
			url = url +"&backFlag=${GlobalConstant.FLAG_N}";
		}
		window.parent.frames['mainIframe'].location.href = url;
		jboxClose();
	}
	
	function search(){
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value='/gcp/researcher/choosePatient'/>" method="get"> 
			受试者编号：<input type="text" name="patientCode" value="${param.patientCode}" />&#12288;
			受试者姓名缩写：<input type="text" name="patientNamePy" value="${param.patientNamePy}" />&#12288;
			<input type="button" value="查&#12288;询" onclick="search();" class="search"/>
			</form>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="7%">受试者编号</th>
					<th width="10%">受试者姓名缩写</th>
					<!-- <th width="10%">受试者随机号</th> -->
					<th width="10%">药物编号</th>
					<th width="10%">入组日期</th>
					<th width="10%">入组医生</th>
					<th width="10%">状态</th>
				</tr>
				</thead>
				<tbody id="data">
					<c:forEach items="${patientList}" var="patient">
						<tr class="_${patient.patientStageId}"  style="cursor: pointer;" onclick="addAe('${patient.patientFlow}','${patient.orgFlow}','${patient.patientCode}','${patient.patientNamePy}','${patientAeMap[patient.patientFlow]}')">
							<td width="7%">${patient.patientCode}</td>
							<td width="10%">${patient.patientNamePy}</td>
							<%-- <td width="10%">${''}</td> --%>
							<td width="10%">${drugPackMap[patient.patientFlow]}</td>
							<td width="10%">${pdfn:transDate(patient.inDate)}</td>
							<td width="10%">${patient.inDoctorName}</td>
							<td width="10%">${patient.patientStageName}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tr id="dataFoot"><td align="center" colspan="10">无记录</td></tr>
			</table>
			</div>
</div></div></div>
</body>
</html>