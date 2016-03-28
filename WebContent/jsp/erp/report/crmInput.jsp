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
	function search(){
		$("#searchForm").submit();
	}
	
	function refresh(pickType,checked){
		if(checked==false){
			pickType = "";
		}
		window.location.href="<s:url value='/erp/report/crmInputReportPick'/>?pickType="+pickType;
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="title1 clearfix">
		<form id="searchForm" action="<s:url value="/erp/report/crmInputReport"/>" method="post">
			&#12288;日期：
			<input type="text" name="startDate" value="${empty startDate?pdfn:getCurrDate():startDate}" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;margin: 0;" readonly="readonly"/>&nbsp;~&nbsp;
			<input type="text" name="endDate" value="${empty endDate?pdfn:getCurrDate():endDate}" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:100px;" readonly="readonly"/>
			<input type="checkbox" id="day" name="pickType" value="day" <c:if test="${pickType == 'day' or empty pickType }">checked</c:if>  onchange="refresh('day',this.checked);"/><label for="day">&nbsp;当天</label>&nbsp;
         	<input type="checkbox" id="week" name="pickType" value="week" <c:if test="${pickType == 'week' }">checked</c:if> onchange="refresh('week',this.checked);"/><label for="week">&nbsp;一周内</label>&nbsp;
         	<input type="checkbox" id="month"  name="pickType" value="month" <c:if test="${pickType == 'month' }">checked</c:if> onchange="refresh('month',this.checked);"/><label for="month">&nbsp;一月内</label>
			<input type="button" class="search" onclick="search();" value="查&#12288;询" />
		</form>
	</div>
	<div class="content">
		<table class="xllist" >
			<colgroup>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			</colgroup>
				<tr>
					<th>姓名</th>
					<th>部门</th>
					<th>新增客户量</th>
					<th>新增联系人量</th>
				</tr>
				<c:set var="newCustomerNums" value="0"></c:set>
				<c:set var="newCustomerUserNums" value="0"></c:set>
				<c:forEach items="${formList}" var="form">
					<c:set var="newCustomerNums" value="${newCustomerNums+form.newCustomerNum+0 }"></c:set>
					<c:set var="newCustomerUserNums" value="${newCustomerUserNums+form.newCustomerUserNum+0 }"></c:set>
					<tr>
						<td>${form.userName}</td>
						<td>${form.deptName}</td>
						<td>${form.newCustomerNum+0}</td>
						<td>${form.newCustomerUserNum+0}</td>
					</tr>
				</c:forEach>
				<c:if test="${!empty formList}"> 
					<tr>
						<td><font color="red">合计</font></td>
						<td>——————</td>
						<td>${newCustomerNums}</td>
						<td>${newCustomerUserNums}</td>
					</tr>
				</c:if>
				<c:if test="${empty formList}"> 
					<tr> 
						<td align="center" colspan="4">无记录</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>