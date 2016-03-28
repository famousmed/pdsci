
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<style type="text/css">
@charset "utf-8";
/* CSS Document */
html,body,div,span,h1,h2,h3,h4,h5,h6,p,pre,a,code,em,img,small,strong,sub,sup,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label{margin:0;padding:0;border:0;outline:0;font-size:100%;vertical-align:baseline;background:transparent}
a{color:#007bc4/*#424242*/; text-decoration:none;}
a:hover{text-decoration:underline}
ol,ul{list-style:none}
table{border-collapse:collapse;border-spacing:0}
body{height:100%; font:12px/18px "Microsoft Yahei", Tahoma, Helvetica, Arial, Verdana, "\5b8b\4f53", sans-serif; color:#51555C; background:#162934 url(../css/skin/${skinPath}/images/body_bg.gif) repeat-x}
img{border:none}


#header{width:980px; height:92px; margin:0 auto; position:relative}
#logo{width:240px; height:90px; background:url(../css/skin/${skinPath}/images/logo_demo.gif) no-repeat}
#logo h1{text-indent:-999em}
#logo h1 a{display:block; width:240px; height:90px}


#main{width:980px; min-height:600px; margin:30px auto 0 auto; background:#fff; -moz-border-radius:12px;-khtml-border-radius: 12px;-webkit-border-radius: 12px; border-radius:12px;}
h2.top_title{margin:4px 20px; padding-top:15px; padding-left:20px; padding-bottom:10px; border-bottom:1px solid #d3d3d3; font-size:18px; color:#a84c10; background:url(../css/skin/${skinPath}/images/arrL.gif) no-repeat 2px 14px}

#footer{height:60px;}
#footer p{ padding:10px 2px; line-height:24px; text-align:center}
#footer p a:hover{color:#51555C}
#stat{display:none}

.google_ad{width:728px; height:90px; margin:50px auto}
.ad_76090,.ad_demo{width:760px; height:90px; margin:40px auto}
.demo_topad{position:absolute; top:15px; right:0px; width:640px; height:60px;}
.nav{width:500px;margin:10px auto;}
.nav li{float:left; width:100px; height:24px; line-height:24px}
.box{height:500px}
.box h3{height:32px; line-height:32px; padding-left:20px; font-size:14px}
#pro,#ser{background:url(img/bg.jpg)}
#news,#con{background:url(img/bg2.gif)}
.clear{clear:both}

</style>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
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
$(function(){
	$(".nav_pro").click(function(){
		$.scrollTo('#pro',500);
	});
	$(".nav_news").click(function(){
		$.scrollTo('#news',800);
	});
	$(".nav_ser").click(function(){
		$.scrollTo('#ser',1000);
	});
	$(".nav_con").click(function(){
		$.scrollTo('#con',1200);
	});
	$(".nav_job").click(function(){
		$.scrollTo('#job',1500);
	});
});
</script>
<body>
<div id="header">
   <div id="logo"><h1><a href="http://www.helloweba.com" title="返回helloweba首页">helloweba</a></h1></div>
   <div class="demo_topad"><script src="/js/ad_js/demo_topad.js" type="text/javascript"></script></div>
</div>

<div id="main">
  <h2 class="top_title"><a href="http://www.helloweba.com/view-blog-118.html">ScrollTo：平滑滚动到页面指定位置</a></h2>
  		<div class="ad_demo"><script src="/js/ad_js/ad_demo.js" type="text/javascript"></script></div>
     <ul class="nav">
       <li><a href="#" class="nav_pro">产品展示</a></li>
       <li><a href="#" class="nav_news">新闻中心</a></li>
       <li><a href="#" class="nav_ser">服务支持</a></li>
       <li><a href="#" class="nav_con">联系我们</a></li>
       <li><a href="#" class="nav_job">人才招聘</a></li>
     </ul>
     <div class="clear"></div>
     <div id="pro" class="box">
        <h3>产品展示</h3>
     </div>
     <div id="news" class="box">
        <h3>新闻中心</h3>
     </div>
     <div id="ser" class="box">
        <h3>服务支持</h3>
     </div>
     <div id="con" class="box">
        <h3>联系我们</h3>
     </div>
     <div id="job" class="box" style="height:680px">
        <h3>人才招聘</h3>
     </div>
</div>
<div id="footer">
    <p>Powered by helloweba.com  允许转载、修改和使用本站的DEMO，但请注明出处：<a href="http://www.helloweba.com">www.helloweba.com</a></p>
</div>
<p id="stat"></p>
</body>
</html>