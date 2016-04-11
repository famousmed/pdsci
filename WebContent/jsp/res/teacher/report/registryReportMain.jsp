<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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

<script type="text/javascript">
 $(function(){
	 selectTag('<s:url value="/res/teacher/registryReportList"/>','<c:out value="${param.recTypeId}" default="${resRecTypeEnumCaseRegistry.id}"/>');
	});
	function selectTag(url, id) {
	    // 操作标签
	    var tag = document.getElementById("tags").getElementsByTagName("li");
	    var taglength = tag.length;
	    for (i = 0; i < taglength; i++) {
	        tag[i].className = "ui-bluetag";
	    }
	    document.getElementById(id).parentNode.className = "selectTag";
	    // 操作内容
	    jboxLoad("contentDiv",url+"?recTypeId="+id+"&roleFlag=${empty roleFlag?param.roleFlag:roleFlag}&isCurrentFlag="+($("#isCurrentFlag:checked").length>0?$("#isCurrentFlag:checked").val():""),true);
	}
	function doBack() {
		window.location.href="<s:url value='/res/teacher/showView/${empty roleFlag?param.roleFlag:roleFlag}'/>";
	}
	function audit(recFlow,recTypeId,processFlow){
		var url =  "<s:url value='/res/teacher/showAudit'/>?isReport=true&recFlow="+recFlow+"&recTypeId="+recTypeId+"&roleFlag=${empty roleFlag?param.roleFlag:roleFlag}&processFlow="+processFlow;
		var width=(window.screen.width)*0.6;
		if(recTypeId=="${resRecTypeEnumAfterEvaluation.id}"){
			width = (window.screen.width)*0.7;
		}
		var height = 300;
		if("${empty roleFlag?param.roleFlag:roleFlag}"=="${GlobalConstant.RES_ROLE_SCOPE_HEAD}"){
			height = 400;
		}
		jboxOpen(url,"审核意见",width,height,true);
	}
</script>

<style type="text/css">
	#table1 th {background: #fff; width: 110px;border:none;}
	#table1,#table1 td{border:none;}
</style>
</head>
<body>
<div class="mainright">
  <div class="content" style="margin-top: 10px;">
  	<ul id="tags">
		<li class="selectTag"><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumCaseRegistry.id}');" href="javascript:void(0)" id="${resRecTypeEnumCaseRegistry.id}">大病历</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumDiseaseRegistry.id}');" href="javascript:void(0)" id="${resRecTypeEnumDiseaseRegistry.id}">病&#12288;种</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumSkillRegistry.id}');" href="javascript:void(0)" id="${resRecTypeEnumSkillRegistry.id}">操作技能</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumOperationRegistry.id}');" href="javascript:void(0)" id="${resRecTypeEnumOperationRegistry.id}">手&#12288;术</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumCampaignRegistry.id}');" href="javascript:void(0)" id="${resRecTypeEnumCampaignRegistry.id}">参加活动</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumTrainData.id}');" href="javascript:void(0)" id="${resRecTypeEnumTrainData.id}">培训数据</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumAfterSummary.id}');" href="javascript:void(0)" id="${resRecTypeEnumAfterSummary.id}">出科小结</a></li>
		<li><a onclick="selectTag('<s:url value='/res/teacher/registryReportList'/>','${resRecTypeEnumAfterEvaluation.id}');" href="javascript:void(0)" id="${resRecTypeEnumAfterEvaluation.id}">出科考核表</a></li>
    </ul>
    <div id="tagContent" class="divContent">
    	<div id="contentDiv" style="">
		</div>
    </div>
  </div>
</div>
</body>
</html>