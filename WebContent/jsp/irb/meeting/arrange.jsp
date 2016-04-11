<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_fullcalendar" value="true"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
#calendar {
	width: 900px;
	margin: 40px auto;
}
</style>
<script type="text/javascript">
function renderCalendar() {
	$('#calendar').fullCalendar({
		buttonText: {
			prev: '<',
			next: '>',
			today: '今天',
			month: '月',
			week: '周',
			day: '天'
		},
		allDayText: '全天',
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		firstDay:1,
		editable: true,
		timeFormat: 'H:mm',
		axisFormat: 'H:mm',
		lang:"zh-cn",
		dayClick:function( date, allDay, jsEvent, view ) { 
			jboxOpen("<s:url value='/irb/meeting/addMeeting'/>?date="+
					moment(date).format("YYYY-MM-DD"),"添加会议",400,250);},
		events: [
		         <c:forEach items="${meetingList}" var="meeting" >
			    	{
						title: '${meeting.meetingAddress}\n\r${meeting.meetingHost}\n\r${meeting.irbName}',
						allDay: false,
						start: '${meeting.meetingDate}'+' '+'${meeting.meetingStartTime}',
						end: '${meeting.meetingDate}'+' '+'${meeting.meetingEndTime}',
						editable : false,
						url:"<s:url value='/irb/meeting/agenda'/>?meetingFlow=${meeting.meetingFlow}",
					},
             </c:forEach>
		]
	});
}

$(function(){
	renderCalendar();
	if ("meetingList" == "${type}") {
		meetingList();
	}
});

function calendar(){
	$("#meetingButton").css("display","");
	$("#calendarButton").css("display","none");
	$("#meetingList").css("display","none");
	$("#calendar").css("display","");
}

function meetingList(){
	$("#calendarButton").css("display","");
	$("#meetingButton").css("display","none");
	$("#calendar").css("display","none");
	$("#meetingList").css("display","");
}

function search(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function addMeeting(){
	jboxOpen("<s:url value='/irb/meeting/addMeeting'/>?type=meetingList" ,"添加会议", 400,250); 
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div style="text-align: right;padding-top: 10px;">
				<input type="button" value="切换列表" class="search" id="meetingButton" onclick="meetingList();" style="display: "/>
				<input type="button" value="切换试图" class="search" id="calendarButton" onclick="calendar();" style="display: none"/>&#12288;
			</div>
			<div id="calendar" style="display: ;">
			</div>
			<div id="meetingList" style="display: none;">
				<form id="searchForm" action="<s:url value="/irb/meeting/meetingList" />" method="post">
					<p>
						会议状态：
						<select name="meeting.meetingStatus" class="xlselect">
							<option value="" <c:if test="${empty param['meeting.meetingStatus']}">selected="selected"</c:if> >全部</option>
							<option value="N" <c:if test="${param['meeting.meetingStatus']=='N'}">selected="selected"</c:if> >未结束</option>
							<option value="Y" <c:if test="${param['meeting.meetingStatus']=='Y'}">selected="selected"</c:if> >已结束</option>
						</select>
						会议时间：<input type="text" name="meeting.meetingDate"  class="ctime" style="width: 150px" value="${param['meeting.meetingDate'] }"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />~ <input type="text" name="meetingEndDate" value="${param.meetingEndDate }" class="ctime" style="width:150px"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						<input type="button" class="search" value="查&#12288;询" onclick="search()"/>
						<input type="button" class="search" value="新&#12288;增" onclick="addMeeting()"/>
					</p>
				</form><br/>
				<table class="xllist nofix">
					<thead>
						<tr>
							<th width="10%" >状态</th>
							<th width="10%" >会议日期</th>
							<th width="10%" >会议时间</th>
							<th width="25%" >会议地点</th>
							<th width="10%" >主持人</th>
							<th width="5%" >操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${meetingList}" var="meeting">
							<tr>
								<td><c:if test="${empty meeting.meetingStatus }">未结束</c:if><c:if test="${meeting.meetingStatus==GlobalConstant.FLAG_Y }"><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>已结束</c:if></td>
								<td>${meeting.meetingDate }</td>
								<td>${meeting.meetingStartTime }-${meeting.meetingEndTime }</td>
								<td>${meeting.meetingAddress }</td>
								<td>${meeting.meetingHost }</td>
								<td>[<a href="<s:url value='/irb/meeting/agenda'/>?meetingFlow=${meeting.meetingFlow}">进入</a>]</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>