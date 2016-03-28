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

function accounts(){
	jboxLoad("content","<s:url value='/jsres/manage/accounts'/>",true);
}

/* 培训信息 */
function main(){
	var url = "<s:url value='/jsres/doctor/main'/>";
	jboxLoad("content", url, false);
}

function doctorInfo(){
	jboxLoad("content","<s:url value='/jsp/jsres/doctor/doctorInfo.jsp'/>",false);
}

function trainMain(){
	jboxLoad("content","<s:url value='/jsp/jsres/doctor/trainMain.jsp'/>",false);
}

/* 结业信息 */
function graduateMain(){
	jboxLoad("content","<s:url value='/jsp/jsres/doctor/graduate/main.jsp'/>",false);
}

/* function registerRecord(){
	jboxLoad("content","<s:url value='/jsp/jsres/doctor/registerRecord.jsp'/>",false);
} */

/* function addTrainRecord(){
	jboxLoad("content","<s:url value='/jsp/jsres/doctor/trainRecord.jsp'/>",false);
} */

function selectMenu(menuId,subMenuId){
	$("#"+menuId).find("a").click();
	$(".select").removeClass("select");
	$("#"+menuId).find("a").addClass("select");
	$("#subMenuId").val(subMenuId);
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
       <a href="<s:url value='/jsres/manage/doctor'/>">江苏省住院医师规范化培训管理平台</a>
     </h1>
     <div class="account">
       <h2 style="text-align: right;">您好，${sessionScope.currUser.userName }</h2>
       <div class="head_right">
        <a href="<s:url value='/jsres/manage/doctor'/>">首页</a>&#12288;
         <a href="<s:url value='/inx/jsres/logout'/>">退出</a>
       </div>
     </div>
   </div>
 </div>

 <div class="body">
   <div class="container">
     <div class="content_side">
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>医师个人信息管理<input type="hidden" id="subMenuId" value=""/>
          </dt>
          <dd class="menu_item" id="main"><a onclick="main();">培训信息</a></dd>
          <dd class="menu_item" id="graduateMain"><a onclick="graduateMain();">结业考核申请</a></dd>
          <!-- <dd class="menu_item" id="doctorInfo"><a onclick="doctorInfo();">基本信息</a></dd>
          <dd class="menu_item" id="registerRecord"><a onclick="registerRecord();">注册记录</a></dd>
          <dd class="menu_item" id="addTrainRecord"><a onclick="addTrainRecord();">添加培训记录</a></dd> -->
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
                <a href="javascript:selectMenu('main','doctorInfo');">
                  <span class="tap_inner">
                    <i class="message"></i>
                    <em class="number" style="font-size: 25px;">审核中</em>
                    <strong  class="title">培训信息</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="#" style="cursor: default;">
                  <span class="tap_inner tab_second">
                    <i class="people"></i>
                    <em class="number" style="font-size: 25px;">在培</em>
                    <strong  class="title">医师状态</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
          <div class="index_tap top_right">
            <ul class="inner">
              <li class="index_item index_green">
                <a href="javascript:selectMenu('main','trainInfo');">
                  <span class="tap_inner">
                    <i class="crowd"></i>
                    <em class="number">3</em>
                    <strong  class="title">轮转培训</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div class="main_bd">
		    <ul>
		        <li class="score_frame">
		            <h1>医师信息概况</h1>
		            <div class="index_table" >
		                <table cellpadding="0" cellspacing="0" width="100%">
		                <colgroup>
		                  <col width="50%"/>
		                  <col width="50%"/>
		                </colgroup>
		                <tbody>
		                <tr>
			                <td class="up" colspan="2">
			                	<h3>培训信息审核进度</h3>
								<div class="flowsteps" id="icn">
								  <ol class="num5">
							        <li class="first done">
							          <span><i style="width: 34px;">1</i><em>注册</em></span>
							        </li>
							        <li class="done">
							          <span><i>2</i><em>基地审核</em></span>
							        </li>
							        <li class="current">
							          <span><i>3</i><em>市局审核</em></span>
							        </li>
							        <li>
							          <span><i>4</i><em>毕教委审核</em></span>
							        </li>
							        <li class="last">
							          <span><i>5</i><em>完成</em></span>
							        </li>
							      </ol>
								</div>
			                </td>
		                </tr>
		                <tr>
		                	<td class="td_first">
			                	<h3><a href="javascript:selectMenu('main','trainInfo');" style="color: black;">培训信息</a></h3>
			                	<dl class="gray">
								<dd class="left">已培养年限修改：<span class="right">等待基地审核...</span></dd>
								<dd class="left">结业考核&#12288;&#12288;&#12288;：<span class="right">等待结业考核...</span></dd>
								<dd class="left">基地变更申请&#12288;：<span class="right">等待转入基地审核...</span></dd>
								</dl>
			                </td>
			                <td class="td_last">
			                	<h3><a href="javascript:selectMenu('main','trainInfo');" style="color: black;">轮转培训记录</a></h3>
			                	<dl class="gray">
								<dd class="left">苏州市广济医院 <span class="right">消化内科&#12288;</span></dd>
								<dd class="left">苏州市九龙医院<span class="right">儿科&#12288;</span></dd>
								<dd class="left">苏州市九龙医院<span class="right">神经内科&#12288;</span></dd>
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
