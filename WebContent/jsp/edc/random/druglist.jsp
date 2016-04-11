<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script type="text/javascript">
	function searchDrug(){
		window.location.href="<s:url value='/edc/random/druglist/${userScope}'/>?orgFlow="+$("#orgFlow").val();
	}
	</script>
<body> 
	<div class="mainright">
		<div class="content">
		<c:if test="${ userScope == GlobalConstant.DEPT_LIST_LOCAL}">
		<div class="title1 clearfix">
			&#12288;&#12288;中心号：${pubProjOrg.centerNo}
			&#12288;&#12288;机构名称：${applicationScope.sysOrgMap[sessionScope.currUser.orgFlow].orgName}
			&#12288;&#12288;
			 已申请药物数量：<font color="red">${assignCount}</font> &#12288; 剩余药物数量：<font color="red">${unAssignCount}</font>
			&#12288;&#12288;
			<input type="button" value="药物入库" class="search" onclick=""/>
		</div>
		</c:if>
		<c:if test="${ userScope == GlobalConstant.DEPT_LIST_GLOBAL}">
		<div class="title1 clearfix">
			&#12288;&#12288;参与机构：
						<select id="orgFlow" name="orgFlow" class="xlname" style="width: 200px;"
							onchange="searchDrug();">
							<option value=""></option>
							<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
								<option value="${projOrg.orgFlow}"
									<c:if test="${param.orgFlow==projOrg.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}
								</option>
							</c:forEach>
						</select>&#12288;
						<c:if test="${!empty param.orgFlow }">
						 已申请药物数量：<font color="red">${assignCount}</font> &#12288; 剩余药物数量：<font color="red">${unAssignCount}</font>
						</c:if>
						&#12288;&#12288;
			<input type="button" value="药物入库" class="search" onclick=""/>
		</div>
		</c:if>
		
		<table class="xllist">
			<tr>
				<th width="50px">序号</th> 
				<th width="100px">药品编码</th>
				<th width="100px">状态</th>
				<th width="100px">受试者编号</th>
				<th width="100px">预后因素</th>
				<th width="100px">申请人</th>
				<th width="160px">申请日期</th>
			</tr>
			<c:forEach items="${drugList }" var="drug">
			<c:if test="${drug.drugStatusId==gcpDrugStoreStatusEnumSend.id }">
			<tr>
				<td>${drug.ordinal }</td>
				<td>${drug.drugPack }</td>
				<td>${drug.drugStatusName }</td>
				<td>${drug.patientCode }</td>
				<td>${drug.drugFactorName }</td>
				<td>${drug.assignUserName }</td>
				<td>${pdfn:transDateTime(drug.assignTime) }</td>
			</tr>
			</c:if>
			</c:forEach>
			<c:if test="${empty drugList }"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="10">无记录</td>
				</tr>
			</c:if>	
			</table>
	</div>
</div>
</body>
</html>