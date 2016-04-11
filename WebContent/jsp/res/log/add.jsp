<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
	function viewchange(type){
		$(".cat").hide();
		$("#"+type).show();
	}
	
	function renderCalendar() {
		$('#calendar').fullCalendar({
			buttonText: {
				prev: '<',
				next: '>',
				today: '今天',
				month: '月',
				week: '周',
				day: '日'
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
				jboxOpen("<s:url value='/jsp/res/log/edit.jsp'/>?date="+
						moment(date).format("YYYY-MM-DD"),"添加工作日志",700,500);},
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
	});
	function calendar(){
		$("#rec").hide();
		$("#calendar").show();
		$(".fc-button-agendaWeek").click();
	}
</script>

</head>
<body>
<body>	
   <div class="mainright" style="height: 100%;background-color: white;">
      <div class="content">
        <div class="title1 clearfix">
        <div id="calendar" style="display: none">
		</div>
		<div id="rec" style="margin-top: 5px; ">
			<table width="100%" class="basic" >
				<tr>
					<th style="text-align: left;">
						<span id="operImg" style="float: right;cursor: pointer;" onclick="editFormHidden();">
							<a href="javascript:viewchange('week');">周</a>&#12288;
							<a href="javascript:viewchange('month');">月</a>&#12288;
							<a href="javascript:viewchange('day');">日</a>&#12288;
							<a href="javascript:calendar();">日历模式</a>
						</span>
					</th>
				</tr>
			</table>
			<div class="cat" id="week" style="margin-top: 5px;"> 第：<input type="text" style="width: 50px;text-align: center;" value="12"/>&#12288;周  &#12288;&#12288;日期：<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;text-align: center;" > 至 <input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;text-align: center;" > </div>
			<div class="cat"id="month" style="margin-top: 5px;display: none"> 第：<input type="text" style="width: 50px;text-align: center;" value="12"/>&#12288;月  &#12288;&#12288;日期：<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;text-align: center;" > 至 <input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;text-align: center;" > </div>
			<div class="cat" id="day" style="margin-top: 5px;display: none"> 日期：<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 100px;text-align: center;"/></div>
			 <textarea style="border:1px solid #bdbebe;	margin-top:5px;width:100%;height: 350px;"></textarea>
			 <div style="float: left;margin-top: 5px;"><input type="button" value="保&#12288;存" onclick="add();" class="search"></div>
		</div>
		</div>
	</div></div>
</body>
</html>
