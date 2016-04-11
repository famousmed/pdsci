<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.i-trend-main-div-table th{color: #333;}
</style>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<c:if test="${!empty meetingList }">
		<col width="12%" />
        <col width="20%" />
        <col width="30%" />
        <col width="12%" />
        <col width="20%" />
        <tr>
	     <th>会议日期</th>
	     <th>会议名称</th>
	     <th>会议地点</th>
	     <th>会议类型</th>
	     <th>主办单位</th>
	   </tr>
	   <c:forEach items="${meetingList}" var="meeting" varStatus="status">
		<tr <c:if test="${status.count%2==0}"> class="odd" </c:if>   >
			<td>${meeting.meetingDate}</td>
			<td>${meeting.meetingName}</td>
			<td>${meeting.meetingAddress}</td>
			<td>${meeting.meetingTypeName}</td>
			<td>${meeting.meetingHost}</td>
		</tr>
	   </c:forEach>
	   </c:if>
	   <c:if test="${empty meetingList }">
	   <tr><td colspan="5">无记录！</td></tr>
	   </c:if>
	</table>
</div>
