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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<script type="text/javascript">
	function search(){
		$("#recSearchForm").submit();
	}
	
	function openDetail(recFlow,title,width,hight){
		jboxOpen("<s:url value='/res/rec/showRegistryForm'/>?recFlow="+recFlow,title,width,hight);
	}
	
	function openSummary(recFlow){
		openDetail(recFlow,"出科小结",700,500);
	}
	
	function openEvaluation(recFlow){
		openDetail(recFlow,"出科考核表",1000,500);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="recSearchForm" method="post" action="<s:url value='/res/teacher/docoutReport/${roleFlag}'/>">
			带教老师：
		 	<select name="auditStatusId" style="width:100px;" onchange="search();">
		 		<option value=""></option>
		 		<option value="${recStatusEnumTeacherAuditN.id}" ${param.auditStatusId eq recStatusEnumTeacherAuditN.id?"selected":""}>未审核</option>
		 		<option value="${recStatusEnumTeacherAuditY.id}" ${param.auditStatusId eq recStatusEnumTeacherAuditY.id?"selected":""}>已审核</option>
		 	</select>
		 	&#12288;
		 	科主任：
		 	<select name="headAuditStatusId" style="width:100px;" onchange="search();">
		 		<option value=""></option>
		 		<option value="${recStatusEnumHeadAuditN.id}" ${param.headAuditStatusId eq recStatusEnumHeadAuditN.id?"selected":""}>未审核</option>
		 		<option value="${recStatusEnumHeadAuditY.id}" ${param.headAuditStatusId eq recStatusEnumHeadAuditY.id?"selected":""}>已审核</option>
		 	</select>
		 	&#12288;
		 	医师姓名：
		 	<input type="text" name="operUserName" value="${param.operUserName}" onchange="search();"/>
			&#12288;
			<label>
			<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y || param.headAuditStatusId == null?"checked":""} onchange="search();"/>&nbsp;当前轮转科室
			</label>
		</form>
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th width="150px;">住院医师</th>
					<th width="150px;">轮转科室</th>
					<th width="150px;">出科考核</th>
					<th width="150px;">出科小结</th>
					<th width="200px;">轮转时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${doctorProcessList}" var="doctorProcess">
					<c:set value="${doctorProcess.schDeptFlow}${doctorProcess.userFlow}summary" var="summaryKey"/>
					<c:if test="${!empty recMap[summaryKey]}">
						<c:set value="${doctorProcess.schDeptFlow}${doctorProcess.userFlow}evaluation" var="evaluationKey"/>
						<tr>
							<td>${recMap[summaryKey].operUserName}</td>
							<td>${doctorProcess.schDeptName}</td>
							<td>
								<a href="javascript:openEvaluation('${recMap[evaluationKey].recFlow}');" style="color: blue">
									出科考核表 (${scoreMap[evaluationKey]+0})
								</a>
							</td>
							<td>
								<a href="javascript:openSummary('${recMap[summaryKey].recFlow}');" style="color: blue">
									出科小结
								</a>
							</td>
							<td>
								${doctorProcess.startDate} ~ ${doctorProcess.endDate}
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${empty recMap}">
					<tr><td colspan="7">无记录</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>