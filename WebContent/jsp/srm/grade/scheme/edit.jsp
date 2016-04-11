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
</jsp:include>
<script type="text/javascript">
	function saveGradeScheme() {
		if(false==$("#srmGradeScheme").validationEngine("validate")){
			return ;
		}
		var url = '<s:url value="/srm/grade/scheme/saveGradeScheme"/>';
		jboxStartLoading();
		jboxPost(url , $('#srmGradeScheme').serialize() , function(){
			$("#searchGradeScheme",window.parent.frames['mainIframe'].document).submit();
			doClose();
		} , null , true);
	}
	function doClose() {
		jboxClose();
	}
</script>
</head>
<body>
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
			<form id="srmGradeScheme" action="<s:url value="/srm/grade/scheme/save"/>">
				<table class="basic" width="500px;">
					<tr>
						<th width="100px">方案名称：</th>
						<td>
							<input class="validate[required] xltext" name="schemeName" type="text"	value="${srmGradeScheme.schemeName }" />
						</td>
					</tr>
					<tr>
						<th width="200px">适用范围：</th>
						<td>
							<input type="radio" class="validate[required]" name="evaluationId" value="${evaluationEnumApproveEvaluation.id}"
							<c:if test='${srmGradeScheme.evaluationId==evaluationEnumApproveEvaluation.id}'> checked="checked"</c:if> />${evaluationEnumApproveEvaluation.name}
							<input type="radio" class="validate[required]" name="evaluationId" value="${evaluationEnumCompleteEvaluation.id}"
							<c:if test='${srmGradeScheme.evaluationId==evaluationEnumCompleteEvaluation.id}'> checked="checked"</c:if> />${evaluationEnumCompleteEvaluation.name}
						</td>
					</tr>
				</table>
				<div class="button" style="width: ;">
					<input type="hidden" name="schemeFlow" value="${srmGradeScheme.schemeFlow }" />
					<input type="button" class="search" onclick="saveGradeScheme();" value="保&#12288;存"/>
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
				</div>
			</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>