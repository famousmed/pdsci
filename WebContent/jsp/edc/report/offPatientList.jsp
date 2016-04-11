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
<script>
function selOrg(orgFlow){
	if(orgFlow == null || orgFlow == ""){
		$(".count").show();
	}else{
		$(".count").hide();
		$("."+orgFlow).show();
	}
	countData();
}

$(document).ready(function(){
	countData();
});

function countData(){
	var dataSum = $(".count").not(":hidden").length;
	$("#count").text(dataSum);
	if(dataSum==0){
		$("#dataFoot").show();
	}else{
		$("#dataFoot").hide();
	}
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
			<div style="margin-top: 5px">
				&#12288;&#12288;参与机构：
				<select  name="orgFlow" id="orgFlow" class="xlname" style="width:200px;" onchange="selOrg(this.value);">
					<option value=""></option>
					<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
						<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
					</c:forEach>
				</select>
				&#12288;&#12288;总记录数:&#12288;<font id="count"></font>
				<hr/>
			</div>
			<div class="title1 clearfix">
				<table class="xllist" >
					<tr>
					<th style="text-align: center" width="5%">中心号</th>
					<th style="text-align: center" width="15%">机构名称</th>
					<th style="text-align: center" width="10%">受试者编号</th>
					<th style="text-align: center" width="10%">受试者姓名缩写</th>
					<th style="text-align: center" width="5%">性别</th>
					<th style="text-align: center" width="10%">入组日期</th>
					<th style="text-align: center" width="30%">最后一次访视（访视日期）</th>
					<th style="text-align: center" width="20%">脱落原因</th>
				</tr>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<c:forEach items="${offCountMap[projOrg.orgFlow] }"  var="patient">
					<tr class="count ${projOrg.orgFlow }"> 
						<c:set var="vistNameKey" value="${patient.patientFlow }_VisitName"></c:set>
						<c:set var="vistDateKey" value="${patient.patientFlow }_VisitDate"></c:set>
						<td width="5%">${projOrg.centerNo }</td>
						<td width="15%">${projOrg.orgName }</td>
						<td width="10%">${patient.patientCode }</td>
						<td width="10%">${patient.patientNamePy}</td>
						<td width="5%">${patient.sexName }</td>
						<td width="10%">${pdfn:transDate(patient.inDate) }</td>
						<td width="30%">
						<c:if test="${!empty visitDateMap[vistDateKey] }">
							${visitDateMap[vistNameKey] }（${visitDateMap[vistDateKey] }）
						</c:if>
						</td>
						<td width="20%">${patient.patientStageNote }</td>
					</tr> 
					</c:forEach>
				</c:forEach>
				<tr id="dataFoot"> 
					<td align="center" colspan="8">无记录</td>
				</tr>
				</table>
		</div>
	</div>
	</div>
</body>
</html>