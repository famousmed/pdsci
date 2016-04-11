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
	function searchPatient(orgFlow){
	jboxGet("<s:url value='/edc/query/patientQueryList/${patientScope}?orgFlow='/>"+orgFlow,null,function(resp){
		$("#listDiv").html(resp);
	},null,false);
	}
	
	$(document).ready(function(){
		searchPatient('');
	});
	</script>
	<div class="mainright">
		<div class="content">
	<div class="title1 clearfix">
		<c:if test="${ patientScope == GlobalConstant.DEPT_LIST_GLOBAL}">
			&#12288;&#12288;参与机构：
			<select id="orgFlow"  name="orgFlow" class="xlname" style="width:200px;" onchange="searchPatient(this.value);">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select>
		</c:if>
		<c:if test="${ patientScope == GlobalConstant.DEPT_LIST_LOCAL}">
			&#12288;&#12288;当前机构： ${sessionScope.currUser.orgName}&#12288;&#12288;&#12288;&#12288;
		</c:if>
			&#12288;
			<font color="red">Sdv： 电子数据与源数据不一致&#12288;&#12288;Manual：手工疑问&#12288;&#12288;Logic：逻辑检查</font>
			
			
			<span style="float: right;"><input type="checkbox" name="inputModel" value='1' id="inputModel"/><label for="inputModel">&#12288;弹窗模式 &#12288;</label></span>
	</div>
	<hr/>
	<div id="listDiv">
		
	</div>
	</div>
</div>
</body>
</html>