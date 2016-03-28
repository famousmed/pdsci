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
	
	function editAbsence(absenceFlow){
		var title = "新增缺勤信息";
		if(absenceFlow != null && absenceFlow != ''){
			title = "编辑缺勤信息";
		}
		jboxOpen("<s:url value='/sch/doc/aid/editAbsence'/>?absenceFlow="+absenceFlow,title,550,450);
	}
	
	function delAbsence(absenceFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/sch/doc/aid/delAbsence?absenceFlow='/>" + absenceFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					search();
				}
			},null,true);
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				<form id="doctorSearchForm" method="post" action="<s:url value='/sch/doc/aid/searchAbsence'/>">
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
					<input type="button" class="search" onclick="editAbsence();" value="新&#12288;增"/>
				</form>
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 10%;" >医师姓名</th>
							<th style="text-align: center;width: 5%;" >届数</th>
							<th style="text-align: center;width: 15%;" >专业</th>
							<th style="text-align: center;width: 10%;" >开始时间</th>
							<th style="text-align: center;width: 10%;" >结束时间</th>
							<th style="text-align: center;width: 10%;" >缺勤天数</th>
							<th style="text-align: center;width: 10%;" >缺勤天数合计</th>
							<th style="text-align: center;" >缺勤原因</th>
							<th style="text-align: center;width: 10%;" >操作</th>
						</tr>
						<tbody>
							<c:forEach items="${doctorList}" var="doctor">
								<c:if test="${!empty docAbsenceMap[doctor.doctorFlow]}">
										<c:set value="${docAbsenceMap[doctor.doctorFlow].size()}" var="colspan"></c:set>
										<c:set value="0" var="absenceCount"></c:set>
										<c:forEach items="${docAbsenceMap[doctor.doctorFlow]}" var="docAbsence" varStatus="status">
										<c:set value="${absenceCount + docAbsence.intervalDay}" var="absenceCount"></c:set>
										<tr>
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
											<td>${docAbsence.absenceReson}</td>
											<td><a href="javascript:editAbsence('${docAbsence.absenceFlow}')" class="edit" style="color: blue">编辑</a>&#12288;|&#12288;<a href="javascript:delAbsence('${docAbsence.absenceFlow}')" style="color: blue" class="ll">删除</a></td>
											</tr>
											<c:if test="${status.last}">
												<script type="text/javascript">$("#count${doctor.doctorFlow}").text("${absenceCount}");</script>
											</c:if>
										</c:forEach>
									
								</c:if>
							</c:forEach>
						</tbody>
						<c:if test="${empty docAbsenceMap}">
							<tr><td align="center" colspan="9">无记录</td></tr>
						</c:if>
					</table>
			</div>
	</div>
</div>
</div>
</body>
</html>