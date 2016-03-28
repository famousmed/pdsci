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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include> 
<script type="text/javascript">
	var orgCenterNo = {
			<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
				"${projOrg.orgFlow}":"${projOrg.centerNo}",
			</c:forEach>
	};

	function searchPatient() {
		var orgFlow = $("#orgFlow").val();
		var type = $("[id='abnormal']:checked").val();
		var groupFlow = "";
		var displayOut = $("#abnormal:checked").val();
		if ($("[name='group']:checked").val() != null) {
			groupFlow = $("[name='group']:checked").val();
		}
		jboxGet("<s:url value='/edc/report/timeWindowData?orgFlow='/>"+orgFlow+"&type="+type+"&groupFlow="+groupFlow+"&displayOut="+displayOut, null, function(resp) {
			$("#listDiv").html(resp);
		}, null, false);
	}
	
	$(function (){
		searchPatient();
	});

</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				&#12288;&#12288;参与机构：
			<select id="orgFlow" name="orgFlow" class="xlname" style="width: 200px;" onchange="searchPatient();">
				<option value=""></option>
					<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}">
						${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}
					</option>
					</c:forEach>
			</select>&#12288;
			<c:if test="${!empty groupList}">
				<c:forEach var="group" items="${groupList}" varStatus="status">
					<input type="radio" name="group" id="${group.groupFlow}" onclick="searchPatient();" value="${group.groupFlow}" <c:if test="${status.first}"> checked</c:if>>
					<label for="${group.groupFlow}">${group.groupName}&nbsp;</label>
				</c:forEach>&#12288;&#12288;
			</c:if>
			<input id="abnormal" value="${GlobalConstant.FLAG_Y}" type="checkBox" onclick="searchPatient();"/><label for="abnormal">只显示异常</label>	
			</div>
			<hr />
			<div id="listDiv"></div>
		</div>
	</div>
			
</body>
</html>