<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<script type="text/javascript">
function saveAudit(agreeFlag,satFlow){
	var tip =  agreeFlag=="${GlobalConstant.FLAG_Y}"?"审核通过":"退回";
	var url = "<s:url value='/srm/ach/sat/saveAudit'/>?agreeFlag=" + agreeFlag + "&satFlow=" + satFlow;
	jboxConfirm("确认"+tip+"?" ,  function(){
		jboxStartLoading();
		jboxPost(url , $('#auditForm').serialize() , function(resp){
			$("#auditList",window.parent.frames['mainIframe'].document).submit(); 
			window.parent.frames['mainIframe'].window.search();
			jboxClose();
			} , null , true);
	});
}
</script>
</head>
<body>
<div class="mainright">
    <div class="content">
		<div id="view" style="width: 900px;height: 100%"></div>
		<jsp:include page="edit.jsp">
            <jsp:param  name="editFlag" value="${GlobalConstant.FLAG_N}"/>
        </jsp:include>
		<h2>审核意见：</h2>
		<hr/>
		<form method="post" id="auditForm">
		<div align="center">
			<textarea id="auditContent" name="auditContent" style="width: 100%" rows="7"></textarea><br/><br/><br/>
		    <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_Y}','${sat.satFlow}')" type='button'  value='同&#12288;意' />&#12288;
			<input class='search' onclick="saveAudit('${GlobalConstant.FLAG_N}','${sat.satFlow}')" type='button' value='退&#12288;回'/>&#12288;
		</div>
		</form>
	</div>
</div> 
</body>
</html>