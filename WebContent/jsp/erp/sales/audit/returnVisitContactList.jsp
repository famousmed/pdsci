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

function returnVisitContact(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/returnVisitContact'/>?contactFlow="+contactFlow+"&visitFlag=Y&historyFlag=Y";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'工作联系单回访',w,h,null,false);
}

function trackContact(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/trackContact'/>?contactFlow="+contactFlow+"&trackFlag=Y&historyFlag=Y";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'实施进度跟踪',w,h,null,false);
}

function closeContactOrder(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/sales/lastContactOrder'/>?contactFlow=" + contactFlow + "&closeFlag=${GlobalConstant.FLAG_Y}";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'工作联系单关单',w,h,null,false);
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
function setStatusName(id){
	$("#"+id+"Name").val($("#"+id+"Id").find("option:selected").text());
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/sales/returnBackContactList/${sessionScope[GlobalConstant.USER_LIST_SCOPE]}"/>" method="post">
				<input type="hidden" id="checkContactFlow" name="checkContactFlow" value="${param.checkContactFlow }"/>
				 <div style="padding-bottom: 10px;">
				    客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName }" class="xltext"/>
					 联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
					产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName }" class="xltext"/>
				</div>
				<div style="padding-bottom: 10px;">
					需求事项：<select class="xlselect" name="demandMatterId">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id }">selected</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
				             联系单状态：<select name="contactStatusId" class="xlselect" style="width: 108px;">
		            	<option value="">请选择</option>
		            	<option value="${contactOrderStatusEnumImplementing.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumImplementing.id}">selected="selected"</c:if>>${contactOrderStatusEnumImplementing.name}</option>
		            	<option value="${contactOrderStatusEnumImplemented.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumImplemented.id}">selected="selected"</c:if>>${contactOrderStatusEnumImplemented.name}</option>
		            	<option value="${contactOrderStatusEnumReturnVisited.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumReturnVisited.id}">selected="selected"</c:if>>${contactOrderStatusEnumReturnVisited.name}</option>
		            	<option value="${contactOrderStatusEnumClosed.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumClosed.id}">selected="selected"</c:if>>${contactOrderStatusEnumClosed.name}</option>
					</select>
					&#12288;申请时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart }" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd }" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
				    <c:if test="${param.type!='track' }">
				      <input type="button" class="search" onclick="search('<s:url value="/erp/sales/returnBackContactList/${sessionScope[GlobalConstant.USER_LIST_SCOPE]}"/>?type=visit');" value="查&#12288;询">
				    </c:if>
				    <c:if test="${param.type=='track' }">
				      <input type="button" class="search" onclick="search('<s:url value="/erp/sales/trackContactList?type=track"/>');" value="查&#12288;询">  
				    </c:if>
				</div>
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				 <input  type="hidden" name="type" value="${param.type }"/>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="20%"/>
					<col width="10%"/>
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
					<th>审核状态</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:if test="${empty contactOrderList  }">
				      <tr><td colspan="9">无记录</td></tr>
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
					<td>${contactOrder.contactStatusName }</td>
					<td>
					 <c:if test="${param.type == 'visit' and (contactOrder.contactStatusId eq contactOrderStatusEnumImplemented.id or contactOrder.contactStatusId eq contactOrderStatusEnumReturnVisited.id or contactOrder.contactStatusId eq contactOrderStatusEnumClosed.id)}">
					  [<a href="javascript:returnVisitContact('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">回访</a>]
					 </c:if>
					 <c:if test="${param.type == 'track' }"> 
					  [<a href="javascript:trackContact('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">跟踪</a>]
                     </c:if>					
					</td>
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