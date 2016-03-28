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
function addWorkOrder() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=edit","新增派工单", 840, 650);
}

function editWorkOrder() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=edit","编辑派工单", 840, 650);
}

function workOrderInfo() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=info","派工单详情", 840, 650);
}

function auditWorkOrder() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=assistantAudit","审核派工单", 840, 650);
}

function visit() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=visit","客户回访", 840, 650);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<table class="xllist">
				<colgroup>
					<col width="25%"/>
					<col width="25%"/>
					<col width="25%"/>
					<col width="25%"/>
				</colgroup>
				<thead>
				<tr>
					<th>派工时间</th>
					<th>实施工程师</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<tr>
					<td>2014-11-02</td>
					<td>李丽</td>
					<td>未提交</td>
					<td>
						[<a href="javascript:editWorkOrder();">编辑</a>]
					</td>
				</tr>
				<tr>
					<td>2014-11-02</td>
					<td>李丽</td>
					<td>实施完成</td>
					<td>
						[<a href="javascript:workOrderInfo();">详情</a>] |
						[<a href="javascript:auditWorkOrder();">审核</a>]
					</td>
				</tr>
				<tr>
					<td>2014-10-22</td>
					<td>李丽</td>
					<td>审核通过</td>
					<td>
						[<a href="javascript:workOrderInfo();">详情</a>] |
						[<a href="javascript:visit();">回访</a>]
					</td>
				</tr>
				<tr>
					<td>2014-09-10</td>
					<td>李丽</td>
					<td>已关闭</td>
					<td>
						[<a href="javascript:workOrderInfo();">详情</a>]
					</td>
				</tr>
				</tbody>
			</table>
			</div>
			<div class="button">
				<input type="button" class="search" onclick="addWorkOrder();" value="新&#12288;增" >
				<input type="button" class="search" onclick="jboxCloseMessager();" value="关&#12288;闭" >
			</div>	
	</div>
</div>
</body>
</html>