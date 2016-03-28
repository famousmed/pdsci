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
<style>
.divPic{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}

.viewTd img {border: 0;position: relative;vertical-align: middle;}
</style>
<body>
	<script type="text/javascript">
		function searchPatient(){
			window.location.href="<s:url value='/edc/random/randomlist'/>?orgFlow="+$("#orgFlow").val();
		}
		
	</script>
<div class="mainright">
		<div class="content">	
<div class="title1 clearfix">
			&#12288;&#12288;机构：
			<select id="orgFlow" name="orgFlow" class="xlname" style="width:300px;" onchange="searchPatient(this.value);">
				<option value=""></option>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
				</c:forEach>
			</select><font color="red">&#12288;&#12288;红色代表已揭盲</font>
</div>	

		<table class="xllist">
			<tr>
				<th width="50px">序号</th>
				<th width="100px">状态</th>
				<th width="200px">预后因素</th>
				<th width="100px">组别</th>
				<th width="100px">受试者编号</th>
				<th width="120px">申请时间</th>
				<th width="200px">申请医生</th>
			</tr>
			<c:forEach items="${ recList}" var="rec">
			<tr  
			<c:if test="${rec.promptStatusId  == edcRandomPromptStatusEnumPrompted.id }">style="color: red"</c:if>
			>
				<td>${rec.ordinal }</td>	
				<td>${rec.assignStatusName}</td>
				<td>${rec.drugFactorName}</td>	
				<td>
					<c:choose>
						<c:when test="${!isBlind || rec.promptStatusId  == edcRandomPromptStatusEnumPrompted.id}">${rec.drugGroup }</c:when>
						<c:otherwise>***</c:otherwise>
					</c:choose>
				</td>	
				<td>${rec.patientCode }</td>	
				<td>${pdfn:transDateTime(rec.assignTime) }</td>	
				<td>${rec.assignUserName }</td>	
			</tr>
			</c:forEach>
			<c:if test="${empty recList }"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="7">无记录</td>
				</tr>
			</c:if>	
		</table></div></div>
</body>
</html>