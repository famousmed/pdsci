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
function doClose() 
{
	jboxClose();
}
function save(){}
</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<table class="xllist" width="400px">
			<tbody>
				<tr>
					<th colspan="4"  style="text-align: left">&#12288;&#12288;经费总预算</th>
				</tr>
				<tr>
					<td ><b>费用类别</b></td><td>差旅费</td>
					<td ><b>类别预算</b></td><td>10000</td>
				</tr>
				<tr>
					<th colspan="4"  style="text-align: left">&#12288;&#12288;报销信息</th>
				</tr>
				<tr>
					<td ><b>报销申请</b></td><td >1800</td>
					<td ><b>实际报销</b></td><td>3600</td>
				</tr>
				<tr>
					<td ><b>报销正负比</b></td><td colspan="3">200%</td>
				</tr>
				<tr>
					<th colspan="4"  style="text-align: left">&#12288;&#12288;超出预算原因</th>
				</tr>
				<tr>
					<td colspan="4"><textarea style="width: 100%;height: 100px">未买到打折机票</textarea></td>
				</tr>
			</tbody>
		</table>
		<div class="button" style="width: 400px;">
		</div>
	</div>
	</div>
</body>
</html>