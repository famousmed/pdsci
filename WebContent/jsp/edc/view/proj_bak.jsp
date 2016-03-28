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
<style>
	.centerNo{width: 70px}
</style>
<script type="text/javascript">
   function changeLocked(lockNode,lockType){
	   var orgFlow = lockNode.id;
	   var requestData = "orgFlow="+orgFlow+"&lockType="+lockType;
	   var url = "<s:url value='/edc/proj/saveProjOrgLock'/>";
	   jboxPost(url,requestData,function(resp){
		   if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
			   var imgSrc = lockNode.src;
			   var regLock = /\/lock\.png/;
			   var regUnlock = /\/unlock\.png/;
			   if(regLock.test(imgSrc)){
				   $(lockNode).attr("src",imgSrc.replace(regLock,"/unlock.png"));
			   }else{
				   $(lockNode).attr("src",imgSrc.replace(regUnlock,"/lock.png"));
			   }
			}
	   },null,true);
   }
   
   function normalValueLockConfig(orgFlow){
	   window.location.href="<s:url value='/edc/normalvalue/list/${GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}'/>?orgFlow="+orgFlow;
   }
   
   function detail(){
	   jboxOpen("<s:url value='/edc/proj/inDetailMain'/>", "入组详情",600,450);
   }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th class="centerNo">中心号</th>
							<th>机构名称</th>
							<th>机构角色</th>
							<th>承担病例</th>
							<th>随机状态</th>
							<th>正常值范围</th>
							<th>录入状态</th>
							<th>核查状态</th>
						</tr>
							<c:forEach items="${pdfn:filterProjOrg(projOrgList)}" var="projOrg">
								<tr>
									<td>${projOrg.centerNo}</td>
									<td>${projOrg.orgName}</td>
									<td>${projOrg.orgTypeName}</td>
									<td>${projOrg.patientCount}</td>
									<td>
										<c:if test="${edcProjOrgMap[projOrg.orgFlow].randomLock == GlobalConstant.LOCK_STATUS_Y}">
												<img id="${projOrg.orgFlow}" title="已锁定" src="<s:url value='/css/skin/${skinPath}/images/lock.png'/>" onclick="javascript:changeLocked(this,'randomLock')"/>
										</c:if> 
										<c:if test="${edcProjOrgMap[projOrg.orgFlow].randomLock != GlobalConstant.LOCK_STATUS_Y}">
												<img id="${projOrg.orgFlow}" title="未锁定" src="<s:url value='/css/skin/${skinPath}/images/unlock.png'/>"  onclick="javascript:changeLocked(this,'randomLock')"/>
										</c:if> 
									</td>
									<td>
										<c:if test="${edcProjOrgMap[projOrg.orgFlow].normalValueLock == GlobalConstant.LOCK_STATUS_Y}">
											<img title="已提交" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
										</c:if>
										<c:if test="${edcProjOrgMap[projOrg.orgFlow].normalValueLock != GlobalConstant.LOCK_STATUS_Y}">
											[<a id="${projOrg.orgFlow}" href="javascript:void(0)" onclick="javascript:normalValueLockConfig(this.id)">设置</a>]
										</c:if>
									</td>
									<td>
										<c:if test="${edcProjOrgMap[projOrg.orgFlow].inputLock == GlobalConstant.LOCK_STATUS_Y}">
												<img id="${projOrg.orgFlow}" title="已锁定" src="<s:url value='/css/skin/${skinPath}/images/lock.png'/>"  onclick="javascript:changeLocked(this,'inputLock')"/>
										</c:if> 
										<c:if test="${edcProjOrgMap[projOrg.orgFlow].inputLock != GlobalConstant.LOCK_STATUS_Y}">
												<img id="${projOrg.orgFlow}" title="未锁定" src="<s:url value='/css/skin/${skinPath}/images/unlock.png'/>"  onclick="javascript:changeLocked(this,'inputLock')"/>
										</c:if> 
									</td>
									<td>-</td>
								</tr>
							</c:forEach>
							<c:if test="${empty pdfn:filterProjOrg(projOrgList)}">
									<tr>
										<td align="center" style="text-align: center;" colspan="8">无记录</td>
									</tr>
								</c:if>
					</table>
		</div>
		<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<div style="width:65%; ;float: left;margin-bottom: 10px;" align="left">
							<div style="width: 100%;" >
								  <table width="100%" class="xllist">
									<tr>
							          <th  style="text-align: left;" colspan="6">&#12288;入组情况
							          	<a style="float: right; padding-right: 10px;" href="javascript:detail()">[详情]</a>
										</th>
							        </tr>
							        <tr>
							        	<th class="centerNo">中心号</th>
							        	<th>入组</th>
							        	<th>脱落</th>
							        	<th>完成</th>
							        	<th>承担例数</th>
							        	<th>进度</th>
							        </tr>
							        <c:set var="inSum" value="0" />
							        <c:set var="offSum" value="0" />
							        <c:set var="finishSum" value="0" />
							        <c:set var="patientCountSum" value="0"/>
							        
							        <c:forEach items="${pdfn:filterProjOrg(projOrgList)}" var="projOrg">
										<c:set var="count" value="${projOrg.orgFlow}_Count"/>
										<c:set var="totalPatientCount" value="${totalPatientCount+projOrg.patientCount}"/>
										
							        	<c:set var="inSum" value="${inSum + inDateMap[count]}" />
							        	<c:set var="offSum" value="${offSum + offCountMap[projOrg.orgFlow].size()}" />
							        	<c:set var="finishSum" value="${finishSum + finishCountMap[projOrg.orgFlow].size()}" />
								        <c:set var="patientCountSum" value="${patientCountSum + projOrg.patientCount}"/>
								        <tr>
								        	<td>${projOrg.centerNo}</td>
								        	<td>${inDateMap[count]+0}</td>
								        	<td>${offCountMap[projOrg.orgFlow].size()+0}</td>
								        	<td>${finishCountMap[projOrg.orgFlow].size()+0}</td>
								        	<td>${projOrg.patientCount + 0}</td>
								        	<td>${pdfn:getPercent(inDateMap[count],projOrg.patientCount) }</td>
								        </tr>
							        </c:forEach>
							        <c:if test="${!empty pdfn:filterProjOrg(projOrgList)}">
							        	<tr>
								        	<td>汇总</td>
								        	<td>${inSum}</td>
								        	<td>${offSum}</td>
								        	<td>${finishSum}</td>
								        	<td>${patientCountSum}</td>
								        	<td>${pdfn:getPercent(inSum,totalPatientCount) }</td>
							       		</tr>
							        </c:if>
							        <c:if test="${empty pdfn:filterProjOrg(projOrgList)}">
										<tr>
											<td align="center" style="text-align: center;" colspan="6">无记录</td>
										</tr>
									</c:if>
								</table>
							</div>
						</div>
						<div style="width:34%; ;float: right;margin-left: 10px;margin-bottom: 10px;" >
							<div style="width: 100%;" >
								  <table width="100%" class="xllist">
									<tr>
							          <th  style="text-align: left;" colspan="3">&#12288;入组概况
										</th>
							        </tr>
							        <tr><th class="centerNo">中心号</th>
							        	<th>入组/承担</th>
							        	<th>最新入组</th>
							        </tr>
							        
							        <c:set var="inDateCount" value="0"/>
							        <c:set var="patientCountSum" value="0"/>
							        <c:set var="newDate" value=""/>
							        
							        <c:forEach items="${pdfn:filterProjOrg(projOrgList)}" var="projOrg">
										<c:set var="max" value="${projOrg.orgFlow}_Max"/>
										<c:set var="count" value="${projOrg.orgFlow}_Count"/>
										<c:set var="maxDate" value="${empty inDateMap[max]?'-':pdfn:transDateTime(inDateMap[max])}"/>
										
										<c:set var="inDateCount" value="${inDateCount + inDateMap[count]}"/>
								        <c:set var="patientCountSum" value="${patientCountSum + projOrg.patientCount}"/>
							        	<c:set var="newDate" value="${!empty maxDate?(maxDate.compareTo(newDate)>0?maxDate:newDate):newDate}"/>
								        
								        <tr>
								        	<td>${projOrg.centerNo}</td>
								        	<td>${inDateMap[count]+0}/${projOrg.patientCount + 0}</td>
								        	<td>${maxDate}</td>
								        </tr>
							        </c:forEach>
							        <c:if test="${!empty pdfn:filterProjOrg(projOrgList)}">
								        <tr>
								        	<td>汇总</td>
								        	<td>${inDateCount}/${patientCountSum}</td>
								        	<td>${empty newDate?'-':newDate}</td>
								        </tr>
							        </c:if>
							        <c:if test="${empty pdfn:filterProjOrg(projOrgList)}">
									<tr>
										<td align="center" style="text-align: center;" colspan="3">无记录</td>
									</tr>
								</c:if>
								</table>
							</div>
						</div>
				</div>
				<div style="width:100%;margin-bottom: 10px;margin-top: 10px;" align="left">
					<div style="width: 100%">
					<table width="100%" class="xllist" style="font-size: 14px">
							 <tr><th rowspan="2" class="centerNo">中心号</th>
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
							        	<th><img title="已发送"src="<s:url value='/css/skin/${skinPath}/images/sendQuery.gif'/>"/></th>
							        	<th><img title="已解决" src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></th>
							        </tr>
							<tbody>	
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
						        <c:if test="${!empty pdfn:filterProjOrg(projOrgList)}">
							         <tr>
								        	<td>汇总</td>
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
										<td align="center" style="text-align: center;" colspan="9">无记录</td>
									</tr>
								</c:if>
							</tbody>													
						</table >
						</div>
				</div>
	</div>
</div>
</div>
</body>
</html>