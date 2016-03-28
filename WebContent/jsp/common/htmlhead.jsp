<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<title>${applicationScope.sysCfgMap['sys_title_name']}V${applicationScope.sysCfgMap['sys_version']}<%-- --http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath} --%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<c:if test="${param.compatible=='true'}">
<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge,IE=10;">
</c:if>

<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"> 
<meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">

<link rel="shortcut icon" href="<s:url value='/favicon.ico'/>" />

<c:set var="min" value=".min"></c:set>
<c:if test="${param.basic=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/skin/${skinPath}/fenye.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/skin/${skinPath}/basic.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/skin/${skinPath}/login.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-1.8.3${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/json2${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>
<c:if test="${param.edu_basic=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/basic.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-1.8.3${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/json2${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<%-- <script type="text/javascript" src="<s:url value='/jsp/edu/js/menu.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script> --%>
</c:if>
<c:if test="${param.jquery_form=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.form${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jbox=='true'}">

<c:choose>
	<c:when test="${empty applicationScope.sysCfgMap['sys_jbox'] or applicationScope.sysCfgMap['sys_jbox']=='jbox'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jBox/Blue/jbox.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.jBox.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery.jBox-zh-CN.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common-jbox.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.position.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/slideRight.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/slideRight.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
	</c:when>
	<c:when test="${applicationScope.sysCfgMap['sys_jbox']=='art'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/js/artDialog/css/ui-dialog.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/artDialog/dialog-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/artDialog/dialog-plus-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/common-art.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/slideRight.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/slideRight.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
	</c:when>
</c:choose>
<script>
$(document).ready(function(){
	jboxEndLoading();	
});
</script>
</c:if>



<c:if test="${param.jquery_ui_tooltip=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery-ui/product/jquery-ui.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.widget.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.effect.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.effect-fold.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.position.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.tooltip.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(document).tooltip({
			//hide: { Bounce : "blind", duration: 1000 } ,
			track: true,
			show:{ effect: "Fold", duration: 800 } ,
			events: {
				def: "mouseover,mouseout",
				input: "focus mouseover,blur mouseout",
				widget: "focus mouseover,blur mouseout",
				tooltip: "mouseover,mouseout"
			},
			content: function() {
		        var element = $( this );
		        if ( element.is( "[title]" ) ) {
		          return element.attr( "title" );
		        }
			}
		}
	);
});
</script>
</c:if>

<c:if test="${param.jquery_ui_sortable=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery-ui/product/jquery-ui.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.widget.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.mouse.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.sortable.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_ui_combobox=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery.scombobox.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.scombobox${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery.easing${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_cxselect=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.cxselect${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_scrollTo=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.scrollTo${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_jcallout=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jcallout.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.effect.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.effect-blind.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.effect-explode.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jcallout${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_placeholder=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery.html5.placeholder.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.html5.placeholder${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
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

<c:if test="${param.jquery_fullcalendar=='true'}">
<script type="text/javascript" src="<s:url value='/js/moment${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/fullcalendar.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>   
<script type="text/javascript" src="<s:url value='/js/fullcalendar/fullcalendar${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/fullcalendar/lang/zh-cn.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_fngantt=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.fn.gantt${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_fixedtableheader=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.fixedtableheader${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script>
$(document).ready(function(){
	var h = $(window).height()-95;
	var w = $(".mainright").width()-30;
	$(".xllist").not(".nofix").fixedtableheader({container:$(".mainright")});
});
</script>
</c:if>

<c:if test="${param.jquery_iealert=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/css/iealert/style.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/iealert${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<c:if test="${not empty applicationScope.sysCfgMap['chrome_download_url']}">
<script type="text/javascript">
$(document).ready(function(){
	var text = "请点击下面的链接下载，解压后运行exe文件即可访问系统.</font><br /><br />";
	var panel = "<p> "+ text +"</p>"
    + "<div style='width=100%'>"
    + "<a href='${applicationScope.sysCfgMap['chrome_download_url']}'><img src='<s:url value='/css/iealert/iealertsprite_01.png' />'>&#12288;&#12288;下载专业的浏览器</a>"
    + "</div>"; 
	$("body").iealert({
		support: "ie10",
		title:"为了得到我们网站最好的体验效果和访问速度<br>我们建议您使用我们的专业浏览器进行访问！",
        text:panel,
        upgradeTitle:"升级",
        upgradeLink:"",
	  	closeBtn: true,
	  	overlayClose:false
	});
});
</script>
</c:if>

</c:if>

<c:if test="${param.swfobject=='true'}">
<script type="text/javascript" src="<s:url value='/js/swfobject/swfobject${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
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

<c:if test="${param.jquery_fixedtable=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.fixedtable${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_jownload=='true'}">
</c:if>

<c:if test="${not empty applicationScope.sysCfgMap['online_notice'] and sessionScope.online_notice!=applicationScope.sysCfgMap['online_notice']}">
<script type="text/javascript">
$(document).ready(function(){
	var url = "<s:url value='/jsp/notice.jsp'/>"+"?time="+new Date();
	//var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='400px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxOpen(url,"系统通知", 800, 600);
	//$("#jbox-content").css("overflow-y","hidden");
});
</script>
</c:if>

<script type="text/javascript" src="<s:url value='/js/jquery.elastic${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('textarea').elastic();
	$('textarea').trigger('update');
});
</script>

<c:if test="${param.jquery_fullscreen=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.fullscreen${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.jquery_mask=='true'}">
<script type="text/javascript" src="<s:url value='/js/jquery.mask${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.echarts=='true'}">
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: '<s:url value='/js/echarts'/>'
            }
        });
    </script>
</c:if>
<c:if test="${param.tag=='true'}">
<link rel="stylesheet" href="<s:url value='/css/tag/jquery.tagsinput.css'/>?v=${applicationScope.sysCfgMap['sys_version']}" type="text/css">
<script type="text/javascript" src="<s:url value='/js/jquery-tag/jquery.tagsinput.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-tag/jquery-ui.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" href="<s:url value='/css/tag/jquery-ui.css'/>?v=${applicationScope.sysCfgMap['sys_version']}" type="text/css">
</c:if>
<c:if test="${param.resedu=='true'}">
    <link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/edu.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
</c:if>
<c:if test="${param.res_edu_jbox=='true'}">
    <link rel="stylesheet" type="text/css" href="<s:url value='/js/artDialog/css/ui-dialog.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
    <script type="text/javascript" src="<s:url value='/js/artDialog/dialog-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
    <script type="text/javascript" src="<s:url value='/js/artDialog/dialog-plus-min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
    <script type="text/javascript" src="<s:url value='/js/common-edu-jbox.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>
<c:if test="${param.video=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/js/jquery-raty/jquery.raty.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/jquery-ui/smoothness/jquery-ui.min.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/video.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
<script type="text/javascript" src="<s:url value='/js/jwplayer/jwplayer.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jwplayer/jwpsrv.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-raty/jquery.raty.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.core.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.widget.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.mouse.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery-ui/jquery.ui.slider.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/video.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
</c:if>

<c:if test="${param.courseDetail=='true'}">
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/video.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"/>
</c:if>
<%-- <script type="text/javascript" src="<s:url value='/js/sisyphus${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('form').sisyphus({
		excludeFields: [],
		customKeySuffix: "",
		locationBased: false,
		timeout: 5,
		autoRelease: true,
		onSave: function() {
			jboxTip("本地自动保存成功！");
		},
		onBeforeRestore: function() {
		},
		onRestore: function() {
			jboxTip("本地自动恢复成功！");
		},
		onRelease: function() {
			jboxTip("本地自动清除成功！");
		}
	});
});
</script> --%>
