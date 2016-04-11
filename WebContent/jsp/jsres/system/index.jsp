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

function accounts(){
	jboxLoad("content","<s:url value='/jsres/manage/accounts'/>",true);
}

function hospitalList(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/hospital/hospitalList.jsp'/>",true);
}

function auditHospitals(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/hospital/auditHospitals.jsp'/>",true);
}

function editHosSpecials(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/hospital/editHosSpecials.jsp'/>",true);
}

function doctorList(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/doctor/doctorList.jsp'/>",true);
}

function auditDoctors(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/doctor/auditDoctors.jsp'/>",true);
}

function doctorManage(){
	jboxLoad("content","<s:url value='/jsp/jsres/city/doctorManage.jsp'/>",false);
}

function unpassedDoctors(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/doctor/unpassedDoctors.jsp'/>",true);
}

function timeoutRegisterHoses(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/doctor/timeoutRegisterHoses.jsp'/>",false);
}

/* 统计分析 */
function trainBaseStatistics(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/trainBaseStatistics.jsp'/>",false);
}

function specialBaseStatistics(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/specialBaseStatistics.jsp'/>",false);
}

function hosBaseStatistics(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/hosBaseStatistics.jsp'/>",false);
}

function doctorOverView(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/doctorOverView.jsp'/>",false);
}

function doctorStatistics(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/doctorStatistics.jsp'/>",false);
}

function generalDoctorStatistics(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/generalDoctorStatistics.jsp'/>",false);
}

function specialDoctorStatistics(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/statistics/specialDoctorStatistics.jsp'/>",false);
}

/* 系统管理 */
function userList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/userList.jsp'/>",false);
}

function roleList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/roleList.jsp'/>",false);
}

function sysDictList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/sysDictList.jsp'/>",false);
}

function sysCfg(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/sysCfg.jsp'/>",false);
}

function schoolList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/schoolList.jsp'/>",false);
}

function sysDeptList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/sysDeptList.jsp'/>",false);
}

function specialList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/specialList.jsp'/>",false);
}

function baseSpecialList(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/baseSpecialList.jsp'/>",false);
}

function baseLog(){
	jboxLoad("content","<s:url value='/jsp/jsres/system/sys/baseLog.jsp'/>",false);
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
       <a href="<s:url value='/jsres/manage/system'/>">江苏省住院医师规范化培训管理平台</a>
     </h1>
     <div class="account">
       <h2>${sessionScope.currUser.orgName }</h2>
       <div class="head_right">
        <a href="<s:url value='/jsres/manage/system'/>">首页</a>&#12288;
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
          <dd class="menu_item"><a href="javascript:auditHospitals();">基地申请审核</a></dd>
          <dd class="menu_item"><a href="javascript:hospitalList();">基地信息查询</a></dd>
          <dd class="menu_item"><a href="javascript:editHosSpecials();">培训专业修改</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>医师信息管理
          </dt>
          <dd class="menu_item"><a href="javascript:auditDoctors();">注册信息审核</a></dd>
          <dd class="menu_item"><a href="javascript:doctorList();">医师信息查询</a></dd>
          <dd class="menu_item"><a href="javascript:unpassedDoctors();">审核未通过名单</a></dd>
          <!-- <dd class="menu_item"><a href="javascript:timeoutRegisterHoses();">超时注册名单</a></dd> -->
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>统计分析
          </dt>
          <dd class="menu_item"><a href="javascript:trainBaseStatistics();">培训基地统计</a></dd>
          <dd class="menu_item"><a href="javascript:specialBaseStatistics();">专业基地统计</a></dd>
          <dd class="menu_item"><a href="javascript:hosBaseStatistics();">基地花名册</a></dd>
          <dd class="menu_item"><a href="javascript:doctorOverView();">在培医师总览</a></dd>
          <dd class="menu_item"><a href="javascript:doctorStatistics();">在培医师统计</a></dd>
          <dd class="menu_item"><a href="javascript:generalDoctorStatistics();">全科在培医师统计</a></dd>
          <dd class="menu_item"><a href="javascript:specialDoctorStatistics();">专科在培医师统计</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_setup"></i>设置
          </dt>
           <!-- <dd class="menu_item"><a href="javascript:userList();">用户管理</a></dd>
           <dd class="menu_item"><a href="javascript:roleList();">角色管理</a></dd>
           <dd class="menu_item"><a href="javascript:sysDictList();">字典维护</a></dd>
           <dd class="menu_item"><a href="javascript:sysCfg();">系统配置</a></dd> -->
           <!-- <dd class="menu_item"><a href="javascript:schoolList();">学校管理</a></dd>
           <dd class="menu_item"><a href="javascript:sysDeptList();">职能科室管理</a></dd>
           <dd class="menu_item"><a href="javascript:specialList();">专业管理</a></dd>
           <dd class="menu_item"><a href="javascript:baseSpecialList();">基地专业管理</a></dd>
           <dd class="menu_item"><a href="javascript:baseLog();">基地操作日志</a></dd> -->
           <!-- <dd class="menu_item"><a href="javascript:doctorManage();">医师用户管理</a></dd> -->
           <dd class="menu_item"><a href="javascript:accounts();">安全中心</a></dd>
        </dl>
     </div>
     <div class="col_main" id="content">
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
