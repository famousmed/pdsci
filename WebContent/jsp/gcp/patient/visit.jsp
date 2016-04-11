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
	var patientVisitFlows = [
				<c:forEach items="${patientVisitList}" var="patientVisit">
					"${patientVisit.visitDate}",
				</c:forEach>
	                         ];
	
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
				date = moment(date).format("YYYY-MM-DD");
				if(${!hasNextVisit}){
					jboxTip("对不起!没有更多访视!");
				}else if(patientVisitFlows.indexOf(date)==-1){
					jboxOpen("<s:url value='/gcp/researcher/patientInfo'/>?beforePage=${param.beforePage}&patientFlow=${patient.patientFlow}&date="+date,"受试者信息",500,380);
				}
			},
			events: [
			         <c:forEach items="${patientVisitList}" var="patientVisit">
				         {
							title: "${patientVisit.visitName}",
							allDay: true,
							start: "${patientVisit.visitDate}",
							end: "${patientVisit.visitDate}",
							editable : false,
							url:"<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${patient.patientFlow}&visitFlow=${patientVisit.visitFlow}",
						},
						<c:if test="${!empty visitInfoMap[patientVisit.recordFlow]['recipeInfo']}">
						{
							title: "处方信息",
							allDay: true,
							start: "${patientVisit.visitDate}",
							end: "${patientVisit.visitDate}",
							editable : false,
							url:"<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${patient.patientFlow}&visitFlow=${patientVisit.visitFlow}",
						},
						</c:if>
						<c:if test="${!empty visitInfoMap[patientVisit.recordFlow]['labExam']}">
						{
							title: "理化检查",
							allDay: true,
							start: "${patientVisit.visitDate}",
							end: "${patientVisit.visitDate}",
							editable : false,
							url:"<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${patient.patientFlow}&visitFlow=${patientVisit.visitFlow}",
						},
						</c:if>
						<c:if test="${!empty visitInfoMap[patientVisit.recordFlow]['advice'] || !empty visitInfoMap[patientVisit.recordFlow]['doctorExplain']}">
						{
							title: "医生说明",
							allDay: true,
							start: "${patientVisit.visitDate}",
							end: "${patientVisit.visitDate}",
							editable : false,
							url:"<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${patient.patientFlow}&visitFlow=${patientVisit.visitFlow}",
						},
						</c:if>
					</c:forEach>
			],
		});
	}
	
	$(function(){
		renderCalendar();
	});
	
	function search(){
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function back(){
		var url = "<s:url value='/gcp/researcher/${param.beforePage}'/>";
		window.location.href = url;
	}
	
	var visitTitle = {
			"recipeInfo":"处方信息",
			"labExam":"理化检查",
			"doctorExplain":"医生说明",
	};
	function goVisitInfo(visitFlow){
		location.href = "<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${patient.patientFlow}&visitFlow="+visitFlow;
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div style="text-align: center;padding-top: 10px;">
				<b>受试者编号：</b>${patient.patientCode }&#12288;<b>受试者姓名缩写：</b>${patient.patientNamePy }&#12288;
				<b>性别：</b>${patient.sexName }&#12288;<b>年龄：</b>${patient.patientAge }&#12288;
				<b>入组日期：</b>${pdfn:transDate(patient.inDate)}&#12288;
				<input type="button" value="返&#12288;回" class="search" onclick="back();"/>
			</div>
			<div id="calendar" style="display: ;">
			</div>
		</div>
	</div>
</body>
</html>