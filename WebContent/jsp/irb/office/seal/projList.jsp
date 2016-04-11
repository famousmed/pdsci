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
</head>
<script type="text/javascript">

function toPage(page){
	//alert(page);
	var form = $("#projForm");
	$("#currentPage").val(page);
	form.submit();
}

$(document).ready(function(){
	$(".projTr").click(function(){
		var $projFlowInput = $(this).children().children();
		var projFlow = $projFlowInput.val();
		var projName = $projFlowInput.parent().text().trim();
		//alert("projFlow:" +projFlow + "  projName:"+ projName);
		window.parent.frames["jbox-iframe"].document.getElementById("projName").value = projName;
		window.parent.frames["jbox-iframe"].document.getElementById("projFlow").value = projFlow;
		jboxCloseMessager();
	});
});

function search() {
	$("#projForm").submit();
}
</script>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="projForm" action="<s:url value='/irb/office/showProj'/>" method="post">
			<p style="text-align: left;background-color: #6cb4e7; color:#fff; height: 38px;">
				&#12288;项目名称：<input type="text" class="xltext" name="projName" value="${param.projName}"/> 
				&#12288;项目编号：<input type="text" class="xltext" name="projNo" value="${param.projNo}"/>
				
				<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
			</p>
			<table class="xllist" style="width: 100%">
				<tr>
					<!-- <th></th> -->
					<th>项目名称</th>
					<th>项目编号</th>
					<th>期类别</th>
					<th>项目来源</th>
				</tr>
				<c:forEach items="${projList}" var="proj">
					<tr class="projTr" style="cursor: pointer;">
						<%-- <td width="5%"><input type="checkbox" name="projFlow" value="${proj.projFlow}"/></td> --%>
						<td width="40%">
							${proj.projName}<input type="hidden" name="projFlow" value="${proj.projFlow}"/>
						</td>
						<td width="20%">${proj.projNo}</td>
						<td width="10%">${proj.projSubTypeName}</td>
						<td width="30%">${proj.projDeclarer}</td>
					</tr>
				</c:forEach>
			</table>
	
			<p>
				<input type="hidden" id="currentPage" name="currentPage">
			    <c:set var="pageView" value="${pdfn:getPageView2(projList , 10)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p>
		</form>
		</div>
	</div>
</div>

</body>
</html>