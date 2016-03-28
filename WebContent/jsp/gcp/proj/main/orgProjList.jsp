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

function projInfo(projFlow){
	window.location.href="<s:url value='/gcp/proj/projInfo'/>?editFlag=${GlobalConstant.FLAG_Y}&projFlow="+projFlow;
}
function search(){
	$("#searchForm").submit();
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/gcp/proj/orgProjList" />" method="post">
				项目类别：
				<select class="xlselect" name="projCategoryId" onchange="search()">
					<option value="">全部</option>
					<option value="${projCategroyEnumYw.id }" <c:if test="${param.projCategoryId==projCategroyEnumYw.id}">selected="selected"</c:if> >${projCategroyEnumYw.name}</option>
					<option value="${projCategroyEnumKy.id }" <c:if test="${param.projCategoryId==projCategroyEnumKy.id}">selected="selected"</c:if> >${projCategroyEnumKy.name}</option>
					<option value="${projCategroyEnumQx.id }" <c:if test="${param.projCategoryId==projCategroyEnumQx.id}">selected="selected"</c:if> >${projCategroyEnumQx.name}</option>
				</select>
			</form>
		</div> 
		<div>
			<table class="xllist">
				<tr>
					<th width="5%">序号</th>
					<th width="10%">项目编号</th>
					<th width="30%">项目名称</th>
					<th width="8%">期类别</th>
					<th width="17%">项目来源</th>
					<th width="9%">承担科室</th>
					<th width="12%">主要研究者</th>
					<th width="9%">项目阶段</th>
				</tr>
				<c:forEach items="${projList}" var="proj" varStatus="statu">
				<tr>
					<td width="5%">${statu.count}</td>
					<td width="10%">${proj.projNo }</td>
					<td width="30%">${proj.projName }</td>
					<td width="8%">${proj.projSubTypeName }</td>
					<td width="17%">${proj.projShortDeclarer }</td>
					<td width="9%">${proj.applyDeptName }</td>
					<td width="12%">${proj.applyUserName }</td>
					<td width="9%">${proj.projStageName }</td>
				</tr>
				</c:forEach>
				<c:if test="${empty projList }">
				<tr>
				<td colspan="8">无记录！</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div> 
</div>
</body>
</html>