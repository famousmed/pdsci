<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
	
	function editAppeal(appealFlow,schDeptFlow,isRead){
		jboxOpen("<s:url value='/res/rec/editAppeal'/>?appealFlow="+appealFlow+"&schDeptFlow="+schDeptFlow+"&isRead="+isRead,"编辑申述",700,400);
	}
	
	function operAppeal(appeal){
		var info = "确认删除?";
		if("statusId" in appeal){
			info = "确认提交?";
		}
		jboxConfirm(info,function(){
			jboxPost("<s:url value='/res/rec/operAppeal'/>",appeal,function(resp){
				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					search();
				}
			},null,true);
		},null);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="searchForm" method="post" action="<s:url value='/res/rec/appealList'/>">
			申述类别：
			<select name="recTypeId" style="width: 100px;" onchange="search();">
			<option value="">全部</option>
			<option value="${resRecTypeEnumDiseaseRegistry.id}" ${param.recTypeId eq resRecTypeEnumDiseaseRegistry.id?'selected':''}>${resRecTypeEnumDiseaseRegistry.typeName}</option>
			<option value="${resRecTypeEnumOperationRegistry.id}" ${param.recTypeId eq resRecTypeEnumOperationRegistry.id?'selected':''}>${resRecTypeEnumOperationRegistry.typeName}</option>
			<option value="${resRecTypeEnumSkillRegistry.id}" ${param.recTypeId eq resRecTypeEnumSkillRegistry.id?'selected':''}>${resRecTypeEnumSkillRegistry.typeName}</option>
			</select>
			&#12288;
			申述名称：
			<input name="itemName" value="${param.itemName}" type="text" />
			&#12288;
			申述时间：
			<input type="text" name="startTime" value="${param.startTime}" style="width: 100px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
			-
			<input type="text" name="endTime" value="${param.endTime}" style="width: 100px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
			<input type="button" class="search" onclick="search();" value="查&#12288;询"/>
		</form>
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;" id="doc">
				<table class="xllist" style="font-size: 14px;width: 100%">
						<tr>
							<th style="text-align: center;" width="10%">申述类别</th>
							<th style="text-align: center;" width="10%">轮转科室 </th>
							<th style="text-align: center;" width="10%">申述名称</th>
							<th style="text-align: center;" width="7%">申述数量 </th>
							<th style="text-align: center;" width="10%">申述时间</th>
							<th style="text-align: center;" width="25%">申述理由 </th>
							<th style="text-align: center;" width="12%">申述状态 </th>
							<!-- <th style="text-align: center;" width="15%">操作</th> -->
						</tr>
						<c:forEach items="${appealList}" var="appeal">
							<tr>
								<td>${appeal.recTypeId eq resRecTypeEnumDiseaseRegistry.id?resRecTypeEnumDiseaseRegistry.typeName:(appeal.recTypeId eq resRecTypeEnumOperationRegistry.id?resRecTypeEnumOperationRegistry.typeName:(appeal.recTypeId eq resRecTypeEnumSkillRegistry.id?resRecTypeEnumSkillRegistry.typeName:''))}</td>
								<td>${appeal.schDeptName}</td>
								<td>${appeal.itemName}</td>
								<td>${appeal.appealNum}</td>
								<td>${appeal.operTime}</td>
								<td title="${appeal.appealReason}">${pdfn:cutString(appeal.appealReason,15,true,1)}</td>
								<td>
									<c:if test="${empty appeal.headAuditStatusId && empty appeal.auditStatusId}">
										${appeal.statusName}
									</c:if>
									<c:if test="${!empty appeal.headAuditStatusId || !empty appeal.auditStatusId}">
										${empty appeal.headAuditStatusId?appeal.auditStatusName:appeal.headAuditStatusName}
									</c:if>
								</td>
								<%-- <td>
									<c:if test="${appeal.statusId eq recStatusEnumSubmit.id}">
										<a href="#" onclick="editAppeal('${appeal.appealFlow}','${appeal.schDeptFlow}',true);" style="color: blue">查看</a>
									</c:if>
									<c:if test="${appeal.statusId eq recStatusEnumEdit.id}">
										<a href="#" onclick="editAppeal('${appeal.appealFlow}','${appeal.schDeptFlow}',false);" style="color: blue">编辑</a>
										&#12288;
										<a href="#" onclick="operAppeal({'appealFlow':'${appeal.appealFlow}','statusId':'${recStatusEnumSubmit.id}'});" style="color: blue">提交</a>
										&#12288;
										<a href="#" onclick="operAppeal({'appealFlow':'${appeal.appealFlow}','recordStatus':'${GlobalConstant.RECORD_STATUS_N}'});" style="color: blue">删除</a>
									</c:if>
								</td> --%>
							</tr>
						</c:forEach>
						<c:if test="${empty appealList}">
		             		<tr><td colspan="8">无记录</td></tr>
		             	</c:if>
					</table>
		</div>
	</div>
</div>
</div>
</body>
</html>