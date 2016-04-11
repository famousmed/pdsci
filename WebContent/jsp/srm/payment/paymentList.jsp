 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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

function getDetail(fundFlow ,schemeFlow ,projFlow) {
	var url ="<s:url value='/srm/payment/getDetailByFundFlow?fundFlow='/>"+ fundFlow + "&schemeFlow=" + schemeFlow+"&projFlow="+projFlow;
	var w = $('#mainright').width();
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'报销明细',w,400);
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

</script>


</head>
<body>
<div class="mainright" id="mainright">
   <div class="content">
   
       <div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/payment/list"/>" method="post">
				<p>
					项目名称：	
					<input class="xltext" style="width: 150px" name="projName" type="text" value="${ param.projName}"/>
					
					<input class="search" type="button" value="查&nbsp;&nbsp;询" onclick="search()"/>
				</p>
			</form>
        </div>
        
		<table class="xllist">
		<tr>
			<th>项目名称</th>
			<th width="170px;">项目类型</th>
			<th width="120px;">预算总经费(万元)</th>
			<th width="120px;">到账金额(万元)</th>
			<th width="120px;">已报销金额(万元)</th>
			<th width="120px;">到账余额(万元)</th>
			<th width="80px;">未通过</th>
			<th width="80px;">操作</th>
		</tr>
		
		<c:forEach items="${fundInfoList}" var="fundInfo">
		<tr>
			<td>${fundInfo.project.projName}</td>
			<td>${fundInfo.project.projTypeName}</td>
			<td>${fundInfo.fund.budgetAmount}</td>
			<td>${fundInfo.fund.realityAmount}</td> 
			<td>${fundInfo.fund.yetPaymentAmount}</td> 
			<td>${fundInfo.fund.realityBalance}</td> 
			<td>${noApproveMap[fundInfo.fund.fundFlow]}</td>
			<td>
				<%--点击报销，页面下方弹出报销明细界面 --%>
				<a href="javascript:void(0)" onclick="getDetail('${fundInfo.fund.fundFlow }','${fundInfo.fund.schemeFlow}' , '${fundInfo.project.projFlow}');">报销</a>
			</td>
		</tr>
		</c:forEach>

		</table>
   </div> 	
 </div>
</body>
</html>