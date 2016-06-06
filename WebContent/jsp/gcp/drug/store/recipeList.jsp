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
    
    function dispensDrug(recipeFlow){
		jboxOpen("<s:url value='/gcp/drug/editDispensDrug'/>?recipeFlow="+recipeFlow,"处方发药",700,450);
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
			<div class="title1 clearfix">
		    <form id="searchForm" action="<s:url value='/gcp/drug/recipeList'/>" method="post">
		    	受试者姓名：
		        <input type="text" name="patientName" value="${param.patientName }" class="xltext" style="width: 100px;"/>
		      	项目名称：
		        <input type="text" name="projName" value="${param.projName }" class="xltext"/>
		         <input type="button" onclick="search();" value="查&#12288;询" class="search">
		         <input type="hidden" id="currentPage" name="currentPage">
		    </form>
		    </div>
		    <table class="xllist" >
		     <thead>
		       <tr>
		        <th width="80px;">序号</th>
		        <th  >项目名称</th>
		        <th width="100px;">承担科室</th>
		        <th width="100px;">姓名</th>
		        <th width="100px;">性别</th>
		        <th width="100px;">年龄</th>
		        <th width="200px;">处方时间</th>
		        <th width="100px;">处方医生</th>
		        <th width="100px;">操作</th>
		       </tr>
		     </thead>
		     <tbody>
		     <c:forEach items="${recipeList }" var="recipe" varStatus="status">
		    	<tr>
					<td>${status.count }</td>
					<td  title="${ recipe.projName }" style="text-align: left;padding: 10px;">${!empty recipe.projShortName?recipe.projShortName:recipe.projName}</td>
					<td>${recipe.applyDeptName}</td>
					<td >${recipe.patientName}</td>
					<td >${recipe.sexName}</td>
					<td >${recipe.patientAge}</td>
					<td >${pdfn:transDateTime(recipe.recipeDate)}</td>
					<td >${recipe.recipeDoctorName}</td>
					<td >
					<a href="javascript:void(0)" onclick="dispensDrug('${recipe.recipeFlow}')" style="color: blue;">发药</a>
					</td>
				</tr>
		     </c:forEach>
		     </tbody>
		     <c:if test="${empty recipeList}">
		         <tr>
		           <td colspan="9">无记录！</td>
		         </tr>
		     </c:if>
		   </table>	
		   <p>
			<c:set var="pageView" value="${pdfn:getPageView2(recipeList, 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
			</p>
		</div> 
		</div>
</body>
</html>