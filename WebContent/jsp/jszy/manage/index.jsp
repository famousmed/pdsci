<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${sysCfgMap['sys_title_name']}</title>
<jsp:include page="/jsp/jszy/htmlhead-jszy.jsp">
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

$(document).ready(function(){
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

/**
 * 基地录取情况
 */

function showAdmit (){
	var url = "<s:url value='/jszy/manage/showDocRecruit'/>";
	jboxLoad("content", url, true);
}

function showRecruit(){
	jboxLoad("content" , "<s:url value='/jszy/manage/showRecruit'/>" , true);
}

function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	window.location.href="<s:url value='/jszy/manage/home'/>?currentPage="+$("#currentPage").val();
} 

function swap(){
	jboxLoad("content","<s:url value='/jszy/manage/swap'/>",true);
}

/**
 * 招录设置
 */
function cfg() {
	jboxLoad("content","<s:url value='/jszy/manage/datecfg'/>",true);
}
/**
 * 招录计划
 */
function planList(assignYear){
	jboxLoad("content","<s:url value='/jszy/manage/plan'/>?assignYear="+assignYear,true);
}
/**
 * 基地维护
 */
function org(isY,id){
	jboxLoad("content","<s:url value='/jszy/manage/org'/>?isCountry="+isY+"&id="+id,true);
}
/**
 * 专业维护
 */
function spe(){
	jboxLoad("content","<s:url value='/jszy/manage/spe'/>",true);
}
/**
 * 公告
 */
function notice(currentPage){
	if(!currentPage){
		currentPage = 1;
	}
	jboxLoad("content","<s:url value='/jszy/manage/noticemanage?currentPage='/>"+currentPage,true);
}
/**
 * 安全中心
 */
function accounts(){
	jboxLoad("content","<s:url value='/hbres/singup/accounts'/>",true);
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
<jsp:include page="/jsp/jszy/head.jsp"/>
 <div class="body">
   <div class="container">
     <div class="content_side">
         <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_setup"></i>调剂管理
          </dt>
          	 <dd class="menu_item"><a onclick="swap();">学员调剂</a></dd>
        </dl>
     
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>统计查询<input type="hidden" id="subMenuId" value=""/>
          </dt>
	           <c:set value="${sysCfgMap['res_reg_year_sczy']}" var="year"/>
          <dd class="menu_item" id="main"><a onclick="planList('${year}');">招录概况</a></dd>
          <dd class="menu_item"><a onclick="showAdmit();">基地录取人员一览表</a></dd>
          <dd class="menu_item"><a onclick="showRecruit();">基地录取情况一览表</a></dd>
        </dl>
        
        
        
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_setup"></i>设置
          </dt>
          	<dd class="menu_item"><a href="javascript:notice();">公告维护</a></dd>
          	 <dd class="menu_item"><a href="javascript:org('','');">基地维护</a></dd>
           <dd class="menu_item"><a href="javascript:spe();">专业维护</a></dd>
           <dd class="menu_item"><a href="javascript:cfg();">招录设置</a></dd>
            <dd class="menu_item"><a href="javascript:accounts();">安全中心</a></dd>
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
                    <em class="number" style="font-size: 25px;">${singupCount}</em>
                    <strong  class="title">报名人数</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner tab_second">
                    <i class="people"></i>
                    <em class="number" style="font-size: 25px;">${passedCount}</em>
                    <strong  class="title">审核通过</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
          <div class="index_tap top_right">
            <ul class="inner">
              <li class="index_item index_green">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner tab_third">
                    <i class="crowd"></i>
                    <em class="number">${recruitCount}</em>
                    <strong  class="title">录取人数</strong>
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
            <strong><a href="<s:url value='/inx/jszy/noticeView'/>?infoFlow=${msg.infoFlow}" target="_blank">${msg.infoTitle }</a>
            <c:if test="${pdfn:signDaysBetweenTowDate(pdfn:getCurrDate(),pdfn:transDate(msg.infoTime))<=7}">
            	<i class="new1"></i>
            </c:if>
            </strong>
            <span>${pdfn:transDate(msg.infoTime)}</span>
            </a>
            </li>
            </c:forEach>
          </ul>
        </div>
        <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value=""/>
           <c:set var="pageView" value="${pdfn:getPageView(messages)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
		
		
       </div>
     </div>
   </div>
 </div>
</div>
</div>
<c:if test="${applicationScope.sysCfgMap['online_service']=='Y'}">
    <jsp:include page="/jsp/service.jsp"></jsp:include>
</c:if>
<jsp:include page="/jsp/jszy/foot.jsp" />
</div>
</body>
</html>
