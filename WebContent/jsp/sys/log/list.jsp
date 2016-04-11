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
	<jsp:param name="jquery_cxselect" value="true"/>
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
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	search();
}
function search() {
	if($("#startDate").val()!="" && $("#endDate").val()!=""){
		if($("#startDate").val() > $("#endDate").val()){
			jboxTip("起始日期不能大于结束日期");
			return;
		}
	}
	jboxStartLoading();
	$("#searchForm").submit();
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/sys/log/list" />"	method="post">
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					登录时间:	<input type="text" class="xltext ctime" id="startDate" name="startDate" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${param.startDate }"/>
					~&#12288;	<input type="text" class="xltext ctime" id="endDate" name="endDate" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${param.endDate }"/>
					姓名：<input type="text" name="userName" class="xltext" value="${param.userName }"/>
					<input type="button" class="search" onclick="search();" value="查&#12288;询"> 
				</form>
			</div>		
			<table id="orgTable" class="xllist">
				<thead>
				<tr>
					<th>时间</th>
					<th>方式</th>
					<th>用户名</th>
					<th>姓名</th>
					<th>机构</th>
					<th>部门</th>
					<th>类别</th>
					<th>描述</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${logList}" var="log">
					<tr>
						<td>${pdfn:transDateTime(log.logTime)}</td>
						<td>${pdfn:transDateTime(log.reqTypeName)}</td>
						<td>${log.userCode }</td>
						<td>${log.userName }</td>
						<td>${log.orgName}</td>
						<td>${log.deptName}</td>
						<td>${log.operName }</td>
						<td>${log.logDesc}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(logList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>