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
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
</head>
<script type="text/javascript">
function addVisit(){
	jboxConfirm("确认新增访视？" , function(){
		jboxGet("<s:url value='/edc/visit/addVisit'/>",null,function(resp){
			refresh();
		},null,true)});
	
}
function showVisit(){
	jboxGet("<s:url value='/edc/visit/showVisit'/>",null,function(resp){
		$("#visitDiv").html(resp);			
	},null,false);	
}
function refresh(){
	if($("#view1").is(":visible")){
		showVisit();
	}else {
		showVisitTable();
	}
}
function showVisitTable(){
	jboxGet("<s:url value='/edc/visit/showVisitTable'/>",null,function(resp){
		$("#visitDiv").html(resp);					
	},null,false);	
}
$(document).ready(function(){
	showVisitTable();
});
function changeView(){
	if($("#view1").is(":visible")){
		$("#view1").hide();
		$("#view2").show();
		showVisitTable();
	}else {
		$("#view2").hide();
		$("#view1").show();
		showVisit();
	}
}
function visitManage(){
	jboxOpen("<s:url value='/edc/visit/visitManage'/>", "访视维护", 800, 600);
}
function designManage(){
	jboxGet("<s:url value='/edc/visit/designManage'/>",null,function(resp){
		$("#visitDiv").html(resp);				
	},null,false);	
}
</script>
<body>

<div class="title1 clearfix"> 
<!-- 
     			<input type="button" id="view1" onclick="changeView();" value="表格模式" class="search" style="display: none"/>
     			<input type="button" id="view2" onclick="changeView();" value="列表模式" class="search" />
     			<input type="button" id="addBtn" onclick="addVisit();" value="新增访视" class="search" /> 
     			<input type="button" id="addBtn" onclick="visitManage();" value="访视维护" class="search" />
     			<input type="button" id="addBtn" onclick="designManage();" value="设计维护" class="search" /> 
-->
</div>
<div class="mainright">
		<div class="content">
<div id="visitDiv" style="width: 100%;height: 100%;">
            	
</div>
</div></div>
</body>
</html>