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
</style>
<script type="text/javascript">

function deleteCustomer(customerFlow, customerName){
	jboxConfirm("确认该患者已完成所有随访? ", function() {
	});		
}

function view(){
	window.location.href="<s:url value='/jsp/fllow/patient/view.jsp'/>";
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
					患者姓名：<input type="text" name="customerName" value="${param.customerName}" placeholder="客户姓名/手机号" class="xltext" style="width: 210px;" onblur="resetOthers();"/>
					随访提醒：
					<select class="xlselect" name="customerTypeId" style="width: 108px;margin-left: -4px;" onchange="showCustomerType(this.value)">
		            	<option value=""></option>
		             	<option value="">一天</option>
		             	<option value="">三天</option>
		             	<option value="">一周</option>
		             	<option value="">已过期</option>
					</select>
					&#12288;&#12288;<input type="button" class="search"  value="查&#12288;询" />
				</div>
				</form>
			</div>		
			<form id="customerForm">	
			<table class="xllist">
				<colgroup>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="100"/>
					<col width="100"/>
					<col width="100"/>
					<col width="100"/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<thead>
				<tr >
					<th>患者姓名</th>
					<th>身份证号</th>
					<th>手机号</th>
					<th>首次访视日期</th>
					<th>上次访视日期</th>
					<th>访视次数</th>
					<th>下次访视日期</th>
					<th>提醒</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>李军</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-03-09</td>
						<td>2015-04-12</td>
						<td>1</td>
						<td>2015-05-13</td>
						<td style="color:#0000FF">距下次随访：3天</td>
						<td style="color:#0000FF">随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>王蒙</td>
						<td>32421232893123</td>
						<td>15229382910</td>
						<td>2015-03-15</td>
						<td>2015-04-15</td>
						<td>1</td>
						<td>2015-05-17</td>
						<td>距下次随访：7天</td>
						<td>随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>黄季军</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-03-26</td>
						<td>2015-04-22</td>
						<td>2</td>
						<td>2015-05-30</td>
						<td>距下次随访：8天</td>
						<td>随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>王芬</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-03-28</td>
						<td>2015-04-26</td>
						<td>3</td>
						<td>2015-06-08</td>
						<td>距下次随访：13天</td>
						<td>随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>张好汉</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-04-02</td>
						<td>2015-04-29</td>
						<td>3</td>
						<td>2015-06-15</td>
						<td>距下次随访：15天</td>
						<td>随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>熊科</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-04-22</td>
						<td>2015-05-12</td>
						<td>5</td>
						<td>2015-06-13</td>
						<td>距下次随访：17天</td>
						<td>随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>马文芳</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-05-02</td>
						<td>2015-06-12</td>
						<td>4</td>
						<td>2015-07-13</td>
						<td>距下次随访：17天</td>
						<td>随访中...</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>李进军</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-05-11</td>
						<td>2015-06-12</td>
						<td>2</td>
						<td>2015-06-28</td>
						<td style="color: red">距下次随访：-9天</td>
						<td style="color: red">随访中...(已超窗)</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							| [<a href="javascript:void(0)" onclick="deleteCustomer('${customer.customerFlow}','${customer.customerName}')">完成随访</a>]
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>玉林</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-03-09</td>
						<td>2015-04-12</td>
						<td>8</td>
						<td>2015-05-13</td>
						<td>-</td>
						<td>完成随访</td>
						<td>
							[<a href="javascript:view();">访视</a>]
							&#12288;&#12288;&#12288;&#12288;&#12288;
						</td>
					</tr>
					<tr id="${customer.customerFlow}_Tr" style="cursor: pointer;">
						<td>张婷</td>
						<td>32192312893123</td>
						<td>15229382910</td>
						<td>2015-03-09</td>
						<td>2015-04-12</td>
						<td>8</td>
						<td>2015-05-13</td>
						<td>-</td>
						<td>完成随访</td>
						<td>
							[<a href="javascript:view();">访视</a>]
						&#12288;&#12288;&#12288;&#12288;&#12288;
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