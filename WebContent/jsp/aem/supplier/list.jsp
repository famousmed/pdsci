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
				     	供应商名称：<input type="text" name="userName" value="${param.userName}"  class="xltext"/>  						
				     	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
				</form>
			</div>
	<table class="xllist" > 
		<tr>
			<th width="20px"></th>
			<th width="80px">省份</th>
			<th width="80px">供应商名称</th>
			<th width="30px">公司地址</th>
			<th width="60px">联系人</th>
			<th width="30px">联系手机</th>
			<th width="60px">联系Email</th>
		</tr>
		<tr>			
			<td></td>
			<td>江苏</td>
			<td>******XXX公司1</td>
			<td>南京市XX路2#</td>
			<td>赵四</td>
			<td>13813866831</td>
			<td>zhao123@163.com</td>
		</tr>
		<tr>			
			<td></td>
			<td>安徽</td>
			<td>******XXX公司1</td>
			<td>合肥市XX路2#</td>
			<td>王五</td>
			<td>13813866831</td>
			<td>zhao123@163.com</td>
		</tr>
		<tr>			
			<td></td>
			<td>山东</td>
			<td>******XXX公司1</td>
			<td>济南市XX路2#</td>
			<td>钱六</td>
			<td>13813866831</td>
			<td>zhao123@163.com</td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>