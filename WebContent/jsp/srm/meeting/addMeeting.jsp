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
function saveMeeting(){
	if($("#meetingForm").validationEngine("validate")){
		var url = "<s:url value='/srm/meeting/save'/>";
		jboxStartLoading();
		jboxPost(url , $('#meetingForm').serialize() , function(){
			 window.parent.frames['mainIframe'].window.fnMthChange();
			doClose();
		} , null , true);
	}
}
function doClose() 
{
	jboxClose();
}
</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<form id="meetingForm" method="post" action="<s:url value='/srm/meeting/save'/>">
		<table class="basic" width="500px">
			<thead>
				<tr>
					<th>会议日期</th>
					<td style="text-align: left"><input type="text" name="meetingDate" value="${param.date}" readonly="readonly" class="validate[required] xltext"/></td>
				</tr>
				<tr>
					<th>会议时间</th>
					<td style="text-align: left"><input name="meetingStartTime" type="text"  style="width: 50px" onClick="WdatePicker({dateFmt:'HH:mm'})" class="validate[required] xltext"/>
						~
						<input name="meetingEndTime" type="text" style="width: 50px"  onClick="WdatePicker({dateFmt:'HH:mm'})" class="validate[required] xltext"/>
					</td>
				</tr>
				<tr>
					<th>会议地点</th>
					<td style="text-align: left"><input name="meetingAddress" type="text" style="width: 200px" class="validate[required,maxSize[50]] xltext"/>(小于50个字)</td>
				</tr>
				<tr>
					<th>会议主题</th>
					<td style="text-align: left"><input name="groupName" type="text" style="width: 200px" class="validate[required,maxSize[20]] xltext"/>(小于20个字)</td>
				</tr>
			</tbody>
		</table>
		<div class="button" style="width: 500px;">
					<input type="button" class="search" value="保&#12288;存" onclick="saveMeeting();"/>
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
		</form>
	</div>
	</div>
</body>
</html>