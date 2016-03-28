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
		function assign(patientFlow){
			jboxOpen("<s:url value='/edc/random/assign'/>?patientFlow="+patientFlow,"入组申请",500,600);
		}
		function assignFollow(patientFlow){
			jboxOpen("<s:url value='/edc/random/assignFollow'/>?patientFlow="+patientFlow,"随访申请",600,600);
		}
	</script>
<body> 
	<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
		<table class="xllist">
			<tr>
				<th width="100px">中心号</th> 
				<th width="300px">机构名称</th>
				<th>入组例数</th>
				<th>发药次数</th>
				<th>第一例入组日期</th>
				<th>最后一例入组日期</th>
			</tr>
			<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList) }" var="org">
				<c:set var="min" value="${org.orgFlow}_Min"/>
				<c:set var="max" value="${org.orgFlow}_Max"/>
				<c:set var="count" value="${org.orgFlow}_Count"/>
			<tr>
				<td>${org.centerNo }</td>
				<td>${org.orgName }</td>
				<td>${inDateMap[count] }</td>
				<td>${assignDateMap[count]}</td>
				<td>${pdfn:transDateTime(inDateMap[min])}</td>
				<td>${pdfn:transDateTime(inDateMap[max])}</td>
			</tr>
			</c:forEach>
			<c:if test="${empty pdfn:filterProjOrg(pubProjOrgList)}"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="8">无记录</td>
				</tr>
			</c:if>	
			</table>
				</div>
	</div>
</div>
</body>
</html>