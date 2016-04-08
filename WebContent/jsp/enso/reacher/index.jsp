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
/*
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
	jboxLoad("content","<s:url value='/jsp/enso/pi/overview.jsp'/>",true);
}
function changeProj(){
	jboxConfirm("确认切换项目?",function(){
		jboxStartLoading();
		window.location.href = "<s:url value='/enso/projlist'/>";
	});
}
function addPatient(){
	jboxLoad("content","<s:url value='/enso/addPatient'/>",true);
}
function patients(orgFlow,currentPage){
	jboxLoad("content","<s:url value='/enso/patientList'/>?projFlow=${proj.projFlow}&orgFlow="+orgFlow+"&currentPage="+currentPage,true);
}
function visit(patientFlow){
	jboxLoad("content","<s:url value='/enso/visit'/>?patientFlow="+patientFlow,true);
}
function drugs(){
	jboxLoad("content","<s:url value='/enso/drug'/>",true);
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
          <dd class="menu_item"><a href="javascript:addPatient();">添加受试者</a></dd>
          <dd class="menu_item"><a href="javascript:patients('${sessionScope.currUser.orgFlow }','');">受试者访视/随访</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>统计查询
          </dt>
           <dd class="menu_item"><a href="javascript:drugs();">药品管理</a></dd>
          <dd class="menu_item"><a href="javascript:orgList('');">机构入组概况</a></dd>
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
                    <i class="message"></i>
                    <em class="number">${13 }</em>
                    <strong  class="title">消息数</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="javascript:patients('${sessionScope.currUser.orgFlow }','');" style="cursor: point;">
                  <span class="tap_inner tab_second">
                    <i class=" people"></i>
                    <em class="number">${orgPatientCount }</em>
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
                    <em class="number">${totleCount }</em>
                    <strong  class="title">总人数</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
        </div>
         <div class="index_form">
          <h3>随访提醒&#12288;
          <!-- 
           <span style="float: right">
          <label><input type="checkbox" checked="checked">7天</input></label>
          &#12288;<label><input type="checkbox">10天</input></label>
         	&#12288;<label> <input type="checkbox">15天</input></label>
          </span>
           -->
         
          </h3>
          <table border="0" cellpadding="0" cellspacing="0" class="grid" style="border-top: 0px;">
            	<tr >
            		<td style="padding-left: 20px;text-align: left;">受试者编号：003X </td>
            		<td  style="padding-left: 20px;text-align: left;"> 联系方式：17652233456</td>
            		<td  style="padding-left: 20px;text-align: left;">访视次数：1/5&nbsp;(上次访视：2016-3-12)</td>
            		<td  style="padding-left: 20px;text-align: left;">随访日期：2016-4-28 </td>
            		<td><a href="javascript:visit();" title="访视">>></a> </td>
            	</tr>
            	<tr >
            		<td style="padding-left: 20px;text-align: left;">受试者编号：3212 </td>
            		<td  style="padding-left: 20px;text-align: left;"> 联系方式：18976233456</td>
            		<td  style="padding-left: 20px;text-align: left;">访视次数：1/5&nbsp;(上次访视：2016-3-12)</td>
            		<td  style="padding-left: 20px;text-align: left;">随访日期：2016-5-23</td>
            		<td> <a href="javascript:visit();" title="访视">>></a> </td>
            	</tr>
            	<tr >
            		<td style="padding-left: 20px;text-align: left;">受试者编号：2313 </td>
            		<td  style="padding-left: 20px;text-align: left;"> 联系方式：15252235612</td>
            		<td  style="padding-left: 20px;text-align: left;">访视次数：3/5&nbsp;(上次访视：2016-3-12)</td>
            		<td  style="padding-left: 20px;text-align: left;">随访日期：2016-5-24</td>
            		<td><a href="javascript:visit();" title="访视">>></a> </td>
            	</tr>
            	<tr >
            		<td style="padding-left: 20px;text-align: left;">受试者编号：3672 </td>
            		<td  style="padding-left: 20px;text-align: left;"> 联系方式：15252212311</td>
            		<td  style="padding-left: 20px;text-align: left;">访视次数：2/5&nbsp;(上次访视：2016-3-12)</td>
            		<td  style="padding-left: 20px;text-align: left;">随访日期：2016-5-28</td>
            		<td><a href="javascript:visit();" title="访视">>></a> </td>
            	</tr>
            	
          </table>
        </div>
         <div class="index_form" style="margin-top: 20px;">
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
            		<td style="width: 100px;padding-left: 20px;">&#12288;适应症：</td>
            		<td style="text-align: left;" >${proj.projShortDeclarer}</td>
            		<td style="width: 100px;padding-left: 20px;text-align: right">申办单位：</td>
            		<td style="text-align: left;">${proj.projShortDeclarer}</td>
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
