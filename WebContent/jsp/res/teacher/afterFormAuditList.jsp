<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="true" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="ueditor" value="true"/>
</jsp:include>

<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
	
	function defaultImg(img){
		img.src="<s:url value='/jsp/edu/css/images/up-pic.jpg'/>";
	}
	
	function opRec(recFlow,schDeptFlow, rotationFlow, userFlow, schResultFlow,typeId,typeName,processFlow){
		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
				"?schDeptFlow="+schDeptFlow+
				"&rotationFlow="+rotationFlow+
				"&recTypeId="+typeId+"&userFlow="+userFlow+
				"&roleFlag=${roleFlag}&openType=open"+
				"&resultFlow="+schResultFlow+
				"&recFlow="+recFlow+
				"&processFlow="+processFlow;
		jboxOpen(url, typeName, 1000, 500);
	}
</script>

</head>
<body>
<div class="mainright">
	<div class="content">
	
		<form id="searchForm" action="<s:url value='/res/teacher/afterFormAudit/${roleFlag}'/>" method="post">
		<table class="basic" style="width:100%; margin-bottom: 10px; margin-top: 10px;">
			<tr>
				<td>
					医师姓名：<input type="text" name="doctorName" value="${param.doctorName}" onchange="search();" style="width: 60px;">
					&#12288;
					<label>
						<input type="checkbox" name="isCurrentFlag" value="${GlobalConstant.FLAG_Y}" ${param.isCurrentFlag eq GlobalConstant.FLAG_Y?"checked":""} onclick="search();"/>
						当前轮转科室
					</label>
				</td>
			</tr>
			</table>
		</form>
		
		<table class="xllist" style="margin-top: 10px;">
			<tr>
				<th style="min-width: 100px;">姓名</th>
	  			<th style="min-width: 50px;">性别</th>
	  			<th style="min-width: 100px;">电话</th>
<!-- 	  			<th style="min-width: 150px;">身份证</th> -->
	  			<th style="min-width: 100px;">人员类型</th>
	  			<th style="min-width: 100px;">轮转开始日期</th>
	  			<th style="min-width: 100px;">轮转结束日期</th>
	  			<th style="min-width: 100px;">状态</th>
	  			<th style="text-align: left;">&#12288;出科审核</th>
			</tr>
			<c:forEach items="${processList}" var="process">
				<c:set var="user" value="${userMap[process.userFlow]}"/>
				<c:set var="doctor" value="${doctorMap[process.userFlow]}"/>
				<tr>
					<td title="<img src='${sysCfgMap['upload_base_url']}/${user.userHeadImg}' onerror='defaultImg(this);' style='width: 110px;height: 130px;'/>">
						${user.userName}
					</td>
					<td>${user.sexName}</td>
					<td>${user.userPhone}</td>
					<td>${doctor.doctorCategoryName }</td>
					<td>${process.schStartDate }</td>
					<td>${process.schEndDate }</td>
					<td>
						<c:set var="aftersKey" value="${doctor.doctorFlow}${afterRecTypeEnumAfterSummary.id}"/>
						<c:set var="aftereKey" value="${doctor.doctorFlow}${afterRecTypeEnumAfterEvaluation.id}"/>
						<c:if test="${process.schFlag eq GlobalConstant.FLAG_Y}">
							已出科
						</c:if>
						<c:if test="${!(process.schFlag eq GlobalConstant.FLAG_Y)}">
							<c:if test="${!empty recMap[aftersKey] || !empty recMap[aftereKey]}">
								待出科
							</c:if>
							<c:if test="${!(!empty recMap[aftersKey] || !empty recMap[aftereKey])}">
								轮转中
							</c:if>
						</c:if>
					</td>
<%-- 					<td>${user.idNo}</td> --%>
					<td style="text-align: left;">&#12288;
						<c:forEach items="${afterRecTypeEnumList}" var="after">
		  					<c:set var="showKey" value="res_${after.id}_form_flag"/>
  							<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[showKey]}">
  							
								<c:set var="key" value="${process.userFlow}${process.schDeptFlow}${after.id}"/>
								
								<c:if test="${(afterRecTypeEnumAfterSummary.id eq after.id && !empty recMap[key]) || !(afterRecTypeEnumAfterSummary.id eq after.id)}">
	  								<c:set var="color" value="blue"/>
	  								
	  								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER eq roleFlag && !empty recMap[key].auditStatusId}">
	  									<c:set var="color" value="black"/>
	  								</c:if>
	  								
	  								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_HEAD eq roleFlag && !empty recMap[key].headAuditStatusId}">
	  									<c:set var="color" value="black"/>
	  								</c:if>
	  								
	  								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER eq roleFlag && !empty recMap[key].managerAuditStatusId}">
	  									<c:set var="color" value="black"/>
	  								</c:if>
									<a style="color: ${color};cursor:pointer;" onclick="opRec('${recMap[key].recFlow}','${process.schDeptFlow}','${doctor.rotationFlow}','${process.userFlow}','${process.schResultFlow}','${after.id}','${after.name}','${process.processFlow}');">${after.name}</a>
									&nbsp;
								</c:if>
							</c:if>
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
</body>
</html>
