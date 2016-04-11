<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>弹出窗口</title>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="false"/>
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="false"/>
	<jsp:param name="ueditor" value="false"/>
</jsp:include>
<%-- <jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/sample/jquery-ui.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.widget.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.position.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.button.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.dialog.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script> --%>
<script type="text/javascript">
/* $(function(){
	$( "#dialog" ).dialog({
		autoOpen: false,
		modal: true,
		dialogClass: "alert"
	});
}); */
function showDialog(){
	//$( "#dialog" ).dialog("open");
	//jboxTip("操作成功！");
	//jboxMessage();
	jboxConfirm("确认提交？",function(){},null);
	//jboxInfo("请选选择课程！");
	//jboxOpen("<s:url value='/inx/edu'/>",);
	
}
</script>
</head>
<body style="overflow: auto;">
<!-- <div id="dialog" title="提示">
	<p>操作成功</p>
</div> -->
<input type="button" value="弹出" onclick="showDialog()">
<div style="height: 800px;"></div>
<p ></p>
</body>
</html>