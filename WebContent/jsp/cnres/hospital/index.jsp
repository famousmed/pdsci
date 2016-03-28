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
<script>
$(document).ready(function(){
	$(".menu_item a").click(function(){
		$(".select").removeClass("select");
		$(this).addClass("select");
	});
	setBodyHeight();
});


function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	window.location.href="<s:url value='/cnres/singup/manage/local'/>?currentPage="+$("#currentPage").val();
} 

function main(){
	jboxLoad("content","<s:url value='/cnres/singup/hospital/main'/>",true);
}

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

/* 住培招录计划 */
function planList(assignYear){
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	jboxLoad("content","<s:url value='/cnres/singup/manage/plan'/>?assignYear="+assignYear
			+"&orgFlow="+orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}",true);
}

/**
 * 住培学员注册登记表
 */
function registerList(currentPage){
	if(!currentPage){
		currentPage = 1;
	}
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	var url = "<s:url value='/cnres/grade/registerList'/>?currentPage="+ currentPage
			+"&orgFlow=" + orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}";
	jboxLoad("content", url, true);
}

/**
 * 住培注册学员统计表
 */
function registerStatistics(){
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	var url = "<s:url value='/cnres/grade/registerStatistics'/>?orgFlow=" + orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}";
	jboxLoad("content", url, true);
}

/**
 * 录取考试成绩排序表
 */
function recruitResultList(currentPage){
	if(!currentPage){
		currentPage = 1;
	}
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	var url = "<s:url value='/cnres/grade/recruitResultList'/>?currentPage="+currentPage 
			+"&orgFlow="+orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}";
	jboxLoad("content", url, true);
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
       <a href="<s:url value='/cnres/singup/manage/local'/>">国家住院医师规范化培训示范性基地招录系统</a>
     </h1>
     <div class="account">
       <h2>${sessionScope.currUser.orgName }</h2>
       <div class="head_right">
        <a href="<s:url value='/cnres/singup/manage/local'/>">首页</a>&#12288;
         <a href="<s:url value='/inx/cnres/logout'/>">退出</a>
       </div>
     </div>
   </div>
 </div>


 <div class="body">
   <div class="container">
     <div class="content_side">
        <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>管理
          </dt>
          <dd class="menu_item"><a href="javascript:main();">招录管理</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>统计
          </dt>
          <c:set value="${sysCfgMap['res_reg_year']}" var="year"/>
          <dd class="menu_item"><a href="javascript:planList('${year}');">住培招录计划</a></dd>
          <dd class="menu_item"><a href="javascript:registerList();">住培学员注册登记表</a></dd>
          <dd class="menu_item"><a href="javascript:registerStatistics();">住培注册学员统计表</a></dd>
          <dd class="menu_item"><a href="javascript:recruitResultList();">录取考试成绩排序表</a></dd>
        </dl>
     </div>
     <div class="col_main" id="content">
       <div class="content_main">
         <div class="index_show">
          <div class="index_tap top_left">
            <ul class="inner">
              <li class="index_item index_blue">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner">
                    <i class="message"></i>
                    <em class="number">${volunNum }</em>
                    <strong  class="title">填报数</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner tab_second">
                    <i class="crowd"></i>
                    <em class="number">${retestNum }</em>
                    <strong  class="title">复试数</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
          <div class="index_tap top_right">
            <ul class="inner">
              <li class="index_item index_green">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner">
                    <i class="people"></i>
                    <em class="number">${recruitNum }</em>
                    <strong  class="title">录取数</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
        </div>
         <div class="index_form">
          <h3>系统公告</h3>
          <ul class="form_main">
          	<c:forEach items="${messages}" var="msg">
            <li>
            <a>
            <strong><a href="<s:url value='/cnres/notice/view'/>?infoFlow=${msg.infoFlow}" target="_blank">${msg.infoTitle }</a>
            <c:if test="${pdfn:signDaysBetweenTowDate(pdfn:getCurrDate(),pdfn:transDate(msg.infoTime))<=7}">
            	<i class="new1"></i>
            </c:if>
            </strong>
            <span>${pdfn:transDate(msg.infoTime) }</span>
            </a>
            </li>
            </c:forEach>
          </ul>
        </div>
         <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value=""/>
           <c:set var="pageView" value="${pdfn:getPageView(messages)}" scope="request"></c:set>
	  		 <pd:pagination-cnres toPage="toPage"/>	 
        </div>
       </div>
     </div>
   </div>
 </div>
</div>
</div>

 <div class="foot">
   <div class="foot_inner">
        主管单位：国家卫生计生委科教司 | 技术支持：国家卫生计生委统计信息中心
   </div>
 </div>
</div>
</body>
</html>
