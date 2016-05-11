<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${applicationScope.sysCfgMap['sys_title_name']}</title>
<jsp:include page="/jsp/medroad/htmlhead-medroad.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts.min.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/base.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script>
$(document).ready(function(){
	$(".menu_item a").click(function(){
		$(".select").removeClass("select");
		$(this).addClass("select");
	});
	setBodyHeight();
});


window.onload=function(){
	document.getElementsByTagName("body")[0].onkeydown =function(){
		
		//获取事件对象
		var elem = event.relatedTarget || event.srcElement || event.target ||event.currentTarget; 
		
		if(event.keyCode==8){//判断按键为backSpace键
		
				//获取按键按下时光标做指向的element
				var elem = event.srcElement || event.currentTarget; 
				
				//判断是否需要阻止按下键盘的事件默认传递
				var name = elem.nodeName;
				
				if(name!='INPUT' && name!='TEXTAREA'){
					return _stopIt(event);
				}
				var type_e = elem.type.toUpperCase();
				if(name=='INPUT' && (type_e!='TEXT' && type_e!='TEXTAREA' && type_e!='PASSWORD' && type_e!='FILE')){
						return _stopIt(event);
				}
				if(name=='INPUT' && (elem.readOnly==true || elem.disabled ==true)){
						return _stopIt(event);
				}
			}
		}
}
function _stopIt(e){
		if(e.returnValue){
			e.returnValue = false ;
		}
		if(e.preventDefault ){
			e.preventDefault();
		}				

		return false;
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
	jboxPostLoad("content","<s:url value='/medroad/orgList'/>",searchData,true);
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
	jboxLoad("content","<s:url value='/medroad/noticelist'/>",true);
}
function overview(){
	jboxLoad("content","<s:url value='/jsp/medroad/pi/overview.jsp'/>",true);
}
function changeProj(){
	jboxConfirm("确认切换项目?",function(){
		jboxStartLoading();
		window.location.href = "<s:url value='/medroad/projlist'/>";
	});
}
function addPatient(){
	jboxLoad("content","<s:url value='/medroad/addPatient'/>",true);
}
function patients(orgFlow,currentPage){
	jboxLoad("content","<s:url value='/medroad/patientList'/>?projFlow=${proj.projFlow}&orgFlow="+orgFlow+"&currentPage="+currentPage,true);
}

function drugs(){
	jboxLoad("content","<s:url value='/medroad/drug'/>",true);
}
$(document).ready(function(){
	//加载随访提醒
	followRemind();
	//
	initInPatientChart();
});
function followRemind(){
	jboxLoad("followRemind","<s:url value='/medroad/followRemind'/>",true);
}
function projInfo(){
	jboxLoad("content","<s:url value='/medroad/proj/info'/>",true);
}
function projPath(){
	jboxLoad("content","<s:url value='/medroad/proj/path'/>",true);
}
function visit(patientFlow){
	jboxLoad("content","<s:url value='/medroad/visit'/>?patientFlow="+patientFlow,true);
}
function followup(){
	jboxLoad("content","<s:url value='/medroad/followup'/>",true);
}

function initInPatientChart(){
	var myChart = echarts.init(document.getElementById('inpatient')); 
    var lineLabel = [];
 	var lineValue = [];
 	<c:forEach items="${assignMap['inDateList'] }" var="indate">
	  	<c:set var="inDateKey" value="${sessionScope.currUser.orgFlow}_${indate }"></c:set>
	  	lineLabel.push("${indate }");
	  	lineValue.push("${assignMap['assignOrgNum'][inDateKey]+0 }");
	</c:forEach>
	if (lineLabel.length==0) {
		lineLabel.push("");
	  	lineValue.push("");
	}
 	option = {
 		    tooltip : {
 		        trigger: 'axis'
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
 		           boundaryGap: [0, '100%'],
 		            axisLabel : {
 		                formatter: '{value}'
 		            }
 		        }
 		    ],
 		    /*
 		   dataZoom: [{
 		        type: 'inside',
 		        start: 0,
 		        end: 10
 		    }, {
 		        start: 0,
 		        end: 10
 		    }],
 		    */
 		    series : [
 		        {
 		            name:'入组例数',
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
function projFile(){
	jboxLoad("content","<s:url value='/medroad/proj/file'/>",true);
}
function drugList(){
	jboxLoad("content","<s:url value='/medroad/drug/list'/>",true);
}
function record(currentPage){
	jboxLoad("content","<s:url value='/medroad/drug/record'/>?currentPage="+currentPage,true);
}
function store(){
	jboxLoad("content","<s:url value='/medroad/drug/store'/>",true);
}
function overview(){
	jboxLoad("content","<s:url value='/medroad/statis/overview'/>",true);
}
</script>
<style>
body{overflow:hidden;}
.faq {
    width: 178px;
    margin-top: -42px;
    position: relative;
    top: -18px;
    padding-left: 20px;
    display: none;
}
</style>
</head>

<body >
<div style="overflow:auto;position: relative;" id="indexBody">
<div class="bd_bg">
<div class="yw">
<jsp:include page="/jsp/medroad/head.jsp" flush="true">
    <jsp:param value="/medroad/main?projFlow=${proj.projFlow}&roleFlow=${role.roleFlow}" name="indexUrl"/>
</jsp:include>


 <div class="body">
   <div class="container">
    	<div class="content_side">
     
     	 <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>项目管理
          </dt>
          <dd class="menu_item"><a href="javascript:projInfo();">项目概况</a></dd>
          <!-- 
          <dd class="menu_item"><a href="javascript:projPath();">诊疗方案</a></dd>
           <dd class="menu_item"><a href="javascript:void();">项目进展</a></dd>
           -->
          <dd class="menu_item"><a href="javascript:projFile();">项目文档</a></dd>
        </dl>
        <dl class="menu menu_first">
          <dt class="menu_title">
            <i class="icon_menu menu_management"></i>受试者管理
          </dt>
          <dd class="menu_item"><a href="javascript:patients('${sessionScope.currUser.orgFlow }','');">受试者列表</a></dd>
          <dd class="menu_item"><a href="javascript:followup();">随访提醒</a></dd>
         
        </dl>
         <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>药品管理
          </dt>
          <dd class="menu_item"><a href="javascript:drugList();">药物信息</a></dd>
          <dd class="menu_item"><a href="javascript:record('');">使用记录</a></dd>
          <!-- 
          <dd class="menu_item"><a href="javascript:void();">储运记录</a></dd>
           -->
           <dd class="menu_item"><a href="javascript:store();">库存记录</a></dd>
        </dl>
         <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_statistics"></i>统计查询
          </dt>
          <!-- 
          <dd class="menu_item"><a href="javascript:search();">数据查询</a></dd>
           -->
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
         <div class="index_form" id="" style="margin-top: 20px;">
         	 <h3>入组概况</h3>
         	 <table border="0" cellpadding="0" cellspacing="0" class="grid" style="border-top: 0px;">
         	 <tr><td><div class="inpatient" id="inpatient" style="width: 100%;height: 300px;"></div></td></tr>
         	 </table>
           
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
     <div class="faq">
           <ul class="links">
                 <li class="links_item"><a href="http://kf.qq.com/faq/120911VrYVrA1509086vyumm.html" target="_blank">返回顶部</a></li>
           </ul>
           <p class="tail">www.famousmed.cn</p>
       </div>
   </div>
 </div>
</div>

</div>
<jsp:include page="/jsp/medroad/foot.jsp" />

 
</body>

</html>
