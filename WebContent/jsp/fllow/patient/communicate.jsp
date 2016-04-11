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
<style>
.edit3{text-align: center;border:none;}
a:hover{text-decoration:underline;}
</style>
<script type="text/javascript">

function deleteCustomer(customerFlow, customerName){
	jboxConfirm("确认该患者已完成所有随访? ", function() {
	});		
}

function view(){
	jboxOpen("<s:url value='/jsp/fllow/patient/communicate_detail.jsp'/>","医患交流详细信息",700,500);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" name="searchForm" action="<s:url value="/erp/crm/searchCustomer/${sessionScope.userListScope}"/>" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="currentPage2" name="currentPage2" value="${param.currentPage }"/>
				<input type="hidden" id="checkedFlow" name="checkedFlow" value="${checkedFlow }"/>
				<div style="margin-bottom: 10px">
					关键字：<input type="text" name="customerName" value="${param.customerName}" placeholder="疾病名称/症状/诊断/..." class="xltext" style="width: 210px;" onblur="resetOthers();"/>
					科室:<select class="xltext"><option>消化科</option><option>普内科</option></select>
					&#12288;&#12288;<input type="button" class="search"  value="查&#12288;询" />
				</div>
				</form>
			</div>		
			<form id="customerForm">	
			<table class="xllist">
				<colgroup>
					<col width="100"/>
					<col width=""/>
					<col width="100"/>
					<col width="100"/>
					<col width="100"/>
				</colgroup>
				<thead>
				<tr >
					<th>患者姓名</th>
					<th style="text-align: left;padding-left: 20px;">问题描述</th>
					<th>咨询科室</th>
					<th>时间</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>李军</td>
						<td style="text-align: left;padding-left: 20px;"><a href="javascript:view();">你好，医生，而且不管饿或者饱就网上打嗝，是胃溃疡之类的胃病吗</a></td>
						<td>消化科</td>
						<td>2014-05-12</td>
						<td>
							[<a href="javascript:view();">查看</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>张路</td>
						<td style="text-align: left;padding-left: 20px;"><a href="javascript:view();">本人最近胃口不好喉部感觉有异物，喉部至胸口感觉酸酸热热，肚子感觉热热的，右上腹部胀偶尔疼痛，右腹部肋骨及背部肋骨偶尔疼痛，是什么原因？</a></td>
						<td>消化科</td>
						<td>2014-04-11</td>
						<td>
							[<a href="javascript:view();">查看</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>匿名</td>
						<td style="text-align: left;padding-left: 20px;"><a href="javascript:view();">你好，我母亲做钡餐检查食道结果是食管下段约见3cm粘膜不规整段管壁略显僵硬钡齐尚能通过余段信管钡剂通过顺畅管壁光滑完整，粘膜正常，请问这是食道炎还是别的。</a></td>
						<td>消化科</td>
						<td>2014-03-08</td>
						<td>
							[<a href="javascript:view();">查看</a>]
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(customerList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>