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
function search() {
	jboxStartLoading();
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}

function auditPay() {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/business/auditPay'/>";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'到账确认',w,700,null,false);
}

</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/business/auditBillList" />"	method="post">
				<div>
					客户名称：<input type="text" name="" value="" class="xltext"/>
					合同号：<input type="text" name="" value="" class="xltext"/>
					合同名称：<input type="text" name="" value="" class="xltext"/>
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
				</div>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="13%"/>
					<col width="13%"/>
					<col width="7%"/>
					<col width="22%"/>
					<col width="7%"/>
					<col width="6%"/>
					<col width="12%"/>
					<col width="6%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>客户名称</th>
					<th>合同名称</th>
					<th>申请日期</th>
					<th>开票内容</th>
					<th>开票金额</th>
					<th>开票申请人</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				 <tr>
					<td>1</td>
					<td>苏州卫生局</td>
					<td>卫生局科研系统三方合同</td>
					<td>2014-12-08</td>
					<td>住院医师系统第二笔回款</td>
					<td>2元</td>
					<td>李丽</td>
					<td>第二笔回款</td>
					<td>[<a href="javascript:auditPay();">到账确认</a>]</td>
				</tr> 
				</tbody>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(contractList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>