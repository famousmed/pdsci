<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>临床科研信息化管理系统</title>
<jsp:include page="/jsp/enso/htmlhead-enso.jsp">
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
	window.location.href="<s:url value='/enso/main/pi'/>?currentPage="+$("#currentPage").val();
} 

function main(){
	jboxLoad("content","<s:url value='/hbres/singup/hospital/main'/>",true);
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

function orgList(currentPage){
	var searchData = {
			"orgCode":$("#orgCode").val(),
			"orgName":$("#orgName").val(),
			"currentPage":currentPage
	};
	jboxPostLoad("content","<s:url value='/enso/orgList'/>",searchData,true);
}
/**
 * 住培学员注册登记表
 */
function registerList(currentPage){
	if(!currentPage){
		currentPage = 1;
	}
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	var url = "<s:url value='/hbres/grade/registerList'/>?currentPage="+ currentPage
			+"&orgFlow=" + orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}";
	jboxLoad("content", url, true);
}

/**
 * 住培注册学员统计表
 */
function registerStatistics(){
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	var url = "<s:url value='/hbres/grade/registerStatistics'/>?orgFlow=" + orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}";
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
	var url = "<s:url value='/hbres/grade/recruitResultList'/>?currentPage="+currentPage 
			+"&orgFlow="+orgFlow+"&source=${GlobalConstant.USER_LIST_LOCAL}";
	jboxLoad("content", url, true);
}
/**
 * 安全中心
 */
function accounts(){
	jboxLoad("content","<s:url value='/hbres/singup/accounts'/>",true);
}

function resMain(){
	window.open("<s:url value='/hbres/singup/login'/>?userFlow=${sessionScope.currUser.userFlow}");
}
function noticeList(){
	jboxLoad("content","<s:url value='/enso/noticelist'/>",true);
}
function overview(){
	jboxLoad("content","<s:url value='/enso/overview'/>",true);
}
function changeProj(){
	jboxConfirm("确认切换项目?",function(){
		window.location.href = "<s:url value='/enso/projlist'/>";
	});
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
<jsp:include page="/jsp/enso/head.jsp">
    <jsp:param value="/enso/main?projFlow=${proj.projFlow}&roleFlow=${role.roleFlow}" name="indexUrl"/>
</jsp:include>


 <div class="body">
   <div class="container">
     <div class="content_side">
        <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>受试者管理
          </dt>
          <dd class="menu_item"><a href="javascript:main();">添加受试者</a></dd>
          <dd class="menu_item"><a href="javascript:main();">受试者访视/随访</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>统计查询
          </dt>
          <c:set value="${sysCfgMap['res_reg_year']}" var="year"/>
          <dd class="menu_item"><a href="javascript:orgList();">机构入组概况</a></dd>
          <dd class="menu_item"><a href="javascript:overview();">聚集抽样分析</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_setup"></i>设置
          </dt>
           <dd class="menu_item"><a href="javascript:accounts();">安全中心</a></dd>
        </dl>
     </div>
     <div class="col_main" id="content">
       <div class="content_main">
         <div class="index_show">
          <div class="index_tap top_left">
            <ul class="inner">
              <li class="index_item index_blue">
                <a href="javascript:noticeList();" style="cursor: point;">
                  <span class="tap_inner">
                    <i class="index_message"></i>
                    <em class="number">${3 }</em>
                    <strong  class="title">消息数</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner tab_second">
                    <i class=" people"></i>
                    <em class="number">${48 }</em>
                    <strong  class="title">机构入组</strong>
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
                    <i class="crowd"></i>
                    <em class="number">${272 }</em>
                    <strong  class="title">总人数</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
        </div>
         <div class="index_form">
          <h3>项目概况</h3>
          <table border="0" cellpadding="0" cellspacing="0" class="grid" style="border-top: 0px;">
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">项目名称：</td>
            		<td style="text-align: left;" colspan="3">${proj.projName}</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">项目简称：</td>
            		<td style="text-align: left;width: 400px;">${proj.projShortName}</td>
            		<td style="width: 100px;padding-left: 20px;text-align: right">项目编号：</td>
            		<td style="text-align: left;">${proj.projNo}</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">项目类型：</td>
            		<td style="text-align: left;width: 400px;">${proj.projSubTypeName}</td>
            		<td style="width: 100px;padding-left: 20px;text-align: right">计划病例数：</td>
            		<td style="text-align: left;">100000例</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">申办单位：</td>
            	<td style="text-align: left;" colspan="3">${proj.projShortDeclarer}</td>
            	</tr>
          </table>
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
	<jsp:include page="/jsp/enso/foot.jsp" />
</div>
</body>
</html>
