<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="compatible" value="false"/>
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="false"/>
	<jsp:param name="ueditor" value="false"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/j.suggest.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<style type="text/css">
html,body{
	overflow:auto;
	background-color:#fff;
	position:relative;
}
</style>
<script type="text/javascript">
$(function(){
	if("${param.tagId}" != ""){
		$("#${param.tagId}").stop().click();
	}else{
		loadPatient();
	}
	/*辅助输入*/
	loadProjList();
	$("#searchParam").keyup(function(){   
		  if(event.keyCode == 13){      
			  var projFlow =  $("#SuggestResult").val();
			  window.location.href="<s:url value='/gcp/proj/projInfo'/>?projFlow="+projFlow+"&roleScope=${GlobalConstant.ROLE_SCOPE_GO}";
		  }
	  });
});
function loadProjList() {
	var projs = new Array();
	var url = "<s:url value='/gcp/proj/seachProjListJson'/>";
	jboxPost(url,null,function(data){
		if(data!=null){
			for ( var i = 0; i < data.length; i++) {
				projs[i]=new Array(data[i].projFlow,data[i].projShortName,data[i].projNo);
			}
		}
	},null,false);
	$("#searchParam").suggest(projs,{
		attachObject:'#suggest',
		triggerFunc:function(projFlow){
			window.location.href="<s:url value='/gcp/proj/projInfo'/>?projFlow="+projFlow+"&roleScope=${GlobalConstant.ROLE_SCOPE_GO}";
		},
	});
}
function selectTag(url, id) {
    // 操作标签
    var tag = document.getElementById("itags").getElementsByTagName("li");
    var taglength = tag.length;
    for (i = 0; i < taglength; i++) {
        tag[i].className = "ui-bluetag";
    }
    //selfObj.parentNode.className = "iselectTag";
    document.getElementById(id).parentNode.className = "iselectTag";
    // 操作内容
    jboxLoad("contentDiv",url,true);
}
function reload(){
	window.location.reload();
}
function addIrb(){
	jboxOpen("<s:url value='/gcp/fin/showAddIrb'/>?projFlow=${param.projFlow}","新增伦理信息", 800,350);
}
function loadContract(){
	selectTag('<s:url value="/gcp/fin/orgContList"/>','htjl');
}
function loadFund(){
	selectTag('<s:url value="/gcp/fin/orgFundList"/>', 'jfjl');
}
function loadPatient(){
	selectTag('<s:url value="/gcp/proj/orgInDetailList"/>', 'rzjl');
}
function loadQcRecord(){
	selectTag('<s:url value="/gcp/proj/qcRecordList"/>','zkjl');
}
function loadMeeting(){
	selectTag('<s:url value="/gcp/proj/orgMeetingList"/>', 'hyjl');
}
function loadTrain(){
	selectTag('<s:url value="/gcp/proj/orgTrainList"/>', 'pxjl');
}
function orgProjList(projCategoryId){
	jboxOpen("<s:url value='/gcp/proj/orgProjList'/>?projCategoryId="+projCategoryId,"项目列表",1000,450);
}
function contractList(){
	jboxOpen("<s:url value='/gcp/fin/projList'/>?mainView=${GlobalConstant.FLAG_Y}","合同情况",1000,450);
}
function fundList(){
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	jboxOpen("<s:url value='/gcp/fin/projFundList'/>","经费情况",width,450);
}
function projList(){
	jboxOpen("<s:url value='/gcp/proj/list'/>?mainView=${GlobalConstant.FLAG_Y}","项目概况",1000,450);
}
function orgRemindList(qcTypeId){
	jboxOpen("<s:url value='/gcp/qc/orgRemindList'/>?qcTypeId="+qcTypeId,"质控提醒列表",1000,450);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
<div class="ui-container">
  <div class="i-banner">
    <div class="i-banner-content">
      <div class="i-banner-portrait">
        <a class="userInfo-portrait">
          <img src="<s:url value='/css/skin/${skinPath}/images/gcp_main_photo.gif' />" width="80px" height="80px" />
        </a>
      </div>
      <div class="i-banner-main">
        <div class="i-banner-main-logo">
        	欢迎您，${sessionScope.currUser.userName}
        	<div style="float: right;display: inline-block;">
        	<input id="searchParam" placeholder="输入关键字,如项目编号/简称">
        	<div id="suggest" class="ac_results" style="margin-left: -7px"></div>
        	<input id="SuggestResult" type="hidden"/>
        	</div>
        </div>
        <div class="i-banner-main-detail">
         <div class="fn-left">用户名：<a>${sessionScope.currUser.userCode }</a></div><div class="separator-20">|</div><div class="fn-left">角色：<a>${role}</a></div><div class="separator-20">|</div><div class="fn-left">所在机构：<a>${sessionScope.currUser.orgName }</a></div>
        </div>
      </div>
    </div>
  </div>
  <div class="i-content">
    <div class="i-assets">
      <table class="i-assets-table" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="i-assets-balance" style="width: 500px;">
            <div class="i-assets-content" id="fund">
              <h3>机构余额</h3>
              <div class="i-assets-left">
              <c:set var="fundArray"  value="${fn:split(dataMap['fund'],'.')}"/>
              <strong class="amount"><c:out value="${fundArray[0]}" default="0"></c:out><span><c:if test="${!empty fundArray[1] }">.${fundArray[1]}</c:if></span></strong>元
              <a class="ui-button" href="javascript:void(0)" onclick="contractList()">合同情况</a>
              <a class="ui-button" href="javascript:void(0)" onclick="fundList()">经费情况</a>
              <!-- <span class="ui-button-blue-15"><a class="ui-blue">查看</a>|<a class="ui-blue" href="javascript:void(0);" onclick="changeView('contract');">合同</a></span> -->
              </div>
              <!-- <i class="i-assets-visible-icon-back"></i> -->
            </div>  
          </td>
          <td rowspan="2" width="240">
            <div class="i-assets-content">
            <h3>质控提醒<span class="ui-button-blue-120" style="margin-left: 90px;" ><a href="javascript:orgRemindList('');" class="ui-blue">更多&gt;</a></span></h3>
            <ul>
            	<li class="gray content" id="drugInfo" >
                <c:forEach items="${gcpQcTypeEnumList}" var="qcType">
                	<c:if test="${!(gcpQcTypeEnumInspection.id eq qcType.id)}">
                	<p>${qcType.name}：<a href="javascript:orgRemindList('${qcType.id}');" class="ui-blue-no-margin">${qcCountMap[qcType.id]+0}</a></p>
                	</c:if>
                </c:forEach>
                </li>
                <li class="ui-message" id="drugMore" style="text-align: right;">
	                <span class="ui-button-blue-50" >
		                <a class="ui-blue" href="<s:url value='/gcp/qc/projQcList'/>?roleScope=${GlobalConstant.ROLE_SCOPE_GO}">质控</a>
		                |
		                <a class="ui-blue" href="<s:url value='/gcp/cfg/qcRemindConfig'/>?beforePage=main">配置</a>
	                </span>
                </li>
			</ul>
            </div>
          </td>
          <td rowspan="2">
            <div class="i-assets-content">
            <h3>项目类别<span class="ui-button-blue-120" style="margin-left: 100px;" ><a href="javascript:void(0)" class="ui-blue" onclick="orgProjList('')">更多&gt;</a></span></h3>
              <ul class="content" style="padding-bottom: 0;height: 140px;">
				<li class="ui-ico-yw"><span>药物试验：<a href="javascript:void(0);" onclick="orgProjList('${projCategroyEnumYw.id}');" class="ui-blue-no-margin">${projCountMap[projCategroyEnumYw.id] }</a></span></li>
				<li class="ui-ico-ky"><span>临床科研：<a href="javascript:void(0);" onclick="orgProjList('${projCategroyEnumKy.id}');" class="ui-blue-no-margin">${projCountMap[projCategroyEnumKy.id] }</a></span></li>
				<li class="ui-ico-qx"><span>医疗器械：<a href="javascript:void(0);" onclick="orgProjList('${projCategroyEnumQx.id}');" class="ui-blue-no-margin">${projCountMap[projCategroyEnumQx.id] }</a></span></li>
			   </ul>
            </div> 
          </td>
        </tr>
        <tr>
          <td>
            <div class="i-assets-content">
               <h3>项目概况</h3>
              <div class="i-assets-left">
              <c:forEach items="${gcpProjStageEnumList }" var="sEnum">
              	<span class="ui-left">${sEnum.name}：<font class="yellow">${dataMap[sEnum.id]}</font>个</span>
              </c:forEach>
              <span class="ui-button-blue-15">|<a class="ui-blue" href="javascript:void(0)" onclick="projList()">查看</a></span>
              </div>
            </div>  
          </td>
        </tr>
      </tbody>
      </table>
    </div>
    <div class="i-trend">
      <table class="i-trend-table" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="ith_t">
            <div class="i-trend-header">
              <ul id="itags">
                <li><strong>最新消息</strong>&nbsp;</li>
                <li class="iselectTag"><a onclick="loadPatient()" href="javascript:void(0)" id="rzjl">入组记录</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadQcRecord()" href="javascript:void(0)" id="zkjl">质控记录</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadMeeting()" href="javascript:void(0)" id="hyjl">会议记录</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadTrain()" href="javascript:void(0)" id="pxjl">培训记录</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadContract()" href="javascript:void(0)" id="htjl">合同记录</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadFund()" href="javascript:void(0)" id="jfjl">经费记录</a></li>
              </ul>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div id="itagContent">
             <div class="selectTag" id="contentDiv">
             </div>
            </div>
          </td>
        </tr>
        <tr><td class="dc"><!-- <a class="ui-blue">导出</a> --></td></tr>
      </tbody>
      </table>
  </div>
  </div>
</div>
</div>
</div>
</body>
</html>