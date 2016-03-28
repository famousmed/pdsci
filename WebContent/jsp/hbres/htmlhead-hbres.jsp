<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<c:if test="${param.compatible=='true'}">
<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge,IE=10;">
</c:if>

<link rel="shortcut icon" href="<s:url value='/favicon.ico'/>" />
<c:set var="min" value=".min"></c:set>
<c:if test="${param.basic=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery-1.8.3${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery.SuperSlide.2.1.1.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>
<c:if test="${param.font=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/font.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
</c:if>

<c:if test="${param.register=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/style.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
</c:if>
<c:if test="${param.jbox=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/js/artDialog/css/ui-dialog.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/artDialog/dialog-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/artDialog/dialog-plus-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/edu/js/common-edu-jbox.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>

</c:if>


<c:if test="${param.jquery_placeholder=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery.html5.placeholder.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.html5.placeholder${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
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
			promptPosition : "topRight",
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
<script type="text/javascript" charset="utf-8" src="<s:url value='/jsp/hbres/js/bootstrap-datepicker.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/datepicker.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
</c:if>
<c:if test="${param.ueditor=='true'}">
<script type="text/javascript">
window.UEDITOR_HOME_URL = "${ctxPath}/ueditor/";
</script>
<script type="text/javascript" charset="utf-8" src="<s:url value='/jsp/hbres/js/ueditor.config.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" charset="utf-8" src="<s:url value='/ueditor/ueditor.all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" charset="utf-8" src="<s:url value='/ueditor/lang/zh-cn/zh-cn.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>
<c:if test="${param.jquery_ui_combobox=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/jquery.scombobox.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/jsp/hbres/js/jquery.scombobox.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/jsp/hbres/js/jquery.easing${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>
<c:if test="${param.echarts=='true'}">
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                'echarts' : '<s:url value='/js/echarts'/>'
            }
        });
    </script>
</c:if>
<c:if test="${not empty applicationScope.sysCfgMap['online_notice'] and sessionScope.online_notice!=applicationScope.sysCfgMap['online_notice']}">
<script type="text/javascript">
$(document).ready(function(){
	var url = "<s:url value='/jsp/notice.jsp'/>"+"?time="+new Date();
	//var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='400px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxOpen(url,"系统通知", 800, 400,true);
	//$("#jbox-content").css("overflow-y","hidden");
});
</script>
</c:if>


