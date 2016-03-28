<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
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

function hosMain(baseFlow){
	var url =  "<s:url value='/jsres/base/main'/>?baseFlow="+baseFlow;
	jboxLoad("content",url,false);
}

/* function commuHospital(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/hos/commuHospital.jsp'/>",false);
} */

function auditHosProcess(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/hos/auditHosProcess.jsp'/>",false);
}

function accounts(){
	jboxLoad("content","<s:url value='/jsres/singup/accounts'/>",true);
}

function doctorList(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/doctor/doctorList.jsp'/>?source=hospital",true);
}

function auditDoctors(currentPage){
	var url = "<s:url value='/jsres/manage/province/doctor/auditDoctors'/>?source=hospital";
	jboxLoad("content", url, true);
}

function auditGraduate(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/doctor/auditGraduates.jsp'/>?source=hospital",false);
}

/* function doctorAccountUnlock(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/doctor/doctorAccountUnlock.jsp'/>",false);
} */

/* function schDeptInfo(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/doctor/schDeptInfo.jsp'/>",false);
} */

function doctorManage(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/doctorManage.jsp'/>",false);
}

function selectMenu(menuId){
	$("#"+menuId).find("a").click();
}

function changeBaseMain(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/doctor/changeBaseMain.jsp'/>",false);
}

function doctorTrendMain(){
	jboxLoad("content","<s:url value='/jsres/doctorRecruit/doctorRecruitList'/>",false);
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
       <a href="<s:url value='/jsres/singup/manage/local'/>">江苏省住院医师规范化培训管理平台</a>
     </h1>
     <div class="account">
       <h2 class="head_right">${sessionScope.currUser.orgName }</h2>
       <div class="head_right">
        <a href="<s:url value='/jsres/singup/manage/local'/>">首页</a>&#12288;
         <a href="<s:url value='/inx/jsres/logout'/>">退出</a>
       </div>
     </div>
   </div>
 </div>


 <div class="body">
   <div class="container">
     <div class="content_side">
        <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_function"></i>基地信息管理
          </dt>
          <dd class="menu_item"><a href="javascript:hosMain('${sessionScope.currUser.orgFlow}');">基地信息维护</a></dd>
          <!-- <dd class="menu_item"><a href="javascript:commuHospital();">社区培训基地维护</a></dd> -->
          <!-- <dd class="menu_item"><a href="javascript:auditHosProcess();">审核进度查询</a></dd> -->
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>医师信息管理
          </dt>
          <dd class="menu_item" id="auditDoctors"><a onclick="auditDoctors();">医师信息审核</a></dd>
          <dd class="menu_item"><a onclick="changeBaseMain();">培训变更管理</a></dd>
          <dd class="menu_item"><a onclick="doctorTrendMain();">医师走向管理</a></dd>
          <dd class="menu_item" id="doctorList"><a onclick="doctorList();">医师信息查询</a></dd>
          <!-- <dd class="menu_item"><a href="javascript:doctorAccountUnlock();">医师帐号解锁</a></dd> -->
          <!-- <dd class="menu_item"><a href="javascript:schDeptInfo();">轮转情况查询</a></dd> -->
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>结业考核管理
          </dt>
          <dd class="menu_item" id="auditGraduate"><a onclick="auditGraduate();">考核申请审核</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_setup"></i>设置
          </dt>
           <dd class="menu_item"><a href="javascript:doctorManage();">医师账号管理</a></dd>
           <dd class="menu_item"><a href="javascript:accounts();">安全中心</a></dd>
        </dl>
     </div>
     <div class="col_main" id="content">
       <div class="content_main">
         <div class="index_show">
          <div class="index_tap top_left">
            <ul class="inner">
              <li class="index_item index_blue">
                <a href="javascript:selectMenu('auditDoctors');">
                  <span class="tap_inner">
                    <i class="message"></i>
                    <em class="number">5</em>
                    <strong  class="title">基本信息待审核</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="javascript:selectMenu('auditDoctors');">
                  <span class="tap_inner tab_second">
                    <i class="people"></i>
                    <em class="number">16</em>
                    <strong  class="title">培训信息待审核</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
          <div class="index_tap top_right">
            <ul class="inner">
              <li class="index_item index_green">
                <a href="javascript:selectMenu('auditGraduate');">
                  <span class="tap_inner">
                    <i class="crowd"></i>
                    <em class="number">8</em>
                    <strong  class="title">考核申请待审核</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div class="main_bd">
		    <ul>
		        <li class="score_frame">
		            <h1>基地信息概况</h1>
		            <div class="index_table" >
		                <table cellpadding="0" cellspacing="0" width="100%">
		                <colgroup>
		                  <col width="50%"/>
		                  <col width="50%"/>
		                </colgroup>
		                <tbody>
		                <tr>
			                <td class="up" colspan="2">
			                	<h3>基地审核进度</h3>
								<div class="flowsteps" id="icn">
								  <ol class="num4">
							        <li class="first done">
							          <span><i>1</i><em>基地申请</em></span>
							        </li>
							        <li class="done">
							          <span><i>2</i><em>市局审核</em></span>
							        </li>
							        <li class="current">
							          <span><i>3</i><em>毕教委审核</em></span>
							        </li>
							        <li class="last">
							          <span><i>4</i><em>完成</em></span>
							        </li>
							      </ol>
								</div>
			                </td>
		                </tr>
		                <tr>
		                	<td class="td_first">
			                	<h3><a href="javascript:selectMenu('doctorList');" style="color: black;">注册概况</a></h3>
			                	<dl class="gray">
								<dd class="left">2015届<span class="right">注册医师：65，审核通过：13</span></dd>
								<dd class="left">2014届<span class="right">注册医师：61，审核通过：60</span></dd>
								<dd class="left">2013届<span class="right">注册医师：59，审核通过：59</span></dd>
								<dd class="left">:</dd>
								</dl>
			                </td>
			                <td class="td_last">
			                	<h3><a href="javascript:selectMenu('auditGraduate');" style="color: black;">结业考核</a></h3>
			                	<dl class="gray">
								<dd class="left">考核申请数： <span class="right">12</span></dd>
								<dd class="left">待审核数&#12288;：<span class="right">3</span></dd>
								<dd class="left">审核通过数：<span class="right">9</span></dd>
								</dl>
			                </td>
		                </tr>
		                </tbody>
		                </table>
		            </div>
		        </li>
		    </ul>
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
 <div class="foot">
   <div class="foot_inner">
       主管单位：江苏省卫生厅科教处 | 协管单位：江苏省毕业后医学继续教育委员会
   </div>
 </div>
 
</div>

</body>
</html>
 