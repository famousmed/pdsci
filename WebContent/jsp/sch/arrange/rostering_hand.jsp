<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	var rosteringDateTemp = {};
	
	$(document).ready(function(){
		loadDeptList('');
		$("#selDeptTab").hide();
	});

	function search(){
		$("#doctorSearchForm").submit();
	}
	
	function deptList(doctorFlow,doctor){
		loadDeptList(doctorFlow);
		$(".doctorTd").css({"color":""}); 
		$(doctor).css({"color":"red"});
	}
	
	function loadDeptList(doctorFlow){
		jboxLoad("dept","<s:url value='/sch/arrange/rostering_hand_dept'/>?doctorFlow="+doctorFlow,true);
	}
</script>
</head>
<body>
	<div class="main_fix" style="overflow: hidden;margin-top: -45px" >
		<div id="main">
			<div style="width: 22%;float: left;overflow: auto;height: 98%;" class="side">
				<form action="<s:url value='/sch/arrange/searchRostering_hand'/>" method="post" id="doctorSearchForm">
				<table class="xllist" style="width: 100%">
					<tr>
						<th colspan="2" style="text-align: left;">&#12288;培训专业：
							<select name="trainingSpeId" class="xlselect" style="width: 140px;margin-right: 0px">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
									<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						</th>
					</tr>
					<tr>
						<th style="text-align: left;">
							&#12288;届&#12288;&#12288;数：
							<select name="sessionNumber" style="width: 65px;">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
									<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected=\'selected\'':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						</th>
						<td rowspan="2"><input type="button" style="float: right;margin-right: 10px" class="search" onclick="search();" value="查&#12288;询"></td>
					</tr>
					<tr>
						<th style="text-align: left;">&#12288;医师姓名：
							<input name="doctorName" type="text" value="${param.doctorName}" style="width: 60px;">
						</th>
					</tr>
					<c:forEach items="${doctorList}" var="doctor">
						<tr class="doctorTd" style="cursor: pointer;" onclick="deptList('${doctor.doctorFlow}',this);">
							<td valign="top" colspan="2">
									(${doctor.doctorCode})${doctor.doctorName}
							</td>
						</tr>	
					</c:forEach>
				</table>
				</form>
			</div>
			<div class="side" style="width:73%; margin-left:10px;margin-bottom: 10px;float: left;overflow: auto;height: 98%;">
			<div id="dept" ></div>
			<div>
				<table id="selDeptTab" class="xllist" style="font-size: 14px;">
					<tr>
						<th>请完成选科</th>
					</tr>
					<tr>
						<td>
							<div id="selDept" style="width:100%;overflow: auto;margin-top: 10px;text-align: left;"></div>
						</td>
					</tr>
				</table>
				</div>
				</div>
	</div>
</div>
</body>
</html>