<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<div class="ui-box-container" >
	<div class="ui-box-title">
		<div class="ui-box-title-border sl-linear">
			<table  class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="20%" />
				<col width="10%" />
				<col width="10%" />
				<tr>
					<th>序号</th>
					<th>姓名缩写</th>
					<th>受试者编号</th>
					<th>性别</th>
					<th>药物编码</th>
					<th>入组日期</th>
					<th>入组医生</th>
					<th>状态</th>
				</tr>
				<c:forEach items="${patientList}" var="patient">
					<tr>
						<td>${patient.patientSeq}</td>
						<td>${patient.patientNamePy}</td>
						<td>${patient.patientCode}</td>
						<td>${patient.sexName}</td>
						<td>
							<c:forEach items="${patientDrugPackMap[patient.patientFlow]}" var="drugPack" varStatus="first">
								${first.first?'':','}${drugPack}
							</c:forEach>
						</td>
						<td>${pdfn:transDate(patient.inDate)}</td>
						<td>${patient.inDoctorName}</td>
						<td>${patient.patientStageName}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>