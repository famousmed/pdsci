<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	if("${param.tagId}" != ""){
		$("#${param.tagId}").stop().click();
	}else{
		//loadBaseInfo();
		loadProcess();
	}
});
function changeView(flag){
	if(flag=="contract"){
		$("#fund").slideToggle("slow",function(){
			$("#contract").show("slow");
		});
	}else if(flag=="fund"){
		$("#contract").slideToggle("slow",function(){
			$("#fund").show("slow");
		});
	}
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
function editDrug(drugFlow,projFlow){
	jboxOpen("<s:url value='/gcp/drug/editDrugInfo'/>?drugFlow="+drugFlow+"&projFlow="+projFlow,"编辑药物信息", 700,625);
}

function drugStore(drugFlow){
	jboxOpen("<s:url value='/gcp/drug/drugStore'/>?drugFlow="+drugFlow,"药物库存", 700,400);
}
function showDrug(){
	$("#drugTip").hide();
	$("#drugInfo").show();
	$("#drugMore").show();
}
function irbList(){
	jboxOpen("<s:url value='/irb/secretary/reviewList'/>?projFlow=${param.projFlow}&isGcp=${GlobalConstant.FLAG_Y}","伦理审查记录", 870,400);
}
function irbDetail(irbFlow){
	var url = "<s:url value='/gcp/proj/showAddIrb'/>?irbFlow="+irbFlow;
	var width = 800;
	var height = 350;
	var message = "伦理审查详情";
	if("${applicationScope.sysCfgMap['gcp_irb_sys_on']}"=="${GlobalConstant.FLAG_Y}"){
		url ="<s:url value='/irb/secretary/decisionDetail'/>?irbFlow="+irbFlow+"&type=view";
		width = 900;
		height = 600;
		message = "批件/意见";
	}
	jboxOpen(url,message, width,height);
}
function submitIrbCheck(){
	if ("${proj.applyDeptFlow}" == "") {
		jboxTip("尚未分配承担科室和主要研究者，不能提交伦理审查！");
		return;
	}
	jboxOpen("<s:url value='/gcp/proj/doIrbApply'/>?projFlow=${param.projFlow}&roleScope=${param.roleScope}","伦理审查申请",400,150);
}
function toPass(){
	jboxConfirm("确认提交审核？",function(){
		var url = "<s:url value='/gcp/proj/changeProj'/>?projStatusId=${gcpProjStatusEnumPassing.id}&projFlow=${param.projFlow}";
		jboxPost(url,null,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				reload();
			}
		},null,true);
	},null);
}
function delProj(){
	jboxConfirm("确认删除该项目？",function(){
		var url = "<s:url value='/gcp/proj/delProj'/>?projFlow=${param.projFlow}";
		jboxPost(url,null,function(resp){
			if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
				window.location.href="<s:url value='/gcp/proj/applyList'/>";
			}
		},null,true);
	},null);
}
function reload(){
	window.location.reload();
}
function search(){
	window.location.reload();
}
function addIrb(){
	jboxOpen("<s:url value='/gcp/proj/showAddIrb'/>?projFlow=${param.projFlow}","新增伦理信息", 800,350);
}
function loadProcess(){
	selectTag('<s:url value="/gcp/proj/loadProcess?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>','xmjdb');
}
function loadBaseInfo(){
	selectTag('<s:url value="/gcp/proj/baseInfo?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>','jbxx');
}
function loadResearchUser(){
	selectTag('<s:url value="/gcp/proj/projUser?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'yjtd');
}
function loadApplyFile(){
	selectTag('<s:url value="/gcp/rec/applyFile?projFlow=${param.projFlow}"/>', 'xmwj');
}
function loadEvaluation(){
	selectTag('<s:url value="/gcp/rec/evaluation?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'lxpg');
}
function loadStartMeeting(){
	selectTag('<s:url value="/gcp/rec/startMeeting?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'qdh');
}
function loadFinishWork(){
	selectTag('<s:url value="/gcp/rec/finishWork?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'yjjsgz');
}
function loadStamp(){
	selectTag('<s:url value="/gcp/rec/sumStamp?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'zjgz');
}
function loadFiling(){
	selectTag('<s:url value="/gcp/rec/provFiling?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'sjba');
}
function loadPatientRecord(){
	selectTag('<s:url value="/gcp/proj/patientRecord?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'rzjl');
}
function loadQualityControl(){
	selectTag('<s:url value="/gcp/proj/qualityControl?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'zkjl');
}
function loadProjFile(){
	selectTag('<s:url value="/gcp/rec/archiveFile?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'wjgd');
}
function viewContract(){
	jboxOpen("<s:url value='/gcp/fin/projList'/>?projFlow=${proj.projFlow}&mainView=${GlobalConstant.FLAG_Y}","查看合同",1000,450);
}

function detail(projFlow,type){
	   jboxOpen("<s:url value='/gcp/proj/inDetailList'/>?orgFlow=${sessionScope.currUser.orgFlow}&projFlow="+projFlow+"&type="+type, "入组详情",750,450);
}
function aeView(projFlow){
	   jboxOpen("<s:url value='/gcp/researcher/patientAeView'/>?projFlow="+projFlow+"&type=projInfo", "不良事件一览",1000,450);
}
function loadFund(){
	selectTag('<s:url value="/gcp/fin/loadFund?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'kx');
}
function loadIrbProv(){
	selectTag('<s:url value="/gcp/proj/loadIrbProv?projFlow=${param.projFlow}&roleScope=${param.roleScope}"/>', 'irbprov');
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
        	<c:set var="mainPhotoName" value="gcp_main_photo.gif"></c:set>
	        <c:if test="${projCategroyEnumKy.id eq proj.projCategoryId }">
	       		<c:set var="mainPhotoName" value="gcp_main_photo-ky.gif"></c:set>
	        </c:if>
	        <c:if test="${projCategroyEnumQx.id eq proj.projCategoryId }">
	       		<c:set var="mainPhotoName" value="gcp_main_photo-qx.gif"></c:set>
	        </c:if>
          <img src="<s:url value='/css/skin/${skinPath}/images/${mainPhotoName }' />" width="80px" height="80px" />
        </a>
      </div>
      <div class="i-banner-main">
        <div class="i-banner-main-logo">
        	${proj.projShortName}
        </div>
        <div class="i-banner-main-detail">
         <div class="fn-left">期类别：<a>${proj.projSubTypeName }</a></div><div class="separator-20">|</div><div class="fn-left">项目来源：<a>${proj.projDeclarer }</a></div><div class="separator-20">|</div><div class="fn-left">承担科室：<a><c:out value="${proj.applyDeptName}" default="尚未分配"/></a></div><div class="separator-20">|</div><div class="fn-left">主要研究者：<a><c:out value="${proj.applyUserName }" default="尚未分配"/>&#12288;${applyUser.userPhone }</a></div>
        </div>
      </div>
    </div>
  </div>
  <div class="i-content" style="width: 100%">
    <div class="i-assets">
      <table class="i-assets-table"  border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="i-assets-balance">
          <c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
            <div class="i-assets-content" id="fund">
              <h3>项目总经费</h3>
              <div class="i-assets-left">
               <c:set var="fundArray"  value="${fn:split(patientCountMap['fund'],'.')}"/>
              <strong class="amount"><c:out value="${fundArray[0]}" default="0"></c:out><span><c:if test="${!empty fundArray[1] }">.${fundArray[1]}</c:if></span></strong>元
              <span class="ui-button-blue-15" style="float:right;margin-left: 30px;">|<a class="ui-blue" href="javascript:void(0);" onclick="changeView('contract');">合同</a></span>
              </div>
            </div>  
            <div class="i-assets-content" id="contract" style="display: none;margin-top: 10px;margin-bottom: 60px;">
              <h3 style="display: inline-block;">合同管理</h3><span class="ui-button-blue-15" style="float: right;margin-right: 10px;"><a href="javascript:void(0)" onclick="changeView('fund')" class="ui-blue">查看经费</a></span>
              <div class="i-assets-left">
              <table id="contartTable"  style="width: 100%;text-align: center;">
					<tbody>
					   <tr style="vertical-align: middle; height: 25px;line-height: 25px">
					   <td style="width:90px;font-weight: bold;">合同类型</td>
					   <td style="width:100px;font-weight: bold;">合同例数</td>
					   <td style="width:90px;font-weight: bold;">合同经费</td>
					   <td style="width:100px;font-weight: bold;">盖章日期</td>
					   <td style="width:50px;font-weight: bold;">附件</td>
					   </tr>
					   <c:forEach items="${contList}" var="cont" end="1">
						<tr  style="vertical-align: middle; height: 25px;line-height: 25px">
							<td align="center">
						       <c:forEach items="${gcpContractTypeEnumList }" var="type">
							     <c:if test="${type.id eq cont.contractTypeId }">
							     ${type.name}
							     </c:if>
						       </c:forEach>
							 </td>
							<td align="center">${cont.caseNumber }</td>
							<td align="center">${cont.contractFund }</td>
							<td align="center">${cont.stampDate }</td>
							<td align="center">
							<c:if test="${!empty cont.fileFlow}">
								<a href="<s:url value="/pub/file/down?fileFlow=${cont.fileFlow}"/>" title="下载"><img style="padding-top: 4px;padding-bottom: 4px;" src="${ctxPath}/css/skin/${skinPath}/images/dload.png"></a>
							</c:if>
							</td>
						</tr>
					  </c:forEach>	
					</tbody>
				</table>
              </div>
            </div> 
            </c:if> 
            <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_GO }">
            	<div class="i-assets-content" id="fund">
	              <h3>项目进度</h3>
	              <div class="i-assets-left">
	              	<div class="flow-list" id="icn">
						<ul>
					    	<li class="list-1-2"><span>1</span><br/>申报</li>
					        <li class="list-2-${proj.projStatusId eq gcpProjStatusEnumPassed.id?'2':'1' }"><span>2</span><br/>审核</li>
					        <li class="list-2-${!empty evalForm.agree?'2':'1' }"><span>3</span><br/>立项</li>
					        <li class="list-2-${proj.projStageId eq gcpProjStageEnumSchedule.id || proj.projStageId eq gcpProjStageEnumComplete.id?'2':'1' }"><span>4</span><br/>实施</li>
					        <c:if test="${proj.projStageId != gcpProjStageEnumTerminate.id }">
					        <li class="list-3-${proj.projStageId eq gcpProjStageEnumComplete.id?'2':'1' }"><span>5</span><br/>结束</li>
					   		</c:if>
					   		<c:if test="${proj.projStageId eq gcpProjStageEnumTerminate.id }">
					        <li class="list-3-${proj.projStageId eq gcpProjStageEnumTerminate.id?'2':'1' }"><span>5</span><br/>终止</li>
					   		</c:if>
					    </ul>
					</div>
	              </div>
	            </div>
            </c:if>
          </td>
          <td rowspan="2" width="250">
            <div class="i-assets-content">
            <h3>药物信息</h3>
              <ul>
              <c:choose>
				<c:when test="${empty drug }">
				<li class="gray content" id="drugTip">
                	<p>暂无药物信息，请<a class="ui-blue-no-margin" href="javascript:void(0);" onclick="editDrug('${drug.drugFlow}','${proj.projFlow }');">&nbsp;编辑</a></p>
                </li>
                </c:when>
                <c:otherwise>
				<li class="gray content" id="drugInfo">
                <p>${drug.drugName }</p>
                <p>规格：${drug.spec }</p>
                <p>用法：${pdfn:cutString(drug.recipeUsage,10,true,3 )}</p>
                </li>
                <li class="ui-message" id="drugMore" <c:if test="${empty drug}">style="display:none;"</c:if>>
                <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER }">
                                                     库存编码数：<font class="yellow">${drugPackNum }</font>
                </c:if>
                <span class="ui-button-blue-50" style="margin-left: ${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER?'20px':'120px'};">
                <a class="ui-blue" href="javascript:void(0);" onclick="editDrug('${drug.drugFlow}','${proj.projFlow}');">编辑</a>
                <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER }">
                |<a class="ui-blue" onclick="drugStore('${drug.drugFlow }','')">库存</a>
                </c:if>
                </span>
                </li>
				</c:otherwise>
			</c:choose>
			</ul>
            </div>
          </td>
          <td rowspan="2">
            <div class="i-assets-content">
            <h3>伦理审查</h3>
              <ul class="content" style="padding-bottom: 0;height: 140px;">
              <c:choose>
				<c:when test="${proj.projStatusId==gcpProjStatusEnumPassed.id&& empty irbList}">
					<li class="ui-ico-cssc">
					您还没有提交伦理审查
					 <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER }">
					，请<a href="javascript:void(0)" class="ui-blue-no-margin" 
					<c:choose><c:when test="${applicationScope.sysCfgMap['gcp_irb_sys_on']==GlobalConstant.FLAG_N }"> onclick="addIrb();" </c:when><c:otherwise>onclick="submitIrbCheck();"</c:otherwise></c:choose> >&nbsp;新增</a>
					</c:if>
					</li>
				</c:when>
				<c:when test="${proj.projStatusId==gcpProjStatusEnumPassed.id&& !empty irbList }">
				    <c:forEach items="${irbList }" var="irb" varStatus="statu" end="2">
				    <c:if test="${statu.index==2 && GlobalConstant.FLAG_Y == irbFlag }"><b>…<br/></b></c:if>
					<li <c:choose>
							<c:when test="${irbTypeEnumInit.id eq irb.irbTypeId}">class="ui-ico-init"</c:when>
							<c:when test="${irbTypeEnumSae.id eq irb.irbTypeId}">class="ui-ico-sae"</c:when>
							<c:otherwise>class="ui-ico-schedule"</c:otherwise>
						 </c:choose>>
		             	<span>${irb.irbTypeName }：
		             	<c:choose>
		                <c:when test="${irb.irbStageId==irbStageEnumArchive.id|| irb.irbStageId==irbStageEnumFiling.id }">
		                	<a href="javascript:void(0);" onclick="irbDetail('${irb.irbFlow}');" class="ui-blue-no-margin">${irb.irbDecisionName }</a>
		                </c:when>
		                <c:otherwise>
		                	 <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER }">
		                		<a href="<s:url value='/irb/researcher/process'/>?projFlow=${proj.projFlow}&irbTypeId=${irb.irbTypeId }&roleScope=${param.roleScope}" class="ui-blue-no-margin">${irb.irbStageName }</a>
		                	</c:if>
		                	<c:if test="${param.roleScope == GlobalConstant.ROLE_SCOPE_DECLARER }">
		                		${irb.irbStageName }
		                	</c:if>
	                	</c:otherwise>
		                </c:choose>
		                </span>
	                 </li>
	                 </c:forEach>
				</c:when>
				<c:otherwise>
					<li class="fn-clear">暂无伦理信息！</li>
				</c:otherwise>
			</c:choose>
			   </ul>
			   <div <c:if test="${proj.projStatusId!=gcpProjStatusEnumPassed.id}">style="display:none;"</c:if> >
			   <span class="ui-button-blue-15" style="float: right;">
			     <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER }">
			       	<a href="javascript:void(0)" class="ui-blue-no-margin" <c:choose><c:when test="${applicationScope.sysCfgMap['gcp_irb_sys_on']==GlobalConstant.FLAG_N }"> onclick="addIrb();" </c:when><c:otherwise>onclick="submitIrbCheck();"</c:otherwise></c:choose> >新增</a> |
			       </c:if> 
			       <a href="javascript:void(0)"  onclick="irbList()" class="ui-blue-no-margin" >查看更多</a>
			   </span>
			   </div>
            </div> 
          </td>
        </tr>
        <tr>
          <td>
            <div class="i-assets-content">
               <h3>项目进展</h3>
              <div class="i-assets-left">
              <font class="black"><strong>总例数：<a class="yellow" href="javascript:detail('${proj.projFlow}');">${patientCountMap[param.projFlow]+0}</a></strong></font>
              <span class="ui-left">入组：<a class="yellow" href="javascript:detail('${proj.projFlow}','${patientStageEnumIn.id }');">${patientCountMap[patientStageEnumIn.id]}</a></span>
              <span class="ui-left">完成：<a class="yellow" href="javascript:detail('${proj.projFlow}','${patientStageEnumFinish.id }');">${patientCountMap[patientStageEnumFinish.id]}</a></span>
              <span class="ui-left">SAE：<a class="yellow" href="javascript:aeView('${proj.projFlow}');">${patientCountMap['saeNum']}</a></span>
              <span class="ui-left">脱落：<a class="yellow" href="javascript:detail('${proj.projFlow}','${patientStageEnumOff.id }');">${patientCountMap[patientStageEnumOff.id]}</a></span>
              <span class="ui-button-blue-15">|<a class="ui-blue" href="javascript:detail('${proj.projFlow}','');">查看</a></span>
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
              	<li class="iselectTag"><a onclick="loadProcess()" href="javascript:void(0)" id="xmjdb">项目进度表</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadBaseInfo()" href="javascript:void(0)" id="jbxx">基本信息</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadApplyFile()" href="javascript:void(0)" id="xmwj">项目文件</a></li>
                <c:if test="${proj.projStatusId==gcpProjStatusEnumPassed.id }">
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadResearchUser()" href="javascript:void(0)" id="yjtd">研究团队</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadEvaluation()" href="javascript:void(0)" id="lxpg">立项评估</a></li>
                <li>|</li>
                 <li class="ui-bluetag"><a onclick="loadIrbProv()" href="javascript:void(0)" id="irbprov">伦理批件</a></li>
                <li>|</li>
                 <li class="ui-bluetag"><a onclick="loadFund()" href="javascript:void(0)" id="kx">款项</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadStartMeeting()" href="javascript:void(0)" id="qdh">启动会</a></li>
                <c:if test="${gcpProjStageEnumSchedule.id eq proj.projStageId || gcpProjStageEnumComplete.id eq proj.projStageId}">
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadPatientRecord()" href="javascript:void(0)" id="rzjl">入组记录</a></li>
                <li>|</li>
                <li class="ui-bluetag ui-notice"><a onclick="loadQualityControl()" href="javascript:void(0)" id="zkjl">质控记录<c:if test="${qcMap[param.roleScope] }"><img src="<s:url value='/css/skin/${skinPath}/images/ui-notice.png'/>" /></c:if></a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadFinishWork()" href="javascript:void(0)" id="yjjsgz">研究结束工作</a></li>
                </c:if>
                <c:if test="${gcpProjStageEnumComplete.id eq proj.projStageId }">
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadStamp()" href="javascript:void(0)" id="zjgz">总结盖章</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadFiling()" href="javascript:void(0)" id="sjba">省级备案</a></li>
                <li>|</li>
                <li class="ui-bluetag"><a onclick="loadProjFile()" href="javascript:void(0)" id="wjgd">文件归档</a></li>
                </c:if>
                </c:if>
              </ul>
              <c:if test="${proj.projStatusId==gcpProjStatusEnumEdit.id||proj.projStatusId==gcpProjStatusEnumNoPassed.id}">
				<div style="float: right; margin-right: 20px;">
				<a class="ui-button-t" href="javascript:void(0)" onclick="toPass()">提交审核</a>
				<a class="ui-button-t" href="javascript:void(0)" onclick="delProj()">删除</a></div>
			 </c:if>
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