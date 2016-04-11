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
function doClose(){
	jboxClose();
}
function reload(){
	window.location.reload();
}
function save(){
	var saveForm = $("#saveForm");
	if(saveForm.validationEngine("validate")){
		var url="<s:url value='/irb/meeting/saveMinutes'/>";
		var requestData = saveForm.serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				reload();
			}
		},null,true);
	}
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="saveForm">
		<table class="xllist nofix">
			<thead>
				<tr>
					<th style="text-align: left;" >&#12288;审查概要</th>
				</tr>
				<tr>
					<td>
					<textarea name="reportMinutes" rows="5" style="width: 100%" class="validate[required] text-input" >${form.reportMinutes}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button">
			<input type="hidden" name="irbFlow" value="${param.irbFlow}"/>
			<c:if test="${meeting.meetingStatus!=GlobalConstant.FLAG_Y && empty param.meetingCheck}"><input type="button" class="search" onclick="save();" value="保&#12288;存"></c:if>
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
	</form>
	</div>
	</div>
</div>
</body>
</html>