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
<script type="text/javascript">
	function search(){
		$("#doctorSearchForm").submit();
	}
	
	function editTerminat(){
		jboxOpen("<s:url value='/sch/doc/aid/editTerminat'/>","编辑终止信息",550,400);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				<form id="doctorSearchForm" method="post" action="<s:url value='/sch/doc/aid/searchTerminat'/>">
					届数：
					<select name="sessionNumber" class="xlselect" style="width: 60px">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected=\'selected\'':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					培训专业：
					<select name="trainingSpeId" class="xlselect">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					姓名：<input type="text" name="doctorName" value="${param.doctorName}"  style="width: 60px;"  class="xltext"/>
					<input type="button" class="search" onclick="search();" value="查&#12288;询"/>
					<input type="button" class="search" onclick="editTerminat();" value="新&#12288;增"/>
				</form>
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 10%;" rowspan="2">医师姓名</th>
							<th style="text-align: center;width: 10%;" rowspan="2">届数</th>
							<th style="text-align: center;width: 20%;" >专业</th>
							<th style="text-align: center;width: 15%;" >终止时间</th>
							<th style="text-align: center;" >终止原因</th>
							<th style="text-align: center;width: 10%;" >操作</th>
						</tr>
						<tbody>
							<c:forEach items="${doctorList}" var="doctor">
								<tr>
									<td>${doctor.doctorName}</td>
									<td>${doctor.sessionNumber}</td>
									<td>${doctor.trainingSpeName}</td>
									<td>${doctor.terminatDate}</td>
									<td>${doctor.terminatReason}</td>
									<td><a href="#" class="edit" style="color: blue">编辑</a>&#12288;|&#12288;<a href="#" style="color: blue" class="ll">删除</a></td>
								</tr>
							</c:forEach>
						</tbody>
						<c:if test="${empty doctorList}">
							<tr><td align="center" colspan="6">无记录</td></tr>
						</c:if>
					</table>
			</div>
	</div>
</div>
</div>
</body>
</html>