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
	function add(){
		jboxOpen("<s:url value='/pub/meeting/editMeeting${meetingType}'/>","新增会议", 800,550); 
	}
	
	function search(){
		$("#searchForm").submit();
	}
	
	function editMeeting(meetingFLow){
		jboxOpen("<s:url value='/pub/meeting/editMeeting${meetingType}'/>?meetingFlow="+meetingFLow,"编辑会议信息", 800,550);
	}
	
	function delMeeting(meetingFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/pub/meeting/delMeeting'/>?meetingFlow="+meetingFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					search();
				}
			},null,true);
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="margin-bottom: 10px">
			<form id="searchForm" action="<s:url value="/pub/meeting/search${meetingType}" />" method="Post">
					会议日期：
					<input type="text" name="startDate" value="${param.startDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" readonly="readonly" style="margin-right: 0px;width: 100px"/>~<input type="text" name="endDate"  value="${param.endDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" readonly="readonly" style="width: 100px"/> 
					会议名称：
					<input type="text" name="meetingName" value="${param.meetingName}" class="xltext"/>
					<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
					<input type="button" value="新&#12288;增" class="search" onclick="add();"/>
			</form>
			</div>
			<table class="xllist">
				<thead>
					<tr>
						<th width="15%">主办单位</th>
						<th width="20%">会议名称</th>
						<th width="10%">会议日期</th>
						<th width="20%">会议地点</th>
						<th>会议简介</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${meetingList}" var="meeting">
						<tr>
							<td>${meeting.meetingHost}</td>
							<td>${meeting.meetingName}</td>
							<td>${meeting.meetingDate}</td>
							<td>${meeting.meetingAddress}</td>
							<td>${meeting.meetingSummary}</td>
							<td>
								[<a href="javascript:editMeeting('${meeting.meetingFlow}');">编辑</a>]
								[<a href="javascript:delMeeting('${meeting.meetingFlow}');">删除</a>]
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${empty meetingList}">
					<tr><td align="center" colspan="6">无记录</td></tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
</body>
</html>