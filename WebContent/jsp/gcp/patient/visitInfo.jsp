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
	<jsp:param name="jquery_cxselect" value="false" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="jquery_fixedtable" value="true" />
</jsp:include>

<script type="text/javascript">
	var title = {
			"labExam":"理化检查",
			"advice":"医嘱",
			"doctorExplain":"医生说明",
	};
	
	$(function(){
		$("#contentTh").text(title['${param.infoType}']);
	});
	
	function save(){
		var url = "<s:url value='/gcp/researcher/saveVisitInfo'/>";
		var getdata = $('#visitInfo').serialize();
		jboxPost(url, getdata, function(data) {
			if ('${GlobalConstant.SAVE_SUCCESSED}' == data) {
				window.parent.frames['mainIframe'].window.refresh("${param.infoType}");
				jboxClose();
			}
		});
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
				<div style="margin-top: 10px;">
					<form id="visitInfo">
						<input type="hidden" name="recordFlow" value="${param.recordFlow}"/>
						<input type="hidden" name="infoType" value="${param.infoType}"/>
						<table class="basic" style="width: 100%">
							<tr>
								<th id="contentTh" style="padding-left:10px;text-align: left"></th>
							</tr>
							<tr>
								<td style="padding-left: 5px;padding-right: 10px">
									<textarea class="xltxtarea" name="infoContent">${infoContent}</textarea>
								</td>
							</tr>
						</table>
					</form>
				<div style="text-align: center; margin-top: 10px;">
					<input type="button" class="search" value="保&#12288;存" onclick="save();" />
					<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>