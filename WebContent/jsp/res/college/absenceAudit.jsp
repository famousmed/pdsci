<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		search();
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" method="post" action="<s:url value='/res/platform/absenceAudit'/>">
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<table  class="basic" width="100%" style="margin-bottom: 10px;">
						<tr>
							<td>
								姓名：
								<input type="text" name="doctorName" value="${param.doctorName}" onchange="search();" style="width: 80px;">
								&#12288;&#12288;
								 培训基地：
								<select name="orgFlow" onchange="search();" style="width: 150px;">
									<option></option>
									<c:forEach items="${applicationScope.sysOrgList}" var="org">
										<option value="${org.orgFlow}" ${param.orgFlow eq org.orgFlow?'selected':''}>${org.orgName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</table>
				</form>
				<table class="basic" width="100%">
					<tr>
						<th style="text-align: center;padding: 0;">培训基地</th>
						<th style="text-align: center;padding: 0;">轮转科室</th>
						<th style="text-align: center;padding: 0;">姓名</th>
						<th style="text-align: center;padding: 0;">请假类型</th>
						<th style="text-align: center;padding: 0;">请假时间</th>
						<th style="text-align: center;padding: 0;">请假事由</th>
						<th style="text-align: center;padding: 0;">带教老师</th>
						<th style="text-align: center;padding: 0;">科主任</th>
						<c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">
						<th style="text-align: center;padding: 0;">医教部门</th>
						</c:if>
					</tr>
					<c:forEach items="${absenceList}" var="absence">
						<tr>
							<td style="text-align: center;padding: 0;">${absence.orgName}</td>
							<td style="text-align: center;padding: 0;">${absence.schDeptName}</td>
							<td style="text-align: center;padding: 0;">${absence.doctorName}</td>
							<td style="text-align: center;padding: 0;">${absence.absenceTypeName}</td>
							<td style="text-align: center;padding: 0;line-height: 22px;">
								${absence.startDate}~${absence.endDate}<br/>
								<font style="font-weight: bold;">
									(${absence.intervalDay}天)
								</font>
							</td>
							<td style="text-align: center;padding: 0;">${absence.schDeptName}</td>
							<td style="text-align: center;padding: 0;line-height: 22px;">
								<c:if test="${!empty absence.teacherAgreeFlag}">
									${absence.teacherName}<br/>
									<c:if test="${GlobalConstant.FLAG_N eq absence.teacherAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" title="不同意"/>
									</c:if>
									<c:if test="${GlobalConstant.FLAG_Y eq absence.teacherAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" title="同意"/>
									</c:if>
								</c:if>
							</td>
							<td style="text-align: center;padding: 0;line-height: 22px;">
								<c:if test="${!empty absence.headAgreeFlag}">
									${absence.headName}<br/>
									<c:if test="${GlobalConstant.FLAG_N eq absence.headAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" title="不同意"/>
									</c:if>
									<c:if test="${GlobalConstant.FLAG_Y eq absence.headAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" title="同意"/>
									</c:if>
								</c:if>
							</td>
							<c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">
							<td style="text-align: center;padding: 0;line-height: 22px;">
								<c:if test="${!empty absence.managerAgreeFlag}">
									${absence.managerName}<br/>
									<c:if test="${GlobalConstant.FLAG_N eq absence.managerAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" title="不同意"/>
									</c:if>
									<c:if test="${GlobalConstant.FLAG_Y eq absence.managerAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" title="同意"/>
									</c:if>
								</c:if>
							</td>
							</c:if>
						</tr>
					</c:forEach>
					<c:if test="${empty absenceList}">
						<tr>
							<td colspan="9" style="text-align: center;padding: 0;">无记录</td>
						</tr>
					</c:if>
				</table>
				<div>
				   	<c:set var="pageView" value="${pdfn:getPageView(absenceList)}" scope="request"/>
					<pd:pagination toPage="toPage"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>