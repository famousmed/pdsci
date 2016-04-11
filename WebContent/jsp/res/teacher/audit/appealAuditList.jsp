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
</jsp:include>
</head>
<script type="text/javascript">
	var auditStatus = {
		<c:if test="${roleFlag eq 'teacher'}">
			"yes":"${recStatusEnumTeacherAuditY.id}",
			"no":"${recStatusEnumTeacherAuditN.id}",
			"attrName":"auditStatusId",
		</c:if>
		<c:if test="${roleFlag eq 'head'}">
			"yes":"${recStatusEnumHeadAuditY.id}",
			"no":"${recStatusEnumHeadAuditN.id}",
			"attrName":"headAuditStatusId",
		</c:if>
	};
	function search(){
		$("#appealSearchForm").submit();
	}
	
	function appealAudit(appealFlow,schDeptFlow){
		jboxOpen("<s:url value='/res/rec/editAppeal'/>?appealFlow="+appealFlow+"&schDeptFlow="+schDeptFlow+"&isAudit=true","审核申述",700,400);
	}
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
					 <form id="appealSearchForm" method="post" action="<s:url value='/res/teacher/appealAudit/${roleFlag}'/>">
					 	<!-- 带教老师：
					 	<select name="auditStatusId" style="width:100px;" onchange="search();">
					 		<option value=""></option>
					 		<option value="${recStatusEnumTeacherAuditN.id}" ${param.auditStatusId eq recStatusEnumTeacherAuditN.id?"selected":""}>未审核</option>
					 		<option value="${recStatusEnumTeacherAuditY.id}" ${param.auditStatusId eq recStatusEnumTeacherAuditY.id?"selected":""}>已审核</option>
					 	</select> -->
<!-- 					 	&#12288; -->
<!-- 					 	科主任： -->
<!-- 					 	<select name="headAuditStatusId" style="width:100px;" onchange="search();"> -->
<!-- 					 		<option value=""></option> -->
<!-- 					 		<option value="${recStatusEnumHeadAuditN.id}" ${param.headAuditStatusId eq recStatusEnumHeadAuditN.id?"selected":""}>未审核</option> -->
<!-- 					 		<option value="${recStatusEnumHeadAuditY.id}" ${param.headAuditStatusId eq recStatusEnumHeadAuditY.id?"selected":""}>已审核</option> -->
<!-- 					 	</select> -->
					 	&#12288;
					 	<label>
					 		<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y || param.headAuditStatusId == null?"checked":""} onchange="search();"/>
					 		&nbsp;当前轮转科室
					 	</label>
					 </form>
					 
					 <table class="xllist" style="margin-top: 10px;">
					 	<tr>
					 		<th width="10%">住院医师</th>
					 		<th width="10%">轮转科室</th>
							<th width="8%">申述类别</th>
							<th width="10%">申述名称</th>
							<th width="7%">申述数量</th>
							<th width="10%">申述时间</th>
							<th width="25%">申述理由</th>
							<th width="10%">带教老师审核</th>
<!-- 							<th width="10%">科主任审核</th> -->
						</tr>
						<c:forEach items="${doctorProcessList}" var="doctorProcess">
							<c:set value="${doctorProcess.schDeptFlow}${doctorProcess.userFlow}" var="key"/>
							<c:forEach items="${appealMap[key]}" var="appeal">
								<tr>
									<td>${appeal.operUserName}</td>
									<td>${appeal.schDeptName}</td>
									<td>${appeal.recTypeId eq resRecTypeEnumDiseaseRegistry.id?resRecTypeEnumDiseaseRegistry.typeName:(appeal.recTypeId eq resRecTypeEnumOperationRegistry.id?resRecTypeEnumOperationRegistry.typeName:(appeal.recTypeId eq resRecTypeEnumSkillRegistry.id?resRecTypeEnumSkillRegistry.typeName:''))}</td>
									<td>${appeal.itemName}</td>
									<td>${appeal.appealNum}</td>
									<td>${appeal.operTime}</td>
									<td title="${appeal.appealReason}">${pdfn:cutString(appeal.appealReason,15,true,1)}</td>
									<td>
										<c:if test="${empty appeal.auditStatusId}">
											<c:if test="${roleFlag eq 'teacher'}">
												<a href="javascript:appealAudit('${appeal.appealFlow}','${appeal.schDeptFlow}');" style="color:blue;">
											</c:if>
												待审核
											<c:if test="${roleFlag eq 'teacher'}">
												</a>
											</c:if>
										</c:if>
										<c:if test="${!empty appeal.auditStatusId}">
											<c:if test="${roleFlag eq 'teacher' && appeal.auditStatusId eq recStatusEnumTeacherAuditN.id}">
												<a href="javascript:appealAudit('${appeal.appealFlow}','${appeal.schDeptFlow}');" style="color:blue;">
											</c:if>
												${appeal.auditStatusId eq recStatusEnumTeacherAuditY?'审核通过':'审核不通过'}
											<c:if test="${roleFlag eq 'teacher' && appeal.auditStatusId eq recStatusEnumTeacherAuditN.id}">
												</a>
											</c:if>
										</c:if>
									</td>
<!-- 									<td> -->
<!-- 										<c:if test="${empty appeal.headAuditStatusId}"> -->
<!-- 											<c:if test="${roleFlag eq 'head'}"> -->
<!-- 												<a href="javascript:appealAudit('${appeal.appealFlow}','${appeal.schDeptFlow}');" style="color:blue;"> -->
<!-- 											</c:if> -->
<!-- 												待审核 -->
<!-- 											<c:if test="${roleFlag eq 'head'}"> -->
<!-- 												</a> -->
<!-- 											</c:if> -->
<!-- 										</c:if> -->
<!-- 										<c:if test="${!empty appeal.headAuditStatusId}"> -->
<!-- 											<c:if test="${roleFlag eq 'head' && appeal.auditStatusId eq recStatusEnumTeacherAuditN.id}"> -->
<!-- 												<a href="javascript:appealAudit('${appeal.appealFlow}','${appeal.schDeptFlow}');" style="color:blue;"> -->
<!-- 											</c:if> -->
<!-- 												${appeal.headAuditStatusId eq recStatusEnumHeadAuditY?'审核通过':'审核不通过'} -->
<!-- 											<c:if test="${roleFlag eq 'head' && appeal.auditStatusId eq recStatusEnumTeacherAuditN.id}"> -->
<!-- 												</a> -->
<!-- 											</c:if> -->
<!-- 										</c:if> -->
<!-- 									</td> -->
								</tr>
							</c:forEach>
						</c:forEach>
						<c:if test="${empty appealMap}">
							<tr><td colspan="9">无记录</td></tr>
						</c:if>
					 </table>
		       	</div>
			</div>
		</div>
	</body>
</html>