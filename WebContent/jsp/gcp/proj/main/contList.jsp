<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.i-trend-main-div-table th{color: #333;}
</style>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<c:if test="${!empty contList }">
		<col width="7%" />
        <col width="20%" />
        <col width="15%" />
        <col width="12%" />
        <col width="12%" />
        <col width="8%" />
        <col width="8%" />
        <col width="10%" />
        <tr>
	     <th>序号</th>
	     <th>项目名称</th>
	     <th>合同名称</th>
	     <th>合同类型</th>
	     <th>合同经费</th>
	     <th>合同份数</th>
	     <th>合同例数</th>
	     <th>盖章日期</th>
	   </tr>
	   <c:forEach items="${contList}" var="cont" varStatus="status">
		<tr <c:if test="${status.count%2==0}"> class="odd" </c:if>   >
			<td>${status.count}</td>
			<td><a href="<s:url value='/gcp/fin/projList'/>?projFlow=${cont.projFlow}" title="点击查看详细">${cont.projShortName}</a></td>
			<td>${cont.contractName}</td>
			<td>${cont.contractTypeName}</td>
			<td>${cont.contractFund}</td>
			<td>${cont.contractCopies}</td>
			<td>${cont.caseNumber}</td>
			<td>${cont.stampDate}</td>
		</tr>
	   </c:forEach>
	   </c:if>
	   <c:if test="${empty contList }">
	   <tr><td colspan="8">无记录！</td></tr>
	   </c:if>
	</table>
</div>
