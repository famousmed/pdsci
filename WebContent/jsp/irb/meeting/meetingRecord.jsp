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
	function downMeetingRecord() {
		var url = "<s:url value='/irb/meeting/downMeetingRecord'/>?meetingFlow=${meeting.meetingFlow}";
	 	window.location.href=url;
	}
	
	function downWordMeetingRecord() {
		var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${meeting.meetingFlow}&recTypeId=meetingRecord";
	 	window.location.href=url;
	}

</script>
</head>
<body>
<div class="mainright" style="height: 90%;">
	<div class="content" style="margin-left: 10px;margin-right: 10px;">
		<div>
		<div style="text-align: center;margin-top: 10px;margin-bottom: 10px;">
			<font style="font-size: 16px;">会议记录</font>
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
					<c:set var="roleName" value="${entry.value[0].roleName }"/>
					<c:if test="${roleName=='秘书' }">
						<c:set var="roleName" value="工作人员"/>
					</c:if>
					<c:if test="${roleName!=GlobalConstant.INDEPENDENT_MEMBER }">
					<tr>
						<td width="20%" style="text-align: center;">${entry.value[0].roleName }
						</td>
						<td colspan="3">
							<c:forEach items="${ entry.value}" var="meetingUser" varStatus="statu">
								${meetingUser.userName }<c:if test="${fn:length(entry.value)>1&& !statu.last }">、</c:if>
							</c:forEach>
						</td>
					</tr>
					</c:if>
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
		<div style="margin-top: 20px;margin-bottom: 20px;text-align: left;">
			&#12288;&#12288;主持人：本次到会委员符合法定人数要求。与审查项目存在利益冲突的委员/独立顾问请声明。
		</div>
		</div>
		<div style="margin-top: 5px;margin-bottom: 5px;">
			一、会议报告项目
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
						<td width="8%">${fastStatus}</td>
						<td width="20%">伦理审查类别</td>
						<td width="72%">${form.irb.irbTypeName }</td>
					</tr>
					<tr>
						<td></td>
						<td>项目</td>
						<td>${form.irb.projName }</td>
					</tr>
					<tr>
						<td></td>
						<td>受理号</td>
						<td>${form.irb.irbNo }</td>
					</tr>
					<tr>
						<td></td>
						<td>主要研究者</td>
						<td>${form.proj.applyUserName }</td>
					</tr>
					<tr>
						<td></td>
						<td>审查决定</td>
						<td>${form.irb.irbDecisionName }</td>
					</tr>
			</table>
		<div style="margin-top: 5px;margin-bottom: 5px;">
			&#12288;审查记录：${minutesMap[form.irb.irbFlow].reportMinutes }
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
						<td width="8%">${meetingStatus}</td>
						<td width="20%">项目</td>
						<td width="72%">${form.irb.projName }</td>
					</tr>
					<tr>
						<td></td>
						<td>受理号</td>
						<td>${form.irb.irbNo }</td>
					</tr>
					<tr>
						<td></td>
						<td>机构角色</td>
						<td>
							<c:if test="${isLeaderMap[form.proj.projFlow] eq projOrgTypeEnumLeader.id}">${projOrgTypeEnumLeader.name }</c:if>
    						<c:if test="${isLeaderMap[form.proj.projFlow] eq projOrgTypeEnumParti.id}">${projOrgTypeEnumParti.name }</c:if>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>主要研究者</td>
						<td>${form.proj.applyUserName }</td>
					</tr>
					<tr>
						<td></td>
						<td>主审委员</td>
						<td><c:forEach items="${committeesMap[form.irb.irbFlow]}" var="irbUser" varStatus="statu">
				            ${irbUser.userName}<c:if test="${fn:length(committeesMap[form.irb.irbFlow])>1&&!statu.last}">、</c:if>
				            </c:forEach>
						</td>
					</tr>
				</table>
				<div style="margin-top: 5px;margin-bottom: 5px;">
					<b>&#12288;审查记录</b>
				</div>
				<table class="basic nofix" style="width: 100%;">
					<tr>
						<td align="left" style="font-weight: bold;">申请人报告</td>
					</tr>
					<tr>
						<td>&#12288;&#12288;${minutesMap[form.irb.irbFlow].title}&nbsp;</td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;">提问与答疑</td>
					</tr>
					<tr>
						<td><pre style="font-family: Microsoft Yahei;line-height:25px;">${minutesMap[form.irb.irbFlow].question}</pre></td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;">讨论（申请人退出，声明有利益冲突的退出）</td>
					</tr>
					<tr>
						<td><pre style="font-family: Microsoft Yahei;line-height:25px;">${minutesMap[form.irb.irbFlow].discussion}</pre></td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;">投票意见</td>
					</tr>
					<tr>
						<td>&#12288;&#12288;
							<c:forEach items="${decisionMap[form.irb.irbFlow]}" var="dec" varStatus="status">
							<c:set var="key" value="${form.irb.irbFlow}${dec.dictId }"></c:set>
								${dec.dictName }&nbsp;${voteCountMap[key] }票<c:if test="${fn:length(decisionMap[form.irb.irbFlow])>1&&!status.last}">，</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<td align="left" style="font-weight: bold;">审查决定</td>
					</tr>
					<tr>
						<td>&#12288;&#12288;${form.irb.irbDecisionName }&nbsp;</td>
					</tr>
				</table>
				<div>
					&#12288;
				</div>	
				</c:forEach>
		</c:forEach>
	</div>
</div>
<div class="button" align="center">
	<!-- <input class="search" type="button" value="pdf下载" onclick="downMeetingRecord();" /> -->
	<input class="search" type="button" value="下&#12288;载" onclick="downWordMeetingRecord();" />
	<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
</div>
</body>
</html>