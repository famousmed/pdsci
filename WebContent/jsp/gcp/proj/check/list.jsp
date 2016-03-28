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
function check(projFlow){
	window.location.href="<s:url value='/gcp/proj/check'/>?projFlow="+projFlow;
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
			<form id="searchForm" action="<s:url value="/gcp/proj/checkList" />" method="post">
				项目编号：<input type="text" name="projNo" value="${param.projNo}" class="xltext"/>
				项目名称：<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 250px"/>
				
				<input type="button" class="search"	onclick="search();" value="查&#12288;询">
			</form>
		</div> 
		<div>
			<table class="xllist">
				<tr>
					<th width="50px;">序号</th>
					<th width="100px;">项目编号</th>
					<th>项目名称</th>		
					<th width="100px;">期类别</th>		
					<th width="150px;">项目来源</th>		
					<th width="100px;">项目类别</th>
					<th width="90px;">组长/参与</th>	
					<th width="110px;">承担科室</th>
					<th width="90px;">操作</th>
				</tr>
				<c:forEach items="${formList}" var="form" varStatus="statu">
				<tr>
					<td>${statu.count}</td>
					<td>${form.proj.projNo }</td>
					<td>${form.proj.projName }</td>
					<td>${form.proj.projSubTypeName }</td>
					<td>${form.proj.projShortDeclarer }</td>
					<td>${form.proj.projTypeName }</td>
					<td>
						<c:if test="${form.isLeader eq projOrgTypeEnumLeader.id}">${projOrgTypeEnumLeader.name }</c:if>
	    				<c:if test="${form.isLeader eq projOrgTypeEnumParti.id}">${projOrgTypeEnumParti.name }</c:if>
					</td>
					<td>${form.proj.applyDeptName }</td>
					<td>
						[<a href="javascript:void(0)" onclick="check('${form.proj.projFlow}')">审核</a>]
					</td>
				</tr>
				</c:forEach>
				<c:if test="${empty formList }">
				<tr>
				<td colspan="9">无记录！</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div> 
</div>
</body>
</html>