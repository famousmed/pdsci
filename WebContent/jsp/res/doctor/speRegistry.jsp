<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.noHead}">
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
</c:if>

<style type="text/css">
	#tags li{cursor: pointer;}
</style>

<script type="text/javascript">
	$(function(){
		$("#tags li:first a").click();
	});

	function selectTag(url,obj){
		$(".selectTag").removeClass("selectTag");
		$(obj).parent().addClass("selectTag");
		jboxLoad("tagContent",url,true);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content" style="height: 100%;">
		<div class="title1 clearfix">
		</div>
		
		<ul id="tags">
			<c:set value="res_registry_type_${globalRecTypeEnumEthics.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/rec/showRecForm'/>?recTypeId=${globalRecTypeEnumEthics.id }&operUserFlow=${doctor.doctorFlow}&roleFlag=${roleFlag}',this);">${globalRecTypeEnumEthics.name }</a></li>
			</c:if>
			
			<c:set value="res_registry_type_${globalRecTypeEnumDocument.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/rec/showRecForm'/>?recTypeId=${globalRecTypeEnumDocument.id }&operUserFlow=${doctor.doctorFlow}&roleFlag=${roleFlag}',this);">${globalRecTypeEnumDocument.name }</a></li>
			</c:if>
			
			<c:set value="res_registry_type_${globalRecTypeEnumAppraisal.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/rec/showRecForm'/>?recTypeId=${globalRecTypeEnumAppraisal.id }&operUserFlow=${doctor.doctorFlow}&roleFlag=${roleFlag}',this);">${globalRecTypeEnumAppraisal.name}</a></li>
			</c:if>
			
			<c:if test="${groupRoleEnumLeader.id eq doctor.groupRoleId}">
	    		<li><a onclick="selectTag('<s:url value='/res/doc/appraisalList'/>?doctorFlow=${doctor.doctorFlow}',this);">小组成员</a></li>
	    	</c:if>
	    	
			<c:set value="res_registry_type_${resRecTypeEnumAnnualTrainForm.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/doc/annualtrainShow?doctorFlow=${param.doctorFlow}'/>',this);">${resRecTypeEnumAnnualTrainForm.name}</a></li>
			</c:if>
			
			<c:set value="res_registry_type_${globalRecTypeEnumAnnualActivity.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/doc/speAbilityAssessList'/>?recTypeId=${globalRecTypeEnumAnnualActivity.id}&operUserFlow=${doctor.doctorFlow}&roleFlag=${roleFlag}',this);">${globalRecTypeEnumAnnualActivity.name}</a></li>
			</c:if>
			
			<c:set value="res_registry_type_${globalRecTypeEnumSpeAbilityAssess.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/doc/speAbilityAssessList'/>?recTypeId=${resRecTypeEnumSpeAbilityAssess.id}&operUserFlow=${doctor.doctorFlow}&roleFlag=${roleFlag}',this);">${globalRecTypeEnumSpeAbilityAssess.name}</a></li>
			</c:if>
			
			<c:set value="res_registry_type_${resRecTypeEnumRegistryCheckForm.id}" var="viewCfgKey"/>
			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y}">
				<li><a onclick="selectTag('<s:url value='/res/doc/speAbilityAssessList'/>?recTypeId=${resRecTypeEnumRegistryCheckForm.id}&operUserFlow=${doctor.doctorFlow}&roleFlag=${roleFlag}',this);">${globalRecTypeEnumRegistryCheckForm.name}</a></li>
			</c:if>
			
			
			
<%-- 			<li ><a onclick="selectTag('<s:url value='/res/rec/showRecForm'/>?recTypeId=${resRecTypeEnumAppraisal.id }&operUserFlow=${doctor.doctorFlow}',this);">实习档案</a></li> --%>
<%-- 			<c:if test="${groupRoleEnumLeader.id eq doctor.groupRoleId }"> --%>
<%-- 	    		<li><a onclick="selectTag('<s:url value='/res/doc/appraisalList'/>?doctorFlow=${doctor.doctorFlow}',this);">小组成员</a></li> --%>
<%-- 	    	</c:if> --%>
<%--     		<li><a onclick="selectTag('<s:url value='/res/doc/annualTrainForm'/>?doctorFlow=${doctor.doctorFlow}&roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}',this);">${resRecTypeEnumAnnualTrainForm.typeName}</a></li> --%>
	    </ul>
	    <div id="tagContent" class="divContent">
	    	
	    </div>
	</div>
</div>
</body>
</html>