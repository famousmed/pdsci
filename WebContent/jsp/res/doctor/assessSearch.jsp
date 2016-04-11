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
		<jsp:param name="jquery_validation" value="false"/>
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
			<li><a onclick="selectTag('<s:url value='/res/doc/userAssessList'/>?roleFlag=${roleFlag}',this);">考试查询</a></li>
	    </ul>
	    <div id="tagContent" class="divContent"></div>
	</div>
</div>
</body>
</html>