<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		location.href="<s:url value='/res/manager/recDetail'/>?recTypeId=${param.recTypeId}&userFlow=${param.userFlow}&schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}&itemName=${param.itemName}&currentPage="+$("#currentPage").val();
	} 
</script>
</head>
<body>
	<div class="i-trend-main-div" style="padding: 15px 10px;">
	<div style="margin-bottom: 10px;">
		住院医师：${doctorName}
		&#12288;
		轮转科室：${schDeptName}
	</div>
	<div style="width: 100%;overflow: auto;">
		<c:if test="${param.recTypeId eq resRecTypeEnumCaseRegistry.id}">
			<table class="xllist" style="width: 1200px;">
			<tr>
				<th style="width:100px;">病人姓名</th>
				<th style="width:100px;">住院号</th>
				<th style="width:100px;">疾病名称</th>
				<th style="width:150px;">操作时间</th>
				<th style="width:200px;">诊断类型</th>
				<th style="width:100px;">诊断</th>
				<th style="width:200px;">抢救措施</th>
				<th style="width:150px;">死亡原因分析</th>
				<th style="width:300px;">记录</th>
				<th style="width:100px;">审核情况</th>
			</tr>
			<c:forEach items="${recList}" var="rec">
				<tr>
					<td>${recContentMap[rec.recFlow].patientName}</td>
					<td>${recContentMap[rec.recFlow].hospitalNumbers}</td>
					<td>${recContentMap[rec.recFlow].diseaseName}</td>
					<td>${pdfn:transDateTime(recContentMap[rec.recFlow].operTime)}</td>
					<td>${recContentMap[rec.recFlow].diagnoseType}</td>
					<td>${recContentMap[rec.recFlow].diagnose}</td>
					<td>${recContentMap[rec.recFlow].saveStep}</td>
					<td>${recContentMap[rec.recFlow].dieReasonParse}</td>
					<td>${recContentMap[rec.recFlow].caseRecord}</td>
					<td>
						<c:if test="${empty rec.auditStatusId}">
							待审核
						</c:if>
						<c:if test="${!empty rec.auditStatusId}">
							${rec.auditStatusId eq recStatusEnumTeacherAuditY.id?'通过':'不通过'}
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty recList}">
				<tr><td colspan="20">无记录</td></tr>
			</c:if>
			</table>
		</c:if>
		<c:if test="${param.recTypeId eq resRecTypeEnumDiseaseRegistry.id}">
			<table class="xllist" style="width: 1200px;">
			<tr>
				<th style="width:100px;">病种名称</th>
				<th style="width:100px;">病人姓名</th>
				<th style="width:100px;">病历号</th>
				<th style="width:150px;">治疗措施</th>
				<th style="width:100px;">类型</th>
				<th style="width:100px;">入院日期</th>
				<th style="width:100px;">状态</th>
				<th style="width:100px;">病历类型</th>
				<th style="width:100px;">诊断类型</th>
				<th style="width:150px;">备注</th>
				<th style="width:300px;">记录</th>
				<th style="width:100px;">审核情况</th>
			</tr>
			<c:forEach items="${recList}" var="rec">
			<tr>
				<td>${deptReqMap[recContentMap[rec.recFlow].diseaseName].itemName}</td>
				<td>${recContentMap[rec.recFlow].patientName}</td>
				<td>${recContentMap[rec.recFlow].caseNo}</td>
				<td>${recContentMap[rec.recFlow].treatMeasure}</td>
				<td>${recContentMap[rec.recFlow].recType}</td>
				<td>${recContentMap[rec.recFlow].inHosDate}</td>
				<td>${recContentMap[rec.recFlow].recStatus}</td>
				<td>${recContentMap[rec.recFlow].caseType}</td>
				<td>${recContentMap[rec.recFlow].diagnosisType}</td>
				<td>${recContentMap[rec.recFlow].remark}</td>
				<td>${recContentMap[rec.recFlow].record}</td>
				<td>
					<c:if test="${empty rec.auditStatusId}">
						待审核
					</c:if>
					<c:if test="${!empty rec.auditStatusId}">
						${rec.auditStatusId eq recStatusEnumTeacherAuditY.id?'通过':'不通过'}
					</c:if>
				</td>
			</tr>
			</c:forEach>
			<c:if test="${empty recList}">
				<tr><td colspan="20">无记录</td></tr>
			</c:if>
			</table>
		</c:if>
		<c:if test="${param.recTypeId eq resRecTypeEnumOperationRegistry.id}">
			
		</c:if>
		<c:if test="${param.recTypeId eq resRecTypeEnumSkillRegistry.id}">
			<table class="xllist" style="width: 1200px;">
			<tr>
				<th style="width:100px;">操作名称</th>
				<th style="width:100px;">操作日期</th>
				<th style="width:100px;">操作时机</th>
				<th style="width:100px;">病人姓名</th>
				<th style="width:100px;">病历号</th>
				<th style="width:150px;">目的</th>
				<th style="width:100px;">状态</th>
				<th style="width:100px;">操作类别</th>
				<th style="width:100px;">诊断类型</th>
				<th style="width:150px;">失败原因</th>
				<th style="width:150px;">备注</th>
				<th style="width:300px;">记录</th>
				<th style="width:100px;">审核情况</th>
			</tr>
			<c:forEach items="${recList}" var="rec">
				<tr>
					<td>${deptReqMap[recContentMap[rec.recFlow].operateName].itemName}</td>
					<td>${recContentMap[rec.recFlow].operateDate}</td>
					<td>${recContentMap[rec.recFlow].operateTime}</td>
					<td>${recContentMap[rec.recFlow].patientName}</td>
					<td>${recContentMap[rec.recFlow].caseNo}</td>
					<td>${recContentMap[rec.recFlow].objective}</td>
					<td>${recContentMap[rec.recFlow].status}</td>
					<td>${recContentMap[rec.recFlow].operateType}</td>
					<td>${recContentMap[rec.recFlow].diagnosisType}</td>
					<td>${recContentMap[rec.recFlow].failReason}</td>
					<td>${recContentMap[rec.recFlow].remark}</td>
					<td>${recContentMap[rec.recFlow].record}</td>
					<td>
						<c:if test="${empty rec.auditStatusId}">
							待审核
						</c:if>
						<c:if test="${!empty rec.auditStatusId}">
							${rec.auditStatusId eq recStatusEnumTeacherAuditY.id?'通过':'不通过'}
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty recList}">
				<tr><td colspan="20">无记录</td></tr>
			</c:if>
			</table>
		</c:if>
		<c:if test="${param.recTypeId eq resRecTypeEnumOperationRegistry.id}">
			<table class="xllist" style="width: 2200px;">
			<tr>
				<th style="width:100px;">手术名称</th>
				<th style="width:100px;">具体名称</th>
				<th style="width:100px;">手术日期</th>
				<th style="width:100px;">操作时机</th>
				<th style="width:100px;">病人姓名</th>
				<th style="width:100px;">病历号</th>
				<th style="width:100px;">目的</th>
				<th style="width:100px;">术前术后诊断</th>
				<th style="width:100px;">手术过程</th>
				<th style="width:100px;">掌握情况</th>
				<th style="width:100px;">麻醉方法</th>
				<th style="width:100px;">术中操作</th>
				<th style="width:100px;">特殊情况</th>
				<th style="width:100px;">术中职务</th>
				<th style="width:100px;">诊断类型</th>
				<th style="width:150px;">备注</th>
				<th style="width:300px;">记录</th>
				<th style="width:100px;">审核情况</th>
			</tr>
			<c:forEach items="${recList}" var="rec">
				<tr>
					<td>${deptReqMap[recContentMap[rec.recFlow].operationName].itemName}</td>
					<td>${recContentMap[rec.recFlow].specificName}</td>
					<td>${recContentMap[rec.recFlow].operationDate}</td>
					<td>${recContentMap[rec.recFlow].operateTime}</td>
					<td>${recContentMap[rec.recFlow].patientName}</td>
					<td>${recContentMap[rec.recFlow].caseNo}</td>
					<td>${recContentMap[rec.recFlow].objective}</td>
					<td>${recContentMap[rec.recFlow].aroundDiagnosis}</td>
					<td>${recContentMap[rec.recFlow].operationProcedure}</td>
					<td>${recContentMap[rec.recFlow].masterStep}</td>
					<td>${recContentMap[rec.recFlow].anesthesiaMethod}</td>
					<td>${recContentMap[rec.recFlow].operate}</td>
					<td>${recContentMap[rec.recFlow].special}</td>
					<td>${recContentMap[rec.recFlow].operatePost}</td>
					<td>${recContentMap[rec.recFlow].diagnosisType}</td>
					<td>${recContentMap[rec.recFlow].remark}</td>
					<td>${recContentMap[rec.recFlow].record}</td>
					<td>
						<c:if test="${empty rec.auditStatusId}">
							待审核
						</c:if>
						<c:if test="${!empty rec.auditStatusId}">
							${rec.auditStatusId eq recStatusEnumTeacherAuditY.id?'通过':'不通过'}
						</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty recList}">
				<tr><td colspan="20">无记录</td></tr>
			</c:if>
			</table>
		</c:if>
	</div>
	<div>
   	 	<input id="currentPage" type="hidden" name="currentPage" value=""/>
       	<c:set var="pageView" value="${pdfn:getPageView(recList)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>	 
    </div>
	<div align="center" style="margin-top: 10px;">
		<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();"/>
	</div>
</div>
</body>
</html>
