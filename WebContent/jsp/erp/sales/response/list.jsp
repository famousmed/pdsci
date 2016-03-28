<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
function search(){
	
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}

function add() {
	var w = $('.mainright').width();
	var h = $('.mainright').height()*0.5;
	var url = "<s:url value='/erp/sales/editResponse'/>";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'新增来电记录',800,h,null,false);
}

function edit(contactFlow) {
	var w = $('.mainright').width();
	var url = "<s:url value='/erp/sales/editResponse'/>?type=edit";
	if('${sessionScope[GlobalConstant.USER_LIST_SCOPE] }'=='personal'){
		var h = $('.mainright').height()*0.5;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'编辑来电记录',800,h,null,false);
	}else{
		var h = $('.mainright').height()*0.8;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'编辑来电记录',800,h,null,false);
	}
	
}

/* function info(contactFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/erp/sales/contactOrderInfo'/>?contactFlow="+contactFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'查看工作联系单',w,h,null,false);
}
 */

function customerInfo(customerFlow) {
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow="+customerFlow+"&type=open";
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
	if('${GlobalConstant.USER_LIST_GLOBAL}'=='${sessionScope[GlobalConstant.USER_LIST_SCOPE]}'){
	    searchDeptUser($("#applyDeptFlow"));
	}
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
				<form id="searchForm" action="<s:url value="/erp/sales/contactOrderList/${sessionScope[GlobalConstant.USER_LIST_SCOPE] }" />" method="post">
				<input type="hidden" id="currentPage" name="currentPage" value=""/>
				<input type="hidden" id="checkContactFlow" name="checkContactFlow" value="${param.checkContactFlow }"/>
				<div style="padding-bottom: 10px;">
				客户名称：&nbsp;<input type="text" name="customerName" placeholder="客户名称/别名" value="${param.customerName }" class="xltext"/>
					记录状态：<select class="xlselect" style="width: 125px;" id="responseStatusId" name="responseStatusId">
				            	<option value="">请选择</option>
				             	<c:forEach var="responseStatus" items="${responseStatusEnumList}">
						            <option value="${responseStatus.id}" <c:if test="${param.responseStatusId eq responseStatus.id }">selected</c:if>>${responseStatus.name}</option>
						        </c:forEach>
							</select>
							<input type="hidden" name="contactStatusName" id="contactStatusName" value="${param.contactStatusName }"/>
				            <input type="button" class="search" onclick="search();" value="查&#12288;询" >
				            <c:if test="${GlobalConstant.USER_LIST_LOCAL != sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
					        <input type="button" class="search" onclick="add();" value="新&#12288;增" >
					        </c:if>
				</div>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="3%"/>
					<col width="17%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>客户名称</th>
					<th>响应状态</th>
					<th>记录人</th>
					<th>记录时间</th>
					<th>响应人</th>
					<th>响应时间</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				  <c:if test="${GlobalConstant.USER_LIST_LOCAL != sessionScope[GlobalConstant.USER_LIST_SCOPE]}">
				   <tr>
				     <td>1</td>
				     <td>江苏省中医院</td>
				     <td>未提交</td>
				     <td>超级管理员</td>
				     <td>2015-04-28 10:01</td>
				     <td>老王</td>
				     <td>2015-04-28 10:03</td>
				     <td>
				        <a href="javascript:edit();">[编辑]</a>|
				        <a href="javascript:delete();">[删除]</a>|
				        <a href="javascript:submit();">[提交]</a>
				     </td>
				   </tr>
				   </c:if>
				   <tr>
				     <td>2</td>
				     <td>江苏省中医院</td>
				     <td>未响应</td>
				     <td>超级管理员</td>
				     <td>2015-04-28 10:04</td>
				     <td>老赵</td>
				     <td>2015-04-28 10:05</td>
				     <td><a href="javascript:edit();">[详情]</a></td>
				   </tr>
				</tbody>
			</table>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView(contactOrderList)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p>
	</div>
</div>
</body>
</html>