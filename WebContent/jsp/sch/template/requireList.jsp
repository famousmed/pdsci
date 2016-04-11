<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
	<head>
		<script type="text/javascript">
		</script>
	</head>
<body>
<div class="mainright" align="center" style="margin-top: 10px;">
	<div class="content">
		<c:set var="enumKey" value="registryTypeEnum${param.recTypeId}"/>
		<table class="xllist" width="100%">
			<tr>
				<c:if test="${applicationScope[enumKey].haveItem eq GlobalConstant.FLAG_Y}">
					<th width="25%">子项名称</th>
				</c:if>
				<th width="25%">要求例数</th>
				<th width="30%">要求说明</th>
				<th width="20%">操作</th>
			</tr>
			<c:forEach items="${deptReqList}" var="req">
				<tr>
					<c:if test="${applicationScope[enumKey].haveItem eq GlobalConstant.FLAG_Y}">
						<td>${req.itemName}</td>
					</c:if>
					<td>${req.reqNum}</td>
					<td>${req.reqNote}</td>
					<td>
						<a href="javascript:editDeptReq('${req.reqFlow}');" class="edit" style="color: blue">编辑</a>
						<c:if test="${!(req.itemId eq GlobalConstant.RES_REQ_OTHER_ITEM_ID)}">
							&nbsp;|&nbsp;
							<a href="javascript:delDeptReq('${req.reqFlow}','${req.recTypeId}');" style="color: blue" >删除</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty deptReqList}">
				<tr><td colspan="4">无记录</td></tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>