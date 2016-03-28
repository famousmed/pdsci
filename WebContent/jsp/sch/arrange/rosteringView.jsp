<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<style type="text/css">
	table.basic td,table.basic th{padding: 0;text-align: center;}
</style>
<script type="text/javascript">

</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			</div>
			<div>
				<table class="basic" style="width: 100%;">
					<tr>
						<th style="width: 100px;max-width: 100px;min-width: 100px;">轮转科室</th>
						<c:forEach items="${months}" var="month">
							<th style="width: 100px;max-width: 100px;min-width: 100px;">${month}</th>
						</c:forEach>
					</tr>
					
					<c:forEach items="${schDeptList}" var="schDept">
						<tr>
							<td>${schDept.schDeptName}(${schDept.deptNum})</td>
							<c:forEach items="${months}" var="month">
								<c:set var="key" value="${schDept.schDeptFlow}${month}"/>
								<td>
									<c:forEach items="${nameOfMonth[key]}" var="name" varStatus="nameStatus">
										<div style="float: left;margin-right: 5px;margin-left: 5px;">
											${nameStatus.first?"":"，"}
											<c:if test="${!(nameStatus.count>schDept.deptNum)}">
												${name}
											</c:if>
											<c:if test="${nameStatus.count>schDept.deptNum}">
												<font color="red">${name}</font>
											</c:if>
										</div>
									</c:forEach>
								</td>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>