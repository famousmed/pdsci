<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<script type="text/javascript">
	function assign(patientFlow){
		jboxOpen("<s:url value='/edc/random/assign'/>?patientFlow="+patientFlow,"入组申请",650,550);
	}
	function assignFollow(patientFlow){
		jboxOpen("<s:url value='/edc/random/assignFollow'/>?patientFlow="+patientFlow,"随访申请",650,600);
	}
	function breakBlind(patientFlow){
		jboxOpen("<s:url value='/edc/random/breakBlind'/>?patientFlow="+patientFlow,"在线揭盲",500,300);
	}
	function breakBlindApply(patientFlow){
		jboxConfirm("确认提交揭盲申请?",function(){
			jboxGet("<s:url value='/edc/random/breakBlindApply'/>?patientFlow="+patientFlow,null,function(resp){
				window.location.href="<s:url value='/edc/random/list'/>";
			},null,true);
		});
	}
	function cancleAssign(){
		jboxOpen("<s:url value='/edc/random/cancleAssign'/>","撤销申请",700,400);
	}
	
	function showRandomInfo(patientFlow){
		jboxOpen("<s:url value='/edc/random/showRandomInfo'/>?patientFlow="+patientFlow,"随机信息",660,550);
	}
	</script>
<body> 
	<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
			&#12288;&#12288;中心号：${pubProjOrg.centerNo}
			&#12288;&#12288;机构名称：${applicationScope.sysOrgMap[sessionScope.currUser.orgFlow].orgName}
			&#12288;&#12288;
			 总例数：<font color="red">${fn:length(patientList )}</font> &#12288; 申请例数：<font color="red">${fn:length( randomMap)}</font>
			&#12288;&#12288;
			<c:if test="${projParam.randomLock !=  GlobalConstant.FLAG_Y
			&&  edcProjOrg.randomLock != GlobalConstant.LOCK_STATUS_Y}">
			<input type="button" value="撤销申请" class="search" onclick="cancleAssign();"/>
			</c:if>
			<c:if test="${projParam.randomLock ==  GlobalConstant.FLAG_Y
			or  edcProjOrg.randomLock == GlobalConstant.LOCK_STATUS_Y}"><font color="red">随机申请已锁定,暂时无法申请,请联系项目管理员!</font></c:if>
		   
		</div>
		<table class="xllist">
			<tr>
				<th width="50px">序号</th> 
				<th width="100px">受试者编号</th>
				<th width="100px">姓名</th>
				<th width="100px">随机号</th>
				<c:if test="${isBlind }">
				<th width="100px">药物编码</th>
				</c:if>
				<th width="100px">预后因素</th>
				<th width="100px">受试者状态</th>
				<th width="100px">申请人</th>
				<th width="160px">申请日期</th>
				<th>操作</th>
			</tr>
			<c:forEach items="${patientList }" var="patient">
			<tr <c:if test="${!empty randomMap[patient.patientFlow] }"> style="cursor: pointer;" ondblclick="showRandomInfo('${patient.patientFlow}');"</c:if>
			<c:if test="${randomMap[patient.patientFlow].promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">style="color: red"</c:if>
			>
				<td width="50px">${patient.patientSeq }</td>
				<td width="100px">${patient.patientCode }<c:if test="${(!isBlind && !empty randomMap[patient.patientFlow].drugGroup) || randomMap[patient.patientFlow].promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">(<font color="red">${randomMap[patient.patientFlow].drugGroup }</font>)</c:if></td>
				<td width="100px">${patient.patientName}</td>
				<td width="100px">${randomMap[patient.patientFlow].randomCode}</td>
				<c:if test="${isBlind }">
				<td width="100px">${randomMap[patient.patientFlow].drugPack }</td>
				</c:if>
				<td width="100px">${randomMap[patient.patientFlow].drugFactorName }</td>
				<td width="100px">${patient.patientStageName }</td>
				<td width="100px">${randomMap[patient.patientFlow].assignUserName}</td>
				<td width="160px">${pdfn:transDateTime(randomMap[patient.patientFlow].assignTime)}</td>
				<td style="text-align: left;padding-left: 5px;">
					<c:if test="${projParam.randomLock !=  GlobalConstant.LOCK_STATUS_Y  && edcProjOrg.randomLock != GlobalConstant.LOCK_STATUS_Y  
					&& randomMap[patient.patientFlow].promptStatusId  != edcRandomPromptStatusEnumPrompted.id}">
						<c:if test="${assignFlag != GlobalConstant.FLAG_N and empty randomMap[patient.patientFlow]}">
							[<a href="javascript:assign('${patient.patientFlow }');">入组申请</a>]
							<c:set var="assignFlag" value="${GlobalConstant.FLAG_N }"/>
						</c:if>
						<c:if test="${!empty randomMap[patient.patientFlow] && GlobalConstant.FLAG_Y ==  projParam.isVisit && isBlind}">
						[<a href="javascript:assignFollow('${patient.patientFlow}');">随访申请</a>]
						</c:if>
					</c:if>
					<!-- 揭盲 申请界面不放接盲操作 -->
					<c:if test="${isBlind && patient.patientStageId != patientStageEnumFilter.id && !empty randomMap[patient.patientFlow] 
									&& empty randomMap[patient.patientFlow].promptStatusId  }">
							[<a href="javascript:breakBlindApply('${patient.patientFlow}');" title="申请提交后需主要研究者审核同意方可继续揭盲">申请揭盲</a>]
					</c:if>
					<c:if test="${isBlind && patient.patientStageId != patientStageEnumFilter.id && !empty randomMap[patient.patientFlow] 
									&& randomMap[patient.patientFlow].promptStatusId == edcRandomPromptStatusEnumApply.id }">
							揭盲待审核...
					</c:if>
					<c:if test="${isBlind && patient.patientStageId != patientStageEnumFilter.id && !empty randomMap[patient.patientFlow] 
									&& randomMap[patient.patientFlow].promptStatusId == edcRandomPromptStatusEnumAgree.id }">
							[<a href="javascript:breakBlind('${patient.patientFlow}');">揭盲</a>]
					</c:if>
					<c:if test="${randomMap[patient.patientFlow].promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">
						已揭盲
					</c:if>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${empty patientList }"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="10">无记录</td>
				</tr>
			</c:if>	
			</table>
	</div>
</div>
</body>
</html>