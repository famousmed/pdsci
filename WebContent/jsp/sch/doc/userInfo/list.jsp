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
	function editDoctor(doctorFlow){
		jboxOpen("<s:url value='/sch/doc/userInfo/editDoc'/>?doctorFlow="+doctorFlow,"编辑医师信息",775,450);
	}
	
	function addDoctor(){
		jboxOpen("<s:url value='/sch/doc/userInfo/editDoc'/>","新增医师信息",775,450);
	}
	
	function search(){
		$("#doctorSearchForm").submit();
	}
</script>
<style type="text/css">
	.xlselect,.xltext{margin-right: 0px}
</style>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="doctorSearchForm" action="<s:url value='/sch/doc/userInfo/searchList'/>" method="post" >
				<div>
					届数：
					<select name="sessionNumber" class="xlselect" style="width: 60px">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
							<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected=\'selected\'':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					&#12288;
					培训专业：
					<select name="trainingSpeId" class="xlselect" style="width: 150px">
						<option></option>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<option value="${dict.dictId}" ${param.trainingSpeId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					&#12288;
					毕业院校：
					<select name="graduatedId" class="xlselect" style="width: 150px">
						<option></option>
						<c:forEach items="${dictTypeEnumGraduateSchoolList}" var="dict">
							<option value="${dict.dictId}" ${param.graduatedId eq dict.dictId?'selected=\'selected\'':''}>${dict.dictName}</option>
						</c:forEach>
					</select>
					&#12288;
					姓名：<input type="text" name="doctorName" value="${param.doctorName}"  style="width: 80px;"  class="xltext"/>
					<input type="button" value="查&nbsp;询" onclick="search()" class="search">
					<input type="button" value="新&nbsp;增" onclick="addDoctor()" class="search">
					<input type="button" value="导入Excel" onclick="search()" class="search">
				</div>
			</form>
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th width="10%" >工号</th>
					<th width="10%" >姓名</th>
					<th width="5%" >性别</th>
					<th width="10%" >届数</th>
					<th >毕业院校</th>
					<th width="8%" >学位</th>
					<th width="15%" >培训专业</th>
					<th width="10%" >是否结业</th>
					<th width="10%" >是否停用</th>
					<th width="8%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${doctorList}" var="doctor">
					<tr>
						<td>${doctor.doctorCode}</td>
						<td></td>
						<td></td>
						<td>${doctor.sessionNumber}</td>
						<td>${doctor.graduatedName}</td>
						<td></td>
						<td>${doctor.trainingSpeName}</td>
						<td>${doctor.doctorStatusName}</td>
						<td>${doctor.recordStatus eq GlobalConstant.RECORD_STATUS_Y ?"否":"是"}</td>
						<td><a href="javascript:editDoctor('${doctor.doctorFlow}')" class="edit" style="color: blue">编辑</a></td>
					</tr>
				</c:forEach>
				<c:if test="${empty doctorList}">
					<tr><td align="center" colspan="9">无记录</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>