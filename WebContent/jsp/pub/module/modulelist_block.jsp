<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html">
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
<style type="text/css">
body{font-size:14px;font-family:Tahoma,"微软雅黑", Geneva, sans-serif;}
.moduleDiv{color:#fff;line-height:35px;float:left;height:35px;background-color:#1CA1E2;text-align: center;vertical-align: middle;padding-left:20px;padding-right:20px;margin-left: 20px;margin-top: 10px;cursor: pointer; }
</style>
<script type="text/javascript">
function editModule(moduleFlow){
	jboxOpen("<s:url value='/pub/module/getModuleByFlow?moduleFlow='/>"
			+ moduleFlow, "编辑模块信息", 500, 300);
}
function list(moduleCode) {
	jboxStartLoading();
	window.parent.frames['mainIframe'].window.location.href="<s:url value='/pub/module/show?moduleCode='/>"+moduleCode;
	jboxCloseMessager();
}
function add(){
	jboxOpen("<s:url value='/pub/module/addModule?moduleTypeId=${param.domain}'/>"
			, "新增模块信息", 500, 300);
}
$(document).ready(function(){
	init();
});
function init(){
	$(".viewDiv").hover(function() {
		$(this).find("span").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
	},function(){
		$(this).find("span").stop().animate({left: "0", opacity: 0}, "slow");
	});
}
</script>
</head>
<body>
<div class="moduleDiv" title="新增" onclick="add();" style="background-color:;border:1px ;background-image: url('<s:url value='/css/skin/${skinPath}/images/add6.png' />'); background-repeat: no-repeat;background-position: center;">
</div>
<c:forEach items="${moduleList }" var="module">
<div class="moduleDiv viewDiv" onclick="list('${module.moduleCode}');" >
	${module.moduleName }(${module.moduleShortName})&#12288;&#12288;
	<span style="display: ;" onclick="editModule('${module.moduleFlow}')">[编辑]</span>
</div>
</c:forEach>
</body>
</html>