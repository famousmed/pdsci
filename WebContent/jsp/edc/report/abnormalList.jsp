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
	function search(){
		$("#visitDataForm").submit();
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<form id="visitDataForm" action="<s:url value='/edc/report/abnormalList'/>">
				&#12288;&#12288;参与机构：
			<select id="orgFlow" name="orgFlow" style="width: 200px;" onchange="search();">
				<option value=""></option>
					<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<option value="${projOrg.orgFlow}" ${projOrg.orgFlow eq param.orgFlow?'selected="selected"':''}>
						${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}
					</option>
					</c:forEach>
			</select>
			&#12288;受试者编码：
			<input type="text" name="patientCode" value="${param.patientCode}" style="width: 70px"/>
			&#12288;
			<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
			</form>
			</div>
			<hr />
			<table class="xllist">
				<thead>
					<tr>
						<th width="18%">机构名称</th>
						<th width="8%">受试者编码</th>
						<th width="15%">检查项</th>
						<th width="18%">访视页面</th>
						<th width="7%">录入序号</th>
						<th width="9%">录入值</th>
						<th width="25%">提示信息</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="org">
						<c:forEach items="${patientVisitDataFormMap[org.orgFlow]}" var="visitData">
							<tr>
								<td>${org.orgName}</td>
								<td>${visitData.patientCode}</td>
								<td>${visitData.elementName}.${visitData.attrName}</td>
								<td>${visitData.visitName}</td>
								<td>${visitData.elementSerialSeq}</td>
								<td>${visitData.attrValue}</td>
								<td style="text-align: left;padding-left: 10px;">${visitData.attrValueTip}</td>
							</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
				<tfoot>
					<c:if test="${empty patientVisitDataFormMap}">
						<tr><td colspan="7">无记录</td></tr>
					</c:if>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>