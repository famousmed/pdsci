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
<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/gcp/qc/orgRemindList" />" method="post">
				质控类型：
				<select class="xlselect" name="qcTypeId">
					<option value="">全部</option>
					<c:forEach items="${gcpQcTypeEnumList}" var="qcType">
					<c:if test="${!(gcpQcTypeEnumInspection.id eq qcType.id)}">
						<option value="${qcType.id}" <c:if test="${param.qcTypeId eq qcType.id}">selected="selected"</c:if> >${qcType.name}</option>
					</c:if>
					</c:forEach>
				</select>
				质控节点：
				<select class="xlselect" name="qcCategoryId">
					<option value="">全部</option>
					<c:forEach items="${gcpQcCategoryEnumList}" var="qcCategory">
						<option value="${qcCategory.id}" <c:if test="${param.qcCategoryId eq qcCategory.id}">selected="selected"</c:if> >${qcCategory.name}</option>
					</c:forEach>
				</select>
				项目名称：
				<input type="text" name="projName" value="${param.projName}" class="xltext">
				<input type="button" value="查&#12288;询" class="search" onclick="search();">
			</form>
		</div> 
		<div>
			<table class="xllist">
				<tr>
					<th width="5%">序号</th>
					<th width="25%">项目名称</th>
					<th width="10%">质控类别</th>
					<th width="10%">质控节点</th>
					<th width="40%">提醒内容</th>
					<th width="10%">提醒日期</th>
				</tr>
				<c:forEach items="${qcRemindList}" var="remind" varStatus="seq">
				<tr>
					<td width="5%">${seq.count}</td>
					<td width="25%">${projMap[remind.projFlow].projName}</td>
					<td width="10%">${remind.qcTypeName}</td>
					<td width="10%">${remind.qcCategoryName}</td>
					<td width="40%" style="text-align: left;padding-left: 10px">${remind.remindContent}</td>
					<td width="10%">${pdfn:transDate(remind.createTime)}</td>
				</tr>
				</c:forEach>
				<c:if test="${empty qcRemindList}">
				<tr>
				<td colspan="6">无记录！</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div> 
</div>
</body>
</html>