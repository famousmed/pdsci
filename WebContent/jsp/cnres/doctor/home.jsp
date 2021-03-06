<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>国家住院医师规范化培训示范性基地招录系统</title>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>

<script type="text/javascript">
	var main = null;
	function goUserInfo(){
		main.src="<s:url value='/cnres/singup/doctor/userInfo'/>";
	}
	
	function goIndex(){
		location.href="<s:url value='/cnres/singup/doctor'/>";
	}
	
	function logout(){
		location.href="<s:url value='/inx/cnres/logout'/>";
	}
	function noticeList(){
		main.src="<s:url value='/cnres/singup/doctor/noticelist'/>";
	}
	
	function setBodyHeight(){
		if (navigator.appName.indexOf("Microsoft Internet Explorer")>-1) {//处理ie浏览器placeholder和password的不兼容问题
			$("#indexBody").css("height",document.documentElement.offsetHeight+"px");
			$("#mainIframe").css("height",document.documentElement.offsetHeight-111+"px");
	    } else {
	    	$("#indexBody").css("height",window.innerHeight+"px");
	    }
	}
	
	$(function(){
		main = $("#mainIframe")[0];
		setBodyHeight();
	});
	
	onresize=function(){
		setBodyHeight();
	}
	
</script>
<style>
html{overflow:hidden;}
</style>
</head>

<body id="indexBody" style="overflow-y:hidden;">
  <div class="header_bg">
    <div class="header_inner">
      <div class="header_logo">
        <img src="<s:url value='/jsp/cnres/images/basic/logo.png'/>" />
      </div>
      <ul>
        <li class="home"><a onclick="goIndex();">主页</a></li>
        <li class="head_notice_n"><a onclick="noticeList();">公告</a></li>
        <li class="user"><a onclick="goUserInfo();">个人中心</a></li>
        <li class="loginout"><a onclick="logout();">退出</a></li>
      </ul>
    </div>
  </div>
  
    <div class="wrapper" style="overflow:hidden;">
	<iframe id="mainIframe" name="mainIframe" scrolling="yes" width="100%" height="100%" frameborder="0" allowtransparency="no" src="<s:url value='/cnres/singup/doctorMain'/>" marginheight="0" marginwidth="0">
	</iframe>
	</div>
    
  <c:if test="${applicationScope.sysCfgMap['online_service']=='Y'}">
		<jsp:include page="/jsp/service.jsp"></jsp:include>
	</c:if>
  <div class="footer">
  	主管单位：国家卫生计生委科教司 | 技术支持：国家卫生计生委统计信息中心
  </div>
	
</body>
</html>
