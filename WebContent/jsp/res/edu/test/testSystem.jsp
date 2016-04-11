<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
function doClose(){
   if('${param.closeFlag}'!='Y'){
	   if('${param.refreshFlag}'=='N'){
			window.parent.frames['mainIframe'].loadTestList('${param.chapterFlow}');
		}else{
			window.parent.frames['mainIframe'].loadTestList();
		} 
   }
   jboxCloseMessager();
}
</script>
</head>
<body>
    <iframe id="testSystem" src="${url }" style="width: 100%;height: 90%;"></iframe>
    <p align="center" style="width:100%">
		<input class="search" type="button" value="关&#12288;闭"  onclick="doClose();" />
    </p>
</body>
</html>