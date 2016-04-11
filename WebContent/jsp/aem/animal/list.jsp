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
function showDetail(){
	$("#detailTable").slideToggle("slow");
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
<div class="title1 clearfix">
		<table class="xllist" width="700px">
			<tr>
					<th colspan="3" align="left">&#12288;文件存档</th>
				</tr>
				<tr>
					<td colspan="3" style="text-align: left;">&#12288;动物管理</td>
				</tr>
				<tr>
					<th width="50px">序号</th><th>文件名称</th><th width="150px">存档日期</th>
				</tr>
				<tr>
					<td width="50px">1</td><td style="text-align: left">&#12288;1. 动物生产许可证</td><td width="150px">2013-05-08</td>
				</tr>
				<tr>
					<td width="50px">2</td><td style="text-align: left">&#12288;2. 动物的遗传背景资料</td><td width="150px">2013-05-08</td>
				</tr>
				<tr>
					<td width="50px">4</td><td style="text-align: left">&#12288;3. 动物质量合格证书</td><td width="150px">2013-05-08</td>
				</tr>
				<tr>
					<td width="50px">5</td><td style="text-align: left">&#12288;4. 动物微生物检查资料</td><td width="150px">2013-05-08</td>
				</tr>
				<tr>
					<td width="50px">6</td><td style="text-align: left">&#12288;5. 动物年龄、性别和健康资料</td><td width="150px">2013-05-08</td>
				</tr>
			</tbody>
		</table>
		<div class="button" style="width: 700px;">
		</div>
	</div>
	</div></div>
</body>
</html>