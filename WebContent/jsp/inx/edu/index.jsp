<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>医学教育学习平台</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="index" value="true"/>
</jsp:include>
<script>
$(function(){
	if($.browser.msie && $.browser.version < 10){
		$('body').addClass('ltie10');
	}
	$.fn.fullpage({
		verticalCentered: false,
		anchors: ['page1', 'page2', 'page3', 'page4', 'page5'],
		navigation: true,
		navigationTooltips: ['精品课程', '高校联盟', '双向认证', '移动平台','立即体验']
	});
});
function toUrl(url){
	window.location.href=url;
}
</script>
</head>
<body>
<div class="section section1">
	<div class="bg"><img src="<s:url value='/jsp/edu/css/images/section1.jpg'/>"></div>
    <div class="bg13"></div>
    <h3></h3>
</div>
<div class="section section2">
	<div class="bg"><img src="<s:url value='/jsp/edu/css/images/section2.jpg'/>" alt=""></div>
	<div class="bg21"></div>
	<div class="bg22"></div>
	<div class="bg23"></div>
	<h3></h3>
</div>
<div class="section section3">
	<div class="bg"><img src="<s:url value='/jsp/edu/css/images/section3.jpg'/>" ></div>
	<div class="bg31"></div>
	<div class="bg32"></div>
	<div class="bg33"></div>
	<h2></h2>
</div>
<div class="section section4">
  <div class="bg"><img src="<s:url value='/jsp/edu/css/images/section4.jpg'/>" alt=""></div>
	<div class="bg41"></div>
	<h2></h2>
</div>

<div class="section section5">
	<div class="bg"><img src="<s:url value='/jsp/edu/css/images/section5.jpg'/>" alt=""></div>
	<div class="bg51"></div>
	<div class="bg52"></div>
	<a href="<s:url value='/inx/edu/login'/>" class="bg53"></a>
	<div class="hgroup">
	</div>
</div>
<div id="top-text">
     <c:choose>
	   	 <c:when  test="${empty sessionScope.currUser }">
	   	 <div class="top-right fr">
		   	 <input type="button" class="login-btn" value="登录" onclick="toUrl('<s:url value="/inx/edu/login"/>')"/>
		     <input type="button" value="注册" onclick="toUrl('<s:url value="/inx/edu/register"/>')"/>
		  </div>
    	</c:when>
    	<c:otherwise>
    		<%-- <dl class="fl">
        	<dt><a class="top-login" href="<s:url value='/${sessionScope[GlobalConstant.CURRENT_VIEW]}'/>">
        	${sessionScope.currUser.userName}</a>
        	<img src="<s:url value='/jsp/edu/css/images/top-line.png'/>" width="3" height="20" />
        	<a href="<s:url value='/logout'/>" class="top-register">退出</a>
        	</dt>
            <dd></dd>
	        </dl> --%>
	        <div class="top-right fr">
		   	 <input type="button" class="login-btn" value="${sessionScope.currUser.userName}" onclick="toUrl('<s:url value="/${sessionScope[GlobalConstant.CURRENT_VIEW]}"/>')"/>
		     <input type="button" value="退出" onclick="toUrl('<s:url value="/inx/edu/logout"/>')"/>
		  </div>
	        <!-- 这里写登录后的HTML代码 -->
	    </c:otherwise>
    </c:choose>
</div>
</body>
</html>