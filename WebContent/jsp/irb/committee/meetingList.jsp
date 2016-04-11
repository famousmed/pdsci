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
		jboxStartLoading();
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/committee/meetingList" />" method="post">
				<p>
					会议状态：
					<select name="meeting.meetingStatus" class="xlselect">
						<option value="" <c:if test="${empty param['meeting.meetingStatus']}">selected="selected"</c:if> >全部</option>
						<option value="N" <c:if test="${param['meeting.meetingStatus']=='N'}">selected="selected"</c:if> >未结束</option>
						<option value="Y" <c:if test="${param['meeting.meetingStatus']=='Y'}">selected="selected"</c:if> >已结束</option>
					</select>
					会议时间：<input type="text" name="meeting.meetingDate"  class="ctime" style="width: 150px" value="${param['meeting.meetingDate'] }"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />~ <input type="text" name="meetingEndDate" value="${param.meetingEndDate }" class="ctime" style="width:150px"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					<input type="button" class="search" value="查&#12288;询" onclick="search()"/>
				</p>
			</form><br/>
		<table class="xllist">
			<thead>
				<tr>
					<th width="10%" >状态</th>
					<th width="10%" >会议日期</th>
					<th width="10%" >会议时间</th>
					<th width="25%" >会议地点</th>
					<th width="10%" >主持人</th>
					<th width="10%" >会议报告项目数</th>
					<th width="10%" >会议审查项目数</th>
					<th width="5%" >操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${mFormList}" var="form">
					<tr>
						<td><c:if test="${empty form.meeting.meetingStatus }">未结束</c:if><c:if test="${form.meeting.meetingStatus==GlobalConstant.FLAG_Y }"><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>已结束</c:if></td>
						<td>${form.meeting.meetingDate }</td>
						<td>${form.meeting.meetingStartTime }-${form.meeting.meetingEndTime }</td>
						<td>${form.meeting.meetingAddress }</td>
						<td>${form.meeting.meetingHost }</td>
						<td>${form.fastCount }</td>
						<td>${form.meetingCount }</td>
						<td>[<a href="<s:url value='/irb/meeting/agenda'/>?meetingCheck=${GlobalConstant.FLAG_Y}&meetingFlow=${form.meeting.meetingFlow}">进入</a>]</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
</div>
</body>
</html>