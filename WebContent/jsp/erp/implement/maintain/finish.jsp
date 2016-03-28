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
function save(){
	var form = $("#saveForm");
	if(form.validationEngine("validate")){
		jboxClose();
	}
} 
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent" >
			<div class="tagContent selectTag" id="tagContent0">
			<form id="saveForm" >
				<table width="730" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px">派工单信息</th>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">客户名称：</td>
						<td>苏州卫生局</td>
						<td style="text-align: right;padding-right: 10px;">产品名称：</td>
						<td>住院医师系统</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">维护类别：</td>
						<td>安装</td>
						<td style="text-align: right;padding-right: 10px;">需求时间：</td>
						<td>2014-06-18</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">派&nbsp;单&nbsp;&nbsp;人：</td>
						<td>李黎</td>
						<td style="text-align: right;padding-right: 10px;">派单时间：</td>
						<td>2014-06-22</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">工&nbsp;单&nbsp;&nbsp;号：</td>
						<td>GDH-0011</td>
						<td style="text-align: right;padding-right: 10px;">实&nbsp;施&nbsp;&nbsp;人：</td>
						<td>王一</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">完成日期：</td>
						<td><input type="text" class="xltext ctime" value="${pdfn:getCurrDate() }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
						<td style="text-align: right;padding-right: 10px;">满&nbsp;意&nbsp;&nbsp;度：</td>
						<td>
							<select class="xlselect">
				            	<option value="">请选择</option>
				             	<c:forEach var="satisfaction" items="${dictTypeEnumSatisfactionList}">
						            <option value="${satisfaction.dictId}" >${satisfaction.dictName}</option>
						        </c:forEach>
							</select>
						</td>
					</tr>
				</table>
				<div class="button" style="width: 730px;">
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