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
function logDetail(){
	var url = "<s:url value='/jsp/res/edu/manage/logDetail.jsp'/>";
	jboxOpen(url, "日志详情", 700, 500);
}

function search(){
	toPage("${param.currentPage}");
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="searchForm" action="<s:url value='/resedu/report/sysLog'/>" method="post">
	<input id="currentPage" type="hidden" name="currentPage" value=""/> 
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
		工号：<input type="text" name="userName" value="${param.userName }" class="xltext " style="width: 100px;"/>
		时间：<input type="text" name="logTime"  value="${param.logTime }" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width:100px;"/>
		科室：<select name="deptFlow" class="xlselect" style="width: 100px;">
				<c:forEach items="${deptList }" var="dept">
					<option value="">请选择</option>
					<option value="${dept.deptFlow }" ${dept.deptFlow eq param.deptFlow?'selected':'' }>${dept.deptName }</option>
				</c:forEach>
			</select>
		<input type="button" class="search" onclick="search();" value="查&#12288;询">
	</div>
	</form>
	 <table class="xllist">
		<tr>
			<th width="10%">科室</th>
			<th width="10%">姓名</th>
			<th width="10%">工号</th>
			<th width="10%">职位</th>
			<th width="10%">年月</th>
			<th width="10%">登录次数</th>
			<th width="10%">时长统计（时:分:秒）</th>
			<th width="10%">详情</th>
		</tr>
		<c:forEach items="${oldLogs}" var="log" varStatus="status">
			<tr>
				<td>${log.deptName}</td>
				<td>${log.userName }</td>
				<td></td>
				<td>主任医师</td>
				<td>${pdfn:transDateTimeForPattern(log.logTime,'yyyyMMddHHmmss','yyyy年MM月')}</td>
				<td></td>
				<td></td>
				<td>[<a href="javascript:void(0);" onclick="logDetail();">详情</a>]</td>
			</tr>
		</c:forEach>
		<c:if test="${empty logs }">
			<tr>
				<td colspan="8">无记录</td>
			</tr>
		</c:if>
	</table>
	<div>
	   	<c:set var="pageView" value="${pdfn:getPageView(oldLogs)}" scope="request"/>
		<pd:pagination toPage="toPage"/>
	</div>
</div>
</div>
</div>
</body>