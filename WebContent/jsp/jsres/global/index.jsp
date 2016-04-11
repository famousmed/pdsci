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
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
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

function timeoutRegisterHoses(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/hospital/timeoutRegisterHoses.jsp'/>",false);
}

/* 结业考核管理 */

function gradeInput(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/gradeInput.jsp'/>?source=province",false);
}

function graduateManage(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/graduateManage.jsp'/>",false);
}

function graduateUserList(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/graduateUserList.jsp'/>",false);
}

function auditGraduate(){
	jboxLoad("content","<s:url value='/jsp/jsres/hospital/doctor/auditGraduates.jsp'/>?source=province",false);
}

function theoResultsImport(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/theoResultsImport.jsp'/>",false);
}

function skillsResults(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/skillsResults.jsp'/>",false);
}

function skillsResultsAudit(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/skillsResultsAudit.jsp'/>",false);
}

function doctorResults(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/doctorResults.jsp'/>",false);
}

function personalResults(){
	jboxLoad("content","<s:url value='/jsp/jsres/province/graduate/personalResults.jsp'/>",false);
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

/* 设置 */
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

function selectMenu(menuId){
	$("#"+menuId).find("a").click();
}

$(document).ready(function(){
	showHosCanvas();
	showDoctorCanvas();
});

function showHosCanvas(){
	var myChart = echarts.init(document.getElementById('hosChart')); 
	option = {
		    tooltip : {
		        trigger: 'item',
		        formatter: "{b}"
		    },
		    title : {
 		        text: '基地审核概况',
 		        x:'center',
 		        y:'bottom'
 		    },
		    series : [
		        {
		          
		            type:'pie',
		            radius : '65%',
		            itemStyle : {
		                normal : {
		                    label : {
		                        show : true
		                    },
		                    labelLine : {
		                        show : true
		                    }
		                }
		            },
		            data:[
     		                {value:6, name:'待审核：6'},
     		                {value:8, name:'审核通过：8'},
     		                {value:1, name:'审核不通过：1'}
     		            ]
		        }
		    ]
		};
// 为echarts对象加载数据 
myChart.setOption(option);
}

function showDoctorCanvas(){
    var myChart = echarts.init(document.getElementById('doctorChart')); 
    var lineLabel = ['2012','2013','2014','2015'];
 	var lineValue = ['80','98','100','119'];
 	option = {
 		    title : {
 		        text: '医师注册数走向',
 		        subtext: "医师注册总数：356，审核通过总数：320"
 		    },
 		    tooltip : {
 		        trigger: 'axis'
 		    },
 		    legend: {
 		        data:['审核通过数']
 		    },
 		    calculable : true,
 		    xAxis : [
 		        {
 		            type : 'category',
 		            boundaryGap: true,
 		            data : lineLabel
 		        }
 		    ],
 		    yAxis : [
 		        {
 		            type : 'value',
 		            axisLabel : {
 		                formatter: '{value}'
 		            }
 		        }
 		    ],
 		    series : [
 		        {
 		            name:'审核通过数',
 		            type:'line',
 		            data:lineValue,
 		            itemStyle: {
	                    normal: {
	                        label : {
	                            show: true, position: 'top'
	                        }
	                    }
               		}
 		        }
 		    ]
 		};
     // 为echarts对象加载数据 
     myChart.setOption(option); 
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
       <a href="<s:url value='/jsres/manage/global'/>">江苏省住院医师规范化培训管理平台</a>
     </h1>
     <div class="account">
       <h2 class="head_right">${sessionScope.currUser.orgName }</h2>
       <div class="head_right">
        <a href="<s:url value='/jsres/manage/global'/>">首页</a>&#12288;
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
          <dd class="menu_item" id="auditHospitals"><a onclick="auditHospitals();">基地信息审核</a></dd>
          <dd class="menu_item" id="hospitalList"><a onclick="hospitalList();">基地信息查询</a></dd>
          <!-- <dd class="menu_item"><a href="javascript:timeoutRegisterHoses();">超时注册名单</a></dd> -->
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>医师信息管理
          </dt>
          <dd class="menu_item" id="auditDoctors"><a onclick="auditDoctors();">医师信息审核</a></dd>
          <dd class="menu_item"><a href="javascript:doctorList();">医师信息查询</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>结业考核管理
          </dt>
          <dd class="menu_item" id="auditGraduate"><a onclick="auditGraduate();">考核申请审核</a></dd>
          <dd class="menu_item"><a href="javascript:gradeInput();">成绩管理</a></dd>
          <dd class="menu_item"><a href="javascript:graduateUserList();">待结业名单</a></dd>
          <dd class="menu_item"><a href="javascript:graduateManage();">结业管理</a></dd>
          <!-- <dd class="menu_item"><a href="javascript:theoResultsImport();">理论成绩导入</a></dd>
          <dd class="menu_item"><a href="javascript:skillsResults();">理论成绩查询</a></dd>
          <dd class="menu_item"><a href="javascript:skillsResults();">技能成绩查询</a></dd>
          <dd class="menu_item"><a href="javascript:skillsResultsAudit();">技能成绩审核</a></dd>
          <dd class="menu_item"><a href="javascript:gradeInput();">分数线</a></dd>
          <dd class="menu_item"><a href="javascript:doctorResults();">医师成绩查询</a></dd>
          <dd class="menu_item"><a href="javascript:personalResults();">个人成绩查询</a></dd> -->
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
           <!-- <dd class="menu_item"><a href="javascript:doctorManage();">医师用户管理</a></dd> -->
           <dd class="menu_item"><a href="javascript:schoolList();">学校管理</a></dd>
           <dd class="menu_item"><a href="javascript:sysDeptList();">职能科室管理</a></dd>
           <dd class="menu_item"><a href="javascript:specialList();">专业管理</a></dd>
           <dd class="menu_item"><a href="javascript:baseSpecialList();">基地专业管理</a></dd>
           <dd class="menu_item"><a href="javascript:baseLog();">基地操作日志</a></dd>
           <dd class="menu_item"><a href="javascript:accounts();">安全中心</a></dd>
        </dl>
     </div>
     <div class="col_main" id="content">
       <div class="content_main">
         <div class="index_show">
          <div class="index_tap top_left">
            <ul class="inner">
              <li class="index_item index_blue">
                <a href="javascript:selectMenu('auditHospitals');">
                  <span class="tap_inner">
                    <i class="message"></i>
                    <em class="number">6</em>
                    <strong  class="title">基地信息待审核</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="javascript:selectMenu('auditDoctors');">
                  <span class="tap_inner tab_second">
                    <i class="people"></i>
                    <em class="number">53</em>
                    <strong  class="title">医师信息待审核</strong>
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
		            <h1>信息概况</h1>
		            <div class="index_table" >
		                <table class="in_table" cellpadding="0" cellspacing="0" width="100%">
		                <colgroup>
		                  <col width="50%"/>
		                  <col width="50%"/>
		                </colgroup>
		                <tbody>
		                <tr>
		                	<td>
			                	<h3>基地概况</h3>
			                	<dl class="gray">
								<dd class="left">基地数&#12288;：<span class="right">毕教委审核通过数：4，全科中心审核通过数：3</span></dd>
								<dd class="left">基地审核：<span class="right">审核中：8，审核通过：7，审核不通过：3</span></dd>
								</dl>
			                </td>
			                <td>
			                <div id="hosChart" style="height: 200px;"></div>
			                </td>
		                </tr>
		                </tbody>
		                </table><br/>
		                <table class="in_table" cellpadding="0" cellspacing="0" width="100%" style="margin: 0;">
		                <colgroup>
		                  <col width="35%"/>
		                  <col width="65%"/>
		                </colgroup>
		                <tbody>
		                <tr>
		                	<td>
			                	<h3>医师概况</h3>
			                	<dl class="gray">
								<dd class="left">医师数&#12288;：<span class="right">毕教委审核通过数：328</span></dd>
								<dd class="left">&#12288;&#12288;&#12288;&#12288;&#12288;<span class="right">全科中心审核通过数：246</span></dd>
								<dd class="left">注册审核：<span class="right">审核中：75，审核通过：574</span></dd>
								<dd class="left">&#12288;&#12288;&#12288;&#12288;&#12288;<span class="right">审核不通过：23</span></dd>
								</dl>
			                </td>
			                <td>
			                	<div id="doctorChart" style="height: 250px;width:100%;margin: 20px 0 0 0;"></div>
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
