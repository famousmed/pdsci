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
function saveIrbMeeting() {
	if(false==$("#meetingForm").validationEngine("validate")){
		return ;
	}
	jboxPost('<s:url value='/irb/meeting/addMeeting'/>' , $('#meetingForm').serialize() , function(){
		if ("meetingList"=="${param.type}") {
			window.parent.frames['mainIframe'].location.href = "<s:url value='/irb/meeting/arrange'/>?type=${param.type}";
		} else {
			window.parent.frames['mainIframe'].location.reload(true);
		}
		jboxClose();
	} , null , true);
}
</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<form id="meetingForm">
		<input type="hidden" name="meetingFlow" value="${meeting.meetingFlow}"/>
		<table class="xllist" width="400px">
			<thead>
				<tr>
					<td >会议日期</td>
					<td style="text-align: left">&nbsp;&nbsp;
						<c:if test="${empty meeting.meetingDate}">
							<c:if test="${!empty param.date}">
								${param.date}
								<input type="hidden" name="meetingDate" value="${param.date}"/>
							</c:if>
							<c:if test="${empty param.date}">
								<input style="width: 180px;" name="meetingDate" value="${pdfn:getCurrDate() }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime"  type="text"/>
							</c:if>
						</c:if>
						<c:if test="${!empty meeting.meetingDate}">
							<input style="width: 180px;" name="meetingDate" value="${meeting.meetingDate}" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime"  type="text"/>
						</c:if>
						
					</td>
				</tr>
				<tr>
					<td  >会议时间</td>
					<td style="text-align: left">&#12288;<input type="text" name="meetingStartTime" value="${meeting.meetingStartTime}" style="width: 50px" class="validate[required]" onClick="WdatePicker({dateFmt:'HH:mm'})"  />
					~&nbsp;&nbsp;<input type="text" style="width: 50px"  name="meetingEndTime" value="${meeting.meetingEndTime}" onClick="WdatePicker({dateFmt:'HH:mm'})" class="validate[required]" />
					</td>
				</tr>
				<tr>
					<td  >主持人</td>
					<td style="text-align: left">&#12288;<input type="text" name="meetingHost" value="${meeting.meetingHost}" class="validate[required]" style="width: 180px"/></td>
				</tr>
				<tr>
					<td  >会议地点</td>
					<td style="text-align: left">&#12288;<input type="text"  name="meetingAddress" value="${meeting.meetingAddress}" class="validate[required]" style="width: 180px"/></td>
				</tr>
				<tr>
					<td  >伦理委员会</td>
					<td style="text-align: left">&nbsp;&nbsp;
						<select name="irbInfoFlow" style="width: 184px;" 
								<c:if test="${! empty meeting.meetingFlow}">disabled="disabled"</c:if>
								>
							<c:forEach items="${irbInfoList}" var="irbInfo">
								<option value="${irbInfo.recordFlow}" 
									<c:if test="${irbInfo.recordFlow eq meeting.irbInfoFlow}">selected="selected"</c:if>
									>${irbInfo.irbName}</option>
								
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="button">
					<input type="button" class="search" value="保&#12288;存" onclick="saveIrbMeeting();" />
					<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
		</div>
	</div>
	</div>
</body>
</html>