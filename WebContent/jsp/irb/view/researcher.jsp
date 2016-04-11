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
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_init.png" />" onclick="window.location.href='<s:url value='/irb/researcher/applyMain'/>?roleScope=${GlobalConstant.USER_LIST_LOCAL}'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/researcher/applyMain'/>?roleScope=${GlobalConstant.USER_LIST_LOCAL}'">初始审查申请</a></b><br/>
												无项目、首次伦理审查申请<br/>
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_track.png" />" onclick="window.location.href='<s:url value='/irb/researcher/list/local'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/irb/researcher/list/local'/>'">跟踪审查申请</a></b><br/>
												存在项目、跟踪审查申请<br/>
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
								<th colspan="3"style="text-align: left;">&#12288;最新消息</th>
							</tr>
							<tbody>	
									<c:choose>
										<c:when test="${! empty unReviewIrbs || !empty withdrawnIrbs || !empty archiveIrbs || !empty receiveIrbs}">	
											<c:forEach items="${withdrawnIrbs }" var="irb">			 
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														${irb.projShortName }&#12288;${irb.projSubTypeName } &#12288;${irb.projShortDeclarer }&#12288;${irb.irbTypeName }&#12288;申请材料被撤回&#12288;点击
														<a href="<s:url value='/irb/researcher/applyMain'/>?projFlow=${irb.projFlow}&irbFlow=${irb.irbFlow}&from=view&roleScope=${GlobalConstant.USER_LIST_LOCAL}" style="color: red;cursor: pointer;">这里</a>重新修改送审
													</td>
												</tr>
											</c:forEach>
											<c:forEach items="${receiveIrbs }" var="irb">			 
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														${irb.projShortName }&#12288;${irb.projSubTypeName } &#12288;${irb.projShortDeclarer }&#12288;${irb.irbTypeName }&#12288;已受理，受理号：<font color='red'>${irb.irbNo }</font>
													</td>
												</tr>
											</c:forEach>		
											<c:forEach items="${unReviewIrbs }" var="irb">			 
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														${irb.projShortName }&#12288;${irb.projSubTypeName } &#12288;${irb.projShortDeclarer }&#12288;${irb.irbTypeName }&#12288;已安排上会&#12288;<font color="red">${irb.reviewWayName}</font>&#12288;会议日期为：<font color="red">${irb.meetingDate }</font>
													</td>
												</tr>
											</c:forEach>
											<c:forEach items="${archiveIrbs }" var="irb">			 
												<tr>
													<td style="text-align: left;padding-left: 30px;" >
														${irb.projShortName }&#12288;${irb.projSubTypeName } &#12288;${irb.projShortDeclarer }&#12288;<a href="<s:url value='/irb/researcher/process'/>?projFlow=${irb.projFlow}&irbFlow=${irb.irbFlow}&roleScope=${GlobalConstant.USER_LIST_LOCAL}" style="color:red">${irb.irbTypeName }</a>&#12288;已完成审查.&#12288;审查决定：&#12288;${irb.irbDecisionName}&#12288;
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td style="text-align: left;padding-left: 30px;" >
													暂无任何消息.
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
							          <th  colspan="5"  style="text-align: left;">&#12288;审查概况</th>
							        </tr>
							        </thead>
							        <tbody>
							        	<tr>
							        		<td width="10%"><b>初始审查</b></td><td width="10%"><b>跟踪审查</b></td>
							        		<td width="10%"><b>SAE</b></td><td width="10%"><b>结题</b></td>
							        	</tr>
					       	 			<tr>
								             <td style="text-align: center;">
								             	${countMap['initCount'] }
								             </td>
								             <td style="text-align: center">
								             		${countMap['followCount'] }
								             </td>
								              <td style="text-align: center">
								              		${countMap['SaeCount'] }
								             </td>
								             <td style="text-align: center">
								             		${countMap['finishCount'] }
								             </td>
								        </tr>
							        </tbody>
							  </table>
				</div></div>
				  <div  style="width:100%; margin-top: 10px;">
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
														${irb.projShortName }&#12288;${irb.projSubTypeName } &#12288;${irb.projShortDeclarer }&#12288;<a href="<s:url value='/irb/researcher/process'/>?projFlow=${irb.projFlow}&irbFlow=${irb.irbFlow}&roleScope=${GlobalConstant.USER_LIST_LOCAL}" style="color:red">${irb.irbTypeName }</a>&#12288;跟踪审查日期：<font color="red">${irb.trackDate }</font>
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
	</div>
</div>
</body>
</html>