<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<div class="mainright">
   <div class="content">
   <div class="title1 clearfix"></div>
   <table class="xllist">
   		<tr>
			<th>Year</th>
			<th width="17%">Abbreviated Journal Title (linked to journal information)</th>
			<th width="10%">ISSN</th>
			<th>Total Cites</th>
			<th>Impact Factor</th>
			<th width="8%">5-Year Impactor Factor</th>
			<th width="8%">Immediacy Index</th>
			<th>Articles</th>
			<th width="6%">Cited Half-life</th>
			<th width="8%">EigenfactorTM Score</th>
			<th width="10%">Article InfluenceTM Score</th>
		</tr>
		
		<c:choose>
			<c:when test="${not empty factorList}">
				<c:forEach items="${factorList}" var="factor">
					<tr>
						<td>${factor.year }</td>
						<td>${factor.journalTitle }</td>
						<td>${factor.issn }</td>
						<td>${factor.totalCites }</td>
						<td>${factor.impactFactor }</td>
						<td>${factor.fiveYearImpactorFactor }</td>
						<td>${factor.immediacyIndex }</td>
						<td>${factor.articles }</td>
						<td>${factor.citedHalflife }</td>
						<td>${factor.eigenfactortmSource }</td>
						<td>${factor.influencetmSource }</td>
					<tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="11">暂无收录！</td>
				</tr>
			</c:otherwise>
		
		</c:choose>
   </table>
   
   </div>
</div>
</body>
</html>