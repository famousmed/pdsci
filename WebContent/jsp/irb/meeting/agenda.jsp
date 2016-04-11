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
function voteDesction(irbFlow){
	jboxOpen("<s:url value='/irb/meeting/voteDesction'/>?irbFlow="+irbFlow,"审查决定",800,600);
}
function minutes(irbFlow,meetingArrange){
	jboxOpen("<s:url value='/irb/meeting/minutes'/>?irbFlow="+irbFlow+"&meetingArrange="+meetingArrange+"&meetingCheck=${meetingCheck}",meetingArrange=='${irbReviewTypeEnumFast.id}'?"审查概要":"审查记录",800,meetingArrange=='${irbReviewTypeEnumFast.id}'?300:600);
}
function viewIrbFile(){
	jboxOpen("<s:url value='/irb/committee/viewIrbFile'/>","送审文件",1000,600);
}
function irbSettle(meetingArrange){
	jboxOpen("<s:url value='/irb/meeting/irbSettle'/>?meetingArrange="+meetingArrange+"&meetingFlow=${meeting.meetingFlow}&irbInfoFlow=${meeting.irbInfoFlow}","调整上会项目",1000,600);
}
function selMeetingUser(){
	jboxOpen("<s:url value='/irb/meeting/selMeetingUser'/>?meetingFlow=${meeting.meetingFlow}","选择参会人员",1000,600);
}
function reload(){
	window.location.reload();
}
function vote(irbFlow){
	jboxOpen("<s:url value='/irb/committee/vote'/>?irbFlow="+irbFlow,"委员投票",800,400);
}
function declare(irbFlow){
	jboxConfirm("确定声明利益冲突，退出本次投票?",function(){
		var url = "<s:url value='/irb/committee/saveVote'/>";
		var requestData = {"irbFlow":irbFlow,"conflict":'${GlobalConstant.FLAG_Y}'};
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				reload();
			}
		},null,true);
	});
}
function finishMeeting(){
	jboxGet("<s:url value='/irb/meeting/finishMeetingConfirm'/>?meetingFlow=${meeting.meetingFlow}",null,function(resp){
		if(resp==0){
			jboxConfirm("确定结束本次会议，保存后将无法修改?",function(){
				var url = "<s:url value='/irb/meeting/finishMeeting'/>";
				var requestData = {"meetingFlow":"${meeting.meetingFlow}"};
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
						reload();
					}
				},null,true);
			},function(){$("#opre").val("")});
		} else {
			jboxInfo("本次会议有<font color='red'> "+resp+" </font>条审查没有审查决定，不能结束会议！");
		}
	},null,false);
}

function showMeetingRecord() {
	jboxOpen("<s:url value='/irb/meeting/meetingRecord'/>?meetingFlow=${meeting.meetingFlow}","会议记录",700,600);
}
function opre(type){
	
	if(type=="finish"){
		finishMeeting();
	}
	if(type=="edit"){
		jboxOpen("<s:url value='/irb/meeting/toEditMeeting?meetingFlow=${meeting.meetingFlow}'/>","编辑会议",400,250);
	}
	if(type=="meetingUser"){
		selMeetingUser();
	}
} 

function editMeeting() {
	jboxOpen("<s:url value='/irb/meeting/toEditMeeting?meetingFlow=${meeting.meetingFlow}'/>","编辑会议",400,250);
}

function showMeetingAgenda() {
	jboxOpen("<s:url value='/irb/meeting/meetingAgenda'/>?meetingFlow=${meeting.meetingFlow}","会议议程",700,600);
}
function showMeetingFile() {
	jboxOpen("<s:url value='/irb/meeting/showMeetingFile'/>?meetingFlow=${meeting.meetingFlow}","会议文件",900,550);
}

function downMeetingRegist(){
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${meeting.meetingFlow}&recTypeId=meetingRegist";
	window.location.href= url;
}

function downMeetingAgenda() {
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&meetingFlow=${meeting.meetingFlow}&recTypeId=meetingAgenda";
	window.location.href= url;
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
						<table style="width: 100%">
							<tr>
	                        	<td width="80%" align="left"  style="padding-top:5px;padding-bottom: 10px;">
	                        		<b>会议日期：</b>${meeting.meetingDate }&#12288;${meeting.meetingStartTime } ～ ${meeting.meetingEndTime }&#12288;<b>地点：</b> ${meeting.meetingAddress }&#12288;<b>主持人：</b>${meeting.meetingHost }&#12288;<b>伦理委员会：</b>${meeting.irbName } 
								</td>
								<td width="20%"align="center">
									<c:if test="${empty meetingCheck && meeting.meetingStatus != GlobalConstant.FLAG_Y}">
										<table class="xllist" style="border: 0;">
											<tr>
												<td style="border: 0;width: 20%">
													<img src="<s:url value='/css/skin/${skinPath}/images/shu.gif'/>" onclick="editMeeting();" style="cursor: pointer;" title="会议信息修改"/>
												</td>
												<td style="border: 0;width: 20%">
													<img src="<s:url value='/css/skin/${skinPath}/images/add_user.png'/>" onclick="selMeetingUser();" style="cursor: pointer;" title="选择参会人员"/>
												</td>
												<td style="border: 0;width: 20%">
													<img src="<s:url value='/css/skin/${skinPath}/images/meet_file.png'/>" onclick="showMeetingFile();" style="cursor: pointer;" title="会议文件"/>
												</td>
												<td style="border: 0;width: 20%">
													<img src="<s:url value='/css/skin/${skinPath}/images/checking.png'/>" onclick="showMeetingRecord();" style="cursor: pointer;" title="会议记录"/>
												</td>
												<td style="border: 0;width: 20%">
													<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" onclick="finishMeeting();" style="cursor: pointer;" title="完成本次会议"/>
												</td>
											</tr>
										</table>
										</c:if>
										<c:if test="${meeting.meetingStatus==GlobalConstant.FLAG_Y}">
											<span style="color: red;font-weight: bold;">（本次会议已结束）</span>
										</c:if>
								</td>
                       		 </tr>
                       		 <tr>
                       		 	<td colspan="2" align="left">
									<input type="hidden" id="meetingFlow" value="${meeting.meetingFlow}">
									<c:if test="${!empty meetingUserMap }">
										<c:forEach items="${meetingUserMap}" var="entry">
											<b>${entry.value[0].roleName }：</b>
											<c:forEach items="${ entry.value}" var="meetingUser" varStatus="statu">
												${meetingUser.userName }<c:if test="${fn:length(entry.value)>1&& !statu.last }">、</c:if>
											</c:forEach>
											&#12288;
										</c:forEach>
									</c:if>
								</td>
                       		 </tr>
						</table>
		</div>
		<table class="xllist nofix">
			<thead>
				<tr>
					<th colspan="7">会议报告项目
						<span style="float: right;font-weight: normal;">
						<c:if test="${empty meetingCheck && meeting.meetingStatus!=GlobalConstant.FLAG_Y}">
						[<a href="javascript:void(0);" style="color: blue;" onclick="irbSettle('-1');">调整上会项目</a>]
						</c:if>&#12288;&#12288;
						</span>
					</th>
				</tr>
				<tr>
					<th width="20%">项目名称</th>
					<th width="10%">专业组</th>
					<th width="10%">主要研究者</th>
					<th width="10%">伦理审查类别</th>
					<th width="10%">受理号</th>
					<th width="10%">审查决定</th>
					<th width="10%" >审查概要</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${fastFormList }" var="form" >
					<tr>
						<td >
							<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${form.proj.projFlow}&irbFlow=${form.irb.irbFlow }&stype=meeting" target="_blank" style="color: blue">${form.irb.projShortName }</a>
						</td>
						<td >${form.proj.applyDeptName }</td>
						<td >${form.proj.applyUserName }</td>
						<td >${form.irb.irbTypeName }</td>
						<td >${form.irb.irbNo }</td>
						<td >${form.irb.irbDecisionName }</td>
						<td >[<a href="javascript:void(0)" onclick="minutes('${form.irb.irbFlow }','${form.irb.meetingArrange}');">审查概要</a>]</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div style="height: 10px"></div> 
		<table class="xllist nofix">
			<thead>
				<tr>
					<th colspan="7">
					会议审查项目
					<span style="float: right;font-weight: normal;">
						<c:if test="${empty meetingCheck && meeting.meetingStatus!=GlobalConstant.FLAG_Y}">
						[<a href="javascript:void(0);" style="color: blue;" onclick="irbSettle('${irbReviewTypeEnumMeeting.id}');">调整上会项目</a>]
						</c:if>&#12288;&#12288;
					</span>
					</th>
				</tr>
				<tr>
					<th width="20%">项目名称</th>
					<th width="10%">专业组</th>
					<th width="10%">主要研究者</th>
					<th width="10%">伦理审查类别</th>
					<th width="10%">受理号</th>
					<c:choose>
						<c:when test="${GlobalConstant.FLAG_Y == meetingCheck}">
							<th width="10%">委员投票</th>
						</c:when>
						<c:otherwise>
							<th width="10%">审查决定</th>
						</c:otherwise>
					</c:choose>
					<th width="10%" >审查记录</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${meetFormList }" var="form" >
					<tr>
						<td >
							<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${form.proj.projFlow}&irbFlow=${form.irb.irbFlow }&stype=meeting" target="_blank" style="color: blue">${form.irb.projShortName }</a>
						</td>
						<td >${form.proj.applyDeptName }</td>
						<td >${form.proj.applyUserName }</td>
						<td >${form.irb.irbTypeName}</td>
						<td >${form.irb.irbNo }</td>
							<c:choose>
								<c:when test="${GlobalConstant.FLAG_Y == meetingCheck}">
									<td>
										<c:choose>
											<c:when test="${!empty voteMap[form.irb.irbFlow].decisionId }">
												<a href="javascript:void(0)" onclick="vote('${form.irb.irbFlow}')">${voteMap[form.irb.irbFlow].decisionName}</a>
											</c:when>
											<c:when test="${!empty voteMap[form.irb.irbFlow].conflict }">
												<span style="color: red;">利益冲突退出</span>
											</c:when>
											<c:otherwise>
												[<a href="javascript:void(0)" style="color:blue" onclick="vote('${form.irb.irbFlow}')">委员投票</a>]
											</c:otherwise>
										</c:choose>
									</td>
								</c:when>
								<c:otherwise>
									<td>
										<c:choose>
											<c:when test="${!empty form.irb.irbDecisionId }"><a href="javascript:void(0)"  onclick="voteDesction('${form.irb.irbFlow}')">${form.irb.irbDecisionName }</a></c:when>
											<c:otherwise>[<a href="javascript:void(0)" style="color: red" onclick="voteDesction('${form.irb.irbFlow}')">审查决定</a>]</c:otherwise>
										</c:choose>
									</td>
								</c:otherwise>
							</c:choose>
						<td >[<a href="javascript:void(0)" onclick="minutes('${form.irb.irbFlow }','${form.irb.meetingArrange}');">审查记录</a>]</td>
						</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>