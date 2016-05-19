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
<body>
<div style="text-align:center; vertical-align:middle;margin-left:auto;margin-right:auto;padding:0;">
 	<c:choose>
 		<c:when test="${fn:indexOf(applicationScope.sysCfgMap['sys_login_img'],'medroad')>-1}">
 			<img style="margin:0 auto;" src="<s:url value='/css/skin/${skinPath}/images/main_medroad.png'/>"/>
 		</c:when>
 		<c:otherwise><img style="margin:0 auto;" src="<s:url value='/css/skin/${skinPath}/images/main.png'/>"/></c:otherwise>
 	</c:choose>
</div>
</body>
</html>