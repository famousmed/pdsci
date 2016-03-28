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
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	$(function(){
		$("#detail").slideInit({
			width:1000,
			speed:500,
			outClose:true
		});
	});
	
	function search(){
		$("#doctorForm").submit();
	}
	
	function loadDeatil(userFlow){
		jboxPost("<s:url value='/res/doc/annualTrainForm'/>?doctorFlow="+userFlow+"&roleFlag=${GlobalConstant.RES_ROLE_SCOPE_TEACHER}",null,function(resp){
			$("#detail").html(resp).rightSlideOpen();
		},null,false);
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<form id="doctorForm" action="<s:url value='/res/teacher/annualTrainRecords'/>" method="post">
		<table class="basic" style="width:100%;">
			<tr>
				<td>
					姓名：
					<input type="text" name="userName" value="${param.userName}" onchange="search();" style="width: 100px;"/>
					&#12288;
					<label>
						<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" <c:if test="${param.isCurrentFlag eq GlobalConstant.FLAG_Y || isCurrentFlag eq GlobalConstant.FLAG_Y}">checked</c:if>  onchange="search();"/>
						当前轮转科室
					</label>
				</td>
			</tr>
		</table>
		</form>
	</div>
	 <table class="xllist">
		<tr>
			<th width="15%">学号/工号</th>
			<th width="20%">学员姓名</th>
			<th width="20%">岗前培训表</th>
			<th width="20%">审核时间</th>
			<th width="20%">审核人</th>
			<th width="20%">状态</th>
		</tr>
		<c:forEach items="${userFlows}" var="flow">
			<c:set value="${doctorMap[flow]}" var="doctor"/>
			<tr>
				<td>${doctor.doctorCode}</td>
				<td>${doctor.doctorName}</td>
				<td>
					<c:if test="${!empty recMap[flow]}">
						[<a style="color: blue;cursor: pointer;" onclick="loadDeatil('${flow}');">
							详情
						</a>]
					</c:if>
				</td>
				<td>${pdfn:transDate(recMap[flow].auditTime)}</td>
				<td>${recMap[flow].auditUserName}</td>
				<td>
					<c:if test="${!empty recMap[flow] && empty recMap[flow].auditStatusId}">
						未审核
					</c:if>
					<c:if test="${!empty recMap[flow].auditStatusId}">
						已审核
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</div>
<div id="detail"></div>
</body>
</html>