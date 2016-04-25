<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${applicationScope.sysCfgMap['sys_title_name']}</title>
<jsp:include page="/jsp/medroad/htmlhead-medroad.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script>
$(document).ready(function(){
	$(".menu_item a").click(function(){
		$(".select").removeClass("select");
		$(this).addClass("select");
	});
	setBodyHeight();
});

function setBodyHeight(){
	if (navigator.appName.indexOf("Microsoft Internet Explorer")>-1) {//处理ie浏览器placeholder和password的不兼容问题
		if(navigator.appVersion.indexOf("MSIE 7.0")>-1){
			$("#indexBody").css("height",window.innerHeight+"px");
		}else if(navigator.appVersion.indexOf("MSIE 8.0")>-1){
			$("#indexBody").css("height",document.documentElement.offsetHeight+"px");
		}else{
			$("#indexBody").css("height",window.innerHeight+"px");
		}
    } else {
    	$("#indexBody").css("height",window.innerHeight+"px");
    }
}
onresize=function(){
	setBodyHeight();
}
$(document).ready(function(){
	jboxStartLoading();
	jboxLoad("container","<s:url value='/medroad/projlist'/>");
});
function tieredMedical(){
	window.location.href = "<s:url value='/jsp/medroad/tms/index.jsp'/>";
}
</script>
<style>
body{overflow:hidden;}
</style>
</head>

<body>
<div style="overflow:auto;" id="indexBody">
<div class="bd_bg">
<div class="yw">
<div class="head">
	<div class="head_inner">
		<h1 class="logo">
			${applicationScope.sysCfgMap['sys_title_name']}
		</h1>
		<c:if test="${not param.notShowAccount}">
		<div class="account">
			<h2 style="text-align: right">欢迎您：${sessionScope.currUser.userName }&#12288;-&#12288;${sessionScope.currUser.orgName }</h2>
			<div class="head_right">
				<!-- 
				<a href="<s:url value='${param.indexUrl}'/>">首页</a>&#12288;
				<a href="javascript:changeProj();">${proj.projShortName}&#12288;(${role.roleName})</a>&#12288;
				 -->
				 <!-- 
				<a href="javascript:tieredMedical();">分级诊疗</a>&#12288;
				  -->
				<a href="javascript:void();">临床科研一体化</a>&#12288;
<!-- 
				<a href="javascript:void();">教育培训</a>&#12288;
 -->
				<a href="<s:url value='/logout'/>">退出</a>
			</div>
		</div>
		</c:if>
		
	</div> 
</div>

 <div class="body">
   <div class="container" id="container">
     	
					
   </div>
 </div>
</div>
</div>
 <c:if test="${applicationScope.sysCfgMap['online_service']=='Y'}">
		<jsp:include page="/jsp/service.jsp"></jsp:include>
	</c:if>
<div class="foot">
	<div class="foot_inner">
		技术支持： <a style="color: #fff" href="http://www.famousmed.cn/"
			target="_blank">江苏法迈生医学科技有限公司</a>
	</div>
</div>
</div>
</body>
</html>
