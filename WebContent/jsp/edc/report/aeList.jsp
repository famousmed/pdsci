<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
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
	
	function detail(moduleCode,visitFlow,recordFlow,seq){
		var mainIframe = window.parent.frames["mainIframe"];
		var width = mainIframe.document.body.scrollWidth;
		jboxOpen("<s:url value='/edc/report/reportInfoMain?moduleCode='/>"+moduleCode+"&visitFlow="+visitFlow+"&recordFlow="+recordFlow+"&seq="+seq, "不良事件信息",width,450);
	}
</script>
</head>
	<body>
		<div id="tableDiv">
		<table id="patientFixedTable" class="xllist FixedTables">
			<thead>
			<tr id="top">
				<th width="6%">中心号</th>
				<th width="20%">机构名称</th>
				<th width="10%">受试者编号</th>
				<th width="10%">姓名缩写</th>
				<th width="5%">性别</th>
				<th width="5%">年龄</th>
				<th width="10%">入组时间</th>
				<th width="10%">序号</th>
				<th width="10%">操作</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${pubProjOrgList}" var="projOrg">
					<c:forEach items="${patientListMap[projOrg.orgFlow]}" var="patient"><tr id='foot'>
						<c:forEach items="${patientVisitListMap[patient.patientFlow]}" var="patientVisit">
							<c:set value="${patientVisit.patientFlow}${patientVisit.visitFlow}" var="seqKey"></c:set>
							<c:forEach items="${visitDataEventSeqFormMap[seqKey]}" var="seq">
								<tr class="count ${projOrg.orgFlow}">
									<td>${projOrg.centerNo}</td>
									<td>${projOrg.orgName}</td>
									<td>${patient.patientCode}</td>
									<td>${patient.patientNamePy}</td>
									<td>${patient.sexName}</td>
									<td>${patient.patientAge}</td>
									<td>${pdfn:transDate(patient.inDate)}</td>
									<td>${seq.elementSerialSeq}</td>
									<td>[<a href="javascript:detail('${module.moduleCode}','${patientVisit.visitFlow}','${patientVisit.recordFlow}','${seq.elementSerialSeq}')">详情</a>]</td>
								</tr>
							</c:forEach>
						</c:forEach>
					</c:forEach>
				</c:forEach>
				<tr id='dataFoot'><td align="center" colspan="9">无记录</td></tr>
			</tbody>
		</table>
	</div>
</body>
</html>