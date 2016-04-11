<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.i-trend-main-div-table th{color: #333;}
</style>
<script type="text/javascript">
	function goDetail(qcFlow,projFlow){
		location.href = "<s:url value='/gcp/qc/qcDetail'/>?beforePage=main&projFlow="+projFlow+"&qcFlow="+qcFlow+"&roleScope=${GlobalConstant.ROLE_SCOPE_GO}";
	}
</script>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<colgroup>
						<col width="12%" />
						<col width="25%" />
						<col width="10%" />
						<col width="10%" />
						<col width="7%" />
						<col width="7%" />
						<col width="15%" />
						<col width="7%" />
						<col width="7%" />
					</colgroup>
        <tr>
				 		<th>质控类型</th>
				 		<th>项目名称</th>
				 		<th>检查开始日期</th>
				 		<th>检查结束日期</th>
				 		<th>检查部门</th>
				 		<th>检查人</th>
				 		<th>检查病历/CRF编码</th>
				 		<th>质控状态</th>
				 		<th>详情</th>
				 	</tr>
	   <tbody>
				 		<c:forEach items="${qcRecordList}" var="qcRecord" varStatus="seq">
				 			<tr>
				 				<td>${qcRecord.qcTypeName}</td>
				 				<td>${projMap[qcRecord.qcFlow].projShortName}</td>
					 			<td>${qcRecord.qcStartDate}</td>
					 			<td>${qcRecord.qcEndDate}</td>
					 			<td>${qcRecord.qcDepartment}</td>
					 			<td>${qcRecord.qcOperator}</td>
					 			<td>${qcRecord.qcPatientCodes}</td>
					 			<td>${qcRecord.qcStatusName}</td>
					 			<td>
						 			<c:if test="${gcpQcTypeEnumOrg.id eq qcRecord.qcTypeId}">
						 				[<a href="javascript:goDetail('${qcRecord.qcFlow}','${projMap[qcRecord.qcFlow].projFlow}');">报告</a>]
						 			</c:if>
					 			</td>
					 		</tr>
				 		</c:forEach>
				 	</tbody>
	   <c:if test="${empty qcRecordList }">
	   <tr><td colspan="9">无记录！</td></tr>
	   </c:if>
	</table>
</div>
