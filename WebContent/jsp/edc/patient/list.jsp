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
	function initPatient(patientType){
		var title = "样本分配";
		if (patientType == "${patientTypeEnumTest.id}") {
			title = "测试样本分配";
		}
		jboxOpen("<s:url value='/pub/patient/initProjPatient'/>?patientType="+patientType,title, 700, 400);
	}
	function adjust(orgFlow){
		jboxOpen("<s:url value='/pub/patient/adjust'/>?orgFlow="+orgFlow,"样本调整", 700,600);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<input type="button" class="search" onclick="initPatient('${patientTypeEnumReal.id}');" value="样本分配">
			<input type="button" class="search" onclick="initPatient('${patientTypeEnumTest.id}');" value="测试样本分配">
		</div>
		<div>
			<table class="xllist">
				<tr>
					<th width="50px">中心号</th>
					<th width="200px">机构名称</th>
					<th width="100px">机构角色</th>
					<th width="100px">机构承担病例数</th>
					<th width="150px">已分配样本</th>
					<th width="150px">已分配测试样本</th>
					<th width="100px">操作</th>
				</tr>
				<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
					<c:set var="realKey" value="${projOrg.orgFlow }_${patientTypeEnumReal.id }"></c:set>
					<c:set var="testKey" value="${projOrg.orgFlow }_${patientTypeEnumTest.id }"></c:set>
					<tr style="height: 20px">
						<td>${projOrg.centerNo}</td>
						<td>${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</td>
						<td>${projOrg.orgTypeName}</td>
						<td>
							${projOrg.patientCount}
						</td>
						<td>${pdfn:getPatientCode(patientMap[realKey]) }</td>
						<td>${pdfn:getPatientCode(patientMap[testKey]) }</td>
						<td>
							[<a	href="javascript:adjust('${projOrg.orgFlow}');">样本调整</a>] 
						</td>
					</tr>
				</c:forEach>
				<c:if test="${pdfn:filterProjOrg(pubProjOrgList) == null || pdfn:filterProjOrg(pubProjOrgList).size()==0 }"> 
					<tr> 
						<td align="center" colspan="6">无记录</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
</body>
</html>