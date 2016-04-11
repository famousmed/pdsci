<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<%-- <jsp:include page="/jsp/common/htmlhead.jsp"> --%>
<%-- 	<jsp:param name="basic" value="true"/> --%>
<%-- 	<jsp:param name="jbox" value="true"/> --%>
<%-- 	<jsp:param name="jquery_form" value="false"/> --%>
<%-- 	<jsp:param name="jquery_ui_tooltip" value="true"/> --%>
<%-- 	<jsp:param name="jquery_ui_combobox" value="false"/> --%>
<%-- 	<jsp:param name="jquery_ui_sortable" value="false"/> --%>
<%-- 	<jsp:param name="jquery_cxselect" value="true"/> --%>
<%-- 	<jsp:param name="jquery_scrollTo" value="false"/> --%>
<%-- 	<jsp:param name="jquery_jcallout" value="false"/> --%>
<%-- 	<jsp:param name="jquery_validation" value="false"/> --%>
<%-- 	<jsp:param name="jquery_datePicker" value="true"/> --%>
<%-- 	<jsp:param name="jquery_fullcalendar" value="false"/> --%>
<%-- 	<jsp:param name="jquery_fngantt" value="false"/> --%>
<%-- 	<jsp:param name="jquery_fixedtableheader" value="false"/> --%>
<%-- 	<jsp:param name="jquery_placeholder" value="false"/> --%>
<%-- 	<jsp:param name="jquery_iealert" value="false"/> --%>
<%-- </jsp:include> --%>
	<script type="text/javascript">
 	function edit(flow){
 		var url="<s:url value='/res/rec/showRegistryForm'/>?roleFlag=${param.roleFlag}&recTypeId=${param.recTypeId}&operUserFlow=${doctor.doctorFlow}&schDeptFlow=${doctor.deptFlow}&userFlow=${doctor.doctorFlow}&recFlow="+flow;
 		jboxOpen(url,"${globalRecName}",800,500);
 	}
 	function del(flow){
 		jboxConfirm("确认删除？", function() {
 			url="<s:url value='/res/rec/delResrec'/>?recFlow="+flow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}";
 			jboxPost(url , null , function(obj){
 				if(obj=="${GlobalConstant.DELETE_SUCCESSED}"){
 					$("#tags .selectTag a").click();
 				}
 		});
 		});
 	} 
	</script>
<%-- 	<c:if test="${roleFlag==GlobalConstant.USER_LIST_LOCAL }"> --%>
<%--    	<c:if test="${empty study.auditStatusId || study.auditStatusId==achStatusEnumRollBack.id}"> --%>
<%-- 	   	<a style="cursor:pointer; color: blue;" onclick="edit('${study.studyFlow}')">编辑</a> | --%>
<%-- 	   	<a style="cursor:pointer; color: blue;" onclick="del('${study.studyFlow}')">删除</a> --%>
<%-- 	</c:if> --%>
<%-- 	<c:if test="${study.auditStatusId==achStatusEnumFirstAudit.id || study.auditStatusId==achStatusEnumSubmit.id}"> --%>
		
<%-- 			<a style="cursor:pointer;  color: blue;" onclick="edit('${study.studyFlow}')">查看</a>  --%>
<%-- 	</c:if> --%>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="speAbilityAssess">
					<div align="right">
						<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<input type="button"  class="search" onclick="edit('');" value="新&#12288;增"/>
						</c:if>
					</div>
				</form>
				<c:forEach items="${recList}" var="rec">
					<div class="ith" style="cursor: pointer;border: 1px solid #ccc;margin-top: 10px;padding: 10px;">
						<div style="float: right;">
						<c:if test="${param.roleFlag == GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<c:if test="${!(!empty rec.managerAuditStatusId || !empty rec.auditStatusId || !empty rec.headAuditStatusId)}">
							<a style="color: blue;cursor: pointer;" onclick="edit('${rec.recFlow}')">编辑</a>	
							|
							<a style="color: blue;cursor: pointer;" onclick="del('${rec.recFlow}');">删除</a>
						</c:if>
							<c:if test="${!empty rec.managerAuditStatusId || !empty rec.auditStatusId || !empty rec.headAuditStatusId}">
								<a style="color: blue;cursor: pointer;" onclick="edit('${rec.recFlow}')">查看</a>
							</c:if>
						</c:if>
						<c:if test="${param.roleFlag != GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
							<a style="color: blue;cursor: pointer;" onclick="edit('${rec.recFlow}')">审核</a>	
						</c:if>
						</div>
						<div style="width: 80%;">
							<c:forEach items="${viewListMap[rec.recFlow]}" var="viewInfo">
								<c:if test="${rec.recTypeId == globalRecTypeEnumAnnualActivity.id}">
									<c:if test="${viewInfo.title != '内容'}">
										&#12288;${viewInfo.title}：${viewInfo.value}
									</c:if>
								</c:if>
								<c:if test="${rec.recTypeId != globalRecTypeEnumAnnualActivity.id}">
									&#12288;${viewInfo.title}：${viewInfo.value}
								</c:if>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
				<c:if test="${empty recList}">
					<div class="ith" style="cursor: pointer;border: 1px solid #ccc;margin-top: 10px;padding: 10px;text-align: center;">
						无记录
					</div>
				</c:if>
			</div>
		</div>
		</div>
</body>
</html>