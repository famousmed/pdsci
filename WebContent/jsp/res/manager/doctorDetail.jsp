<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	function evaluation(doctorFlow,schDeptFlow){
		window.open("<s:url value='/res/manager/evaluation'/>"+
				"?doctorFlow="+doctorFlow+"&schDeptFlow="+schDeptFlow+"&roleFlag=${param.roleFlag}"
				,"_blank");
	}
	
	function processView(resultFlow,schDeptFlow){
		window.open("<s:url value='/res/manager/doctorRegistryDetatil'/>?rotationFlow=${doctor.rotationFlow}&roleFlag=${param.roleFlag}&userFlow=${doctor.doctorFlow}&resultFlow="+resultFlow+"&schDeptFlow="+schDeptFlow,"_blank");
	}
	
	function afterAudit(recTypeId,rotationFlow,schDeptFlow,userFlow,processFlow){
		var url = "<s:url value='/res/rec/showRegistryForm'/>?roleFlag=${GlobalConstant.RES_ROLE_SCOPE_HEAD}&recTypeId="+recTypeId+"&rotationFlow="+rotationFlow+"&schDeptFlow="+schDeptFlow+"&userFlow="+userFlow+"&processFlow="+processFlow+"&isView=false&isManager=true";
		jboxOpen(url,"出科小结",900,600);
	}
	
	function evaluation(recFlow,schDeptFlow, rotationFlow, userFlow, schResultFlow){
		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
				"?schDeptFlow="+schDeptFlow+
				"&rotationFlow="+rotationFlow+
				"&recTypeId=${resRecTypeEnumAfterEvaluation.id}&userFlow="+userFlow+
				"&roleFlag=${param.roleFlag}&openType=open"+
				"&schResultFlow="+schResultFlow+
				"&recFlow="+recFlow
		jboxOpen(url, "出科考核表", 1000, 500);
	}
</script>
<div style="width: 100%;height: 100%;background-color: white;">
	<div style="margin: 10px;">
		<div style="margin-top: 10px;margin-bottom: 10px;padding-left: 20px;font-size: 17px;font-weight: bold;">
			${user.userName}轮转信息概况
		</div>
		<table style="width: 100%;" class="basic">
			<tr>
				<th width="100px">轮转方案：</th>
				<td>${doctor.rotationName}</td>
				<th width="100px">联系电话：</th>
				<td colspan="3">${user.userPhone}</td>
			</tr>
			<tr>
				<th width="100px">毕业院校：</th>
				<td>${doctor.graduatedName}</td>
				<th width="150px">培养年限：</th>
				<td width="50px">${doctor.trainingYears}</td>
				<th width="100px">医师状态：</th>
				<td width="50px">${doctor.doctorStatusName}</td>
			</tr>
			<tr>
				<th width="100px">培训基地：</th>
				<td>${doctor.orgName}</td>
				<th width="100px">培训专业：</th>
				<td colspan="3">${doctor.trainingSpeName}</td>
			</tr>
		</table>
		<div style="margin-top: 10px;">
			Tip：<font color="red"> * </font>表示外院科室！
		</div>
		<table class="xllist" style="margin-top: 10px;">
			<tr>
				<th>轮转状态</th>
				<th>轮转科室(出科成绩)</th>
				<th style="width: 200px;">轮转时间</th>
				<th>完成进度</th>
				<th>带教老师</th>
				<th>科主任</th>
				<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TUTOR)}">
				<th>出科审核</th>
				</c:if>
			</tr>
			<c:forEach items="${resultList}" var="result">
<%-- 				<c:if test="${!empty processMap[result.resultFlow]}"> --%>
				<c:set value="${processMap[result.resultFlow]}" var="process"/>
				<tr>
					<td>
						<c:if test="${GlobalConstant.FLAG_Y eq process.schFlag}">
							已出科
						</c:if>
						<c:if test="${process.isCurrentFlag eq GlobalConstant.FLAG_Y}">
							轮转中
						</c:if>
						<c:if test="${empty processMap[result.resultFlow]}">
							未入科
						</c:if>
					</td>
					<td
						<c:if test="${GlobalConstant.FLAG_Y eq schDeptMap[result.schDeptFlow].isExternal}">
							title="${schDeptMap[result.schDeptFlow].externalOrgName}"
						</c:if>
					>
						<c:if test="${GlobalConstant.FLAG_Y eq schDeptMap[result.schDeptFlow].isExternal}">
							<font color="red">*</font>
						</c:if>
						<c:if test="${!empty processMap[result.resultFlow]}">
							<a style="color: blue;cursor: pointer;" onclick="processView('${result.resultFlow}','${result.schDeptFlow}');">${process.schDeptName}</a>
<%-- 							(<a style="color: blue;cursor: pointer;" onclick="evaluation('${process.userFlow}','${process.schDeptFlow}');">${process.schScore}</a>${empty process.schScore?'暂无':''}) --%>
							(<c:out value="${process.schScore}" default="暂无"/>)
						</c:if>
						<c:if test="${empty processMap[result.resultFlow]}">
							${result.schDeptName}
						</c:if>
					</td>
					<td style="padding-left: 20px;text-align: left;">
						<c:if test="${!empty processMap[result.resultFlow]}">
							${process.startDate} ~ ${process.endDate}
						</c:if>
						<c:if test="${empty processMap[result.resultFlow]}">
							${result.schStartDate} ~ ${result.schEndDate}
						</c:if>
					</td>
					<td>${perMap[process.schResultFlow]+0}%</td>
					<td><c:out value="${process.teacherUserName}" default="-"/></td>
					<td><c:out value="${process.headUserName}" default="-"/></td>
					<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_TUTOR)}">
						<td>
						<c:if test="${!empty processMap[result.resultFlow]}">
							<c:set var="afterKey" value="res_${afterRecTypeEnumAfterEvaluation.id}_form_flag"/>
							<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[afterKey]}">
								<c:set var="color" value="blue"/>
		  						<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER eq param.roleFlag && !empty recMap[processMap[doctor.doctorFlow].userFlow].managerAuditStatusId}">
		  							<c:set var="color" value="black"/>
		  						</c:if>
		  						<a style="color: ${color};" href="javascript:void(0);" onclick="evaluation('${evaluationMap[key].recFlow}','${process.schDeptFlow}','${doctorMap.rotationFlow}','${process.userFlow}','${process.schResultFlow}');">出科考核表</a>
		  						<br/>
		  					</c:if>
							<c:set var="summaryKey" value="res_${afterRecTypeEnumAfterSummary.id}_form_flag"/>
							<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[summaryKey]}">
								<a style="color: blue;cursor: pointer;" onclick="afterAudit('${resRecTypeEnumAfterSummary.id}','${doctor.rotationFlow}','${process.schDeptFlow}','${process.userFlow}','${process.processFlow}');">出科小结</a>
							</c:if>
						</c:if>
						</td>
					</c:if>
				</tr>
<%-- 				</c:if> --%>
			</c:forEach>
<%-- 			<c:set value="${processList.size()}" var="processSize"/> --%>
<%-- 			<c:if test="${processSize<resultList.size()}"> --%>
<%-- 				<c:set value="${resultList[processSize]}" var="nextResult"/> --%>
<!-- 				<tr> -->
<!-- 					<td>待入科</td> -->
<%-- 					<td>${nextResult.schDeptName}(暂无)</td> --%>
<%-- 					<td style="padding-left: 20px;text-align: left;">${nextResult.schStartDate} ~ ${nextResult.schEndDate}</td> --%>
<!-- 					<td>0.0%</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 				</tr> -->
<%-- 			</c:if> --%>
		</table>
	</div>
</div>
