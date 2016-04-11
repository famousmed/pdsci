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

<body>
<table class="xllist" style="width: 500px">
<tr><th width="30%">模块名称</th><th width="10%">缩写</th><th width="30%">模块类型</th><th width="30%">操作</th></tr>
<c:forEach items="${moduleList }" var="module">
<tr>
<td>${module.moduleName }</td>
<td>${module.moduleShortName }</td>
<td>${module.moduleTypeName }</td>
<td>[<a href="javascript:editModule('${module.moduleFlow}')">编辑</a>] | 
						 [<a href="javascript:list('${module.moduleCode}');" >元素维护</a>] 
							 [<a href="javascript:delModule('${module.moduleFlow}','${module.moduleTypeId }');" >废止</a>] 
						</td>
</tr>
</c:forEach> 
</table>
