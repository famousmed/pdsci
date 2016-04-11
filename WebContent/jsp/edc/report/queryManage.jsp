<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<script type="text/javascript">
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
					<table width="100%" class="xllist" style="font-size: 14px">
							 <tr>
							 			<th rowspan="2" width="75px">中心号</th>
							 			<th rowspan="2" width="150px">机构名称</th>
							        	<th colspan="2">SDV疑问</th>
							        	<th colspan="2">手工疑问</th>
							        	<th colspan="2">逻辑核查</th>
							        	<th colspan="2">合计</th>
							        </tr> 
							         <tr>
							        	<th><img title="已发送" src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>"/></th>
							        	<th><img title="已解决" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></th>
							        	<th><img title="已发送" src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>"/></th>
							        	<th><img title="已解决" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></th>
							        	<th><img title="已发送" src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>"/></th>
							        	<th><img title="已解决" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></th>
							        	<th><img title="已发送" src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>"/></th>
							        	<th><img title="已解决" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></th>
							        </tr>
							<tbody>	
								<c:if test="${!empty pdfn:filterProjOrg(projOrgList)}">
									<c:set var="sdvSolvedCount" value="0"/>
									<c:set var="sdvSendedCount" value="0"/>
									<c:set var="logicSolvedCount" value="0"/>
									<c:set var="logicSendedCount" value="0"/>
									<c:set var="manualSolvedCount" value="0"/>
									<c:set var="manualSendedCount" value="0"/>
									
									<c:forEach items="${pdfn:filterProjOrg(projOrgList)}" var="projOrg">
									 	<c:set var="sdvSolved" value="${projOrg.orgFlow}${edcQuerySendWayEnumSdv.id}${edcQuerySolveStatusEnumSolved.id}"/>
									 	<c:set var="sdvSended" value="${projOrg.orgFlow}${edcQuerySendWayEnumSdv.id}${edcQueryStatusEnumSended.id}"/>
									 	<c:set var="logicSolved" value="${projOrg.orgFlow}${edcQuerySendWayEnumLogic.id}${edcQuerySolveStatusEnumSolved.id}"/>
									 	<c:set var="logicSended" value="${projOrg.orgFlow}${edcQuerySendWayEnumLogic.id}${edcQueryStatusEnumSended.id}"/>
									 	<c:set var="manualSolved" value="${projOrg.orgFlow}${edcQuerySendWayEnumManual.id}${edcQuerySolveStatusEnumSolved.id}"/>
									 	<c:set var="manualSended" value="${projOrg.orgFlow}${edcQuerySendWayEnumManual.id}${edcQueryStatusEnumSended.id}"/>
									 	
									 	<c:set var="sdvSolvedCount" value="${sdvSolvedCount + queryMap[sdvSolved]}"/>
									 	<c:set var="sdvSendedCount" value="${sdvSendedCount + queryMap[sdvSended]}"/>
										<c:set var="logicSolvedCount" value="${logicSolvedCount + queryMap[logicSolved]}"/>
										<c:set var="logicSendedCount" value="${logicSendedCount + queryMap[logicSended]}"/>
										<c:set var="manualSolvedCount" value="${manualSolvedCount + queryMap[manualSolved]}"/>
										<c:set var="manualSendedCount" value="${manualSendedCount + queryMap[manualSended]}"/>
								        <tr>
								        	<td>${projOrg.centerNo}</td>
								        	<td>${projOrg.orgName}</td>
								        	<td>${queryMap[sdvSended] + 0}</td>
								        	<td>${queryMap[sdvSolved] + 0}</td>
								        	<td>${queryMap[manualSended] + 0}</td>
								        	<td>${queryMap[manualSolved] + 0}</td>
								        	<td>${queryMap[logicSended] + 0}</td>
								        	<td>${queryMap[logicSolved] + 0}</td>
								        	<td>${queryMap[sdvSended] + queryMap[manualSended] + queryMap[logicSended] + 0}</td>
								        	<td>${queryMap[sdvSolved] + queryMap[manualSolved] + queryMap[logicSolved] + 0}</td>
								        </tr>
							        </c:forEach>
							        <tr>
							        	<td>汇总</td>
							        	<td></td>
							        	<td>${sdvSendedCount}</td>
								        <td>${sdvSolvedCount}</td>
								        <td>${manualSendedCount}</td>
								       	<td>${manualSolvedCount}</td>
								       	<td>${logicSendedCount}</td>
								       	<td>${logicSolvedCount}</td>
								       	<td>${sdvSendedCount + manualSendedCount + logicSendedCount}</td>
								       	<td>${sdvSolvedCount + manualSolvedCount + logicSolvedCount}</td>
							        </tr>
								</c:if>
								<c:if test="${empty pdfn:filterProjOrg(projOrgList)}">
									<tr>
										<td align="center" style="text-align: center;" colspan="10">无记录</td>
									</tr>
								</c:if>
							</tbody>													
						</table >
						</div>
						</div>
				</div>
</body>
</html>