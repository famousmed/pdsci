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
			</div>
	<table class="xllist" > 
		<tr>
			<th width="20px"></th>
			<th width="50px">日期</th>
			<th width="50px">温度</th>
			<th width="30px">湿度</th>
			<th width="60px">记录人</th>
			<th width="150px">操作</th>
		</tr>
		<tr>			
			<td></td>
			<td>2014-06-01</td>
			<td>28°c</td>
			<td>43％</td>
			<td>赵乐</td>
			<td>[编辑][删除]</td>
		</tr>
		<tr>			
			<td></td>
			<td>2014-06-02</td>
			<td>24°c</td>
			<td>49％</td>
			<td>赵乐</td>
			<td>[编辑][删除]</td>
		</tr>
		<tr>			
			<td></td>
			<td>2014-06-03</td>
			<td>31°c</td>
			<td>37％</td>
			<td>赵乐</td>
			<td>[编辑][删除]</td>
		</tr>
	</table>
	</div>
</div>
</body>
</html>