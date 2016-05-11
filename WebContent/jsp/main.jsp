<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/AmazeUI/js/amazeui.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script>
$(document).ready(function(){
	$('#fullscreen').click(function(e){
		$.AMUI.fullscreen.toggle();
	});
});
</script>
<script language="JavaScript">
<!-- //
function move(){
	$("#left").toggle();
	var img = $("#barimg");
	if(img.attr('src')=='<s:url value='/css/skin/${skinPath}/images/left_arrow.png'/>'){
		img.attr('src','<s:url value='/css/skin/${skinPath}/images/right_arrow.png'/>');
	}else{
		img.attr('src','<s:url value='/css/skin/${skinPath}/images/left_arrow.png'/>');
	}
}
function showMenuSet(menuSetId) {
	$(".menuSetClass").each(function(){ 
		if($(this).attr('id')== menuSetId){
			$(this).children('h1').addClass('active');
			$(this).children('span').removeClass('no');
		}else{
			$(this).children('h1').removeClass('active');
			$(this).children('span').addClass('no');
		}
	});
}
function setMenuSetName(menuSetName){
	$("#menuSetName").text(menuSetName);
	setMenuName("");
}
function setMenuName(menuName){
	if(""!=menuName){
		menuName = "--"+menuName;
	}
	$("#menuName").text(menuName);
}
function highlight(menuId){
	$(".aClass").each(function(){ 
		if($(this).attr('id')== menuId){
			$(this).addClass("current");
		}else{
			$(this).removeClass("current");
		}
	});
}
function loadMain(src){
	jboxCloseMessager();
	jboxStartLoading();
	if(src.indexOf('isMainFrame')==-1){
		if(src.indexOf('?')>-1){
			src = src+"&isMainFrame=Y&time="+new Date();
		}else{
			src = src+"?isMainFrame=Y&time="+new Date();
		}		
	}else{
		if(src.indexOf('?')>-1){
			src = src+"?time="+new Date();
		}else{
			src = src+"&time="+new Date();
		}	
	}
	window.frames["mainIframe"].location.href= src;
}
function loadModule(src){
	jboxStartLoading();
	src = src+"?time="+new Date();
	window.parent.location.href= src;
}
function refresh(){
	jboxStartLoading();
	window.frames['mainIframe'].location.reload(true); 
	jboxEndLoading();
}
function goback(){
	jboxStartLoading();
	window.frames['mainIframe'].history.back(-1); 
}
function modPasswd(userFlow,showClose) {
	jboxOpen("<s:url value='/sys/user/modPasswd?userFlow='/>"
			+ userFlow, "修改密码", 500, 300,showClose);
}
function selectProj(){
	jboxOpen("<s:url value='/edc/proj/userProjList'/>", "选择项目", 800, 600,false);
}
function selectStation(){
	jboxOpen("<s:url value='/main/select'/>", "切换工作站", 780, 600);
	//window.location.href="<s:url value='/main'/>"; 
}
<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID and not empty sessionScope.currModuleId and sessionScope.currModuleId!='edc-xtpz' and sessionScope.currModuleId!='edc-mkk' and empty sessionScope.edcCurrProj}"> 
$(document).ready(function(){
	selectProj();
});
</c:if> 
<c:if test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID and not empty sessionScope.currModuleId and sessionScope.currModuleId=='gcp-sszgl' and empty sessionScope.edcCurrProj}"> 
$(document).ready(function(){
	selectProj();
});
</c:if> 
<c:if test="${applicationScope.sysCfgMap['req_complex_passwd']== GlobalConstant.FLAG_Y}">
<c:if test="${sessionScope.currUser.userPasswd==pdfn:encryptPassword(sessionScope.currUser.userFlow,GlobalConstant.INIT_PASSWORD)}">
$(document).ready(function(){
modPasswd('${sessionScope.currUser.userFlow}',false);
});
</c:if>
</c:if>
<c:if test="${not empty sessionScope.mainFrameSrc }">
$(document).ready(function(){
	loadMain('${sessionScope.mainFrameSrc}');
});							
</c:if>
<%-- 当前工作所拥有的模块数量 --%>
<c:set var="moduleListSize" value="0" scope="page"></c:set>
<c:forEach items="${applicationScope.workStationList}" var="workStation">
	<c:forEach items="${workStation.moduleList}" var="module" varStatus="status">
		<c:if test="${sessionScope.currWsId==workStation.workStationId and pdfn:contain(module.moduleId, sessionScope.currUserModuleIdList)}">
			<c:set var="moduleListSize" value="${moduleListSize+1}" scope="page"></c:set>
		</c:if>
	</c:forEach>
</c:forEach>
<c:if test="${ sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
<c:set var="moduleListSize" value="1000" scope="page"></c:set>
</c:if>

function resizeWin() {
	var leftClientHeight  ;
	var secClientHeight  ;
	if(${applicationScope.sysCfgMap['sys_skin']=='LightBlue'}){
		<c:if test="${ moduleListSize>1}">
		leftClientHeight = 80;    
		secClientHeight = 80;
		</c:if>
		<c:if test="${ moduleListSize<2}">
		leftClientHeight = 45;
		secClientHeight = 45;
		</c:if>
		
	}else if(${applicationScope.sysCfgMap['sys_skin']=='Blue' || empty applicationScope.sysCfgMap['sys_skin']}){
		<c:if test="${ moduleListSize>1}">
		leftClientHeight = 120;
		secClientHeight = 120;
		</c:if>
		<c:if test="${ moduleListSize<2}">
		leftClientHeight = 73;
		secClientHeight = 73;
		</c:if>
	}
	
    $("#left").height(eval(document.body.clientHeight - leftClientHeight) + "px");
    $("#menu_sec").height(eval(document.body.clientHeight - secClientHeight) + "px");
    $("#zip").height(eval(document.body.clientHeight - leftClientHeight) + "px");
    $("#tdNotice").height(eval(document.body.clientHeight - leftClientHeight) + "px");
    if ($("#left :hidden").length > 0) {
        $("#tdNotice").width(eval(document.body.clientWidth) + "px");
    }
    else {
        $("#tdNotice").width(eval(document.body.clientWidth - 210) + "px");
    }

 }
 $(window).ready(function () {
     resizeWin();
 });
 $(window).resize(resizeWin);
//-->


</script>
</head>
<body id="body">
	<table width="100%" height="100%" cellspacing="0" cellpadding="0">
		<!--header-->
		<tr>
			<td colspan="3">
				<div class="header">
					<div class="top">
						<p class="tleft">
							<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID}">
								<c:if test="${applicationScope.sysCfgMap['sys_login_img']=='pharmasun'}">
									<img src="<s:url value='/css/skin/${skinPath}/images/sci_head.png'/>" />
								</c:if>
								<c:if test="${applicationScope.sysCfgMap['sys_login_img']=='medroad'}">
									<img src="<s:url value='/css/skin/${skinPath}/images/medroad_head.png'/>" />
								</c:if>
							</c:if>
							<c:if test="${sessionScope.currWsId==GlobalConstant.GCP_WS_ID}">
								
								<c:if test="${applicationScope.sysCfgMap['sys_login_img']=='pharmasun'}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gcp_head.png'/>" />
								</c:if>
								<c:if test="${applicationScope.sysCfgMap['sys_login_img']=='medroad'}">
									<img src="<s:url value='/css/skin/${skinPath}/images/medroad_head.png'/>" />
								</c:if>
							</c:if>
							<c:if test="${sessionScope.currWsId==GlobalConstant.IRB_WS_ID}">
								
								<c:if test="${applicationScope.sysCfgMap['sys_login_img']=='pharmasun'}">
									<img src="<s:url value='/css/skin/${skinPath}/images/irb_head.png'/>" />
								</c:if>
								<c:if test="${applicationScope.sysCfgMap['sys_login_img']=='medroad'}">
									<img src="<s:url value='/css/skin/${skinPath}/images/medroad_head.png'/>" />
								</c:if>
							</c:if>
						</p>
						<c:if test="${applicationScope.sysCfgMap['sys_skin']=='Blue' || empty applicationScope.sysCfgMap['sys_skin']}">
						 <div class="tright">
							<span>
								<p>
									欢迎您 ${sessionScope.currUser.userName},<a href="javascript:modPasswd('${sessionScope.currUser.userFlow}',true)">修改密码</a>
									<%-- 当前所在项目 --%>
									<c:if
										test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID or
										sessionScope.currWsId==GlobalConstant.GCP_WS_ID
										 and not empty sessionScope.edcCurrProj}">
										<a href="javascript:selectProj();" title="${sessionScope.edcCurrProj.projName}">当前项目：${pdfn:cutString(sessionScope.edcCurrProj.projName,10,true,3 )}</a>
									</c:if>
								</p>
								<p>									
									<c:if test="${fn:length(sessionScope.currUserWorkStationIdList)>1 or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
						        		<a class="change" href="javascript:selectStation();">切换工作站</a>
						        	</c:if>
									<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID}">
						        		<a class="shuaxin" href="javascript:selectProj();">切换项目</a>        	
						        	</c:if>
									<a class="shuaxin" href="javascript:refresh();">刷新</a> <a
										class="houtui" href="javascript:goback();">后退</a> <a
										class="zhuye" href="<s:url value="/"/>" target="_blank">主页</a>
									<%-- <a class="help" href="#">帮助</a>--%>
									<a class="zhuxiao" href="<s:url value='/logout.do'/>">注销</a>
								</p>
							</span>
						</div>
						</c:if>
						<c:if test="${applicationScope.sysCfgMap['sys_skin']=='LightBlue'}">
						 <div class="tright">
          					 <div class="menu1">  
 							 <ul>  
   								 <li><a href="#"><p>欢迎您 ${sessionScope.currUser.userName}</p></a>   
     								<!--[if IE 7]><!--></a><!--<![endif]-->  
     								<!--[if lte IE 6]><table><tr><td><![endif]-->  
     								 <ul>  
       									 <li><a class="home" href="<s:url value="/"/>"><img src="<s:url value='/css/skin/${skinPath}/images/home.png'/>" />主页</a></li>
       									 <c:if test="${fn:length(sessionScope.currUserWorkStationIdList)>1 or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
						        		<li><a href="javascript:selectStation();"><img src="<s:url value='/css/skin/${skinPath}/images/check.png'/>" />切换工作站</a></li>
						        	    </c:if>
									    <c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID}">
						        		<li><a href="javascript:selectProj();"><img src="<s:url value='/css/skin/${skinPath}/images/change-xm.png'/>" />切换项目</a></li>        	
						        	    </c:if>  
       									 <li><a href="javascript:refresh();"><img src="<s:url value='/css/skin/${skinPath}/images/sx.png'/>" />刷新</a></li> 
       									 <li><a href="javascript:goback();"><img src="<s:url value='/css/skin/${skinPath}/images/ht.png'/>" />后退</a></li>  
       									 <li><a href="javascript:modPasswd('${sessionScope.currUser.userFlow}',true);"><img src="<s:url value='/css/skin/${skinPath}/images/lock1.png'/>" />修改密码</a></li>  
       		 							 <li><a href="<s:url value='/logout.do'/>"><img src="<s:url value='/css/skin/${skinPath}/images/login out.png'/>" />注销</a></li>   
      								</ul>  
      								<!--[if lte IE 6]></td></tr></table></a><![endif]-->  
   								 </li>  
 		 					</ul>         
							</div>
        				</div>	
        				</c:if>
					</div>
				</div>
			</td>
		</tr>		
		<tr <c:if test="${moduleListSize<2}">style="display: none;"</c:if>>
			<td colspan="3">		
				<div class="menu">
					<ul class="clearfix">
						<c:forEach items="${applicationScope.workStationList}"
							var="workStation">
							<c:if test="${sessionScope.currWsId==workStation.workStationId}">
								<c:forEach items="${workStation.moduleList}" var="module" varStatus="status">
									<c:set var="canShowModule" value="false" scope="page"></c:set>
									<%-- 判断是否开关控制 --%>
									<c:if test="${sessionScope.currWsId=='srm' }">
										<c:set var="canShowModule" value="${pdfn:canShowByVersion(module.version)}" scope="page"></c:set>
									</c:if>										
									<c:if test="${sessionScope.currWsId=='edc' }">
										<c:choose>
											<c:when test="${module.moduleId == 'edc-sjh' and (!empty sessionScope.edcCurrProjParam and sessionScope.edcCurrProjParam.isRandom!='Y' )}">
												<c:set var="canShowModule" value="false" scope="page"></c:set>
											</c:when>
											<c:otherwise>
												<c:set var="canShowModule" value="true" scope="page"></c:set>												
											</c:otherwise>
										</c:choose>
									</c:if>	
									<c:if test="${sessionScope.currWsId!='srm' and sessionScope.currWsId!='edc' }">
										<c:set var="canShowModule" value="true" scope="page"></c:set>
									</c:if>	
									<c:if test="${canShowModule == true }">
									<%-- 判断是否权限控制 --%>
										<c:if test="${pdfn:contain(module.moduleId, sessionScope.currUserModuleIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">									
											<li
												class="
												<c:choose>
													<c:when test="${sessionScope.currModuleId==module.moduleId}">
														yes									
														<c:set var="currModuleName" value="${module.moduleName}" scope="session" />															
														<c:set var="currModuleView" value="${module.view}" scope="session" />
													</c:when>
													<c:otherwise>not</c:otherwise></c:choose>">
												<a
												href="javascript:loadModule('<s:url value='/main/${sessionScope.currWsId}/${module.moduleId}'/>');"
												ondblclick="">
												<%-- 模块图标 --%>
												<c:if test="${sessionScope.currWsId=='srm' ||sessionScope.currWsId=='irb'||sessionScope.currWsId=='edc'
												||  sessionScope.currWsId=='sch'||sessionScope.currWsId=='gcp'}">
												<img src="<s:url value="/css/skin/${skinPath}/images/module/${module.moduleId}.png" />" />
												</c:if>	
												${module.moduleName}</a>
																	
											</li>	
											<%-- 如果当前模块没选中，默认显示第一个模块 --%>
											<c:if test="${empty sessionScope.currModuleId}">
												<c:set var="currModuleId" value="${module.moduleId}" scope="session" />
												<script type="text/javascript">
													$(document).ready(function(){
														loadModule('<s:url value='/main/${sessionScope.currWsId}/${module.moduleId}'/>');
													});
												</script>
											</c:if>							
										</c:if>	
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</td>
		</tr>
		<tr>
			<c:set var="hiddenLeft" value="false" scope="page"></c:set>
			<c:forEach items="${applicationScope.workStationList}" var="workStation">
				<c:if test="${sessionScope.currWsId==workStation.workStationId}">
					<c:forEach items="${workStation.moduleList}" var="module">
						<c:if test="${sessionScope.currModuleId==module.moduleId}">	
							<c:if test="${module.hiddenLeft=='Y'}">
							<c:set var="hiddenLeft" value="true" scope="page"></c:set>
							</c:if>
						</c:if>
					</c:forEach>
				</c:if>
			</c:forEach>
			<c:if test="${hiddenLeft == false}">
			<!--menulist-->
			<td  id="left" width="203" height="100%" valign="top">
			<div class="menu_sec" id="menu_sec">
				<div class="info">功能列表</div>
				<div id="menu" class="menu_list">	
    					
    				<c:set var="defaultMenuSet" value="true"/>				
					<c:forEach items="${applicationScope.workStationList}" var="workStation">
						<c:if test="${sessionScope.currWsId==workStation.workStationId}">
							<c:forEach items="${workStation.moduleList}" var="module">
								<c:if test="${sessionScope.currModuleId==module.moduleId}">				
									<c:forEach items="${module.menuSetList}" var="menuSet" varStatus="status">	                            	
					                    <c:set var="canShowMemuSet" value="false" scope="page"></c:set>
										<c:if test="${sessionScope.currWsId=='srm' }">
											<c:set var="canShowMemuSet" value="${pdfn:canShowByVersion(menuSet.version)}" scope="page"></c:set>
										</c:if>
										<c:if test="${sessionScope.currWsId!='srm' }">
											<c:set var="canShowMemuSet" value="true" scope="page"></c:set>
										</c:if>
										<c:if test="${canShowMemuSet == true }">
											<c:if test="${pdfn:contain(menuSet.setId, sessionScope.currUserMenuSetIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
													<c:if test="${defaultMenuSet}">
													<script>
														$(document).ready(function(){
															showMenuSet('${menuSet.setId}');
															setMenuSetName('${menuSet.setName}');
														});
													</script>
													</c:if>
													<div class="menuSetClass" id="${menuSet.setId}">
						                            <h1 class="active" align="left" onclick="javascript:showMenuSet('${menuSet.setId}');setMenuSetName('${menuSet.setName}');">
														<a href="javascript:void(0)">${menuSet.setName}</a>
													</h1>
													<span class="no">
														<ul>
					                            	<c:forEach items="${menuSet.menuList}" var="menu">						                            	
					                            		<c:set var="canShowMemu" value="false" scope="page"></c:set>
					                            		<c:if test="${sessionScope.currWsId=='srm' }">
															<c:set var="canShowMemu" value="${pdfn:canShowByVersion(menu.version)}" scope="page"></c:set>
														</c:if>		
														<c:if test="${sessionScope.currWsId!='srm' }">
															<c:set var="canShowMemu" value="true" scope="page"></c:set>
														</c:if>
														<c:if test="${canShowMemu == true }">
															<c:if test="${pdfn:contain(menu.menuId, sessionScope.currUserMenuIdList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
																<li><a class="aClass" id="${menu.menuId}" href="javascript:highlight('${menu.menuId}');loadMain('<s:url value='${menu.menuUrl}'/>');setMenuName('${menu.menuName}');">${menu.menuName}</a> </li>
															</c:if>
														</c:if>
													</c:forEach>
														</ul>
													</span>
													</div>
													<c:set var="defaultMenuSet" value="false"/>
											</c:if>
										</c:if>
									</c:forEach>
								</c:if>  
							</c:forEach>
						</c:if>     	
					</c:forEach>
					<div class="menuSetClass" id="sys-personal-module-center">
                        <h1 align="left" class="active" onclick="javascript:showMenuSet('sys-personal-module-center');setMenuSetName('个人中心');">
						<a href="javascript:void(0)">个人中心</a>
					</h1>
					<span>
						<ul>
                         	<li><a class="aClass" id="sys-personal-menu-view" href="javascript:highlight('sys-personal-menu-view');loadMain('<s:url value='/sys/user/view'/>?&editFlag=${GlobalConstant.FLAG_Y}');setMenuName('个人信息');">个人信息</a></li>
                         	<li><a class="aClass" id="sys-personal-menu-sec" href="javascript:highlight('sys-personal-menu-sec');loadMain('<s:url value='/sys/user/security'/>');setMenuName('安全中心');">安全中心</a> </li>
						</ul>
					</span>
					</div>
				</div>
			</div>
			</td>			
			<td id="zip" width="7" height="100%" bgcolor="#60b0e1">
				<table width="100%"	height="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td height="100%">
							<div id="bar" onclick="move()" style="height: 20px;cursor:pointer;vertical-align: center;">
								<img id="barimg" width="7px;" src="<s:url value='/css/skin/${skinPath}/images/left_arrow.png'/>"/>
							</div>
						</td>			
					</tr>
				</table>								
		    </td>
		    </c:if>
			<!--notice-->
			<td id="tdNotice"  height="100%" valign="top">
				<table width="100%" height="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" height="37" width="100%">
							<div class="htop">
								<span><b title="${applicationScope.workStationMap[sessionScope.currWsId].workStationName}">当前位置:</b>${sessionScope.currModuleName }--<span id="menuSetName"></span><span id="menuName"></span></span>
								
								<c:if test="${applicationScope.sysCfgMap['online_service']=='Y'}">
									<span style="float: right;"><a href='javascript:openCusSer();'>在线客服</a>&#12288;&#12288;&#12288;&#12288;</span>
								</c:if>
								<c:if test="${not empty sessionScope.currModuleView }">
									<span style="float: right;"><a href='<s:url value="${sessionScope.currModuleView }"/>' target="mainIframe">概&#12288;况</a>&#12288;&#12288;</span>						
								</c:if>
								<span style="float: right;"><a id="fullscreen" href='#'>全&#12288;屏</a>&#12288;&#12288;</span>						
							</div>
						</td>
					</tr>
					<tr>
						<td height="100%" valign="top">
							<c:if test="${empty sessionScope.currModuleView }">
								<c:set var="currModuleView" value="/jsp/center.jsp" scope="session" />							
							</c:if>
							<iframe id="mainIframe" name="mainIframe"
									scrolling="yes" width="100%" height="100%" frameborder="0"
									allowtransparency="no" src="<s:url value="${currModuleView}"/>?isMainFrame=Y" marginheight="0" marginwidth="0"></iframe></td>			
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<c:if test="${applicationScope.sysCfgMap['online_service']=='Y'}">
		<jsp:include page="service.jsp"></jsp:include>
	</c:if>
</body>
</html>
