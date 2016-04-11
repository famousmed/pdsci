<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.i-trend-main-div-table th{color: #333;}
</style>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<c:if test="${!empty patientList }">
		<col width="15%" />
        <col width="35%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <col width="10%" />
        <tr>
	     <th>入组日期</th>
	     <th>项目名称</th>
	     <th>姓名缩写</th>
	     <th>受试者编号</th>
	     <th>性别</th>
	     <th>药物编码</th>
	     <th>状态</th>
	   </tr>
	   <c:forEach items="${patientList}" var="patient" varStatus="status">
		<tr <c:if test="${status.count%2==0}"> class="odd" </c:if> >
			<td>${pdfn:transDateForPattern(patient.inDate,"yyyy-MM-dd")}</td>
			<td>${projMap[patient.patientFlow].projShortName}</td>
			<td>${patient.patientNamePy}</td>
			<td>${patient.patientCode}</td>
			<td>${patient.sexName}</td>
			<td>
				<c:forEach items="${patientDrugPackMap[patient.patientFlow]}" var="drugPack" varStatus="first">
					${first.first?'':','}${drugPack}
				</c:forEach>
			</td>
			<td>${patient.patientStageName}</td>
		</tr>
	   </c:forEach>
	   </c:if>
	   <c:if test="${empty patientList }">
	   <tr><td colspan="8">无记录！</td></tr>
	   </c:if>
	</table>
</div>
