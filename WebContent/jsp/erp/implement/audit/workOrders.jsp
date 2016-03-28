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
	jboxStartLoading();
	form.submit();
}

function auditWorkOrder(workFlow,contactFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?type=${sessionScope[GlobalConstant.TYPE_SCOPE]}&workFlow=" + workFlow+"&contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"审核派工单", 840, 650, null, false);
}

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/implement/auditWorkOrders/${sessionScope[GlobalConstant.TYPE_SCOPE] }"/>" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<div style="padding-bottom: 10px;"> 
				           客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName}" class="xltext" style="width:188px;"/>
					最终使用方：<input type="text" name="consumerName" placeholder="最终使用方名称/别名" value="${param.consumerName}" class="xltext" style="width: 148px;"/>
					派工单编号：<input type="text" name="workNo" placeholder="派工单编号" value="${param.workNo }" class="xltext"/>
				</div>
				<div>
				    产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName}" class="xltext"/>
					需求事项：<select name="demandMatterId" class="xlselect">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id}">selected="selected"</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
					&#12288;派工时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart}" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd}" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询" >
				</div>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="11%"/>
					<col width="12%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="9%"/>
					<c:if test="${sessionScope[GlobalConstant.TYPE_SCOPE] eq GlobalConstant.MANAGER_AUDIT}">
					<col width="9%"/>
					<col width="9%"/>
					</c:if>
					<col width="9%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>派工单编号</th>
					<th>客户名称</th>
					<th>最终使用方</th>
					<th>产品/项目名称</th>
					<th>申请时间</th>
					<th>需求事项</th>
					<th>派工时间</th>
					<c:if test="${sessionScope[GlobalConstant.TYPE_SCOPE] eq GlobalConstant.MANAGER_AUDIT}">
					<th>完成时间</th>
					<th>实施工程师</th>
					</c:if>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${workOrderExtList}" var="workOrderExt" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${workOrderExt.workNo}</td>
					<td>
					<a href="javascript:customerInfo('${workOrderExt.customerFlow}');" 
						title="${workOrderExt.aliasName}">${workOrderExt.customerName}</a>
					</td>
					<td>
					<a href="javascript:customerInfo('${workOrderExt.consumerFlow}');" 
						title="${workOrderExt.consumerAliasName}">${workOrderExt.consumerName}</a>
					</td>
					<td>${workOrderExt.contactOrder.productTypeName}
					<c:if test="${(not empty workOrderExt.contactOrder.productTypeName) and (not empty workOrderExt.contactOrder.orderProductName) }">、</c:if>
				        ${workOrderExt.contactOrder.orderProductName }
					</td>
					<td>${workOrderExt.contactOrder.applyDate}</td>
					<td>${workOrderExt.contactOrder.demandMatterName}</td>
					<td>${workOrderExt.assignDate}</td>
					<c:if test="${sessionScope[GlobalConstant.TYPE_SCOPE] eq GlobalConstant.MANAGER_AUDIT}">
					<td>${completeDateMap[workOrderExt.workFlow]}</td>
					<td>${workOrderExt.assignUserName}</td>
					</c:if>
					<td>
						[<a href="javascript:auditWorkOrder('${workOrderExt.workFlow}','${workOrderExt.contactFlow }');">审核</a>]
					</td>
				</tr>
				</c:forEach>
				</tbody>
				<c:if test="${empty workOrderExtList}">
					<tr>
						<td colspan="10">无记录</td>
					</tr>
				</c:if>
			</table>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(workOrderExtList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>