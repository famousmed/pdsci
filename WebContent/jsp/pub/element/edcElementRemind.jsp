<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div style="margin-top: 5px;margin-bottom: 5px;">
			&#12288;当前元素：<b>${pubElement.elementName }</b>
			&#12288;<font color="red">该元素已被选入项目库，不能删除!</font>
		</div>
		<div>
			<table class="xllist">
				<tr>
					<th width="150px">项目编号</th>
					<th width="330px">项目名称</th>
					<th width="200px">访视名称</th>
				</tr>
				<c:forEach items="${visitModuleForms}" var="form">
					<tr style="height: 20px">
						<td width="150px">${form.projNo }</td>
						<td width="330px">${form.projShortName }</td>
						<td width="220px">${form.visitName }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
</body>
</html>