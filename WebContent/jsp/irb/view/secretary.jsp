<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	jboxLoad("overview","<s:url value='/irb/secretary/overview'/>?pickType=${quickDatePickEnumMonth.id}");
});
function showMeetingRecord(meetingFlow) {
	jboxOpen("<s:url value='/irb/meeting/meetingRecord'/>?meetingFlow="+meetingFlow,"会议记录",700,600);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
				<div style="width: 100%;">			
						<table  class="xllist nofix" style="width: 100%">
							<tr>
								<th  colspan="3" style="text-align: left;">&#12288;常用操作</th>
							</tr>
							<tbody>								
								<tr>
									<td class="bs_mod viewTd" align="left" >
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_proj_city.png" />" onclick="window.location.href='<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumHandle.id }'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 200px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumHandle.id }'/>'">受理/处理</a></b><br/>
												受理、处理已申请伦理审查
											</div>
										</div>
									<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_track.png" />" onclick="window.location.href='<s:url value='/irb/secretary/followReview'/>'"> 
											</div>
											<div align="left" style=";margin-top: 5px;width: 200px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/secretary/followReview'/>'">跟踪审查</a></b><br/>
												跟踪审查
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_meeting.png" />" onclick="window.location.href='<s:url value='/irb/meeting/arrange'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 200px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/meeting/arrange'/>'">伦理审查会</a></b><br/>
												日期:&#12288;<a style="color: red" href="javascript:window.location.href='<s:url value='/irb/meeting/agenda'/>?meetingFlow=${meeting.meetingFlow}'">${meeting.meetingDate }</a><br/>
												会议安排、评审
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_search.png" />" onclick="window.location.href='<s:url value='/irb/projIrbList'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 200px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/projIrbList'/>'">审查查询</a></b><br/>
												伦理审查查询
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;" >
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_org.png" />" onclick="window.location.href='<s:url value='/irb/office/regulation?arrange=SOP'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 200px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/office/regulation?arrange=SOP'/>'">制度与SOP</a></b><br/>
												法律法规、伦理审查制度、SOP
											</div>
										</div>
									</td>
								</tr>		
							</tbody>													
						</table>
					</div>
				<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
					<div style="width:60%;float: left;margin-bottom: 10px;" align="left">
					<div style="width: 100%">
					<table width="100%" class="xllist" style="font-size: 14px">
							<tr>
								<th colspan="3"style="text-align: left;">&#12288;待办事项</th>
							</tr>
							<tbody>	
									<c:choose>
										<c:when test="${!empty unAcceptIrbs || !empty unDecisionIrbs || !empty unArchiveIrbs || !empty unReviewIrbs}">
											<c:if test="${!empty unAcceptIrbs }">
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														待受理/处理项目数：&#12288;<font style="color: red">${fn:length(unAcceptIrbs) }</font>&#12288;点击
														<a href="<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumHandle.id }'/>" style="color: red;cursor: pointer;">这里</a>受理/处理
													</td>
												</tr>
											</c:if>
											<c:if test="${!empty unReviewIrbs }">
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														待审查项目数：&#12288;<font style="color: red">${fn:length(unReviewIrbs) }</font>&#12288;点击
														<a href="<s:url value='/irb/committee/list/secretary'/>" style="color: red;cursor: pointer;">这里</a>审查
													</td>
												</tr>
											</c:if>
											<c:if test="${!empty unDecisionIrbs }">
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														待传达决定项目数：&#12288;<font style="color: red">${fn:length(unDecisionIrbs) }</font>&#12288;点击
														<a href="<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumDecision.id }'/>" style="color: red;cursor: pointer;">这里</a>传达决定
													</td>
												</tr>
											</c:if>
											<c:if test="${!empty unArchiveIrbs }">		 
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														待文件存档项目数：&#12288;<font style="color: red">${fn:length(unArchiveIrbs) }</font>&#12288;点击
														<a href="<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumArchive.id }'/>" style="color: red;cursor: pointer;">这里</a>文件存档
													</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="text-align: left;padding-left: 30px" >
													您目前没有待办理的业务.
												</td>
											</tr>	
										</c:otherwise>
									</c:choose>
							</tbody>													
						</table >
						</div>
					  <div  style="width:100%; margin-top: 10px;" >
							  <table width="100%" class="xllist">
							        <thead>
							        <tr>
							          <th  colspan="3" style="text-align: left;">&#12288;跟踪审查提醒</th>
							        </tr>
							        <c:choose>
										<c:when test="${!empty trackIrbs }">
											<c:forEach items="${trackIrbs }" var="irb">
												 <tr>
													<td style="text-align: left;padding-left: 30px" >
														${irb.projShortName }&#12288;${irb.projSubTypeName } &#12288;${irb.projShortDeclarer }&#12288;<a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${irb.projFlow}&irbFlow=${irb.irbFlow}&vtype=view" target="_blank" style="color: red">${irb.irbTypeName }</a>&#12288;跟踪审查日期：<font color="red">${irb.trackDate }</font>
													</td>
												</tr>	
											</c:forEach>
										</c:when>
										<c:otherwise>
											 <tr>
												<td style="text-align: left;padding-left: 30px" >
													暂无审查提醒.
												</td>
											</tr>	
										</c:otherwise>
									</c:choose>
							        </tbody>
							  </table>
							  </div>
						</div>
						<div style="width:39%; ;float: right;margin-left: 10px;margin-bottom: 10px;" >
							<div style="width: 100%" id="overview">
							
							</div> 
							<div style="width: 100%;margin-top: 10px;" >
								  <table width="100%" class="xllist">
									<tr>
							          <th  style="text-align: left;">&#12288;会议概况&#12288;(最近一次伦理审查会：
							          	<c:choose>
							          		<c:when test="${meeting.meetingStatus==GlobalConstant.FLAG_Y}">
							          			已结束
							          		</c:when>
							          		<c:otherwise>
							          			待召开
							          		</c:otherwise>
							          	</c:choose>
							          )
							           <a href="javascript:showMeetingRecord('${meeting.meetingFlow }');" style="float: right;padding-right: 10px;" class="quickFlipCta">会议记录>></a>
										</th>
							        </tr>
							        <tr>
							        	<td style="text-align: left;padding-left: 30px;">会议时间：<a style="color: red" href="javascript:window.location.href='<s:url value='/irb/meeting/agenda'/>?meetingFlow=${meeting.meetingFlow}'">${meeting.meetingDate }</a>&#12288;${meeting.meetingStartTime} ~ ${meeting.meetingEndTime}
							        		&#12288;&#12288;主持人：${meeting.meetingHost }
							        	</td>
							        </tr>
							         <tr>
							        	<td style="text-align: left;padding-left: 30px;">会议地点：${meeting. meetingAddress }</td>
							        </tr>
							         <tr>
							        	<td style="text-align: left;padding-left: 30px;">伦理委员会名称：${irbInfo.irbName }
							        	</td>
							        </tr>
							         <tr>
							        	<td style="text-align: left;padding-left: 30px;">会议报告数：${meetingReportIrbCount }&#12288;&#12288;&#12288;&#12288;会议审查数：${meetingReviewIrbCount }</td>
							        </tr>
							        <tr>
							        	<td style="text-align: left;padding-left: 30px;">参会人数：${fn:length(meetingUserList) }
							        	&#12288;&#12288;&#12288;&#12288;&#12288;批件：${approveCount }&#12288;&#12288;意见：${opinionCount }</td>
							        </tr>
								</table>
							</div>
						</div>
				</div>
		</div>
	</div>
</div>
</body>
</html>