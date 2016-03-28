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
		$("#headScoreForm").submit();
	}
	
	$(function(){
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="headScoreForm" action="<s:url value='/res/teacher/teacherAudit'/>" >
				科室：${sessionScope.currUser.deptName}
				&#12288;
				科主任：${sessionScope.currUser.userName}
				&#12288;
				&#12288;
				&#12288;
				轮转科室：
				<select name="schDeptFlow" style="width:100px" onchange="search();">
					<option></option>
					<c:forEach items="${deptList}" var="dept">
						<option value="${dept.schDeptFlow}" ${param.schDeptFlow eq dept.schDeptFlow?'selected':''}>${dept.schDeptName}</option>
					</c:forEach>
				</select>
				&#12288;
				<label>
					<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y || param.schDeptFlow == null?"checked":""} onchange="search();"/>&nbsp;当前轮转科室
				</label>
			</form>
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th>科室</th>
					<th>带教老师</th>
					<th>待审核</th>
					<th>已审核</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${auditCountMap}" var="auditCount">
					<tr>
						<td>${auditCount.value.schDeptName}</td>
						<td>${auditCount.value.teacherUserName}</td>
						<td>${auditCount.value.isNotAudit}</td>
						<td>${auditCount.value.isAudit}</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${empty auditCountMap}">
				<tr><td colspan="4">无记录</td></tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>