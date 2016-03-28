<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>

<script type="text/javascript">
var width = (window.screen.width)*0.5; 
var height = (window.screen.height)*0.3;  
function addImport(){
	jboxOpen("<s:url value = '/sys/impactorFactor/addImport' />","导入Excel数据 ",width,height);
}


function search(){
	$("#searchForm").submit();
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
</script>
</head>

<body>
<div class="mainright">
   <div class="content">
	<form id="searchForm" action="<s:url value="/sys/impactorFactor/list"/>" method="post" >
		<p>	
		<br/>
		年份：
		<input name="year" value="${param.year }" type="text" class="xltext ctime"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy'})"/>
		
		Abbreviated Journal Title：
		<input name="journalTitle" class="xltext" value="${param.journalTitle}"/>
	
		ISSN：
		<input name="issn" class="xltext" value="${param.issn}"/>
		<input type="button" class="search" onclick="search();" value="查&#12288;询">
		
		<input type="button" onclick="addImport();" value="导入Excel数据" class="search"/>
		<input type="hidden" id="currentPage" name="currentPage">
		</p>
	
	</form>	
	<br/>
	<table class="xllist">
		<thead>
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
		</thead>
		<tbody>
		<c:forEach items="${impactorFactorList}" var="factor">
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
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<p>
	    <c:set var="pageView" value="${pdfn:getPageView2(impactorFactorList , 10)}" scope="request"></c:set>
		<pd:pagination toPage="toPage"/>
	</p>
</div>
</div>
</body>
</html>