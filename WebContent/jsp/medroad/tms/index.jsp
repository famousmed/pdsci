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
$(document).ready(function(){
	//加载随访提醒
	followRemind();
});
function followRemind(){
	jboxLoad("followRemind","<s:url value='/enso/followRemind'/>",true);
}
function projInfo(){
	jboxLoad("content","<s:url value='/enso/proj/info'/>",true);
}
function projPath(){
	jboxLoad("content","<s:url value='/enso/proj/path'/>",true);
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
<jsp:include page="/jsp/medroad/head.jsp" flush="true"/>


 <div class="body">
   <div class="container">
     <div class="content_side">
     
     	 <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>双向转诊
          </dt>
          <dd class="menu_item"><a href="javascript:void();">转诊单</a></dd>
          <dd class="menu_item"><a href="javascript:void();">转入本院</a></dd>
          <dd class="menu_item"><a href="javascript:void();">本院转出</a></dd>
          <dd class="menu_item"><a href="javascript:void();">数据中心</a></dd>
        </dl>
        <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>远程会诊
          </dt>
          <dd class="menu_item"><a href="javascript:void();">申请会诊</a></dd>
          <dd class="menu_item"><a href="javascript:void();">我的会诊</a></dd>
          <dd class="menu_item"><a href="javascript:void();">会诊记录</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>远程病理
          </dt>
           <dd class="menu_item"><a href="javascript:void();">申请会诊</a></dd>
          <dd class="menu_item"><a href="javascript:void(););">向我申请</a></dd>
          <dd class="menu_item"><a href="javascript:void();">我的申请</a></dd>
          <dd class="menu_item"><a href="javascript:void();">上传管理</a></dd>
          <dd class="menu_item"><a href="javascript:void();">冰冻预约</a></dd>
        </dl>
         <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>远程影像
          </dt>
           <dd class="menu_item"><a href="javascript:void();">申请会诊</a></dd>
          <dd class="menu_item"><a href="javascript:void('');">向我申请</a></dd>
          <dd class="menu_item"><a href="javascript:void();">我的申请</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>远程B超
          </dt> 
           <dd class="menu_item"><a href="javascript:void();">申请会诊</a></dd>
          <dd class="menu_item"><a href="javascript:void('');">向我申请</a></dd>
          <dd class="menu_item"><a href="javascript:void();">我的申请</a></dd>
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
                    <em class="number">${infos.size()}</em>
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
         <div class="index_form" id="followRemind">
          
        </div>
         <div class="index_form" style="margin-top: 20px;display: none" >
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
            		<td style="text-align: left;">${projInfoForm.caseCount}</td>
            	</tr>
            	<tr >
            		<td style="width: 100px;padding-left: 20px;">&#12288;适应症：</td>
            		<td style="text-align: left;" >${projInfoForm.indication}</td>
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
	<jsp:include page="/jsp/medroad/foot.jsp" />
</div>
</body>
</html>
