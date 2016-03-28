<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<style type="text/css">
	select{width: 100px;height: 27px;}
</style>
<script type="text/javascript">

	function search(){
		$("#doctorSearchForm").submit();
	}
	
	function editAbsence(absenceFlow){
		var title = "新增缺勤信息";
		if(absenceFlow != null && absenceFlow != ''){
			title = "编辑缺勤信息";
		}
		jboxOpen("<s:url value='/res/doc/editAbsence'/>?resRoleScope=${resRoleScope}&absenceFlow="+absenceFlow+"&isRegister=${GlobalConstant.FLAG_Y}",title,800,500);
	}
	
	function editAbsence1(absenceFlow){
		var title = "新增缺勤信息";
		if(absenceFlow != null && absenceFlow != ''){
			title = "编辑缺勤信息";
		}
		jboxOpen("<s:url value='/sch/doc/aid/editAbsence'/>?resRoleScope=${resRoleScope}&absenceFlow="+absenceFlow+"&isRegister=${GlobalConstant.FLAG_Y}",title,800,400);
	}
	
	function delAbsence(absenceFlow){
		jboxConfirm("确认删除?" ,  function(){
			jboxStartLoading();
			var url = "<s:url value='/res/doc/delAbsence'/>?absenceFlow=" + absenceFlow;
			jboxPost(url, null,
				function(resp){
					if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
						window.location.reload(true);
					}
				}, null, true);
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				<form id="doctorSearchForm" method="post" action="<s:url value='/res/teacher/absentManage/${resRoleScope }'/>">
					<input type="hidden" name="firstFlag" value="${GlobalConstant.FLAG_N}">
					<table class="basic" width="100%" style="margin-bottom: 10px;">
						<tr>
							<td style="text-align: left;">
								届数：
								<select name="sessionNumber" style="width: 60px">
									<option></option>
									<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict" varStatus="status">
										<option value="${dict.dictName}" ${(param.sessionNumber eq dict.dictName or (GlobalConstant.FLAG_N != firstFlag and status.first))?'selected':''}>${dict.dictName}</option>
									</c:forEach>
								</select>&#12288;&#12288;
								培训专业：
								<select name="trainingSpeId">
									<option></option>
									<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
										<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
									</c:forEach>
								</select>&#12288;&#12288;
								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_CHARGE eq resRoleScope}">
								培训基地：
										<select name="orgFlow">
											<option></option>
											<c:forEach items="${applicationScope.sysOrgList}" var="org">
												<option value="${org.orgFlow}" ${param.orgFlow eq org.orgFlow?'selected':''}>${org.orgName}</option>
											</c:forEach>
										</select>&#12288;&#12288;
								</c:if>
								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER eq resRoleScope || GlobalConstant.RES_ROLE_SCOPE_CHARGE eq resRoleScope}">
									轮转科室：
									<select name="deptFlow">
										<option value=""></option>
										<c:forEach items="${schDeptList}" var="schDetp">
											<option value="${schDetp.schDeptFlow}" <c:if test="${param.deptFlow eq schDetp.schDeptFlow}">selected="selected"</c:if>>${schDetp.schDeptName}</option>
										</c:forEach>
									</select>&#12288;&#12288;
								</c:if>
								姓名：<input type="text" name="doctorName" value="${param.doctorName}"  style="width: 60px;"/>&#12288;&#12288;
								<input type="button" class="search" onclick="search();" value="查&#12288;询"/>
<%-- 								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER != resRoleScope}"> --%>
									<input type="button" class="search" onclick="editAbsence('');" value="缺勤登记"/>
<%-- 								</c:if> --%>
							</td>
						</tr>
					</table>
				</form>
			</div>
				<table class="xllist" >
						<tr>
							<c:if test="${GlobalConstant.RES_ROLE_SCOPE_CHARGE eq resRoleScope}">
							<th style="text-align: center;width: 10%;" >培训基地</th>
							</c:if>
							<th style="text-align: center;width: 8%;" >医师姓名</th>
							<th style="text-align: center;width: 5%;" >届数</th>
							<th style="text-align: center;width: 13%;" >专业</th>
							<th style="text-align: center;width: 10%;" >开始时间</th>
							<th style="text-align: center;width: 10%;" >结束时间</th>
							<th style="text-align: center;width: 8%;" >缺勤天数</th>
							<th style="text-align: center;width: 8%;" >缺勤天数合计</th>
							<th style="text-align: center;width: 8%;" >缺勤类型</th>
							<th style="text-align: center;">缺勤原因</th>
							<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER != resRoleScope}">
							<th style="text-align: center;width: 10%;" >操作</th>
							</c:if>
						</tr>
						<tbody>
							<c:set var="emptyRecord" value="true"/>
							<c:forEach items="${doctorList}" var="doctor">
								<c:if test="${!empty docAbsenceMap[doctor.doctorFlow]}">
										<c:set var="emptyRecord" value="false"></c:set>
										<c:set value="${docAbsenceMap[doctor.doctorFlow].size()}" var="colspan"></c:set>
										<c:set value="0" var="absenceCount"></c:set>
										<c:forEach items="${docAbsenceMap[doctor.doctorFlow]}" var="docAbsence" varStatus="status">
											<c:set value="${absenceCount + docAbsence.intervalDay}" var="absenceCount"></c:set>
											<tr>
												<c:if test="${resRoleScope eq GlobalConstant.RES_ROLE_SCOPE_CHARGE}">
												<td>${docAbsence.orgName}</td>
												</c:if>
												<c:if test="${status.first}">
													<td rowspan="${colspan}">${doctor.doctorName}</td>
													<td rowspan="${colspan}">${doctor.sessionNumber}</td>
													<td rowspan="${colspan}">${doctor.trainingSpeName}</td>
												</c:if>
												<td>${docAbsence.startDate}</td>
												<td>${docAbsence.endDate}</td>
												<td>${docAbsence.intervalDay}</td>
												<c:if test="${status.first}">
													<td rowspan="${colspan}" id="count${doctor.doctorFlow}"></td>
												</c:if>
												<td>${docAbsence.absenceTypeName}</td>
												<td>${docAbsence.absenceReson}</td>
												<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER != resRoleScope}">
												<td>
												<c:if test="${GlobalConstant.FLAG_Y eq docAbsence.isRegister}">
													<a href="javascript:editAbsence('${docAbsence.absenceFlow}')" class="edit" style="color: blue">编辑</a> |
													<a href="javascript:delAbsence('${docAbsence.absenceFlow}')" style="color: blue" class="ll">删除</a>
												</c:if>
												</td>
												</c:if>
											</tr>
											<c:if test="${status.last}">
												<script type="text/javascript">$("#count${doctor.doctorFlow}").text("${absenceCount}");</script>
											</c:if>
										</c:forEach>
									
								</c:if>
							</c:forEach>
						</tbody>
						<c:if test="${emptyRecord}">
							<tr><td align="center" colspan="11">无记录</td></tr>
						</c:if>
					</table>
	</div>
</div>
</div>
</body>
</html>