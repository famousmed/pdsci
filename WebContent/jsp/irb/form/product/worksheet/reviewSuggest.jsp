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
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function doClose(){
	jboxClose();
}

function toSuggest(){
	var title = window.parent.frames['mainIframe'].$("#${param.type}").val();
	var suggestObj = window.parent.frames['mainIframe'].$("#irbSuggest");
	if (suggestObj.val() == null || suggestObj.val() == '') {
		suggestObj.val(title+"\r\n"+$("#irbSuggest").val());
	} else {
		suggestObj.val(suggestObj.val()+"\r\n"+title+"\r\n"+$("#irbSuggest").val());
	}
	suggestObj.keyup();
	jboxClose();
}

$(document).ready(function(){
	$("#title").html(window.parent.frames['mainIframe'].$("#${param.type}").val());
});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="saveForm">
		<table class="xllist nofix">
			<thead>
				<tr>
					<th style="text-align: left;" >&nbsp;<span id="title"></span></th>
				</tr>
				<tr>
					<td>
					<textarea id="irbSuggest" rows="6" style="width: 99.5%" class="text-input"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button" align="center">
			<input type="button" class="search" onclick="toSuggest();" value="添&#12288;加">
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
	</form>
	</div>
	</div>
</div>
</body>
</html>