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
	var title = {
			   "${resRecTypeEnumCaseRegistry.id}":{
				   registry:"大病历登记",
				   width:400,
				   height:250,
			   },
			   "${resRecTypeEnumDiseaseRegistry.id}":{
				   registry:"病种登记",
				   appeal:"申述病种",
				   width:700,
				   height:500,
			   },
			   "${resRecTypeEnumOperationRegistry.id}":{
				   registry:"手术登记",
				   appeal:"申述手术",
				   width:700,
				   height:500,
			   },
			   "${resRecTypeEnumSkillRegistry.id}":{
				   registry:"操作技能登记",
				   appeal:"申述操作技能",
				   width:700,
				   height:500,
			   },
			   "${resRecTypeEnumCampaignRegistry.id}":{
				   registry:"登记活动",
				   width:700,
				   height:400,
			   },
	};

	//轮转规范
   function sop(){
	   jboxOpen("<s:url value='/res/rec/sopView'/>?schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}", "轮转信息规范",700,500);
   }
   //登记信息列表
   function resRecList(type){
	   window.location.href="<s:url value='/res/rec/requireData'/>?resultFlow=${process.schResultFlow}&schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}&roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}&recTypeId="+type;
   }
   //修改轮转时间
   function modifySchDate(){
	   jboxOpen("<s:url value='/res/doc/showModifySchDate'/>?processFlow=${process.processFlow}", "修改轮转时间",400,200);
   }
   //排班表
   function schList(){
	   window.location.href="<s:url value='/res/doc/searchRotationList'/>";
   }
   
   function ckshb(){
	   window.location.href="<s:url value='/jsp/res/form/product/registry/evaluation_1.0.jsp'/>";
   }
   //评分
   function grade(recTypeId,recFlow){
	   window.location.href="<s:url value='/res/rec/grade'/>?resultFlow=${process.schResultFlow}&schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}&recTypeId="+recTypeId+"&recFlow="+recFlow;
   }
   //登记
   function addRegistry(recTypeId){
	   jboxOpen("<s:url value='/res/rec/showRegistryForm'/>?schDeptFlow=${param.schDeptFlow}&rotationFlow=${param.rotationFlow}&recTypeId="+recTypeId,title[recTypeId].registry,title[recTypeId].width,title[recTypeId].height);
   }
   //申述
   function editAppeal(recTypeId){
	   jboxOpen("<s:url value='/res/rec/editAppeal'/>?schDeptFlow=${param.schDeptFlow}&recTypeId="+recTypeId,title[recTypeId].appeal,700,400);
   }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div id="contain" style="min-width:1000px;">
        
        <div id="con1">
            <a href="javascript:schList();" id="aCycleSectionLink" class="ablue" style="float: right; font-size: 12px; font-weight: bold; margin:10px 20px 0 0;">
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
                            <a href="javascript:sop();" id="aShowCycleSectionStandard" title="点击查看该科室的轮转信息规范" class="ablue" style="font-size: 14px; font-weight: bold; cursor:pointer;
                                margin: 0;">
                                <span id="lbSecName">${process.schDeptName } </span></a>
                                <img src="<s:url value='/css/skin/${skinPath}/images/check.png'/>">
                        </td>
                        <td class="right">
                            医&nbsp;&nbsp;院：
                        </td>
                        <td>
                            <span id="LbHosName">${process.orgName }</span>
                        </td>
                        <td class="right">
                            <span id="LbCycleTimeText">轮转时间：</span> 
                        </td>
                        <c:set var="startDate"  value="${process.schStartDate }"/>
						<c:set var="endDate"  value="${process.schEndDate }"/>
						<c:if test="${!empty process.startDate }">
							<c:set var="startDate"  value="${process.startDate }"/>
						</c:if>
						<c:if test="${!empty process.endDate }">
							<c:set var="endDate"  value="${process.endDate }"/>
						</c:if>
                        <td>
                            <span id="startDate">${startDate }</span> - <span id="endDate">${endDate }</span>
                            <a id="aEditCycleTime" style=" cursor:pointer" class="ablue" onclick="modifySchDate();">修改</a>
                        </td>
                        <td class="right"></td>
                        <td><a id="aCycleState" class="ablue" style="margin: 0; cursor:pointer;display:none;">无</a></td>
                    </tr>
                    <tr>
                        <td class="right">
                            带教老师：
                        </td>
                        <td>
                            <span id="lbClinicalTeacher">${process.teacherUserName }</span>
                        </td>
                        <td class="right">
                            科主任：
                        </td>
                        <td>
                            
                            <span id="lbSectionManage">${process.headUserName }（${process.deptName }） </span>
                            
                        </td>
                        <td class="right">
                            <span id="lblSecTitle">对科室评分：</span>
                        </td>
                        <td>
                            <span id="LbSecScore">
                            	<a href="javascript:grade('${resRecTypeEnumDeptGrade.id}','${deptGrade.recFlow}');" class="ablue" style="margin: 0; cursor:pointer">${empty deptGrade?'未评':(deptGradeMap['totalScore']+0)}分</a>
                            </span>
                        </td>
                        <td class="right">
                            <span id="lblTeacherTitle">对带教老师评分：</span>
                        </td>
                        <td>
                            <span id="LbSecScore">
                            	<a href="javascript:grade('${resRecTypeEnumTeacherGrade.id}','${teacherGrade.recFlow}');" class="ablue" style="margin: 0; cursor:pointer">${empty teacherGrade?'未评':(teacherGradeMap['totalScore']+0)}分</a>
                            </span>
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div id="title">
                数据登记情况<a id="aShowPersonalInfo" onclick="javascript:__doPostBack('');" class="ablue" style="cursor: pointer;">查看详情</a></div>
            <div id="contable">
                <table class="table2" style="line-height: 35px; margin-top: 5px;">
                    <tbody><tr>
                        <td class="right" width="70px">
                            	<a href="javascript:resRecList('${resRecTypeEnumCaseRegistry.id}');">${resRecTypeEnumCaseRegistry.typeName}</a>：
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnDaBingLi" href="javascript:__doPostBack('dbl');" style=" cursor:pointer;"><div id="progressbarDaBingLi" style=" width:303px; height:22px;z-index: 999;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                        <div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddDaBingLi" class="ablue" href="javascript:addRegistry('${resRecTypeEnumCaseRegistry.id}');" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                            
                        </td>
                        <td class="right">
                            <a href="javascript:resRecList('${resRecTypeEnumDiseaseRegistry.id}');">${resRecTypeEnumDiseaseRegistry.typeName}</a>：
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnBingZhong" href="javascript:__doPostBack('bz');" style=" cursor:pointer;"><div id="progressbarBingZhong" style=" width:303px; height:22px;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddBingZhong" onclick="addRegistry('${resRecTypeEnumDiseaseRegistry.id}');" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                        <a id="LBtnExplanBingZhong" onclick="editAppeal('${resRecTypeEnumDiseaseRegistry.id}');" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">申述</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                        </td>
                    </tr>
                    <tr>
                        <td class="right" width="70px">
                            <a href="javascript:resRecList('${resRecTypeEnumSkillRegistry.id}');">${resRecTypeEnumSkillRegistry.typeName}</a>：
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnCaoZuoJiNeng" href="javascript:__doPostBack('czjn');" style=" cursor:pointer;"><div id="progressbarCaoZuoJiNeng" style=" width:303px; height:22px;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                        
                                    </td>
                                    <td>
                                        <a id="LBtnAddCaoZuoJiNeng" onclick="addRegistry('${resRecTypeEnumSkillRegistry.id}');" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                        <a id="LBtnExplanCaoZuoJiNeng" onclick="editAppeal('${resRecTypeEnumSkillRegistry.id}');" class="ablue" style="vertical-align: middle; float:left; cursor:pointer">申述</a>
                                    </td>
                                 </tr>
                            </tbody></table>
                        </td>
                        <td class="right">
                            <a href="javascript:resRecList('${resRecTypeEnumOperationRegistry.id}');">${resRecTypeEnumOperationRegistry.typeName}</a>：
                        </td>
                        <td>
                            <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                        <a id="LBtnShouShu" href="javascript:__doPostBack('ss');" style=" cursor:pointer;"><div id="progressbarShouShu" style=" width:303px; height:22px;" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="ui-progressbar-value ui-widget-header ui-corner-left" style="display: none; width: 0%;"></div><div style="position: static; padding-left:135px; color:#0f4a74; font-size:11px;margin-top: 0px; font-weight:bold; height:22px; line-height:22px;">0%</div></div></a>
                                    </td>
                                    <td>
                                        <a id="LBtnAddShouShu" class="ablue" onclick="addRegistry('${resRecTypeEnumOperationRegistry.id}');" style="vertical-align: middle; float:left; cursor:pointer">登记</a>
                                        <a id="LBtnExplanShouShu" class="ablue" onclick="editAppeal('${resRecTypeEnumOperationRegistry.id}');" style="vertical-align: middle; float:left; cursor:pointer">申述</a>
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
                            已登记（<a id="campaignCount" href="javascript:resRecList('${resRecTypeEnumCampaignRegistry.id}');" class="ablue" style="margin: 0; cursor:pointer">${campaignList.size()+0}</a>）条数据<a id="aAddActivity" href="javascript:addRegistry('${resRecTypeEnumCampaignRegistry.id}');" style=" cursor:pointer" class="ablue">登记</a>
                        </td>
                        <td class="right">
                            轮转出科：
                        </td>
                        <td>
                        <table cellpadding="0" cellspacing="0">
                                 <tbody><tr>
                                    <td width="303px">
                                         <a href="javascript:resRecList('${resRecTypeEnumAfterSummary.id}');">填写出科小结</a>
                                    </td>
                                    <td>
                                        <a id="LBtnAddShouShu" class="ablue" onclick="ckshb();" style="vertical-align: middle; float:left; cursor:pointer">出科考核表</a>
                                    </td>
                                 </tr>
                            </tbody></table>
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
                    <area shape="rect" coords="137,0,243,50" id="AreaMap1"  title="对科室评分">
                    <area shape="rect" coords="244,0,349,50" id="AreaMap2" style="cursor: pointer;" onclick="teacherScore();" title="对带教老师评分">
                    <area id="AreaMap3" shape="rect" coords="350,0,520,50" title="参加出科考核">
                    <area shape="rect" coords="520,0,691,50" id="AreaMap4" onclick="__doPostBack('ckxj');" style="cursor: pointer;" title="填写出科小结">
                </map>
            </div>
            
        </div>
    </div>
	</div>
</div>
</div>
</body>
</html>