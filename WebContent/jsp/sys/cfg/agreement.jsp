<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="true"/>
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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
</head>
<body>
<script type="text/javascript">
function save() {
	if(false==$("#saveCfgForm").validationEngine("validate")){
		return ;
	}
	//var infoContent = UE.getEditor('ueditor').getContent();
	//$("#sys_agreement").val(infoContent);
	var url = "<s:url value='/sys/cfg/save'/>";
	var data = $('#saveCfgForm').serialize();
	jboxPost(url, data, function() {
		window.location.reload(true);
	});
}
$(document).ready(function(){
	var ue = UE.getEditor('ueditor', {
	    autoHeight: false,
	    imagePath: '${sysCfgMap['upload_base_url']}/',
	    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
	    filePath: '${sysCfgMap['upload_base_url']}/',
	    videoPath: '${sysCfgMap['upload_base_url']}/',
	    wordImagePath: '${sysCfgMap['upload_base_url']}/',
	    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
	    catcherPath: '${sysCfgMap['upload_base_url']}/',
	    scrawlPath: '${sysCfgMap['upload_base_url']}/'
	});//实例化编辑器
});

</script>
<div class="mainright">
	<div class="content">
 		<div class="title1 clearfix">
			<form id="saveCfgForm" action="<s:url value="/sys/cfg/edit" />" method="post" >
				<input type="hidden" name="cfgCode" value="sys_agreement">
				<input type="hidden" name="sys_agreement_ws_id"  value="sys">		
				<input type="hidden" name="sys_agreement_desc"  value="系统标题名称">		
				<script id="ueditor" name="sys_agreement_big_value" type="text/plain" style="width:98%;height:400px;position:relative;">${sysCfgMap['sys_agreement']}</script>
			</form>
			<div class="button" >
				<input type="button" class="search" onclick="save();" value="保&#12288;存">
			</div>
		</div>	
	</div> 
</div>
</body>
</html>