<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/process.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
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
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
	table#sp_xllist td{width:200px;text-align: left;padding-left: 12px;}
	#tagContent{background: #f8f8f8;padding: 10px;}
	.butt_see{padding:3px 10px;}
</style>
</head>
<script type="text/javascript">
$().ready(function(){
	if('${param.msg}'=='notAllCheck'){
		jboxTip('${GlobalConstant.NOTICE_OPER_ERROR}');
	}
	if('${!empty irbForm.irb.reviewWayId }'=='true'){
		toChooseMember('member');
	}else if('${!empty irbForm.irb.irbNo }'=='true'){
		toCheckWay('checkWay');
	}else if('${allConfirm}'=='true'){
		toRecNotice('recNotice');
	}else{
		toFormCheck('formCheck');
	}
});

	function uploadFile(){
		jboxOpen("<s:url value='/irb/applyFile'/>", "上传文件", 700,300);
	}
	function reloadContent(url){
		jboxStartLoading();
		jboxLoad("mainContent",url+"?irbFlow=${param.irbFlow}",true);
		jboxEndLoading();
		
	}
	function toFormCheck(id){
		changePosition(45,id);
		reloadContent('<s:url value='/irb/secretary/showFormcheck'/>');
	}
	function toRecNotice(id){
		var url = "<s:url value='/irb/secretary/checkAllConfirmJson'/>";
		var requestData = {"irbFlow":"${param.irbFlow}"};
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.FLAG_Y}'){
				changePosition(167,id);
				reloadContent("<s:url value='/irb/secretary/receiptNotice'/>");
			}else{
				jboxTip('${GlobalConstant.NOTICE_OPER_ERROR}');
			}
		},null,false);
	}
	function toCheckWay(id){
		var irbNo = $("#i_irbNo").text();
		if(!irbNo){
			jboxTip('${GlobalConstant.CHECKWAY_OPER_ERROR}');
			return false;
		}
		changePosition(285,id);
		reloadContent("<s:url value='/irb/secretary/showCheckWay'/>");
	}
	function toChooseMember(id){
		var checkWay = $("#i_checkWay").text();
		if(!checkWay){
			jboxTip('${GlobalConstant.CHOOSE_MEMBER_OPER_ERROR}');
			return false;
		}
		changePosition(410,id);
		reloadContent("<s:url value='/irb/secretary/chooseMember'/>");
	}
	function changePosition(px,id){
		$(".pt").removeClass();
		$("#"+id).addClass("pt"); 
		$("#crentarrow").attr("style","left:"+px+"px;");
	}
	
	function doBackHandle(){
		window.location.href="<s:url value='/irb/secretary/list?irbStageId=${irbStageEnumHandle.id }'/>";
	}
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div style="margin-top: 5px">
					&#12288;项目名称：<b>${irbForm.irb.projShortName } </b>
					&#12288; 期类别：<b>${irbForm.irb.projSubTypeName}</b> &#12288; 项目来源：<b>${irbForm.irb.projDeclarer }</b>
					<span style="margin-left: 30px;">伦理审查类别：</span><b>${irbForm.irb.irbTypeName }</b>
					&#12288;<input type="button"  class="search" value="返&#12288;回" onclick="doBackHandle();"/> 
				</div>
				<div class="title1 clearfix">
							<table class="xllist nofix" id="sp_xllist">
							<tr>
	                              <td >专业组：${irbForm.proj.applyDeptName }</td>
	                            <td >主要研究者：${irbForm.proj.applyUserName}</td>
	                           <td >送审日期：${irbForm.irb.irbApplyDate}</td>
	                             <td ></td>
	                             
                       		 </tr>
								<tr>
                            <td >受理日期：<span id="i_operTime">${irbForm.irb.irbAcceptedDate}</span></td>
                             <td >受理号：<span id="i_irbNo">${irbForm.irb.irbNo}</span></td>
                              <td>审查方式：<span id="i_checkWay">${irbForm.irb.reviewWayName}</span></td>
                           <td >主审委员：<c:forEach items="${committeeList}" var="irbUser" varStatus="statu">${irbUser.userName}<c:if test="${fn:length(committeeList)>1&&!statu.last}">、</c:if></c:forEach></td>
                             
                         </tr>
							</table>
			</div>
			<!-- 
			<div class="setpboxo" style="padding-top: 10px;display: none;">
						<div class="steptaks">
						<span class="step_on " style="cursor: pointer;" onclick="toFormCheck();"><b>形式审查</b></span>
						<span id="recNotice"  class="step_<c:if test='${!allConfirm}'>off</c:if><c:if test='${allConfirm}'>on</c:if> " style="cursor: pointer;" onclick="toRecNotice();"><b>受理通知</b></span> 
						<span id="checkWay" class="step_<c:if test='${empty irbForm.irb.irbNo }'>off</c:if><c:if test='${!empty irbForm.irb.irbNo }'>on</c:if> " style="cursor: pointer;" onclick="toCheckWay();"><b>审查方式</b></span>
						<span id="chooseMember" class="stepend_<c:if test='${empty irbForm.irb.reviewWayId }'>off</c:if><c:if test='${!empty irbForm.irb.reviewWayId }'>on</c:if>  " style="cursor: pointer;" onclick="toChooseMember();"><b>主审/顾问</b></span>
						<div class="crentarrow" id="crentarrow" style="left:45px;"></div>
						</div>
			</div>
			 --><!--45, 167,285,410 -->
			<div class="flow_list" id="icn">
				<ul>
			    	<li class="list_1_2" ><span>1</span><br/><a id="formCheck" onclick="toFormCheck('formCheck');" href="javascript:void(0)">形式审查</a></li>
			        <li class="list_2_<c:if test='${!allConfirm}'>1</c:if><c:if test='${allConfirm}'>2</c:if>" ><span>2</span><br/><a id="recNotice" onclick="toRecNotice('recNotice');" href="javascript:void(0)">受理通知</a></li>
			        <li class="list_2_<c:if test='${empty irbForm.irb.irbNo }'>1</c:if><c:if test='${!empty irbForm.irb.irbNo }'>2</c:if>" ><span>3</span><br/><a id="checkWay" onclick="toCheckWay('checkWay');" href="javascript:void(0)">审查方式</a></li>
			        <li class="list_3_<c:if test='${empty irbForm.irb.reviewWayId }'>1</c:if><c:if test='${!empty irbForm.irb.reviewWayId }'>2</c:if>" ><span>4</span><br/><a id="member" onclick="toChooseMember('member');" href="javascript:void(0)">主审/顾问</a></li>
			    </ul>
			</div> 
			<div id="mainContent" style="padding-top: 10px">

			</div>
		</div>
		</div>
		</div>
</body>
</html>