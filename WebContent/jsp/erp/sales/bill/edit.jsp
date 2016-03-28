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
$(document).ready(function(){
	$("#productName").scombobox({
		forbidInvalid : true,
		invalidAsValue : true,
		expandOnFocus : false
	});
	$(".scombobox-display").css("height","25px");
	$(".scombobox-display").css("border","1px solid #bdbebe");
	$(".scombobox-display").css("width","218px");
});

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
				<table width="770" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px">发票单信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">申请日期：</td>
						<td>
						<input type="text" class="xltext ctime" value="${pdfn:getCurrDate() }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
						</td>
						<td style="text-align: right;padding-right: 10px;">客户名称：</td>
						<td>苏州卫生局</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">客户联系人：</td>
						<td><input class="xltext" type="text" value=""/></td>
						<td style="text-align: right;padding-right: 10px;">电&#12288;&#12288;话：</td>
						<td><input class="xltext" type="text" value=""/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">开票内容：</td>
						<td colspan="3"><input class="xltext" type="text" value="" style="width: 544px;"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">我司开票抬头：</td>
						<td colspan="3">
							<select class="xlselect" style="width: 220px;">
				            	<c:forEach var="invoiceTitle" items="${companyNameEnumList}">
									<option value="${invoiceTitle.id}">${invoiceTitle.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">开票金额：</td>
						<td><input class="xltext" type="text" value=""/></td>
						<td style="text-align: right;padding-right: 10px;">开票申请人：</td>
						<td><input class="xltext" type="text" value="${sessionScope.currUser.userName }"/></td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>
						<td colspan="3"><input class="xltext" type="text" value="" style="width: 544px;"/></td>
					</tr>
				</table>
				<div class="button" style="width: 770px;">
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