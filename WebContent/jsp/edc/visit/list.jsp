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
function edit(visitFlow){
	window.location.href="<s:url value='/edc/visit/edit'/>?visitFlow="+visitFlow;
}
</script>
<body >
<c:forEach var="dict" items="${dictTypeEnumVisitTypeList}">
<div  style="">${dict.dictName}<hr/></div>
<div style="float: left;width: 100%;margin-top: 5px;">
<c:forEach items="${visitList }" var="visit">
<c:if test="${visit.visitTypeId ==dict.dictId}">
<div style="cursor: pointer;height:200px;width:150px;float: left;background: url('<s:url value='/css/skin/${skinPath}/images/caseinfo_edit.jpg'/>' ) no-repeat;" onclick="edit('${visit.visitFlow}');">
<p ><b>${visit.visitName }</b></p>
</div>
</c:if>
</c:forEach>
</div> 
</c:forEach>