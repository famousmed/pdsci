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
function doClose(){
	jboxClose();
}

function offPatient() {
	if(false==$("#saveForm").validationEngine("validate")){
		return ;
	}
	jboxConfirm("确认该受试者脱落？",  function() {
		jboxPost( "<s:url value='/pub/patient/changePatientStage?patientFlow=${patient.patientFlow}'/>&patientStageId=${patientStageEnumOff.id}",$('#saveForm').serialize(),function(resp){
			if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.location.href="<s:url value='/pub/patient/manage/${param.actionScope}?orgFlow=${param.orgFlow}'/>";
				jboxClose();
			}
		},null,true);
	});
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="saveForm">
		<table class="xllist nofix">
				<tr>
					<th style="text-align: left;" >&nbsp;脱落原因</th>
				</tr>
				<tr>
					<td>
					<textarea name="patientStageNote" rows="6" placeholder="请填写脱落原因" style="width: 99.5%" class="text-input validate[required,maxSize[1000]]">${patient.patientStageNote }</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="button" align="center">
			<c:if test="${patientStageEnumIn.id eq patient.patientStageId }">
				<input type="button" class="search" onclick="offPatient();" value="保&#12288;存">
			</c:if>
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</div>
	</form>
	</div>
	</div>
	</div>
</body>
</html>