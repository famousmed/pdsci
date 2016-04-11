<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.i-trend-main-div-table th{color: #333;}
</style>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
	  <c:if test="${ empty projMap}">
	<tr>
		<th colspan="10" class="ith">
		<span>款项信息</span>
		</th>
  	</tr>
  	</c:if>
		<c:if test="${!empty fundList }">
		<col width="12%" />
        <col width="23%" />
        <col width="10%" />
        <col width="12%" />
        <col width="12%" />
        <col width="24%" />
        <tr>
	     <th>日期</th>
	     <c:if test="${not empty projMap}">
	     <th>项目名称</th>
	     </c:if>
	     <th>票号</th>
	     <th>经费类型</th>
	     <th>金额</th>
	     <th>用途</th>
	   </tr>
	   <c:forEach items="${fundList}" var="fund" varStatus="status">
		<tr <c:if test="${status.count%2==0}"> class="odd" </c:if>   >
			<td>${fund.fundDate}</td>
			<c:if test="${not empty projMap}">
			<td><a href="<s:url value='/gcp/fin/projFundList'/>?projFlow=${fund.projFlow}&deptFlag=y" title="点击查看详细">${projMap[fund.fundFlow].projShortName}</a></td>
			</c:if>
			<td>${fund.fundNo}</td>
			<td>${fund.fundTypeName}</td>
			<td>${fund.fundAmount}</td>
			<td>${fund.fundUsesName}</td>
		</tr>
	   </c:forEach>
	   </c:if>
	   <c:if test="${empty fundList }">
	   <tr><td colspan="8">无记录！</td></tr>
	   </c:if>
	</table>
</div>
