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

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}

function assignList(contactFlow){
	var $div = $("#div_"+contactFlow);
	var $content = $("#content_"+contactFlow);
	$div.slideToggle("slow", function(){
		var url = "<s:url value='/erp/implement/assignList'/>?contactFlow=" + contactFlow;
		jboxLoad("content_"+contactFlow, url, false);
 	});
}

function slideDown(contactFlow){
	var $div = $("#div_"+contactFlow);
	var $content = $("#content_"+contactFlow);
	if($.trim($content.html()) != ""){ //未展开不加载
		$div.slideDown("slow", function(){
			var url = "<s:url value='/erp/implement/assignList'/>?contactFlow=" + contactFlow;
			jboxLoad("content_"+contactFlow, url, false);
	 	});
	}
}

$(function(){
	$(".parentA").click(function(event){
        event.stopPropagation();
    });
});

function workInfo(contactFlow){
	var url = "<s:url value='/erp/sales/contactOrderInfo'/>?contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"工作联系单详情", 1000, 670, null, false);
}

function addWorkOrder(contactFlow, customerFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?type=add&contactFlow=" + contactFlow +"&customerFlow=" + customerFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"新增派工单", 840, 650, null, false);
}

function editWorkOrder(workFlow,customerFlow,contactFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?type=edit&workFlow=" + workFlow+"&customerFlow="+customerFlow+"&contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"编辑派工单", 840, 650, null, false);
}

function viewWorkOrder(workFlow,contactFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?workFlow=" + workFlow+"&contactFlow="+contactFlow+"&type=info";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"查看派工单", 840, 650, null, false);
}

function implementedAuditWorkOrder(workFlow,workStatusId,contactFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?type=assistantAudit&workFlow=" + workFlow + "&workStatusId=" + workStatusId+"&contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"审核派工单", 840, 650, null, false);
}

function visit(workFlow) {
	var url = "<s:url value='/erp/implement/editWorkOrder'/>?type=visit&workFlow=" + workFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='100%' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"客户回访", 840, 650, null, false);
}

function workOrderInfo() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=info","派工单详情", 840, 650);
}

function auditWorkOrder() {
	jboxOpen("<s:url value='/erp/implement/editWorkOrder'/>?type=assistantAudit","审核派工单", 840, 650);
}
function recall(contactFlow){
	jboxConfirm("确认将联系单召回该联系单吗？", function(){
		url="<s:url value='/erp/sales/recall'/>?contactFlow="+contactFlow;
		 jboxPost(url , null, function(resp){
			 if(resp != "${GlobalConstant.SAVE_FAIL}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					setTimeout(function(){
						window.parent.frames['mainIframe'].window.search();
					},1000);
				}
		 },null,false);
	},null);
}
function closeContactOrder(contactFlow){
	jboxConfirm("确认完后该联系单吗？", function(){
		url="<s:url value='/erp/sales/closeContact'/>?contactFlow="+contactFlow;
		 jboxPost(url , null, function(resp){
			 if(resp == "${GlobalConstant.FLAG_N}"){
				 jboxTip("该联系单下有尚未完成的派工单");
				 return false;
			 }
			 if(resp != "${GlobalConstant.SAVE_FAIL}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					setTimeout(function(){
						window.parent.frames['mainIframe'].window.search();
					},1000);
				}
		 },null,false);
	},null);
	
}
</script>
<style type="text/css">
.i-trend-main-div-table th{background: #F0FAFF;color: #1079B6;}
.ith{background-color: #f8f8f8;}
</style>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix" style="padding-bottom: 0;">
				<form id="searchForm" action="<s:url value="/erp/implement/contactOrders" />" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<div style="padding-bottom: 10px;">
					客户名称：<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName}" class="xltext"/>
					联系单状态：<select name="contactStatusId" onchange="search()" class="xlselect" style="width: 108px;">
		            	<option value="">请选择</option>
		            	<option value="${contactOrderStatusEnumReceived.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumReceived.id}">selected="selected"</c:if>>${contactOrderStatusEnumReceived.name}</option>
		            	<option value="${contactOrderStatusEnumImplementing.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumImplementing.id}">selected="selected"</c:if>>${contactOrderStatusEnumImplementing.name}</option>
		            	<option value="${contactOrderStatusEnumImplemented.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumImplemented.id}">selected="selected"</c:if>>${contactOrderStatusEnumImplemented.name}</option>
		            	<option value="${contactOrderStatusEnumClosed.id}" <c:if test="${param.contactStatusId eq contactOrderStatusEnumClosed.id}">selected="selected"</c:if>>${contactOrderStatusEnumClosed.name}</option>
					</select>
					联系单编号：<input type="text" name="contactNo" placeholder="联系单编号" value="${param.contactNo }" class="xltext"/>
				    &nbsp;&nbsp;&nbsp;需求事项：<select name="demandMatterId" onchange="search()" class="xlselect" style="width: 108px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandMatter" items="${demandMatterEnumList}">
						            <option value="${demandMatter.id}" <c:if test="${param.demandMatterId eq demandMatter.id}">selected="selected"</c:if>>${demandMatter.name}</option>
						        </c:forEach>
							</select>       
				</div>
				<div style="padding-bottom: 10px;">
				    产品/项目名称：<input type="text" name="productTypeName" placeholder="产品/项目名称" value="${param.productTypeName}" class="xltext" style="width: 130px;"/>
					
					&nbsp;&nbsp;申请时间 ：<input type="text" class="xltext ctime" name="applyDateStart" value="${param.applyDateStart}" style="width: 100px;margin:0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>&nbsp;~
					<input type="text" class="xltext ctime" name="applyDateEnd" value="${param.applyDateEnd}" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					排序条件：<select name="sortCondition" >
				              <option value="">请选择</option>
				              <option value="applyDate" <c:if test="${param.sortCondition eq 'applyDate' }">selected</c:if>>申请时间</option>
				              <option value="demandDate" <c:if test="${param.sortCondition eq 'demandDate' }">selected</c:if>>要求完成时间</option>
				           </select>
				           <select name="sortType">
				              <option value="asc" <c:if test="${empty param.sortType or param.sortType eq 'asc' }">selected</c:if>>升序</option>
				              <option value="desc" <c:if test="${param.sortType eq 'desc' }">selected</c:if>>降序</option>
				           </select>
					<input id="currentPage" type="hidden" name="currentPage"/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询" >
				</div>
				<div>
				   
				</div>
				</form>
			</div>
			
			<c:forEach items="${contactOrderList}" var="contactOrder">
			<div style="cursor: pointer; border: 1px solid #E2E2E2; margin-top:8px;
			  <c:choose>
			  <c:when test="${contactOrder.demandStatusId eq demandStateEnumUrgent.id }">background-color:#fcbdbd;</c:when>
			  <c:when test="${contactOrder.contactStatusId eq contactOrderStatusEnumReceived.id }">background-color:#fff494;</c:when>
			  <c:when test="${contactOrder.contactStatusId eq contactOrderStatusEnumImplementing.id }">background-color:#c2dfff;</c:when>
			  <c:when test="${contactOrder.contactStatusId eq contactOrderStatusEnumImplemented.id }">background-color:#d2f5b0;</c:when>
			  <c:when test="${contactOrder.contactStatusId eq contactOrderStatusEnumClosed.id }">background-color:#c9ccc4;</c:when>
			  </c:choose>" 
			   class="ith" onclick="assignList('${contactOrder.contactFlow}');">
				<table style="width: 100%;border: 0;line-height: 30px;">
					<colgroup>
						<col width="25%"/>
						<col width="20%"/>
						<col width="25%"/>
						<col width="20%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
					    <td>联系单编号：${contactOrder.contactNo }</td>
						<td>客户名称：${pdfn:cutString(contactOrder.customerName,12,true,3 )}</td>
						<td>最终使用方：${pdfn:cutString(contactOrder.consumerName,12,true,3 )}</td>
						<td>产品/项目名称：${pdfn:cutString(contactOrder.productTypeName,6,true,3 )}
						    <c:if test="${(not empty contactOrder.productTypeName) and (not empty contactOrder.orderProductName) }">、</c:if>
				            ${pdfn:cutString(contactOrder.orderProductName,6,true,3)}
						</td>
						<td rowspan="2" style="text-align:left;">
							<a class="parentA" href="javascript:void(0);" onclick="workInfo('${contactOrder.contactFlow}');" style="color: blue;"><img alt="详情" title="详情" src="<s:url value='/css/skin/${skinPath}/images/detail.png'/>"></a>&#12288;
							<c:if test="${contactOrder.contactStatusId != contactOrderStatusEnumClosed.id and contactOrder.contactStatusId != contactOrderStatusEnumReturnVisited.id and contactOrder.contactStatusId != contactOrderStatusEnumImplemented.id}">
							<a class="parentA" href="javascript:void(0);" onclick="addWorkOrder('${contactOrder.contactFlow}','${contactOrder.customerFlow}');" style="color: blue;"><img alt="新增" title="新增" src="<s:url value='/css/skin/${skinPath}/images/add7.png'/>"></a>
							&#12288;<a class="parentA" href="javascript:void(0);" onclick="closeContactOrder('${contactOrder.contactFlow}');" style="color: blue;"><img alt="完成联系单" title="完成联系单" src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"></a>
							</c:if>
							<c:if test="${contactOrder.contactStatusId == contactOrderStatusEnumImplemented.id}">
							<a class="parentA" href="javascript:void(0);" onclick="recall('${contactOrder.contactFlow}');" style="color: blue;"><img alt="召回" title="召回" src="<s:url value='/css/skin/${skinPath}/images/gcp_main_back_blue.png'/>"></a>
							</c:if>
						</td>
					</tr>
					<tr>
						<td>需求事项：${contactOrder.demandMatterName}</td>
						<td>申请人：${contactOrder.applyUserName}</td>
						<td>申请时间：${contactOrder.applyDate}</td>
						<td>联系单状态：${contactOrder.contactStatusName}</td>
					</tr>
				</table>
			</div>
			
			<div id="div_${contactOrder.contactFlow}" style="display: none;">
				<div style="border: 1px solid #E2E2E2; border-top: none; border-bottom: none;">
				<table cellpadding="0" class="i-trend-main-div-table" cellspacing="0" border="0" style="width: 100%;">
					<colgroup>
					    <col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
						<col width="20%" />
					</colgroup>
					<tr style="height: 40px;">
					    <th>派工单编号</th>
					    <th>派工时间</th>
						<th>实施工程师</th>
						<th>派工单状态</th>
						<th>操作</th>
					</tr>
					<tbody>
				        <tr>
				          <td colspan="5">
				             <div id="content_${contactOrder.contactFlow}">
				             </div>
				          </td>
				        </tr>
			      </tbody>
				</table>
				</div>
			</div>
			</c:forEach>
			
			<c:if test="${empty contactOrderList}">
			<div style="cursor: pointer; border: 1px solid #ccc; margin-top: 10px;" class="ith" onclick="assignList('${contactOrder.contactFlow}');">
				<table style="width: 100%;border: 0;line-height: 30px;">
					<tr>
						<td align="center">无记录</td>
					</tr>
				</table>
			</div>
			</c:if>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(contactOrderList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>