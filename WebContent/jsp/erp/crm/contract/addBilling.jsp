<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
function save() {
	jboxClose();
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent" >
			<div class="tagContent selectTag" id="tagContent0">
			<form id="implementForm" >
				<table width="650" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px">开票信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">合同名称：</td>
						<td colspan="3">卫生局科研系统三方合同</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">计划日期：</td>
						<td>2014-06-02</td>
						<td style="text-align: right;padding-right: 10px;">回款金额：</td>
						<td>10元</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">开票日期：</td>
						<td><input type="text" class="xltext ctime" value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
						<td style="text-align: right;padding-right: 10px;">金&#12288;&#12288;额：</td>
						<td><input class="xltext" type="text" value=""/></td>
					</tr>
				</table>
				<div class="button" style="width: 650px;">
					<input class="search" type="button" value="保&#12288;存" onclick="save();" />
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>