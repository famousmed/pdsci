<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="true" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="ueditor" value="true"/>
</jsp:include>

<script type="text/javascript">
	function defaultImg(img){
		img.src="<s:url value='/jsp/edu/css/images/up-pic.jpg'/>";
	}
	
	function opRec(recFlow,schDeptFlow, rotationFlow, userFlow, schResultFlow,typeId,typeName){
		var url = "<s:url value='/res/rec/showRegistryForm'/>"+
				"?schDeptFlow="+schDeptFlow+
				"&rotationFlow="+rotationFlow+
				"&recTypeId="+typeId+"&userFlow="+userFlow+
				"&roleFlag=${roleFlag}&openType=open"+
				"&resultFlow="+schResultFlow+
				"&recFlow="+recFlow;
		jboxOpen(url, typeName, 1000, 500);
	}
	
	function selTag(li,recTypeId){
		$(".selectTag").removeClass("selectTag");
		$(li).addClass("selectTag");
		
		loadGlobalRec(recTypeId);
	}
	
	function loadGlobalRec(recTypeId){
		var data = null;
		if($("#searchForm").length!=null){
			data = $("#searchForm").serialize();
		}
		jboxPost("<s:url value='/res/teacher/globalRegAuditList'/>?roleFlag=${roleFlag}&operUserFlow=${doctor.doctorFlow}&recTypeId="+recTypeId,data,function(resp){
			$("#tagContent").html(resp);
		},null,false);
	}
	$(function(){
		$("#tags li:first").click();
	});
</script>

</head>
<body>
<div class="mainright">
	<div class="content">
		<ul id="tags" style="margin-top: 20px;">
			<c:set var="showKey" value="res_registry_type_${registryTypeEnumAnnualTrainForm.id}"/>
			<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[showKey]}">
				<li style="cursor: pointer;" onclick="selTag(this,'${registryTypeEnumAnnualTrainForm.id}');">
					<a>${registryTypeEnumAnnualTrainForm.name}</a>
				</li>
			</c:if>
			<c:forEach items="${globalRecTypeEnumList}" var="globalRec">
				<c:set var="showKey" value="res_registry_type_${globalRec.id}"/>
				<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap[showKey] && pdfn:contains(globalRec.auditScope,roleFlag)}">
					<li style="cursor: pointer;" onclick="selTag(this,'${globalRec.id}');">
						<a>${globalRec.name}</a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
		<div id="tagContent"></div>
		</div>
</div>
</body>
</html>
