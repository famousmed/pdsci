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
	<jsp:param name="jquery_cxselect" value="false"/>
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
	form.submit();
}
	
function refresh(pickType,checked){
	if(checked==false){
		pickType = "";
	}
	window.location.href="<s:url value='/erp/report/contractDatePick'/>?pickType="+pickType;
}
	
function customerInfo(customerFlow){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/customerInfo'/>?customerFlow=" + customerFlow+"&type=open";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'客户详细信息',w,h,null,false);
}
	
function contractInfo(contractFlow) {
	$("#prevContractFlow").val($("#sub_"+contractFlow).val());
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/erp/crm/contractInfo'/>?contractFlow=" + contractFlow+"&type=open&status=messager";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'合同详细信息',w,h,null,false);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="title1 clearfix">
		<form id="searchForm" action="<s:url value="/erp/report/contractDateRemind"/>" method="post">
			&#12288;维护到期日：
			<input type="text" name="startDate" value="${startDate}" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;margin: 0;" readonly="readonly"/>&nbsp;~&nbsp;
			<input type="text" name="endDate" value="${endDate}" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" readonly="readonly"/>
         	<input type="checkbox" id="week" name="pickType" value="week" <c:if test="${pickType == 'week' or empty pickType}">checked</c:if> onchange="refresh('week',this.checked);"/><label for="week">&nbsp;一周内</label>&nbsp;
         	<input type="checkbox" id="month"  name="pickType" value="month" <c:if test="${pickType == 'month' }">checked</c:if> onchange="refresh('month',this.checked);"/><label for="month">&nbsp;一月内</label>
			<input type="checkbox" id="season" name="pickType" value="season" <c:if test="${pickType == 'season' }">checked</c:if> onchange="refresh('season',this.checked);"/><label for="season">&nbsp;三个月内</label>&nbsp;
         	<input type="checkbox" id="halfYear" name="pickType" value="halfYear" <c:if test="${pickType == 'halfYear' }">checked</c:if> onchange="refresh('halfYear',this.checked);"/><label for="halfYear">&nbsp;半年内</label>&nbsp;
         	<input type="button" class="search" onclick="search();" value="查&#12288;询" />
         	<input id="currentPage" type="hidden" name="currentPage" value=""/> 
         	&#12288;注：<font color="red">红色</font>为维护已到期合同
		</form>
	</div>
	<div class="content">
		<table class="xllist" >
				<colgroup>
					<col width="9%"/>
					<col width="13%"/>
					<col width="17%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="7%"/>
					<col width="9%"/>
					<col width="9%"/>
					<col width="8%"/>
				</colgroup>
				<tr>
					<th>合同号</th>
					<th>客户名称</th>
					<th>合同名称</th>
					<th>合同类别</th>
					<th>合同类型</th>
					<th>签订部门</th>
					<th>负责人</th>
					<th>签订日期</th>
					<th>维护到期日</th>
					<th>合同状态</th>
				</tr>
				<c:forEach items="${contractList}" var="contractExt">
					<tr <c:if test="${contractExt.maintainDueDate < pdfn:getCurrDate() }">style="background-color: #FDDDDD;"</c:if>>
						<td>${contractExt.contractNo }</td>
						<td><a href="javascript:customerInfo('${contractExt.customer.customerFlow }')">${contractExt.customer.customerName }</a></td>
						<td><a href="javascript:contractInfo('${contractExt.contractFlow }')">${contractExt.contractName}</a></td>
						<td>${contractExt.contractCategoryName}</td>
						<td>${contractExt.contractTypeName }</td>
						<td>${contractExt.signDeptName }</td>
						<td>${contractExt.chargeUserName }</td>
						<td>${contractExt.signDate }</td>
						<td>${contractExt.maintainDueDate }</td>
						<td>${contractExt.contractStatusName }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty contractList}"> 
					<tr> 
						<td align="center" colspan="10">无记录</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(contractList)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</div>
</div>
</body>
</html>