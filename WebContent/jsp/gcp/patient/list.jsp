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
</script>
</head>
<body>
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div>
				当前项目：<a title="点击切换项目" href="javascript:selectProj();" style="color:blue">${empty proj.projShortName?pdfn:cutString(proj.projName,10,true,3):proj.projShortName}</a> &#12288;&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumExclude.id?"checked='true'":""} value="${patientStageEnumExclude.id}" id="exclude"/><label for="exclude">${patientStageEnumExclude.name}</label>&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumIn.id?"checked='true'":""} value="${patientStageEnumIn.id}" id="in"/><label for="in">${patientStageEnumIn.name}</label>&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumFinish.id?"checked='true'":""} value="${patientStageEnumFinish.id}" id="finish"/><label for="finish">${patientStageEnumFinish.name}</label>&#12288;
				<input type="checkbox" class="selPatientBox" onclick="selPatient(this.value);" ${param.type eq patientStageEnumOff.id?"checked='true'":""} value="${patientStageEnumOff.id}" id="off"/><label for="off">${patientStageEnumOff.name}</label>&#12288;
			</div>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="7%">受试者编号</th>
					<th width="9%">姓名缩写</th>
					<th width="15%">身份证号</th>
					<th width="5%">性别</th>
					<th width="5%">年龄</th>
					<th width="8%">电话</th>
					<th width="8%">知情同意日期</th>
					<!-- <th width="6%">随机号</th> -->
					<th width="6%">药物编码</th>
					<th width="8%">入组日期</th>
					<th width="8%">入组医生</th>
					<th width="5%">状态</th>
				</tr>
				</thead>
				<tbody id="data">
				<c:forEach items="${patientList}" var="patient">
					<tr class="_${patient.patientStageId}">
						<td width="7%">${patient.patientCode}</td>
						<td width="9%">${patient.patientNamePy}</td>
						<td width="15%">${patient.idNo}</td>
						<td width="5%">${patient.sexName}</td>
						<td width="5%">${patient.patientAge}</td>
						<td width="8%">${patient.patientPhone}</td>
						<td width="8%">${patient.icfDate}</td>
						<%-- <td width="6%">${''}</td> --%>
						<td width="6%">
							<c:forEach items="${patientDrugPackMap[patient.patientFlow]}" var="drugPack" varStatus="first">
								${first.first?'':','}${drugPack}
							</c:forEach>
						</td>
						<td width="8%">${pdfn:transDate(patient.inDate)}</td>
						<td width="8%">${patient.inDoctorName}</td>
						<td width="5%">${patient.patientStageName}</td>
					</tr>
				</c:forEach>
				</tbody>
				<tr id="dataFoot"><td align="center" colspan="14">无记录</td></tr>
			</table></div>
</div></div></div>
</body>
</html>