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
<script type="text/javascript">

	function search() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/edc/input/dataTrail" />"	method="post">
					&#12288;参与机构：
					<select  name="orgFlow" class="xlname" style="width:170px;" onchange="search(this.value);">
						<option value=""></option>
						<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
							<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
						</c:forEach>
					</select>
					&#12288;受试者编号：
					<input type="text" name="patientCode" value="${param.patientCode }" style="width: 100px"/>
					&#12288;模块：
					<select name="moduleCode" onchange="search(this.value);" style="width: 100px">
						<option></option>
						<c:forEach items="${projDescForm.moduleList }" var="module">
							<option value="${module.moduleCode }" <c:if test="${param.moduleCode==module.moduleCode }">selected</c:if>>${module.moduleName }</option>
						</c:forEach>
					</select>
					&#12288;&#12288;检查项：
					<select name="elementAttrCode" onchange="search(this.value);" style="width: 150px">
						<option></option>
						<c:forEach items="${projDescForm.moduleElementMap[param.moduleCode] }" var="element">
							<c:forEach items="${projDescForm.elementAttrMap[element.elementCode] }" var="attr">
								<c:set var="elementAttrCode" value="${element.elementCode }_${attr.attrCode}" />
								<option value="${elementAttrCode}"
								<c:if test="${param.elementAttrCode==elementAttrCode }">selected</c:if>	
								>${element.elementName }
								<c:if test="${attr.attrVarName!=GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME }">
								.${attr.attrName }
								</c:if>
								</option>
							</c:forEach>
						</c:forEach>
					</select>
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
				</form>
			</div>			
			<table id="orgTable" class="xllist">
				<thead>
				<tr>
					<th width="50px">机构名称</th>
					<th width="40px">受试者编码</th>
					<th width="80px">检查项</th>
					<th width="80px">访视页面</th>
					<th width="40px">录入序号</th>
					<th width="60px">原始值</th>
					<th width="60px">修改值</th>
					<th width="50px">修改人</th>
					<th width="50px">修改时间</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${eventList}" var="event">
					<tr>
						<td width="50px">${applicationScope.sysOrgMap[event.orgFlow].orgName }</td>
						<td width="40px">${event.patientCode }</td>
						<td width="80px">${event.elementName}.${event.attrName}</td>
						<td width="80px">${event.visitName}</td>
						<td width="40px">${event.elementSerialSeq}</td>
						<td width="60px">${pdfn:getAttrValue(projDescForm,event.attrCode,event.attrValue)}</td>
						<td width="60px">${pdfn:getAttrValue(projDescForm,event.attrCode,event.attrEventValue)}</td>
						<td width="50px">${event.eventUserName}</td>
						<td width="50px">${pdfn:transDateTime(event.eventTime)}</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${eventList == null || eventList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="9">无记录</td>
					</tr>
				</c:if>
			</table>
	</div>
</div>
</body>
</html>