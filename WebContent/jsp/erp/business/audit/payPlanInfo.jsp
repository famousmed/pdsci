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
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div style="line-height: 25px;padding-top: 5px;">
					<b>客户名称：</b><font color="red"><a href="javascript:customerInfo('f4c1d244e65945f1acd3bed8457ff8e6')">苏州卫生局</a></font>&#12288;
					<b>合同号：</b><font color="red"><a href="javascript:contractInfo('3a79facf6d91452d8de69ace083989d5')">SZWSJ-001</a></font>&#12288;
					<b>合同名称：</b><font color="red"><a href="javascript:contractInfo('3a79facf6d91452d8de69ace083989d5')">卫生局科研系统三方合同</a></font><br/>
					<b>合同金额：</b><font color="red">20.5元</font>&#12288;
					<b>已到款：</b><font color="red">8元</font>&#12288;
					<b>未到款：</b><font color="red">12.5元</font>
				</div>
			<div class="title1 clearfix">
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="7%"/>
					<col width="22%"/>
					<col width="7%"/>
					<col width="6%"/>
					<col width="12%"/>
					<col width="8%"/>
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
				</tr>
				</thead>						
				<tbody>
				<tr>
					<th colspan="7" style="text-align: left;padding-left: 10px;">
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
				</tr>
				<tr>
					<th colspan="7" style="text-align: left;padding-left: 10px;">
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
				</tr>
				<tr>
					<td>2</td>
					<td>2014-12-08</td>
					<td>住院医师系统第二笔回款</td>
					<td>2元</td>
					<td>李丽</td>
					<td>第二笔回款</td>
					<td>已提交</td>
				</tr>
				<tr>
					<th colspan="7" style="text-align: left;padding-left: 10px;">
					<span style="width: 330px;float: left;">计划日期：2015-02-01&#12288;&#12288;回款金额：2.5元</span>状态：未到账
					</th>
				</tr>
				<tr>
					<td colspan="7">无记录</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>