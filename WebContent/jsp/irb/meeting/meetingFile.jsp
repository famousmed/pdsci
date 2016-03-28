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
function downMeetingRegist(){
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${param.meetingFlow}&recTypeId=meetingRegist";
	window.location.href= url;
}

function downMeetingAgenda() {
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${param.meetingFlow}&recTypeId=meetingAgenda";
	window.location.href= url;
}

function downVoteForm(irbFlow) {
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${param.meetingFlow}&irbFlow="+irbFlow+"&recTypeId=voteForm";
	window.location.href= url;
}

function doClose(){
	jboxClose();
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
<div class="title1 clearfix">
		<table class="xllist" width="100%" id="detailTable">
			<thead>
				<tr>
					<th colspan="5" style="text-align: left;">&#12288;会议审查项目</th>
				</tr>
				<tr>
					<th>序号</th><th>项目名称</th><th>伦理审查类别</th><th>受理号</th><th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${irbList }" var="irb" varStatus="statu">
					<tr>
					<td style="width: 7%;">${statu.count }</td>
					<td style="width: 40%;">${irb.projShortName }</td>
					<td style="width: 20%;">${irb.irbTypeName }</td>
					<td style="width: 14%;">${irb.irbNo }</td>
					<td style="width: 10%;">
						[<a href="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${param.meetingFlow}&irbFlow=${irb.irbFlow}&recTypeId=voteForm" title="点击下载投票单" style="color: blue">投票单</a>]
					</td>
				</tr> 
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="button" style="margin-left: 10px;margin-right: 10px;">
		<input class="search" type="button" value="下载会议议程" onclick="downMeetingAgenda();" />
		<input class="search" type="button" value="下载签到表" onclick="downMeetingRegist();" />
		<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
	</div>
	</div>
</div>
</body>
</html>