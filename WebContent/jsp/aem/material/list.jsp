<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
function add() {
	jboxOpen("<s:url value='/sys/user/edit'/>","新增实验信息", 900, 300);
}
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit?userFlow='/>"+ userFlow,"编辑实验信息", 900, 300);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				 <form id="searchForm" action="<s:url value="/sys/user/list/${sessionScope.userListScope}" />" method="post" > 
				     	实验名称：<input type="text" name="userName" value="${param.userName}"  class="xltext"/>  						
				     	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
				</form>
			</div>
	<table class="xllist" > 
		<tr>
			<th width="20px"></th>
			<th width="80px">物料编号</th>
			<th width="80px">物料名称</th>
			<th width="30px">物料类别</th>
			<th width="60px">数量</th>
			<th width="30px">单位</th>
			<th width="60px">剩余量</th>
			<th width="60px">领用日期</th>
			<th width="60px">领用人</th>
		</tr>
		<tr>			
			<td></td>
			<td>F0000001</td>
			<td>******</td>
			<td>试剂</td>
			<td>30</td>
			<td>只</td>
			<td>970</td>
			<td>2014-06-15</td>
			<td>张三</td>
		</tr>		
		<tr>			
			<td></td>
			<td>F0000002</td>
			<td>******</td>
			<td>试剂</td>
			<td>30</td>
			<td>只</td>
			<td>970</td>
			<td>2014-06-15</td>
			<td>张三</td>
		</tr>		
		<tr>			
			<td></td>
			<td>F0000003</td>
			<td>******</td>
			<td>试剂</td>
			<td>30</td>
			<td>只</td>
			<td>970</td>
			<td>2014-06-15</td>
			<td>张三</td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>