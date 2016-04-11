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
<script type="text/javascript">

function save(){
	var url = "<s:url value='/srm/proj/mine/savePageGroupStep'/>";
	jboxPost(url , $('#itemGroup1').serialize() , function(){
		window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();	
	} , null , true);
	
}

</script>
</head>
<body>
	<form action="<s:url value='/srm/proj/mine/savePageGroupStep'/>" id="itemGroup1" method="post" style="position: relative;">
		<input type="hidden" name="pageName" value="step3"/>
		<input type="hidden" name="itemGroupName" value="cost"/>
		<input type="hidden" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="itemGroupFlow" value="${param.itemGroupFlow}"/>
		
		栏目：<input type="text" name="costReason" value="${resultMap.costReason }"><br/>
		金额:<input type="text" name="costCount" value="${resultMap.costCount }"><br/>
		
		
		<input type="button" onclick="save();" value="保存"/>
	</form>	
</body>
</html>