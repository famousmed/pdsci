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
	<jsp:param name="jquery_scrollTo" value="true"/>
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
		<div class="content" style="padding-top: 10px;">
		    <form id="searchForm" action="<s:url value='/gcp/drug/dispensRecord'/>" method="post">
		    	受试者姓名：
		        <input type="text" name="patientName" value="${param.patientName }" class="xltext" style="width: 100px;"/>
		      	项目名称：
		        <input type="text" name="projName" value="${param.projName }" class="xltext"/>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		         <input id="currentPage" type="hidden" name="currentPage" value=""/> 
		    </form>
		    <table width="100%" class="xllist" style="margin-top: 10px;">
		     <thead>
		       <tr>
		        <th width="3%">序号</th>
		        <th width="7%">姓名</th>
		        <th width="7%">药物编码</th>
		        <th width="16%">药物名称</th>
		        <th width="15%">项目名称</th>
		        <th width="12%">发药时间</th>
		        <th width="7%">发药人</th>
		        <th width="12%">处方时间</th>
		        <th width="7%">处方医生</th>
		       </tr>
		     </thead>
		     <tbody>
		    <c:forEach items="${recipeList }" var="recipe" varStatus="num">
		    	<c:set value="${recipeDrugMap[recipe.recipeFlow].size()}" var="rowspan"/>
		    	<c:forEach items="${recipeDrugMap[recipe.recipeFlow]}" var="recipeDrug" varStatus="status">
				<tr>
					<c:if test="${status.first}">
						<td width="3%" rowspan="${rowspan}">${num.count }</td>
						<td width="7%" rowspan="${rowspan}">${recipe.patientName}</td>
						<td width="7%" rowspan="${rowspan}">${recipeDrug.drugPack}</td>
					</c:if>
					<td width="16%">${recipeDrug.drugName}</td>
					<c:if test="${status.first}">
						<td width="15%" title="${recipe.projName }" rowspan="${rowspan}">${pdfn:cutString(recipe.projName,12,true,3 )}</td>
						<td width="12%" rowspan="${rowspan}">${pdfn:transDateTime(recipe.sendDate)}</td>
						<td width="7%" rowspan="${rowspan}">${recipe.sendUserName}</td>
						<td width="12%" rowspan="${rowspan}">${pdfn:transDateTime(recipe.recipeDate)}</td>
						<td width="7%" rowspan="${rowspan}">${recipe.recipeDoctorName}</td>
					</c:if>
				</tr>
				</c:forEach>
		   </c:forEach>
		     </tbody>
		     <c:if test="${empty recipeList}">
		         <tr>
		           <td colspan="9">无记录！</td>
		         </tr>
		     </c:if>
		   </table>	
		   <p>
			<c:set var="pageView" value="${pdfn:getPageView(recipeList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
			</p>
		</div> 
		</div>
</body>
</html>