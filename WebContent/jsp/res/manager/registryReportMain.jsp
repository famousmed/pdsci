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
	var type ;
	$(function(){
		$(".selectTag").click();
	});
	
	function selTag(clickObj){
		$(".selectTag").toggleClass("selectTag");
		$(clickObj).toggleClass("selectTag");
	}
	
	function loadContent(recTypeId){
		var data;
		if(recTypeId == type){
			data = $('#recSearchForm').serialize();
		}
		type = recTypeId;
		jboxPost("<s:url value='/res/manager/registryReportList'/>?recTypeId="+recTypeId,data,function(resp){
			$("#contentDiv").html(resp);
		},null,false);
	}
	
	function detail(userFlow,schDeptFlow,rotationFlow,itemName){
		userFlow = userFlow || "";
		schDeptFlow = schDeptFlow || "";
		rotationFlow = rotationFlow || "";
		itemName = itemName || "";
		jboxOpen("<s:url value='/res/manager/recDetail'/>?recTypeId="+type+"&userFlow="+userFlow+"&schDeptFlow="+schDeptFlow+"&rotationFlow="+rotationFlow+"&itemName="+itemName,title,800,500);
	}
</script>

<style type="text/css">
	#table1 th {background: #fff; width: 110px;border:none;}
	#table1,#table1 td{border:none;}
	#tags li a:HOVER {cursor: pointer;}
</style>
</head>
<body>
<div class="mainright">
  <div class="content" style="margin-top: 10px;">
  	<ul id="tags">
		<li class="selectTag" onclick="selTag(this);loadContent('${resRecTypeEnumCaseRegistry.id}');"><a>${resRecTypeEnumCaseRegistry.typeName}</a></li>
		<li onclick="selTag(this);loadContent('${resRecTypeEnumDiseaseRegistry.id}');"><a>${resRecTypeEnumDiseaseRegistry.typeName}</a></li>
		<li onclick="selTag(this);loadContent('${resRecTypeEnumSkillRegistry.id}');"><a>${resRecTypeEnumSkillRegistry.typeName}</a></li>
		<li onclick="selTag(this);loadContent('${resRecTypeEnumOperationRegistry.id}');"><a>${resRecTypeEnumOperationRegistry.typeName}</a></li>
		<li onclick="selTag(this);loadContent('${resRecTypeEnumCampaignRegistry.id}');"><a>${resRecTypeEnumCampaignRegistry.typeName}</a></li>
    </ul>
    <div id="tagContent" class="divContent">
    	<div id="contentDiv">
		</div>
    </div>
  </div>
</div>
</body>
</html>