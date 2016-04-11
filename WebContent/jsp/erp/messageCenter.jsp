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
	function showTodo(){
		$("li").removeClass("selectTag");
		$("#showTodo").parent().addClass("selectTag");
		jboxGet('<s:url value='/erp/crm/showTodo'/>',null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
		},null,false);
	}
	
	$(document).ready(function(){
		$("li a:first").click();
	});
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div>
				<fieldset style="">
 					<legend>公告</legend>
 					<span>今天中午12点更新系统，请大家及时保存数据！</span>
				</fieldset>
				</div>
				<div>
					<ul id="tags">
					<li class="selectTag" >
						<a id="showTodo" onclick="showTodo();" href="javascript:void(0)">待办事项</a>
					</li>
					</ul>
				<div id="tagContent">
					<div class="tagContent selectTag" id="tagContent" style="margin-top: 5px">
					</div>
				</div>
			</div>
		</div>
		</div></div>
	</body>
</html>