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
<script type="text/javascript">
	function saveSubject() {
		if(false==$("#subjectForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/exam/manage/subject/save'/>";
		var data = $('#subjectForm').serialize();
		jboxPost(url, data, function(resp) {
			window.parent.frames['mainIframe'].window.refreshParent();
			jboxClose();
		});
	}
</script>
</head>
<body>
<form id="subjectForm" style="height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr style="">
						<th>父节点名称：</th>
						<td colspan="3">
							<input type="hidden" name="subjectFlow" value="${subject.subjectFlow }">
							<input type="hidden" name="subjectParentFlow" value="${subjectParent.subjectFlow }">
							${subjectParent.memo }
						</td>
					</tr>
					<tr style="">
						<th>科目编号：</th>
						<td colspan="3">
							<input type="text" name="subjectCode" value="${subject.subjectCode}" class="validate[required] xltext">
						</td>
					</tr>
					<tr>
						<th>科目名称：</th>
						<td colspan="3">
							<input type="text" name="subjectName" value="${subject.subjectName }" class="validate[required] xltext">
						</td>
					</tr>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveSubject();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>