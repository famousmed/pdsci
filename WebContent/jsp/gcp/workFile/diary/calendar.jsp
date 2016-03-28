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
	width: 100%;
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
		firstDay:7,
		editable: true,
		timeFormat: 'H:mm',
		axisFormat: 'H:mm',
		lang:"zh-cn",
		dayClick:function(date, allDay, jsEvent, view) { 
			jboxOpen("<s:url value='/gcp/workFile/editDiary'/>?date="+moment(date).format("YYYY-MM-DD"),"添加工作日志",700,350);
		},
		/* eventClick:function(date, allDay, jsEvent, view) { 
			jboxOpen("<s:url value='/gcp/workFile/editDiary'/>?diaryFlow=${diary.diaryFlow}","修改工作日志",700,350);
		}, */
		events: [
	         <c:forEach items="${diaryList}" var="diary">
		    	{
					title: '\n\r${diary.diaryTitle}',
					allDay: false,
					start: '${diary.diaryDate}'+' '+'${diary.startTime}',
					end: '${diary.diaryDate}'+' '+'${diary.endTime}',
					editable : false,
					url:"javascript:edit('${diary.diaryFlow}')",
				},
             </c:forEach>
		]
	});
}

function edit(diaryFlow){
	jboxOpen("<s:url value='/gcp/workFile/editDiary'/>?diaryFlow="+diaryFlow,"修改工作日志",700,400);
}

$(function(){
	renderCalendar();
});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div id="calendar">
		</div>
	</div>
</div>
</body>
</html>