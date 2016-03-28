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
function add() {
	jboxOpen("<s:url value='/sys/user/edit'/>","新增实验信息", 900, 300);
}
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit?userFlow='/>"+ userFlow,"编辑实验信息", 900, 300);
}
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
		monthNames: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
		dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
		header: {
			left: 'prev,next today',
			center: 'title',
			right: 'month,agendaWeek,agendaDay'
		},
		defaultDate: new Date(),
		lang: 'zh-cn',
		buttonIcons: false, // show the prev/next text
		weekNumbers: false,
		editable: true,
		events: [
			{
				title: '不可预约',
				start: '2014-06-06',
				textColor : 'red',
				editable : false,
			},
			{
				title: '可预约\n\r数量 2',
				start: '2014-06-07',
			},
			{
				title: '可预约\n\r数量1',
				start: '2014-06-08',
			},
			{
				title: '可预约\n\r数量 3',
				start: '2014-06-09',
			},
			{
				title: '可预约\n\r数量 1',
				start: '2014-06-10',
			},
			{
				title: '不可预约',
				start: '2014-06-11',
				textColor : 'red',
				editable : false,
			},
			{
				title: '不可预约',
				start: '2014-06-11',
				textColor : 'red',
				editable : false,
			}
		]
	});
}

$(function(){
	renderCalendar();
});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div id="calendar"></div>
		</div>
	</div>
</body>
</html>