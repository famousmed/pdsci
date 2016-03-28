<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
	function inPatient(patientFlow) {
		jboxOpen("<s:url value='/edc/input/editPubPatient'/>?patientFlow="
				+ patientFlow+"&orgFlow=${orgFlow}&source=manage&actionScope=${param.actionScope}&patientType=${patientTypeEnumReal.id}", "病人基本信息", 500, 325);
	}
	function finishPatient(patientFlow) {
		jboxConfirm("确认该受试者已完成所有访视并结束临床试验观察吗？",  function() {
			jboxPost( "<s:url value='/pub/patient/changePatientStage?patientFlow='/>"+patientFlow+"&patientStageId=${patientStageEnumFinish.id}",null,function(resp){
				if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
					window.location.href="<s:url value='/pub/patient/manage/${param.actionScope}?orgFlow=${orgFlow}'/>";
					jboxClose(); 
				}
			},null,true);
		});
	}
	
	function patientStageNote(patientFlow) {
		jboxOpen("<s:url value='/pub/patient/patientStageNote?patientFlow='/>"+patientFlow+"&orgFlow=${orgFlow}&actionScope=${param.actionScope}", "脱落原因", 500, 300);
	}
	
	function breakBlind(patientFlow){
		jboxOpen("<s:url value='/edc/random/breakBlind'/>?patientFlow="+patientFlow
				+"&orgFlow=${orgFlow}&source=manage&actionScope=${param.actionScope}","在线揭盲",500,300);
	}
	
	function showRandomInfo(patientFlow){
		jboxOpen("<s:url value='/edc/random/showRandomInfo'/>?patientFlow="+patientFlow,"随机信息",660,550);
	}
</script>
</head>
	<body>
		<div id="tableDiv">
		<table id="patientFixedTable" class="xllist FixedTables">
			<thead>
				<tr>
					<th width="50px">序号</th>
					<th width="100px">受试者编号</th>
					<c:if test="${isBlind }">
					<th width="100px">药物编码</th>
					</c:if>
					<th width="100px">受试者拼音缩写</th>
					<th width="80px">性别</th>
					<th width="100px">入组日期</th>
					<th width="270px">当前访视（访视日期）</th>
					<th width="200px">操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${patientList}" var="patient">
				<tr <c:if test="${!empty randomMap[patient.patientFlow] }"> style="cursor: pointer;" ondblclick="showRandomInfo('${patient.patientFlow}');"</c:if>>
					<c:set var="vistNameKey" value="${patient.patientFlow }_VisitName"></c:set>
					<c:set var="vistDateKey" value="${patient.patientFlow }_VisitDate"></c:set>
					<td width="50px">${patient.patientSeq}</td>
					<td width="100px">
					${patient.patientCode}
					<c:if test="${(!isBlind && !empty randomMap[patient.patientFlow].drugGroup) || randomMap[patient.patientFlow].promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">(<font color="red">${randomMap[patient.patientFlow].drugGroup }</font>)</c:if>
					</td>
					<c:if test="${isBlind }">
					<td width="100px">${randomMap[patient.patientFlow].drugPack}</td>
					</c:if>
					<td width="100px">${patient.patientNamePy}</td>
					<td width="80px">${patient.sexName}</td>
					<td width="100px">${pdfn:transDate(patient.inDate)}</td>
					<td width="270px">
						<c:if test="${!empty visitDateMap[vistDateKey] }">
							${visitDateMap[vistNameKey] }（${visitDateMap[vistDateKey] }）
						</c:if>
					</td>
					<td width="200px" style="text-align: left;padding-left: 10px;">
						<c:choose>
							<c:when test="${patientStageEnumFilter.id eq patient.patientStageId }">
								<c:if test="${!isRandom }">
								<a href="javascript:void(0)" onclick="inPatient('${patient.patientFlow}');" style="color: blue;">${patientStageEnumIn.name}</a>
								</c:if>
							</c:when>
							<c:when test="${patientStageEnumIn.id eq patient.patientStageId }">
								<a href="javascript:void(0)" onclick="finishPatient('${patient.patientFlow}');" style="color: blue;">${patientStageEnumFinish.name}</a>
								&nbsp;|&nbsp;&nbsp;<a href="javascript:void(0)" onclick="patientStageNote('${patient.patientFlow}');" style="color: blue;">${patientStageEnumOff.name}</a>
							</c:when>
							<c:when test="${patientStageEnumOff.id eq patient.patientStageId }">
								${patient.patientStageName }&nbsp;&nbsp;|&nbsp;&nbsp;<a href="javascript:void(0)" onclick="patientStageNote('${patient.patientFlow}')" style="color: blue;">${patientStageEnumOff.name}原因</a>
							</c:when>
							<c:otherwise>
								${patient.patientStageName }
							</c:otherwise>
						</c:choose>
						<c:if test="${isBlind && patient.patientStageId != patientStageEnumFilter.id && !empty randomMap[patient.patientFlow] 
										&& randomMap[patient.patientFlow].promptStatusId != edcRandomPromptStatusEnumPrompted.id }">
							&nbsp;|&nbsp;&nbsp;<a href="javascript:void(0)" onclick="breakBlind('${patient.patientFlow}');" style="color: blue;">揭盲</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty patientList}"> 
				<tr> 
					<td align="center" colspan="8">无记录</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		</div>
</body>
</html>