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
	width: 800px;
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
			left: 'prev,today,next',
			center: 'title',
			right: ''
		},
		firstDay:1,
		editable: true,
		timeFormat: 'H:mm',
		axisFormat: 'H:mm',
		lang:"zh-cn",
		dayClick:function( date, allDay, jsEvent, view ) { 
			jboxOpen("<s:url value='/srm/meeting/add'/>?date="+	moment(date).format("YYYY-MM-DD"),"添加会议",500,250);},
		events: []  
	});
}
function fnMthChange() {  
	var view = jQuery('#calendar').fullCalendar('getView');  
	var startDate = moment(view.start).format("YYYY-MM-DD");
	var endDate = moment(view.end).format("YYYY-MM-DD");
	$("#calendar").fullCalendar('removeEvents');  
	var url ="<s:url value='/srm/meeting/getMeetingDataJson'/>?startDate="+startDate+"&endDate="+endDate;
	jboxStartLoading();
	jboxPost(url,null,function(data){
		for(var i=0;i<data.length;i++) {   
			var obj = new Object();     
			obj.title = data[i].groupName;
			obj.allDay = false;
			obj.start = data[i].meetingDate+" "+data[i].meetingStartTime;
			obj.end = data[i].meetingDate+" "+data[i].meetingStartTime;
			obj.editable  = false;
			obj.url = "<s:url value='/srm/meeting/process?groupFlow='/>"+data[i].groupFlow;
			$("#calendar").fullCalendar('renderEvent',obj,true);
		}
	},null,false);
}  
$(function(){
	renderCalendar();
	fnMthChange();
	jQuery('.fc-button-prev').bind('click', fnMthChange);  
	jQuery('.fc-button-next').bind('click', fnMthChange);  
	jQuery('.fc-button-today').bind('click', fnMthChange);  
});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div id="calendar"></div>
		</div>
	</div>
	<c:forEach items="${meetingList}" var="meeting">
		${meeting.groupName}
	</c:forEach>
</body>
</html>