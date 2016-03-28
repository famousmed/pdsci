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
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<table class="basic" width="100%">
				<tr>
					<td>
						<form id="searchForm" action="<s:url value='/sch/doc/searchSchDoc'/>" method="post">
						届数：<select name="sessionNumber" style="width: 60px" onchange="search();">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
									<option value="${dict.dictName}" ${dict.dictName eq param.sessionNumber?'selected="selected"':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						&#12288;
						培训专业：
							<select name="trainingSpeId" onchange="search();">
								<option></option>
								<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
									<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
						&#12288;
						方案：<select name="rotationFlow" style="width: 200px" onchange="search();">
								<option></option>
								<c:forEach items="${rotationMap}" var="rotation">
									<option value="${rotation.value.rotationFlow}" ${rotation.value.rotationFlow eq param.rotationFlow?'selected="selected"':''}>${rotation.value.rotationName}</option>
								</c:forEach>
							</select>
						&#12288;
						医师姓名：<input name="doctorName" type="text" value="${param.doctorName}" style="width: 40px;" onchange="search();"/>
						&#12288;
						<input type="button" class="search" value="导出Excel" style="float: right;margin-right: 10px;margin-top: 5px;"/>
						</form>
					</td>
				</tr>
			</table>
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;" id="doc">
				<c:set value="${pdfn:getCurrDate()}" var="today"></c:set>
				<c:set value="1" var="max"></c:set>
				<c:forEach items="${arrResultMap}" var="entity">
					<c:set value="${entity.value.size()}" var="size"></c:set>
					<c:set value="${size>max?size:max}" var="max"></c:set>
				</c:forEach>
				<table class="xllist" style="font-size: 14px;width: 100%">
						<tr>
							<th style="text-align: center;width: 10%;" >姓名</th>
							<th style="text-align: center;width: 5%;" >届数</th>
							<th style="text-align: center;width: 10%;" >专业</th>
							<th style="text-align: center;" colspan="${max}">轮转科室及轮转日期（<font color="red">红色为当前轮转科室</font>）</th>
						</tr>
						<c:forEach items="${doctorList}" var="doctor">
							<c:if test="${!empty arrResultMap[doctor.doctorFlow]}">
								<tr>
									<td rowspan="2">${doctor.doctorName}</td>
									<td rowspan="2">${doctor.sessionNumber}</td>
									<td rowspan="2">${doctor.trainingSpeName}</td>
									<c:forEach items="${arrResultMap[doctor.doctorFlow]}" var="result">
										<c:set value="${result.schStartDate}" var="startMonth"></c:set>
										<c:set value="${result.schEndDate}" var="endMonth"></c:set>
										<td style="Line-height:16px;${endMonth.compareTo(today)>=0 && startMonth.compareTo(today)<=0 ?'color: red;':''}">
											${startMonth}<br/>~<br/>${endMonth}
										</td>
									</c:forEach>
									<c:forEach begin="1" end="${max - arrResultMap[doctor.doctorFlow].size()}">
										<td></td>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach items="${arrResultMap[doctor.doctorFlow]}" var="result">
										<c:set value="${result.schStartDate}" var="startMonth"></c:set>
										<c:set value="${result.schEndDate}" var="endMonth"></c:set>
										<td ${endMonth.compareTo(today)>=0 && startMonth.compareTo(today)<=0 ?'style="color: red"':''}>
											${result.schDeptName}
										</td>
									</c:forEach>
									<c:forEach begin="1" end="${max - arrResultMap[doctor.doctorFlow].size()}">
										<td></td>
									</c:forEach>
								</tr>
							</c:if>
						</c:forEach>
						<c:if test="${empty doctorList}">
							<tr><td align="center" colspan="4">无记录</td></tr>
						</c:if>
					</table>
		</div>
	</div>
</div>
</div>
</body>
</html>