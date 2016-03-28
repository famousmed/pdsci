<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<head>
	<jsp:include page="/jsp/common/htmlhead.jsp">
		<jsp:param name="basic" value="true"/>
		<jsp:param name="jbox" value="true"/>
		<jsp:param name="jquery_form" value="false"/>
		<jsp:param name="jquery_ui_tooltip" value="true"/>
		<jsp:param name="jquery_ui_combobox" value="false"/>
		<jsp:param name="jquery_ui_sortable" value="false"/>
		<jsp:param name="jquery_cxselect" value="true"/>
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
	
	<script type="text/javascript" >
		function loadList(statusId){
			jboxLoad("loadList","<s:url value='/cnres/manage/audit'/>?statusId="+statusId,true);
		}
		
		function showTheList(){
			$("#auditList").show(0,function(){
				loadList('${userStatusEnumEaminActivated.id}');
			});
		}
	</script>
</head>
<body>
	<a href="javascript:;" onclick="showTheList();">报名审核</a>
	<div id="auditList" style="display:none;">
		<input type="button" value="待审核" onclick="loadList('${userStatusEnumReged.id}');">
		<input type="button" value="审核通过" onclick="loadList('${userStatusEnumActivated.id}');">
		<input type="button" value="审核不通过" onclick="loadList('${userStatusEnumDisActivated.id}');">
		<div id="loadList" style="border: solid 1px black;"></div>
	</div>
</body>
</html>