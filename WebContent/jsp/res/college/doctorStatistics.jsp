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
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" method="post" action="<s:url value='/res/platform/doctorStatistics'/>">
					<table  class="basic" width="100%" style="margin-bottom: 10px;">
						<tr>
							<td>
								机构名称：<input type="text" name="orgName" value="${param.orgName}" onchange="search();">
								&#12288;
								专业：
									<select name="speId" onchange="search();">
										<option>
										<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="spe">
											<option value="${spe.dictId}" <c:if test="${param.speId eq spe.dictId}">selected</c:if> >${spe.dictName}</option>
										</c:forEach>
									</select>
								&#12288;
								届数：
									<select name="sessionNumber" onchange="search();">
										<option>
										<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="sessionNumber">
											<option value="${sessionNumber.dictId}" <c:if test="${param.sessionNumber eq sessionNumber.dictId}">selected</c:if> >${sessionNumber.dictName}</option>
										</c:forEach>
									</select>
							</td>
						</tr>
					</table>
				</form>
				<table class="basic" width="100%">
					<tr>
						<th style="width: 120px;text-align: center;padding: 0;max-width: 120px;min-width: 120px;" rowspan="2">专业</th>
						<c:forEach items="${orgList}" var="org">
							<th style="width: 150px;text-align: center;padding: 0;max-width: 150px;min-width: 150px;" colspan="3">${org.orgName}</th>
						</c:forEach>
						<th style="width: 150px;text-align: center;padding: 0;max-width: 150px;min-width: 150px;" colspan="3">汇总统计</th>
					</tr>
					<tr>
						<c:forEach items="${orgList}" var="org">
							<th style="width: 50px;text-align: center;padding: 0;">招录</th>
							<th style="width: 50px;text-align: center;padding: 0;">在陪</th>
							<th style="width: 50px;text-align: center;padding: 0;">结业</th>
						</c:forEach>
						<th style="width: 50px;text-align: center;padding: 0;">招录</th>
						<th style="width: 50px;text-align: center;padding: 0;">在陪</th>
						<th style="width: 50px;text-align: center;padding: 0;">结业</th>
					</tr>
					<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="spe">
						<c:if test="${(!empty param.speId && spe.dictId eq param.speId) || empty param.speId}">
							<tr>
								<td style="text-align: center;padding: 0;">${spe.dictName}</td>
								<c:set value="0" var="allSum"/>
								<c:set value="0" var="traininSum"/>
								<c:set value="0" var="graduationSum"/>
								<c:forEach items="${orgList}" var="org">
									<c:set value="${org.orgFlow}${spe.dictId}" var="key"/>
									<td style="text-align: center;padding: 0;">${allCountMap[key]+0}</td>
									<c:set value="${allCountMap[key]+allSum}" var="allSum"/>
									<td style="text-align: center;padding: 0;">${countTrainingResultMap[key]+0}</td>
									<c:set value="${countTrainingResultMap[key]+traininSum}" var="traininSum"/>
									<td style="text-align: center;padding: 0;">${countGraduationResultMap[key]+0}</td>
									<c:set value="${countGraduationResultMap[key]+graduationSum}" var="graduationSum"/>
								</c:forEach>
								<td style="text-align: center;padding: 0;">${allSum}</td>
								<td style="text-align: center;padding: 0;">${traininSum}</td>
								<td style="text-align: center;padding: 0;">${graduationSum}</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>