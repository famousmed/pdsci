<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/doctor/Style.css'/>"></link>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
	<style type="text/css">
        body
        {
            text-align: left;
        }
        a
        {
            color: #2485b2;
        }
        a:link
        {
            color: #2485b2;
        }
        a:visited 
        {
        	color: #2485b2;
        }
        .ablue
        {
            color: #2485b2;
            font-size: 12px;
            font-weight: normal;
            margin-left: 10px;
        }
        .ui-widget-header {
	        border: 1px solid #D8D7D8;
	        background: #62B32B url(images/ui-bg_highlight-soft_75_cccccc_1x100.png) 50% 50% repeat-x;
	        color: #ffffff;
	        font-weight: bold;
        }
        .ui-widget-content {
	        border: 1px solid #D8D7D8;
	        background: #ffffff url(images/ui-bg_flat_75_ffffff_40x100.png) 50% 50% repeat-x;
	        color: #222222;
        }
  
</style>
<script type="text/javascript">
   function changeLocked(lockNode,lockType){
	   var orgFlow = lockNode.id;
	   var requestData = "orgFlow="+orgFlow+"&lockType="+lockType;
	   var url = "<s:url value='/edc/proj/saveProjOrgLock'/>";
	   jboxPost(url,requestData,function(resp){
		   if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
			   var imgSrc = lockNode.src;
			   var regLock = /\/lock\.png/;
			   var regUnlock = /\/unlock\.png/;
			   if(regLock.test(imgSrc)){
				   $(lockNode).attr("src",imgSrc.replace(regLock,"/unlock.png"));
			   }else{
				   $(lockNode).attr("src",imgSrc.replace(regUnlock,"/lock.png"));
			   }
			}
	   },null,true);
   }
   
   function normalValueLockConfig(orgFlow){
	   window.location.href="<s:url value='/edc/normalvalue/list/${GlobalConstant.PROJ_STATUS_SCOPE_GLOBAL}'/>?orgFlow="+orgFlow;
   }
   
   function detail(){
	   jboxOpen("<s:url value='/edc/proj/inDetailMain'/>", "入组详情",600,450);
   }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div id="contain" style="min-width:1000px;">
        
        <div id="con1">
            <a href="#" id="aCycleSectionLink" class="ablue" style="float: right; font-size: 12px; font-weight: bold; margin:10px 20px 0 0;">
                <img src="<s:url value='/css/skin/${skinPath}/images/51f6756392d14.png'/>" style="vertical-align: middle; width: 20px; height: 20px;">
                <span style="vertical-align: middle;">查看我的轮转计划</span></a>
            <div id="title">
                <span id="SpanLunZhuangKeShi"><B>当前轮转科室</B></span></div>
            <div id="contable">
                <table border="0" class="table2" style="width: 100%;">
                    <tbody><tr>
                        <td class="right" width="70px">
                            科室名称：
                        </td>
                        <td>
                            <a id="aShowCycleSectionStandard" title="点击查看该科室的轮转信息规范" class="ablue" style="font-size: 14px; font-weight: bold; cursor:pointer;
                                margin: 0;">
                                <span id="lbSecName">无</span></a>
                        </td>
                        <td class="right">
                            医&nbsp;&nbsp;院：
                        </td>
                        <td>
                            <span id="LbHosName">无</span>
                        </td>
                        <td class="right">
                            <span id="LbCycleTimeText">计划轮转时间：</span> 
                        </td>
                        <td>
                            <span id="lbCycleTime">无</span>
                        </td>
                        <td class="right"></td>
                        <td><a id="aCycleState" class="ablue" style="margin: 0; cursor:pointer;display:none;">无</a></td>
                    </tr>
                    <tr>
                        <td class="right">
                            带教老师：
                        </td>
                        <td>
                            <span id="lbClinicalTeacher"></span>
                        </td>
                        <td class="right">
                            科主任：
                        </td>
                        <td>
                            
                            <span id="lbSectionManage">无</span>
                            
                        </td>
                        <td class="right">
                            <span id="lblSecTitle">对科室评分：</span>
                        </td>
                        <td>
                            <span id="LbSecScore"></span>
                        </td>
                        <td class="right">
                            <span id="lblTeacherTitle">对带教老师评分：</span>
                        </td>
                        <td>
                            <span id="LbTeacherScore"></span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div id="title">
                数据登记情况<a id="aShowPersonalInfo" target="FrmMain" class="ablue">查看详情</a></div>
            <div id="contable">
                <table class="table2" style="line-height: 35px; margin-top: 5px;">
                    <tbody><tr>
                        <td class="right" width="70px">
                            大 病 历：
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnDaBingLi" href="javascript:__doPostBack('LBtnDaBingLi','')" style=" cursor:pointer;"><div id="progressbarDaBingLi" style=" width:303px; height:22px;z-index: 999;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                        <div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddDaBingLi" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                            
                        </td>
                        <td class="right">
                            <a id="LBtnNoPassBingZhong" href="javascript:__doPostBack('LBtnNoPassBingZhong','')">病种：</a>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnBingZhong" href="javascript:__doPostBack('LBtnBingZhong','')" style=" cursor:pointer;"><div id="progressbarBingZhong" style=" width:303px; height:22px;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddBingZhong" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                        <a id="LBtnExplanBingZhong" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">申述</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <tr>
                        <td class="right" width="70px">
                            <a id="LBtnNoPassCaoZuoJiNeng" href="javascript:__doPostBack('LBtnNoPassCaoZuoJiNeng','')">操作技能：</a>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnCaoZuoJiNeng" href="javascript:__doPostBack('LBtnCaoZuoJiNeng','')" style=" cursor:pointer;"><div id="progressbarCaoZuoJiNeng" style=" width:303px; height:22px;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddCaoZuoJiNeng" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                        <a id="LBtnExplanCaoZuoJiNeng" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">申述</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                        </td>
                        <td class="right">
                            <a id="LbtnNoPassShouShu" href="javascript:__doPostBack('LbtnNoPassShouShu','')">手术：</a>
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnShouShu" href="javascript:__doPostBack('LBtnShouShu','')" style=" cursor:pointer;"><div id="progressbarShouShu" style=" width:303px; height:22px;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddShouShu" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                        <a id="LBtnExplanShouShu" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">申述</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <tr>
                        <td class="right" width="70px">
                            参加活动：
                        </td>
                        <td>
                            已登记（<a id="aDiscussCount" class="ablue" style="margin: 0; cursor:pointer"></a>）条数据<a id="aAddActivity" style=" cursor:pointer" class="ablue">登记</a>
                        </td>
                        <td class="right">
                            轮转出科：
                        </td>
                        <td>
                        <a id="lbOutSection" href="javascript:__doPostBack('lbOutSection','')">填写出科小结</a>
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div id="title">
                轮转流程</div>
            <div id="contable" style="margin-bottom: 20px;">
               <img src="<s:url value='/css/skin/${skinPath}/images/flowpath0.gif'/>" id="ImgFlowPath" border="0" usemap="#Map" style="margin-top: 10px;
                    margin-left: 10px;">
                <map name="Map" id="Map">
                    <area shape="rect" coords="0,0,137,50" title="登记数据">
                    <area shape="rect" coords="137,0,243,50" id="AreaMap1" title="对科室评分">
                    <area shape="rect" coords="244,0,349,50" id="AreaMap2" title="对带教老师评分">
                    <area id="AreaMap3" shape="rect" coords="350,0,520,50" title="参加出科考核">
                    <area shape="rect" coords="520,0,691,50" id="AreaMap4" title="填写出科小结">
                </map>
            </div>
            
        </div>
        <div id="PanelHaveCycled">
	
        <div id="title" style="margin: 15px 0;">
            <B>已轮转科室</B>&#12288;<a id="LBtnPrint" class="ablue" style="color: blue" target="_blank">生成考核手册</a></div>
        <div id="con2" style=" width:100%">
            <div style=" width:100%">
                    <div id="RepHaveCycled_ctl01_divSecInfo" style="width:33%; float:left; padding-top:5px;">
                         <div id="con2s">
                            <div id="con2ss">
                                <table class="table2">
                                    <tbody><tr>
                                        <td class="right" width="70px">
                                            科室名称：
                                        </td>
                                        <td colspan="3" style="text-align: left;padding-left: 10px;">
                                            呼吸内科
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            轮转时间：
                                        </td>
                                        <td colspan="3" style="text-align: left;padding-left: 10px;">
                                            2012.06.01 - 2012.07.31
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            带教老师：
                                        </td>
                                        <td >
                                            叶亮
                                        </td>
                                        <td class="right" >
                                            科主任：
                                        </td>
                                        <td >
                                            谷伟
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            状 态：
                                        </td>
                                        <td class="green">
                                           <span id="RepHaveCycled_ctl01_LbStates">已出科</span>
                                        </td>
                                        <td class="right">
                                            <span id="RepHaveCycled_ctl01_LBCKKHCJ">出科考核成绩：</span>
                                        </td>
                                        <td>
                                            <span id="RepHaveCycled_ctl01_CKKHCJ">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" style="padding-top: 10px;">
                                            <a href="DipHome.aspx?UCSID=29223" target="FrmMain">
                                                <img src="<s:url value='/css/skin/${skinPath}/images/bdsj.gif'/>"></a><a href="PersonalInfo/PrintHosSecName.aspx?SpecialtyID=76&amp;UserID=18969&amp;PrintType=0&amp;CycleID=114&amp;HosSecID=4506" target="_blank" style="margin-left: 20px;"> <img src="<s:url value='/css/skin/${skinPath}/images/khsc.gif'/>"></a>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </div>
                        </div>
                    </div>
                
                    <div id="RepHaveCycled_ctl02_divSecInfo" style="width:33%; float:left;padding-left:0.5%;padding-top:5px;">
                         <div id="con2s">
                            <div id="con2ss">
                                <table class="table2">
                                    <tbody><tr>
                                        <td class="right" width="70px">
                                            科室名称：
                                        </td>
                                        <td colspan="3">
                                            医学影像科
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            轮转时间：
                                        </td>
                                        <td colspan="3">
                                            2012.08.01 - 2012.08.15
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            带教老师：
                                        </td>
                                        <td >
                                            陈国平
                                        </td>
                                        <td class="right" style="width: 100px;"> 
                                            科主任：
                                        </td>
                                        <td width="50px">
                                            顾建平
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            状 态：
                                        </td>
                                        <td class="green">
                                           <span id="RepHaveCycled_ctl02_LbStates">已出科</span>
                                        </td>
                                        <td class="right">
                                            <span id="RepHaveCycled_ctl02_LBCKKHCJ">出科考核成绩：</span>
                                        </td>
                                        <td>
                                            <span id="RepHaveCycled_ctl02_CKKHCJ">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" style="padding-top: 10px;">
                                           <a href="DipHome.aspx?UCSID=29223" target="FrmMain">
                                                <img src="<s:url value='/css/skin/${skinPath}/images/bdsj.gif'/>"></a><a href="PersonalInfo/PrintHosSecName.aspx?SpecialtyID=76&amp;UserID=18969&amp;PrintType=0&amp;CycleID=114&amp;HosSecID=4506" target="_blank" style="margin-left: 20px;"> <img src="<s:url value='/css/skin/${skinPath}/images/khsc.gif'/>"></a>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </div>
                        </div>
                    </div>
                
                    <div id="RepHaveCycled_ctl03_divSecInfo" style="width:33%; float:left;padding-left:0.5%;padding-top:5px;">
                         <div id="con2s">
                            <div id="con2ss">
                                <table class="table2">
                                    <tbody><tr>
                                        <td class="right" width="70px">
                                            科室名称：
                                        </td>
                                        <td colspan="3">
                                            普外科
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            轮转时间：
                                        </td>
                                        <td colspan="3">
                                            2012.08.16 - 2012.09.30
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right" >
                                            带教老师：
                                        </td>
                                        <td style="width: 100px;">
                                            张斌
                                        </td>
                                        <td class="right" style="width: 100px;">
                                            科主任：
                                        </td>
                                        <td width="50px">
                                            曹红勇
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="right">
                                            状 态：
                                        </td>
                                        <td class="green">
                                           <span id="RepHaveCycled_ctl03_LbStates">已出科</span>
                                        </td>
                                        <td class="right">
                                            <span id="RepHaveCycled_ctl03_LBCKKHCJ">出科考核成绩：</span>
                                        </td>
                                        <td>
                                            <span id="RepHaveCycled_ctl03_CKKHCJ">0</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center" style="padding-top: 10px;">
                                           <a href="DipHome.aspx?UCSID=29223" target="FrmMain">
                                                <img src="<s:url value='/css/skin/${skinPath}/images/bdsj.gif'/>"></a><a href="PersonalInfo/PrintHosSecName.aspx?SpecialtyID=76&amp;UserID=18969&amp;PrintType=0&amp;CycleID=114&amp;HosSecID=4506" target="_blank" style="margin-left: 20px;"> <img src="<s:url value='/css/skin/${skinPath}/images/khsc.gif'/>"></a>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <a id="LBtnShowMore" class="ablue" href="javascript:__doPostBack('LBtnShowMore','')" style="float:right;">查看更多&gt;&gt;</a>
</div>
    </div>
	</div>
</div>
</div>
</body>
</html>