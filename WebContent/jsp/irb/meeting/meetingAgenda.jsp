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
	function downPdfMeetingAgenda() {
		var url = "<s:url value='/irb/meeting/downPdfMeetingAgenda'/>?meetingFlow=${meeting.meetingFlow}";
	 	window.location.href=url;
	}

</script>
</head>
<body>
<div class="mainright" style="height: 90%;">
	<div class="content" style="margin-left: 10px;margin-right: 10px;">
		<div>
		<div style="text-align: center;margin-top: 10px;margin-bottom: 10px;">
			<font style="font-size: 16px;">会议议程</font>
		</div>
		<div>
			<table class="basic nofix" style="width: 100%;">
				<tr>
					<th colspan="4" style="text-align: left;">&nbsp;会议信息</th>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">日期
					</td>
					<td width="30%">${meeting.meetingDate }
					</td>
					<td width="10%" style="text-align: center;">时间
					</td>
					<td width="40%">${meeting.meetingStartTime } ～ ${meeting.meetingEndTime }
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">地点
					</td>
					<td colspan="3">${meeting.meetingAddress }
					</td>
				</tr>
				<c:forEach items="${meetingUserMap}" var="entry">
					<tr>
						<td width="20%" style="text-align: center;">${entry.value[0].roleName }
						</td>
						<td colspan="3">
							<c:forEach items="${ entry.value}" var="meetingUser" varStatus="statu">
								${meetingUser.userName }<c:if test="${fn:length(entry.value)>1&& !statu.last }">、</c:if>
							</c:forEach>
						</td>
					</tr>
				</c:forEach>
				<tr>
					<td width="20%" style="text-align: center;">主持人
					</td>
					<td colspan="3">${meeting.meetingHost }
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">伦理委员会名称
					</td>
					<td colspan="3">${meeting.irbName }
					</td>
				</tr>
			</table>
		</div>
		<div style="line-height:20px;margin-top: 5px;margin-bottom: 20px;text-align: left;">
			秘书核对本次到会委员是否符合法定人数要求。主持人询问是否有与本次审查项目存在利益冲突的委员，如有，请声明。
		</div>
		</div>
		<div style="margin-top: 5px;margin-bottom: 5px;">
			一、会议报告，由秘书进行会议报告
		</div>
		<table class="basic nofix" style="width: 100%;">
			<tr>
				<th colspan="3" style="text-align: left;">
					&nbsp;（一）快速审查<c:if test="${empty fastFormList}">(无)</c:if>
				</th>
			</tr>
		</table>
		<c:set var="fastStatus" value="0"></c:set>
		 <c:forEach items="${fastFormList }" var="form">
		 <c:set var="fastStatus" value="${fastStatus+1 }"></c:set>
			<table class="basic nofix" style="width: 100%;">
					<tr>
						<td width="8%">（${fastStatus}）</td>
						<td width="20%">伦理审查类别：</td>
						<td width="72%">${form.irb.irbTypeName }</td>
					</tr>
					<tr>
						<td></td>
						<td>项目：</td>
						<td>${form.irb.projName }</td>
					</tr>
					<tr>
						<td></td>
						<td>受理号：</td>
						<td>${form.irb.irbNo }</td>
					</tr>
					<tr>
						<td></td>
						<td>主要研究者：</td>
						<td>${form.proj.applyUserName }</td>
					</tr>
					<tr>
						<td></td>
						<td>主审委员：</td>
						<td><c:forEach items="${committeesMap[form.irb.irbFlow]}" var="irbUser" varStatus="statu">
				            ${irbUser.userName}<c:if test="${fn:length(committeesMap[form.irb.irbFlow])>1&&!statu.last}">、</c:if>
				            </c:forEach>
				        </td>
					</tr>
					<tr>
						<td></td>
						<td>审查概要：</td>
						<td>${minutesMap[form.irb.irbFlow].reportMinutes }</td>
					</tr>
					<tr>
						<td></td>
						<td>审查决定：</td>
						<td>${form.irb.irbDecisionName }</td>
					</tr>
			</table>
		<div>
			&#12288;
		</div>
		</c:forEach>
		<div style="margin-top: 5px;margin-bottom: 5px;">
			二、会议审查项目
		</div>
		<c:forEach items="${irbTypeEnumList }" var="dict" varStatus="typeStatus">
			<table class="basic nofix" style="width: 100%;">
				<tr>
					<th colspan="3" style="text-align: left;">
					&nbsp;(${pdfn:transNum(typeStatus.index+1) })&nbsp;${dict.name}<c:if test="${empty irbTypeMap[dict.id] }">(无)</c:if>
					</th>
				</tr>
			</table>
			<c:set var="meetingStatus" value="0"></c:set>
			 <c:forEach items="${irbTypeMap[dict.id] }" var="form">
				<c:set var="meetingStatus" value="${meetingStatus+1 }"></c:set>
				<table class="basic nofix" style="width: 100%;">
					<tr>
						<td width="8%">（${meetingStatus}）</td>
						<td width="20%">项目：</td>
						<td width="72%">${form.irb.projName }</td>
					</tr>
					<tr>
						<td></td>
						<td>受理号：</td>
						<td>${form.irb.irbNo }</td>
					</tr>
					<tr>
						<td></td>
						<td>机构角色：</td>
						<td>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>主要研究者：</td>
						<td>${form.proj.applyUserName }</td>
					</tr>
					<tr>
						<td></td>
						<td>主审委员：</td>
						<td><c:forEach items="${committeesMap[form.irb.irbFlow]}" var="irbUser" varStatus="statu">
				            ${irbUser.userName}<c:if test="${fn:length(committeesMap[form.irb.irbFlow])>1&&!statu.last}">、</c:if>
				            </c:forEach>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>独立顾问：</td>
						<td>${consultantMap[form.irb.irbFlow].userName}
						</td>
					</tr>
				</table>
				<div>
					&#12288;
				</div>	
				</c:forEach>
		</c:forEach>
	</div>
</div>
<div class="button" style="margin-left: 10px;margin-right: 10px;">
	<input class="search" type="button" value="PDF下载" onclick="downPdfMeetingAgenda();" />
	<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
</div>
</body>
</html>