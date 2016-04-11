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
</head>
<body> 
	<script type="text/javascript">
	function searchPatient() {
		var groupFlow = "";
		if ($("[name='group']:checked").val() != null) {
			groupFlow = $("[name='group']:checked").val();
		}
		jboxGet("<s:url value='/edc/inspect/list?orgFlow='/>"+$("#orgFlow").val()+"&groupFlow="+groupFlow,null,function(resp){
			$("#listDiv").html(resp);					
		},null,false);
	}
		$(document).ready(function(){
			searchPatient();
		});
	</script>
	<div class="mainright">
		<div class="content">
	<div class="title1 clearfix">
			&#12288;&#12288;参与机构：
			<select id="orgFlow" name="orgFlow" class="xlname" style="width:200px;" onchange="searchPatient(this.value);">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select>&#12288;
			<c:if test="${!empty groupList}">
				<c:forEach var="group" items="${groupList}" varStatus="status">
					<input type="radio" name="group" id="${group.groupFlow}" onclick="searchPatient();" value="${group.groupFlow}" <c:if test="${empty param.groupFlow?status.first:group.groupFlow == param.groupFlow}"> checked</c:if>>
					<label for="${group.groupFlow}">${group.groupName}&nbsp;</label>
				</c:forEach>&#12288;&#12288;
			</c:if>
			- 未录入&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/unchecked.png'/>"/> 未核查&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/checking.png'/>"/>审核中&#12288;
			<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>已审核&#12288;
			<!-- <span style="float: right;"><input type="checkbox" name="sdvModel" value='1' id="sdvModel"/><label for="sdvModel">&#12288;弹窗模式 &#12288;</label></span> -->
	</div>
	<hr/>
	<div id="listDiv"></div>
	</div>
	</div>
</body>
</html>