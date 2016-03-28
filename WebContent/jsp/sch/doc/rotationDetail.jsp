<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<table class="basic" width="100%" style="margin-bottom: 10px;margin-top: 10px;">
			<tr>
				<td>
					医师：${doctor.doctorName}
					&#12288;
					轮转方案：${doctor.rotationName}
				</td>
			</tr>
		</table>
		<table class="basic list" width="100%">
			<tr>
				<th width="25%">轮转科室</th>
				<th width="40%">轮转时间</th>
				<th width="35%">备注</th>
			</tr>
			<c:forEach items="${arrResultList}" var="result">
				<tr>
					<td>${result.schDeptName}</td>
					<td>${result.schStartDate} ~ ${result.schEndDate}</td>
					<td>
						<c:if test="${!empty absenceCount[result.schDeptFlow]}">
							缺勤${absenceCount[result.schDeptFlow]}天！
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="">
				<tr><td colspan="3">暂无轮转计划!</td></tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>