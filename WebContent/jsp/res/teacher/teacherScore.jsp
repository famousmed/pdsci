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
		$("#searchForm").submit();
	}
	
	function openRecList(teacherFlow){
		$("#"+teacherFlow).slideToggle(500);
	}
	
	function goTeacher(name){
		location.href = "#"+name;
		if($("#"+name).is(":hidden")){
			openRecList(name);
		}
	}
	
	$(function(){
		$(".formatDouble").each(function(){
			$(this).text(parseFloat($(this).text()).toFixed(1));
		});
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value='/res/teacher/teacherScore/${roleFlag}'/>">
				科室：${sessionScope.currUser.deptName}
				&#12288;
				${roleFlag eq 'teacher'?'带教老师':(roleFlag eq 'head'?'科主任':'')}：${sessionScope.currUser.userName}
				&#12288;
				&#12288;
				&#12288;
				届数：
				<select name="sessionNumber" style="width:100px" onchange="search();">
					<option></option>
					<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
						<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
					</c:forEach>
				</select>
				<c:if test="${roleFlag eq 'head'}">
					&#12288;
					带教老师：
					<select name="teacherUserFlow" style="width:100px" onchange="goTeacher(this.value);">
						<option></option>
						<c:forEach items="${teacherMap}" var="teacher" >
							<option value="${teacher.key}">${teacher.value}</option>
						</c:forEach>
					</select>
				</c:if>
				&#12288;
				<label>
					<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y || param.sessionNumber == null?"checked":""} onchange="search();"/>&nbsp;当前轮转科室
				</label>
			</form>
		</div>
		
		<c:if test="${roleFlag eq 'teacher'}">
		<table class="xllist">
			<tr style="display: none;"><td></td></tr>
			<thead>
				<tr>
					<th style="text-align: left;padding-left: 20px;width: 600px;max-width: 600px;min-width: 600px;" >评价指标</th>
					<c:forEach items="${recExtList}" var="recExt">
						<th style="width: 80px;max-width: 80px;min-width: 80px;">${recExt.operUserName}</th>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="count"/>
				<c:forEach items="${titleFormList}" var="title">
					<c:forEach items="${title.itemList}" var="item">
						<tr>
							<td style="text-align: left;padding-left: 20px;">${item.name}</td>
							<c:forEach items="${recExtList}" var="recExt">
								<c:set value="${recExt.schDeptFlow}${recExt.operUserFlow}" var="key"/>
								<td>${scoreMap[key][item.id]['score']}</td>
							</c:forEach>
						</tr>
					</c:forEach>
				</c:forEach>
				<tr style="background-color: #FCF1C0">
					<td style="text-align: left;padding-left: 20px;">总分</td>
					<c:forEach items="${recExtList}" var="recExt">
						<c:set value="${recExt.schDeptFlow}${recExt.operUserFlow}" var="key"/>
						<td>
							<font class="formatDouble">${scoreMap[key]['totalScore']+0}</font>
						</td>
					</c:forEach>
				</tr>
			</tbody>
		</table>
		</c:if>
		<c:if test="${roleFlag eq 'head'}">
			<c:if test="${empty teacherMap}">
				<div style="height: 30px;padding-top: 10px;border:1px solid #ccc;margin-top: 10px;" class="ith" align="center">无记录</div>
			</c:if>
			<c:forEach items="${teacherMap}" var="teacher">
				<div style="cursor: pointer;height: 40px;border: 1px solid #ccc;margin-top: 10px;" class="ith">
				<div style="float: left;width: 100%;padding-top: 10px;padding-bottom:10px;" onclick="openRecList('${teacher.key}');">
					<span style="margin-right: 20px;display: inline-block;width: 200px;">带教老师：${teacher.value}</span>
					<span style="margin-right: 20px;display: inline-block;width: 200px;">总平均分：<font id="${teacher.key}_avg"></font></span>
				</div>
				</div>
				<div id="${teacher.key}" style="display: none;border: 1px solid #ccc;border-top: none;border-bottom: none;border-left: none;border-right: none;overflow: auto;">
					<c:if test="${!empty resExtMap[teacher.key]}">
					<c:set value="0" var="scoreCount"/>
					<table class="xllist" style="width: 100%;border-top: none;">
						<tr style="display: none;"><td></td></tr>
						<thead>
							<tr>
								<th  style="text-align: left;padding-left: 20px;width: 600px;max-width: 600px;min-width: 600px;" >评价指标</th>
								<c:forEach items="${resExtMap[teacher.key]}" var="recExt">
									<th style="width: 80px;max-width: 80px;min-width: 80px;">${recExt.operUserName}</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<c:set value="0" var="count"/>
							<c:forEach items="${titleFormList}" var="title">
								<c:forEach items="${title.itemList}" var="item">
									<tr>
										<td style="text-align: left;padding-left: 20px;">${item.name}</td>
										<c:forEach items="${resExtMap[teacher.key]}" var="recExt">
											<c:set value="${recExt.schDeptFlow}${recExt.operUserFlow}" var="key"/>
											<td>${scoreMap[key][item.id]['score']}</td>
										</c:forEach>
									</tr>
								</c:forEach>
							</c:forEach>
							<tr style="background-color: #FCF1C0">
								<td style="text-align: left;padding-left: 20px;">总分</td>
								<c:forEach items="${resExtMap[teacher.key]}" var="recExt">
									<c:set value="${recExt.schDeptFlow}${recExt.operUserFlow}" var="key"/>
									<td>
										<font class="formatDouble">${scoreMap[key]['totalScore']+0}</font>
										<c:set value="${scoreMap[key]['totalScore']+scoreCount}" var="scoreCount"/>
									</td>
								</c:forEach>
							</tr>
						</tbody>
					</table>
					<c:if test="${resExtMap[teacher.key].size() != 0}">
						<script>
							$("#${teacher.key}_avg").text(${scoreCount/resExtMap[teacher.key].size()}.toFixed(1));
						</script>
					</c:if>
					</c:if>
					<c:if test="${empty resExtMap[teacher.key]}">
						<div style="height: 30px;padding-top: 10px;border-bottom:1px solid #ccc;" align="center">无记录</div>
					</c:if>
				</div>
				<a name="${teacher.key}"></a>
			</c:forEach>
		</c:if>
	</div>
</div>
</body>
</html>