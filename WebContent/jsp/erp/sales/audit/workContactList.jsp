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

function auditWorkContact(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/auditWorkContact'/>?contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'工作联系单申请审核',w,h,null,false);
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
	if($("#"+id+"Id").val()==""){
		$("#"+id+"Name").val("");
	}
}
function searchVisitOpinion(contactFlow){
	jboxOpen("<s:url value='/erp/sales/contactOrderVisitOpinion'/>?contactFlow="+contactFlow,"回访记录", 700, 400);
}
function recall(contactFlow){
	jboxConfirm("确认将联系单撤回至<font color='red'>实施中</font>？", function(){
		url="<s:url value='/erp/sales/recall'/>?contactFlow="+contactFlow;
		 jboxPost(url , null, function(resp){
			 if(resp != "${GlobalConstant.SAVE_FAIL}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					setTimeout(function(){
						window.parent.frames['mainIframe'].window.search();
						jboxCloseMessager();
					},1000);
				}
		 },null,false);
	},null);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/sales/auditWorkContactList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }"/>" method="post">
				<input type="hidden" id="checkContactFlow" name="checkContactFlow" value="${param.checkContactFlow }"/>
				<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] != GlobalConstant.USER_LIST_LOCAL }">
				<div style="padding-bottom: 10px;">
					客户名称：<input type="text" name="customerName" value="${param.customerName }" class="xltext" placeholder="客户名称/别名"/>
					联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
					申请时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart }" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					       <input type="text" class="xltext ctime" name="applyDateEnd"  value="${param.applyDateEnd }" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
				           <input type="button" class="search" onclick="search();" value="查&#12288;询">
				</div>
				</c:if>
				<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_LOCAL }">
				 <div style="padding-bottom: 10px;">
				    客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName }" class="xltext"/>
					审核状态：<select class="xlselect" style="width: 108px;" id="contactStatusId" name="contactStatusId" onchange="setStatusName('contactStatus')">
				            	<option value="">请选择</option>
				             	<c:forEach var="contactStatus" items="${contactOrderStatusEnumList}">
						            <c:if test="${contactStatus.id eq contactOrderStatusEnumSalePassed.id or contactStatus.id eq contactOrderStatusEnumReturnVisited.id }">
						             <option value="${contactStatus.id}" <c:if test="${param.contactStatusName eq contactStatus.name }">selected</c:if>>${contactStatus.name}</option>
						            </c:if>
						        </c:forEach>
							</select>
							<input type="hidden" name="contactStatusName" id="contactStatusName" value="${param.contactStatusName }"/>
					  联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
				</div>
				<div style="padding-bottom: 10px;">
				产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName }" class="xltext" style="width: 128px;"/>
					需求事项：<select class="xlselect" name="demandMatterId" style="width: 108px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id }">selected</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>
					&nbsp;&nbsp;&nbsp;申请时间：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart }" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~&nbsp;
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd }" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
				    <input type="button" class="search" onclick="search();" value="查&#12288;询">
				</div>
				</c:if>
				<input id="currentPage" type="hidden" name="currentPage" value=""/> 
				
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="5%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="15%"/>
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
						<c:if test="${contactOrder.contactStatusId != contactOrderStatusEnumImplemented.id and contactOrder.contactStatusId != contactOrderStatusEnumReturnVisited.id}">
							[<a href="javascript:auditWorkContact('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">审核</a>]
						</c:if>
						<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] == GlobalConstant.USER_LIST_LOCAL and contactOrder.contactStatusId == contactOrderStatusEnumReturnVisited.id}">
							[<a href="javascript:closeContactOrder('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">关单</a>]
							[<a href="javascript:recall('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">撤回</a>]
						    [<a href="javascript:searchVisitOpinion('${contactOrder.contactFlow }');" onclick="checkedView('${contactOrder.contactFlow }');">回访记录</a>]
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