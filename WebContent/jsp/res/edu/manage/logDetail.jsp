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
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
			姓名：张伟&#12288;
			工号：0340&#12288;
			科室：内科
		</div>
			<table id="orgTable" class="xllist">
				<thead>
				<tr>
					<th>登录IP</th>
					<th>登录时间</th>
					<th>退出时间</th>
					<th>登录时长（时：分：秒）</th>
				</tr>
				</thead>						
				<tbody>
				<tr>
					<td>[0:0:0:0:0:0:0:1]</td>
					<td>2015-04-20 10:02:12</td>
					<td>2015-04-20 11:13:17</td>
					<td>1:11:05</td>
				</tr>
				<tr>
					<td>[0:0:0:0:0:0:0:1]</td>
					<td>2015-04-19 10:02:12</td>
					<td>2015-04-19 11:13:17</td>
					<td>1:11:05</td>
				</tr>
				<tr>
					<td>[0:0:0:0:0:0:0:1]</td>
					<td>2015-04-18 10:02:12</td>
					<td>2015-04-18 11:13:17</td>
					<td>1:11:05</td>
				</tr>
				<tr>
					<td>[0:0:0:0:0:0:0:1]</td>
					<td>2015-04-17 10:02:12</td>
					<td>2015-04-17 11:13:17</td>
					<td>1:11:05</td>
				</tr>
				</tbody>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(logList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>