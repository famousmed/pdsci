<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
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
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_review.png" />" onclick="window.location.href='<s:url value='/irb/committee/list/user'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/committee/list/user'/>'">项目审查</a></b><br/>
												您作为主审委员项目的审查工作表
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_meeting.png" />" onclick="window.location.href='<s:url value='/irb/committee/meetingList'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/committee/meetingList'/>'">伦理审查会</a></b><br/>
												日期:&#12288;<a href="javascript:window.location.href='<s:url value='/irb/meeting/agenda'/>?meetingCheck=${GlobalConstant.FLAG_Y}&meetingFlow=${meetingFlow}'">${meetingDate }</a><br/>
												出席伦理委员会.
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;" >
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_org.png" />" onclick="window.location.href='<s:url value='/irb/office/regulation?arrange=SOP'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/office/regulation?arrange=SOP'/>'">制度与SOP</a></b><br/>
												法律法规、伦理审查制度、SOP
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_user.png" />" onclick="window.location.href='<s:url value='/sys/user/view'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/sys/user/view'/>">个人信息</a></b><br/>
												基本信息、教育、工作经历
											</div>
										</div>
									</td>
								</tr>		
							</tbody>													
						</table>
					</div>
				<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
					<div style="width:60%;float: left;margin-bottom: 10px;" align="left">
					<table width="100%" class="xllist" style="font-size: 14px">
							<tr>
								<th colspan="3"style="text-align: left;">&#12288;待办事项</th>
							</tr>
							<tbody>	
							<c:choose>
								<c:when test="${!empty unReviewIrbs }">
								<c:if test="${!empty unReviewIrbs }">
									<tr>
										<td style="text-align: left;padding-left: 30px;" >
											待审查项目数：&#12288;<font style="color: red">${fn:length(unReviewIrbs) }</font>&#12288;点击
											<a href="<s:url value='/irb/committee/list/user'/>" style="color: red;cursor: pointer;">这里</a>审查
										</td>
									</tr>
								</c:if>
								</c:when>
								<c:otherwise>
									<tr>
										<td style="text-align: left;padding-left: 30px" >
											您目前没有待审查的项目.
										</td>
									</tr>	
								</c:otherwise>
								</c:choose>
							</tbody>													
						</table >
						</div>
						<div style="width:39%; ;float: right;margin-left: 10px;margin-bottom: 10px;">
							<table width="100%" class="xllist">
							        <thead>
							        <tr>
							          <th  colspan="4"  style="text-align: left;">&#12288;审查概况</th>
							        </tr>
							        </thead>
							        <tbody>
							        	<tr>
							        		<td width="60%"><b>主审项目</b></td><td><b>参加会议</b></td>
							        	</tr>
					       	 			<tr>
								             <td style="text-align: center;">
								             	${reviewCount }
								             </td>
								             <td style="text-align: center;">
								             	${meetingCount }
								             </td>
								        </tr>
							        </tbody>
							  </table>
				</div>
				</div>
		</div>
	</div>
</div>
</body>
</html>