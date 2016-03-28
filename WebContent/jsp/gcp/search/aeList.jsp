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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		dataCount();
		var aeCount = $("input[name='aeCount']").val();
		$("#aeCount").text(aeCount);
	});
	
	function dataCount(){
		if($("#data tr").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div>
				发生不良事件项目数：<span style="color: red;">${projList.size()}</span>&#12288;发生不良事件总计：<span id="aeCount" style="color: red;"></span>例
			</div>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="5%">序号</th>
					<th width="50%">项目名称</th>
					<th width="20%">项目来源</th>
					<th width="15%">承担科室</th>
					<th width="10%">例数</th>
				</tr>
				</thead>
				<tbody id="data">
				<c:set var="aeCount" value="0"/>
				<c:forEach items="${projList}" var="proj" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${proj.projName}</td>
					<td>${proj.projDeclarer}</td>
					<td>${proj.applyDeptName}</td>
					<td>${projAeMap[proj.projFlow].size()}</td>
					<c:set var="aeCount" value="${aeCount + projAeMap[proj.projFlow].size()}"/>
				</tr>
				</c:forEach>
				</tbody>
				<tr id="dataFoot"><td align="center" colspan="7">无记录</td></tr>
			</table>
			<input type="hidden" name="aeCount" value="${aeCount}"/>
			</div>
</div></div></div>
</body>
</html>