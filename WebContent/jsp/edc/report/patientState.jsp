<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<%@ page import="java.math.BigDecimal" %>
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
	function exportExcel(){
		window.location.href = "<s:url value='/edc/report/exportPatientState'/>";
	}

</script>
<body> 
	<div class="mainright">
		<div class="content">
		<div class="title1 clearfix">
		<table class="xllist">
			<tr>
				<th>中心号</th> 
				<th>机构名称</th>
				<th>第一例入组</th>
				<th>最后一例入组</th>
				<th>试验间隔跨度</th>
				<th>计划入组</th>
				<th>实际入组</th>
				<th>完成病例(%)</th>
				<th>脱落病例(%)</th>
			</tr>
			<c:set var="patientCount" value="0"/>
			<c:set var="inCount" value="0"/>
			<c:set var="finishCount" value="0"/>
			<c:set var="offCount" value="0"/>
			<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList) }" var="org">
				<c:set var="orgFlow" value="${org.orgFlow}"/>
				<c:set var="min" value="${orgFlow}_Min"/>
				<c:set var="max" value="${orgFlow}_Max"/>
				<c:set var="count" value="${orgFlow}_Count"/>
				<c:set var="minInDate" value="${!empty pdfn:transDate(inDateMap[min]) && (empty minInDate || (!empty minInDate && minInDate>pdfn:transDate(inDateMap[min])))?(pdfn:transDate(inDateMap[min])):minInDate }"/>
				<c:set var="maxInDate" value="${!empty pdfn:transDate(inDateMap[max]) && (empty maxInDate || (!empty maxInDate && maxInDate<pdfn:transDate(inDateMap[max])))?(pdfn:transDate(inDateMap[max])):maxInDate }"/>
				<c:set var="patientCount" value="${org.patientCount==null?patientCount:patientCount+org.patientCount }"/>
				<c:set var="inCount" value="${inCount+inDateMap[count] }"/>
				<c:set var="finishCount" value="${finishCount+fn:length(finishCountMap[orgFlow]) }"/>
				<c:set var="offCount" value="${offCount+fn:length(offCountMap[orgFlow]) }"/>
				<tr>
					<td>${org.centerNo }</td>
					<td>${org.orgName }</td>
					<td>${pdfn:transDate(inDateMap[min])}</td>
					<td>${pdfn:transDate(inDateMap[max])}</td>
					<td>${empty inDateMap[max] || empty inDateMap[min]?"":pdfn:signDaysBetweenTowDate(pdfn:transDate(inDateMap[max]),pdfn:transDate(inDateMap[min]))}</td>
					<td>${org.patientCount}</td>
					<td>${inDateMap[count]+0 }</td>
					<td>${fn:length(finishCountMap[orgFlow]) }（${pdfn:transPercent(fn:length(finishCountMap[orgFlow]),inDateMap[count],2) }）</td>
					<td>${fn:length(offCountMap[orgFlow]) }（${pdfn:transPercent(fn:length(offCountMap[orgFlow]),inDateMap[count],2) }）</td>
				</tr>
			</c:forEach>
			<c:set var="dateSpan" value="${empty minInDate || empty maxInDate?'':pdfn:signDaysBetweenTowDate(maxInDate,minInDate)}"/>
			<c:if test="${!empty pdfn:filterProjOrg(pubProjOrgList)}"> 
			<tr>
				<td>汇总</td>
				<td></td>
				<td>${minInDate }</td>
				<td>${maxInDate }</td>
				<td>${dateSpan }</td>
				<td>${patientCount }</td>
				<td>${inCount }</td>
				<td>${finishCount }（${pdfn:transPercent(finishCount,inCount,2) }）</td>
				<td>${offCount }（${pdfn:transPercent(offCount,inCount,2) }）</td>
			</tr>
			</c:if>
			<c:if test="${empty pdfn:filterProjOrg(pubProjOrgList)}"> 
				<tr> 
					<td align="center" style="text-align: center;" colspan="9">无记录</td>
				</tr>
			</c:if>	
			</table>
			<div align="center" style="width: 100%;margin-top: 10px;">
				<input type="button" value="下载EXCEL" onclick="exportExcel();" class="search"/>
			</div>
				</div>
	</div>
</div>
</body>
</html>