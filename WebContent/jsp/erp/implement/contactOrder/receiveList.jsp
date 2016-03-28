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
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}

function receiveWorkContact(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/implement/contactOrderReceive'/>?contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'工作联系单接收',w,h,null,false);
}

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}
function checkedView(contactFlow){
	$.each($(".contactTr"),function(i,n){
		$(n).css("background-color","");
	});
	$("#contactTr_"+contactFlow).css("background-color","pink");
	$("#checkContactFlow").val(contactFlow);
}
$(document).ready(function(){
	if($("#checkContactFlow").val()!=""){
		checkedView($("#checkContactFlow").val());
	}
});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/implement/contactOrderReceiveList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }"/>" method="post">
				<div>
					客户名称：<input type="text" name="customerName" value="${param.customerName }" class="xltext" placeholder="客户名称/别名"/>
					联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
					申请时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart }" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					       <input type="text" class="xltext ctime" name="applyDateEnd"  value="${param.applyDateEnd }" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
				</div>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="5%"/>
					<col width="10%"/>
					<col width="20%"/>
					<col width="25%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>联系单编号</th>
					<th>客户名称</th>
					<th>产品/项目名称</th>
					<th>需求事项</th>
					<th>申请人</th>
					<th>申请时间</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:if test="${empty contactOrderList  }">
				      <tr><td colspan="8">无记录</td></tr>
				 </c:if>
				<c:forEach items="${contactOrderList }" var="contactOrder" varStatus="num">
				<tr class="contactTr" id="contactTr_${contactOrder.contactFlow }">
					<td>${num.count }</td>
					<td>${contactOrder.contactNo }</td>
					<td>
					<a href="javascript:customerInfo('${contactOrder.customerFlow }');">${contactOrder.customerName }</a>
					</td>
					<td>${contactOrder.productTypeName }
					    <c:if test="${(not empty contactOrder.productTypeName) and (not empty contactOrder.orderProductName) }">、</c:if>
				        ${contactOrder.orderProductName }
					</td>
					<td>${contactOrder.demandMatterName }</td>
					<td>${contactOrder.applyUserName }</td>
					<td>${contactOrder.applyDate }</td>
					<td>[<a href="javascript:receiveWorkContact('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">接收</a>]</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(contactOrderList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>