<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<c:if test="${param.compatible=='true'}">
<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge,IE=10;">
</c:if>

<link rel="shortcut icon" href="<s:url value='/favicon.ico'/>" />
<c:set var="min" value=".min"></c:set>
<c:if test="${param.basic=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/basic.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-1.8.3${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/json2${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/njmuedu/js/menu.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>
<c:if test="${param.jbox=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/js/artDialog/css/ui-dialog.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/artDialog/dialog-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/artDialog/dialog-plus-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/njmuedu/js/common-edu-jbox.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>

</c:if>
<c:if test="${param.index=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/jquery.fullPage.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/common.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-1.8.3${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/json2${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/njmuedu/js/jquery-ui.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery.fullPage.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.infini_scroll=='true'}">
<script type="text/javascript" src="<s:url value='/jsp/njmuedu/js/infiniScroll.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.cookie=='true'}">
<script type="text/javascript" src="<s:url value='/jsp/njmuedu/js/jquery.cookie.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.register=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/font.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
</c:if>

<c:if test="${param.video=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/js/jquery-raty/jquery.raty.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery-ui/smoothness/jquery-ui.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/video.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<script type="text/javascript" src="<s:url value='/js/jquery-raty/jquery.raty.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.widget.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.mouse.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.slider.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jwplayer=='true'}">
<script type="text/javascript" src="<s:url value='/js/jwplayer/jwplayer.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jwplayer/jwpsrv.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/njmuedu/js/video.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.teachCourses=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/video.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
</c:if>

<c:if test="${param.courseDetail=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/video.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
</c:if>

<c:if test="${param.findCourse=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/course.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
</c:if>

<c:if test="${param.userCenter=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/soncenter.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.teacherMien=='true' }">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/teachers.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>  
</c:if>
<c:if test="${param.complete=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/njmuedu/css/register.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
</c:if>

<c:if test="${param.jquery_placeholder=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery.html5.placeholder.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.html5.placeholder${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_scrollTo=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.scrollTo${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_form=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.form${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_validation=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/validationEngine.jquery.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.validationEngine-zh_CN.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery.validationEngine${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	var forms = $("form");
	$.each(forms , function(i , form){ 
		$(form).validationEngine("attach",{
			promptPosition : "bottomLeft",
			scroll:true,
			autoPositionUpdate: true,
			//addPromptClass:"formError-noArrow formError-text"
			autoHidePrompt:true,
			maxErrorsPerField:1,
			showOneMessage : true
			}
		); 
	});
});
</script>
</c:if>

<c:if test="${param.jquery_datePicker=='true'}">
<script type="text/javascript" src="<s:url value='/js/DatePicker/WdatePicker.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_ztree=='true'}">
<link rel="stylesheet" href="<s:url value='/css/ztree/demo.css'/>?v=${applicationScope.sysCfgMap['sys_version']}" type="text/css">
<link rel="stylesheet" href="<s:url value='/css/ztree/zTreeStyle/zTreeStyle.css'/>?v=${applicationScope.sysCfgMap['sys_version']}" type="text/css">
<script type="text/javascript" src="<s:url value='/js/ztree/jquery.ztree.core-3.5${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/ztree/jquery.ztree.excheck-3.5${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/ztree/jquery.ztree.exedit-3.5${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.ueditor=='true'}">
<script type="text/javascript">
window.UEDITOR_HOME_URL = "${ctxPath}/ueditor/";
</script>
<script type="text/javascript" charset="utf-8" src="<s:url value='/ueditor/ueditor.config.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" charset="utf-8" src="<s:url value='/ueditor/ueditor.all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" charset="utf-8" src="<s:url value='/ueditor/lang/zh-cn/zh-cn.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>




