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
	function search(){
		$("#appealSearchForm").submit();
	}
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
					 <form id="appealSearchForm" method="post" action="<s:url value='/res/teacher/appealReport/${roleFlag}'/>">
					 	轮转科室：
					 	<input type="text" name="schDeptName" value="${param.schDeptName}" style="width: 100px;"/>
					 	&#12288;
					 	申述名称：
					 	<input type="text" name="itemName" value="${param.itemName}" style="width: 100px;"/>
					 	&#12288;
					 	申述类别：
					 	<select name="recTypeId" style="width: 100px;" onchange="search();">
					 		<option value="">全部</option>
					 		<option value="${resRecTypeEnumDiseaseRegistry.id}" ${param.recTypeId eq resRecTypeEnumDiseaseRegistry.id?'selected':''}>${resRecTypeEnumDiseaseRegistry.typeName}</option>
							<option value="${resRecTypeEnumOperationRegistry.id}" ${param.recTypeId eq resRecTypeEnumOperationRegistry.id?'selected':''}>${resRecTypeEnumOperationRegistry.typeName}</option>
							<option value="${resRecTypeEnumSkillRegistry.id}" ${param.recTypeId eq resRecTypeEnumSkillRegistry.id?'selected':''}>${resRecTypeEnumSkillRegistry.typeName}</option>
					 	</select>
					 	&#12288;
					 	<label>
					 		<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y || param.recTypeId == null?"checked":""} onchange="search();"/>
					 		&nbsp;当前轮转科室
					 	</label>
					 	&#12288;
					 	<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
					 </form>
					 
					 <table class="xllist" style="margin-top: 10px;">
					 	<tr>
					 		<th width="10%">住院医师</th>
							<th width="10%">申述类别</th>
							<th width="10%">轮转科室</th>
							<th width="10%">申述名称</th>
							<th width="8%">申述数量</th>
							<th width="10%">申述时间</th>
							<th width="20%">申述理由</th>
							<th width="12%">带教老师审核</th>
<!-- 							<th width="10%">科主任审核</th> -->
						</tr>
						<c:forEach items="${doctorProcessList}" var="doctorProcess">
							<c:set value="${doctorProcess.schDeptFlow}${doctorProcess.userFlow}" var="key"/>
							<c:forEach items="${appealMap[key]}" var="appeal">
								<tr>
									<td>${appeal.operUserName}</td>
									<td>${appeal.recTypeId eq resRecTypeEnumDiseaseRegistry.id?resRecTypeEnumDiseaseRegistry.typeName:(appeal.recTypeId eq resRecTypeEnumOperationRegistry.id?resRecTypeEnumOperationRegistry.typeName:(appeal.recTypeId eq resRecTypeEnumSkillRegistry.id?resRecTypeEnumSkillRegistry.typeName:''))}</td>
									<td>${appeal.schDeptName}</td>
									<td>${appeal.itemName}</td>
									<td>${appeal.appealNum}</td>
									<td>${appeal.operTime}</td>
									<td title="${appeal.appealReason}">${pdfn:cutString(appeal.appealReason,15,true,1)}</td>
									<td style="line-height: 20px;">
										${empty appeal.auditStatusId?'未审核':(appeal.auditStatusId eq recStatusEnumTeacherAuditY?'审核通过':'审核不通过')}
									</td>
<!-- 									<td style="line-height: 20px;"> -->
<!-- 										${empty appeal.headAuditStatusId?'未审核':(appeal.headAuditStatusId eq recStatusEnumHeadAuditY?'审核通过':'审核不通过')} -->
<!-- 									</td> -->
								</tr>
							</c:forEach>
						</c:forEach>
						<c:if test="${empty appealMap}">
							<tr><td colspan="10">无记录</td></tr>
						</c:if>
					 </table>
		       	</div>
			</div>
		</div>
	</body>
</html>