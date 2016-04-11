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
</jsp:include>
</head>
<script type="text/javascript">
	var openRec = {};
	//标签高亮
	function selTag(tag){
		$(".selectTag").removeClass("selectTag");
		$(tag).addClass("selectTag");
	}
	
	function loadRequireDataList(recTypeId,reqFlow){
		var url = "<s:url value='/res/rec/requireDataList'/>?schDeptFlow=${schDept.schDeptFlow}&rotationFlow=${param.rotationFlow}&recTypeId="+recTypeId;
		if(recTypeId == "${resRecTypeEnumAfterSummary.id}"){
			url = "<s:url value='/res/rec/showRegistryForm'/>?recTypeId="+recTypeId+"&schDeptFlow=${schDept.schDeptFlow}&rotationFlow=${param.rotationFlow}&roleFlag=${param.roleFlag}";
		}
		jboxLoad("tagContent",url,true);
		if(recTypeId=="${resRecTypeEnumCaseRegistry.id}" || recTypeId=="${resRecTypeEnumCampaignRegistry.id}"){
			$("#add").show();
		}else{
			$("#add").hide();
		}
	}
	
	$(function (){
		$("#${param.recTypeId}").click();
	});
	
	function back(){
		window.location.href="<s:url value='/res/doc/rotationDetail'/>?resultFlow=${param.resultFlow}&schDeptFlow=${schDept.schDeptFlow}&rotationFlow=${param.rotationFlow}";
	}
</script>
	<body>
		<div id="main">
			<div class="mainright">
				<div class="content">
					<div style="margin-top: 5px">
						&#12288;轮转科室：<b>${schDept.schDeptName}</b>
					</div>
					<div class="title1 clearfix">
						<input type="button" value="返&#12288;回" class="search" onclick="back();" style="float: right"/>
						<input type="button" value="登&#12288;记" class="search" id="add" style="float: right;${(param.recTypeId eq resRecTypeEnumCaseRegistry.id || param.recTypeId eq resRecTypeEnumCampaignRegistry.id)?'':'display: none;'}" onclick="registry(null,null,null);"/>
					
						<ul id="tags">
			        		<li id="${resRecTypeEnumCaseRegistry.id}" class="selectTag" onclick="selTag(this);loadRequireDataList('${resRecTypeEnumCaseRegistry.id}');">
			        			<a href="#">${resRecTypeEnumCaseRegistry.typeName}</a>
			        		</li>
			        		<li id="${resRecTypeEnumDiseaseRegistry.id}" onclick="selTag(this);loadRequireDataList('${resRecTypeEnumDiseaseRegistry.id}');">
			        			<a href="#">${resRecTypeEnumDiseaseRegistry.typeName}</a>
			        		</li>
			        		<li id="${resRecTypeEnumOperationRegistry.id}" onclick="selTag(this);loadRequireDataList('${resRecTypeEnumOperationRegistry.id}');">
			        			<a href="#">${resRecTypeEnumOperationRegistry.typeName}</a>
			        		</li>
			        		<li id="${resRecTypeEnumSkillRegistry.id}" onclick="selTag(this);loadRequireDataList('${resRecTypeEnumSkillRegistry.id}');">
			        			<a href="#">${resRecTypeEnumSkillRegistry.typeName}</a>
			        		</li>
			        		<li id="${resRecTypeEnumCampaignRegistry.id}" onclick="selTag(this);loadRequireDataList('${resRecTypeEnumCampaignRegistry.id}');">
			        			<a href="#">${resRecTypeEnumCampaignRegistry.typeName}</a>
			        		</li>
							<li id='${resRecTypeEnumAfterSummary.id}' onclick="selTag(this);loadRequireDataList('${resRecTypeEnumAfterSummary.id}');">
								<a href="#">${resRecTypeEnumAfterSummary.typeName}</a>
							</li>
						</ul>
							
						<div id="tagContent">
											         
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>