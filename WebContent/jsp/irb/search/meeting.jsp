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
var width=(window.screen.width)*0.7;
var height=(window.screen.height)*0.7;

	function search(){
		$("#searchForm").submit();
	}
	function showMeeting(meetingFlow){
		jboxOpen("<s:url value='/irb/meeting/agenda'/>?meetingCheck=${GlobalConstant.FLAG_Y}&meetingFlow=" + meetingFlow, "会议信息", width, height);
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/meetingSearch"/>" method="post">
				<p>
					&#12288;会议日期：
					<input type="text" name="meetingStartDate" value="${param.meetingStartDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime xltext" style="margin-right: 0px;"/>
					~ <input type="text" name="meetingEndDate" value="${param.meetingEndDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime xltext" />
					<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
				</p><br/>
		
				<table class="xllist">
					<thead>
						<tr>
							<th width="10%" >会议日期</th>
							<th width="20%" >主持人</th>
							<th width="10%" >会议开始时间</th>
							<th width="15%" >会议结束时间</th>
							<th width="20%" >会议地点</th>
							<th width="10%" >审查项目数</th>
							<th width="10%" >参会人员数</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${! empty meetingList}">
					<c:forEach items="${meetingList}" var="meeting">
						<tr>
							<td>
								[<a href="javascript:void(0)" onclick="showMeeting('${meeting.meetingFlow}');">${meeting.meetingDate}</a>]
							</td>
							<td>${meeting.meetingHost}</td>
							<td>${meeting.meetingStartTime}</td>
							<td>${meeting.meetingEndTime}</td>
							<td>${meeting.meetingAddress}</td>
							<td>
								${empty meetingMap[meeting.meetingFlow].size()?0:meetingMap[meeting.meetingFlow].size() }
							</td>
							<td>
								${empty meetingUserMap[meeting.meetingFlow].size()?0:meetingUserMap[meeting.meetingFlow].size()}
							</td>
						</tr>
					</c:forEach>
					</c:if>		
					</tbody>
					<c:if test="${empty meetingList }"> 
						<tr> 
							<td align="center" colspan="7">无记录</td>
						</tr>
					</c:if>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
</html>