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
$(document).ready(function(){
	loadCustomer("${param.customerFlow}");
	loadUserList("${param.customerFlow}");
});

function doBack(){
	if ("add"=="${param.source}") {
		window.parent.frames["mainIframe"].window.location.reload();
	} else {
		var page = $("#currentPage2",window.top.frames["mainIframe"].document).val();
		if(page==null){
			page=1;
		}
		window.parent.frames["mainIframe"].window.toPage(page);
	}
	jboxCloseMessager();
}

function editCustomer(customerFlow) {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	if (width >1100) {
		width = 1100;
	}
	jboxOpen("<s:url value='/erp/crm/editCustomer'/>?customerFlow="+customerFlow,"编辑客户信息", width, 520);
}

function editCustomerUserList() {
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	if (width >1100) {
		width = 1100;
	}
	jboxOpen("<s:url value='/erp/crm/editCustomerUserList'/>?customerFlow=${param.customerFlow}","编辑联系人信息", width, 520);
}

function searchUserList(){
	var deptName = $("input[name='deptName']").val().trim();
	$("input[name='deptName']").val(deptName);
	var userName = $("input[name='userName']").val().trim();
	$("input[name='userName']").val(userName);
	var url = "<s:url value='/erp/crm/customerUserList'/>"; 
	jboxPostLoad("userListDiv", url , $("#searchForm").serialize(), false);
}

function disableUser(obj, userFlow, recordStatus, userName) {
	var msg = "停用";
	if(recordStatus == '${GlobalConstant.RECORD_STATUS_Y}'){
		msg = "启用";
	}
	msg = "确认" + msg + "联系人&nbsp;<b>"+userName+"</b>&nbsp;" + "吗？";
	jboxConfirm(msg,function () {
		var url = "<s:url value='/erp/crm/disableUser'/>?userFlow=" + userFlow + "&recordStatus=" + recordStatus;
		jboxPost(url, null,
				function(resp){
					if(resp == "${GlobalConstant.OPERATE_SUCCESSED}"){
						searchUserList();
						jboxTip("${GlobalConstant.OPERATE_SUCCESSED}"); 
					}
				},null,false);	
	});
}

function editCustomerUser(userFlow){
	var title = "新增";
	var	url = "<s:url value='/erp/crm/editCustomerUser'/>?customerFlow=${param.customerFlow}";
	if("" != userFlow){
		title = "编辑";
		url = url + "&userFlow=" + userFlow ;
	}
	jboxOpen(url, title + "联系人信息", 650, 400);
}

function loadCustomer(customerFlow){
	var url="";
	if('${empty param.type}'=="false"){
		url = "<s:url value='/erp/crm/customer'/>?customerFlow="+customerFlow+"&type=open";
	}else{
		url = "<s:url value='/erp/crm/customer'/>?customerFlow="+customerFlow;
	}
	jboxLoad("customerDiv", url, true);
}
function loadUserList(customerFlow){
	var url="";
	if('${empty param.type}'=="false"){
		url = "<s:url value='/erp/crm/customerUserList'/>?customerFlow="+customerFlow+"&type=open";
	}else{
		url = "<s:url value='/erp/crm/customerUserList'/>?customerFlow="+customerFlow;
	}
	
	jboxLoad("userListDiv", url, true);
}

function deleteCustomerUser(userFlow, userName){
	var msg = "确认删除联系人&nbsp;<b>"+userName+"</b>&nbsp;" + "吗？";
	jboxConfirm(msg, function() {
		var url = "<s:url value='/erp/crm/deleteCustomerUser'/>?userFlow=" + userFlow;
		jboxPost(url, null,
				function(resp){
					if(resp == "${GlobalConstant.DELETE_SUCCESSED}"){
						searchUserList();
						jboxTip("${GlobalConstant.DELETE_SUCCESSED}"); 
					}
				},null,false);
	});
}

function markUser(userFlow,customerFlow){
	var	url = "<s:url value='/erp/crm/markUser'/>?userFlow="+userFlow+"&customerFlow="+customerFlow;
	jboxOpen(url, "标注联系人", 1000, 500,false);
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent" >
			<div class="tagContent selectTag" id="tagContent0">
				
				<div id="customerDiv">
					<!-- 客户信息 -->
				</div>
				<table cellpadding="0" cellspacing="0" class="xllist" style="width: 100%;border-top: 0px;">
				<tr>
					<th style="text-align: left;padding-left: 10px">联系人信息
						<c:if test="${param.type!='open' }">
						 <img title="编辑" src="<s:url value="/css/skin/${skinPath}/images/gcp_main_edit.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="editCustomerUserList()"/>
						 <img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="editCustomerUser('');"/>
					     </c:if>
				     </th>
				</tr>
				<c:if test="${param.type!='open' }">
				<tr>
					<th style="text-align: left;padding-left: 10px">
						<form id="searchForm" method="post">
							<input type="hidden" name="customerFlow" value="${param.customerFlow}"/>
							科室：<input type="text" name="deptName" value="${param.deptName}" style="width: 100px;"/>&#12288;
							姓名：<input type="text" name="userName" value="${param.userName}" style="width: 100px;"/>&#12288;
							<img title="点击查询" src="<s:url value="/css/skin/${skinPath}/images/search.gif" />" style="cursor: pointer;" onclick="searchUserList()" />
						</form>
					</th>
				</tr>
				</c:if>
				</table>
				
				<div id="userListDiv">
					<!-- 联系人 -->
				</div>
				<div class="button" style="width: 100%;">
				   <c:choose>
				     <c:when test="${param.type!='open' }">
					<input class="search" type="button" value="关&#12288;闭" onclick="doBack();" />
				     </c:when>
				     <c:otherwise>
				       <c:if test="${param.no=='third' }">
				          <input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
				       </c:if>
				       <c:if test="${empty param.no }">
				          <input class="search" type="button" value="关&#12288;闭" onclick="jboxCloseMessager();"/>
				       </c:if>
				       
				     </c:otherwise>
				   </c:choose>
				</div>
								
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>