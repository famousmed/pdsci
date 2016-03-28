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

function billInfo() {
	jboxOpen("<s:url value='/erp/crm/billInfo'/>","发票单信息", 850, 420);
}

function doBack(){
	window.location.href="<s:url value='/erp/crm/searchContract'/>";
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<div>
					<b>客户名称：</b><font color="red">苏州卫生局</font>&#12288;
					<b>合同号：</b><font color="red">SZWSJ-001</font>&#12288;
					<b>合同名称：</b><font color="red">卫生局科研系统三方合同</font>&#12288;
					<b>合同金额：</b><font color="red">20.5元</font>&#12288;
					<b>已到款：</b><font color="red">8元</font>&#12288;
					<b>未到款：</b><font color="red">12.5元</font>
					<input type="button" class="search" onclick="doBack();" value="返&#12288;回" >
				</div>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="7%"/>
					<col width="22%"/>
					<col width="7%"/>
					<col width="6%"/>
					<col width="12%"/>
					<col width="8%"/>
					<col width="6%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>申请日期</th>
					<th>开票内容</th>
					<th>开票金额</th>
					<th>开票申请人</th>
					<th>备注</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<tr>
					<th colspan="8" style="text-align: left;padding-left: 10px;">
					<span style="width: 330px;float: left;">计划日期：2014-10-01&#12288;&#12288;回款金额：8元</span>状态：已到账
					</th>
				</tr>
				<tr>
					<td>1</td>
					<td>2014-10-10</td>
					<td>住院医师系统第一笔回款</td>
					<td>8元</td>
					<td>李丽</td>
					<td>第一笔回款</td>
					<td>财务审核通过</td>
					<td>[<a href="javascript:billInfo();">详情</a>]</td>
				</tr>
				<tr>
					<th colspan="8" style="text-align: left;padding-left: 10px;">
					<span style="width: 330px;float: left;">计划日期：2014-12-01&#12288;&#12288;回款金额：10元</span>状态：未到账
					</th>
				</tr>
				<tr>
					<td>1</td>
					<td>2014-11-26</td>
					<td>住院医师系统第二笔回款</td>
					<td>6元</td>
					<td>李丽</td>
					<td>第二笔回款</td>
					<td>商务审核不通过</td>
					<td>[<a href="javascript:billInfo();">详情</a>]</td>
				</tr>
				<tr>
					<td>2</td>
					<td>2014-12-08</td>
					<td>住院医师系统第二笔回款</td>
					<td>2元</td>
					<td>李丽</td>
					<td>第二笔回款</td>
					<td>已提交</td>
					<td>[<a href="javascript:billInfo();">详情</a>]</td>
				</tr>
				<tr>
					<th colspan="8" style="text-align: left;padding-left: 10px;">
					<span style="width: 330px;float: left;">计划日期：2015-02-01&#12288;&#12288;回款金额：2.5元</span>状态：未到账
					</th>
				</tr>
				<tr>
					<td colspan="8">无记录</td>
				</tr>
				</tbody>
			</table>
	</div>
</div>
</body>
</html>