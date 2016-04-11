<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/deptview.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
</head>

<body marginheight="0" marginwidth="0">
<div class="mainright">
	<div class="content">
    	<div class="triptitle">
        	<div class="left"><b>科室名称：</b>内科<b>&nbsp;&nbsp;实习时间：</b>2015-03-01至2015-04-15</div><div class=""><b>&#12288;&#12288;出科分数：</b>98</b></div>
        </div>
        <div id="tabTitle">
        	<a href="javascript:;" class="cur" id="a1">5<p>教学记录</p></a>
            <a href="javascript:;" class="" id="a2">12<p>病床记录</p></a>
            <a href="javascript:;" class="" id="a3">12<p>病历记录</p></a>
            <a href="javascript:;" class="" id="a4">12<p>危重记录</p></a>
            <a href="javascript:;" class="" id="a5">12<p>临床操作记录</p></a>
            <a href="javascript:;" class="" id="a6">12<p>学术活动</p></a>
            <a href="javascript:;" class="" id="a7">12<p>奖惩记录</p></a>
        </div>
        <dl class="tripinfo">
        	<dt><p><b>教学时间：</b>1次/周</p><p><b>负责科室：</b>内科</p><p><b>完成时间：</b>15周</p><a href="javascript:;" id="swidth">[隐藏]</a></dt>
            <dd id="tripContent">
            	
            	<b>教学目标：</b>
                <p>掌握内科常见病的诊疗思维方法、治疗常规、常用药物的使用、能理论联系实际、具备一定的临床工作能力，掌握内科体验、各种常用操作技术、并能在上级医师指导
下独立操作。</p>
				<b>考核内容：</b>
                <p>1、科室综合表现：实习态度和工作主动性：熟悉病人情况；<br/>
2：出克技能考核：内科常见病的诊疗思维、治疗和用药，内科基本操作掌握情况</p>
                
            </dd>
        </dl>
        <div id="tabContent">
        	<div style="display:block;">
            	<table width="100%" cellspacing="0" cellpadding="0" class="xllist jch">
                    <tr>
                      <th>时间</td>
                      <th>教师</th>
                      <th>形式</th>
                      <th>教学主要内容</th>
                    </tr>
                  <tbody>
                    <tr>
                      <td>2014-02-12</td>
                      <td>张才哲</td>
                      <td>讲座</td>
                      <td>慢性肺源性心脏病</td>
                    </tr>
                    <tr>
                      <td>2014-05-17</td>
                      <td>刘承志</td>
                      <td>讲课</td>
                      <td>肠易激综合征</td>
                    </tr>
                    <tr>
                      <td>2014-06-23</td>
                      <td>李飞光</td>
                      <td>示教</td>
                      <td>消化性溃疡</td>
                    </tr>
                    <tr>
                      <td>2014-07-28</td>
                      <td>吴俊英</td>
                      <td>讲座</td>
                      <td>病毒性心肌炎</td>
                    </tr>
                    <tr>
                      <td>2015-02-12</td>
                      <td>李弘伟</td>
                      <td>讲课</td>
                      <td>急性胰腺炎</td>
                    </tr>
                  </tbody>
               </table>	
            </div>
        	<div>
            	<table width="100%" cellspacing="0" cellpadding="0" class="xllist jch">
                    <tr>
                      <th>科室</td>
                      <th>时间</th>
                      <th>病名</th>
                      <th>病历号</th>
                      <th>指导教师签名</th>
                    </tr>
                  <tbody>
                    <tr>
                      <td>呼吸科</td>
                      <td>2014-02-12</td>
                      <td>心肌梗塞</td>
                      <td>012563</td>
                      <td>张开宇</td>
                    </tr>
                    <tr>
                      <td>消化科</td>
                      <td>2014-06-27</td>
                      <td>荨麻疹</td>
                      <td>024525</td>
                      <td>刘诚志</td>                                                      
                    </tr>
                    <tr>
                      <td>心血管</td>
                      <td>2014-08-02</td>
                      <td>胃溃疡</td>
                      <td>011568</td>
                      <td>赵明智</td>                                                      
                    </tr>
                    <tr>
                      <td>内分泌</td>
                      <td>2015-01-27</td>
                      <td>青光眼</td>
                      <td>125451</td>
                      <td>孙明杰</td>                                                      
                    </tr>
                    <tr>
                      <td>肾科</td>
                      <td>2015-02-28</td>
                      <td>白血病</td>
                      <td>036554</td>
                      <td>李良俊</td>                                                      
                    </tr>
                  </tbody>
               </table>
            </div>
            <div>
            	<table width="100%" cellspacing="0" cellpadding="0" class="xllist jch" >
                    <tr>
                      <th>科室</td>
                      <th>时间</th>
                      <th>病名</th>
                      <th>病历号</th>
                      <th>教师签名</th>
                    </tr>
                  <tbody>
                    <tr>
                      <td>神经</td>
                      <td>2014-05-12</td>
                      <td>小儿湿疹</td>
                      <td>012245</td>
                      <td>马天瑞</td>
                    </tr>
                    <tr>
                      <td>肿瘤</td>
                      <td>2014-04-19</td>
                      <td>帕金森</td>
                      <td>113245</td>
                      <td>张文栋</td>
                    </tr>
                    <tr>
                      <td>呼吸科</td>
                      <td>2014-09-12</td>
                      <td>慢性支气管炎</td>
                      <td>022231</td>
                      <td>李永昌</td>
                    </tr>
                    <tr>
                      <td>血液科</td>
                      <td>2014-11-12</td>
                      <td> 风湿性关节炎</td>
                      <td>012245</td>
                      <td>王志业</td>
                    </tr>
                    <tr>
                      <td>呼吸科</td>
                      <td>2014-05-12</td>
                      <td>小儿湿疹</td>
                      <td>012245</td>
                      <td>李志强</td>
                    </tr>
                    
                  </tbody>
               </table>
            </div>
            <div>
            	 <table width="100%" cellspacing="0" cellpadding="0" class="xllist jch" >
                    <tr>
                      <th>科室</td>
                      <th>时间</th>
                      <th>病名</th>
                      <th>病历号</th>
                      <th>教师签名</th>
                    </tr>
                  <tbody>
                    <tr>
                      <td>呼吸科</td>
                      <td>2014-01-12</td>
                      <td>急性肠胃炎</td>
                      <td>124523</td>
                      <td>张正业</td>
                    </tr>
                    <tr>
                      <td>呼吸科</td>
                      <td>2014-03-18</td>
                      <td>银屑病</td>
                      <td>018912</td>
                      <td>张栋梁</td>
                    </tr>
                    <tr>
                      <td>呼吸科</td>
                      <td>2014-06-18</td>
                      <td>肺结核</td>
                      <td>120451</td>
                      <td>王安全</td>
                    </tr>
                    <tr>
                      <td>精神医学</td>
                      <td>2014-11-12</td>
                      <td>三叉神经痛</td>
                      <td>201542</td>
                      <td>李秋全</td>
                    </tr>
                    
                  </tbody>
               </table>
            </div>
            <div>
            	  
                <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="xllist jch" >
                	<thead>
                    <tr>
                      <th rowspan="2">操作项目名称</td>
                      <th rowspan="2">科室</th>
                      <th rowspan="2">时间</th>
                      <th colspan="3">操作方式</th>
                      <th rowspan="2">指导教师签名</th>
                    </tr>
                    <tr>
                      <th>主要完成</th>
                      <th>助手</th>
                      <th>观摩</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>腹穿</td>
                      <td>内科</td>
                      <td>2014-7-15</td>
                      <td><img
						src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" /></td>
                      <td></td>
                      <td></td>
                      <td>李国华</td>
                    </tr>
                    
                    <tr>
                      <td>肺部X线检查</td>
                      <td>放射科</td>
                      <td>2014-08-21</td>
                      <td></td>
                      <td><img
						src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" /></td>
                      <td></td>
                      <td>王永昌</td>
                    </tr>
                   
                    <tr>
                      <td>腹部体格检</td>
                      <td>内科</td>
                      <td>2014-09-11</td>
                      <td></td>
                      <td><img
						src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" /></td>
                      <td></td>
                      <td>王景中</td>
                    </tr>
                  
                   <tr>
                      <td>三腔二囊管的置入</td>
                      <td>内科</td>
                      <td>2014-11-21</td>
                      <td></td>
                      <td><img
						src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" /></td>
                      <td></td>
                      <td>王景鸽</td>
                   </tr>
                   
                   <tr>
                      <td>腹腔穿刺术</td>
                      <td>内科</td>
                      <td>2014-11-30</td>
                     <td width="100px;"></td>
                      <td width="100px;"><img
						src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" /></td>
                      <td width="100px;"></td>
                      <td>樊伟成</td>
                   </tr>
                   
                   <!--<tr>
                      <td>胃镜</td>
                      <td>内六</td>
                      <td>2015-01-21</td>
                      <td>胃镜</td>
                      <td>崔晓峰</td>
                      <td>王山河</td>
                      <td>黄雪莹</td>
                   </tr>-->
                    
                  </tbody>
               </table>
            </div>
            <div>
            	
                <table width="100%"  border="0" cellspacing="0" cellpadding="0" class="xllist jch">
                  <thead>
                    <tr>
                      <th>日期</td>
                      <th>讲座题目</th>
                      <th>教师签名</th>
                    </tr>
                  </thead>
                  
                  <tbody>
                    <tr>
                      <td>2014-03-15</td>
                      <td>心脏暂停的复苏抢救</td>
                      <td>魏婷婷</td>
                    </tr>
                     <tr>
                      <td>2014-05-30</td>
                      <td>急性中毒的处理原则</td>
                      <td>罗俊洁</td>
                    </tr>
                     <tr>
                      <td>2014-06-01</td>
                      <td>急性肾功能衰竭治疗原则</td>
                      <td>曹俊</td>
                    </tr>
                     <tr>
                      <td>2014-09-20</td>
                      <td>胸外心脏按压</td>
                      <td>阮传学</td>
                    </tr>
                     <tr>
                      <td>2014-11-09</td>
                      <td>内科疾病常用药物及剂量</td>
                      <td>林建华</td>
                    </tr>
                  </tbody>
               </table>
            </div>
            <div>
            	
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="basic">
                  <tr>
                    <th colspan="2" style="text-align:center;color:#000;">特殊情况记录<br />(表扬、批评、<br/>差错、事故)</th>
                    <td colspan="7"><textarea>无</textarea></td>
                  </tr>
                  </table>
            </div>
            
        </div>
    </div>
</div>
<script>
var oTabTitle=document.getElementById('tabTitle');
var aObject=oTabTitle.getElementsByTagName('a');
var oTabContent=document.getElementById('tabContent');
var aDiv=oTabContent.getElementsByTagName('div');

for(var i=0;i<aObject.length;i++){
		aObject[i].index=i;
		aObject[i].onclick=function(){
			for(var i=0;i<aObject.length;i++){
				aObject[i].className="";
				aDiv[i].style.display="";
				}
			this.className='cur';
			aDiv[this.index].style.display="block";
			}
		}


var oSwidth=document.getElementById('swidth');
var otripContent=document.getElementById('tripContent');
var flag=true;
oSwidth.onclick=function(){
	if(flag){
		otripContent.style.display='block';
	    flag=false;	
	}else{
		otripContent.style.display='none';
	    flag=true;		
	}
	
}
</script>
</body>
</html>
