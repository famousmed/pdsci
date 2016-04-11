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
	function savePatient() {
		if ($("#patient").validationEngine("validate")) {
			var url = "<s:url value='/gcp/researcher/editPatientSave'/>";
			var getdata = $('#patient').serialize();
			jboxPost(url, getdata, function(data) {
				if ('${GlobalConstant.SAVE_SUCCESSED}' == data) {
					window.parent.frames['mainIframe'].window.refresh('${param.type}');
					jboxClose();
				}
			});
		}
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<div style="margin-top: 5px;">
					<form id="patient">
					<input type="hidden" name="patientFlow" value="${patient.patientFlow}">
						<table class="xllist" style="width: 100%">
								<tr>
									<th colspan="10" style="text-align: left;padding-left: 10px">受试者信息</th>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 25px">
										姓&#12288;&#12288;名：
										<input type="text" class="validate[required]" name="patientName" value="${patient.patientName}" style="width: 100px"/>
										<font color="red" style="margin-left: 5px">*</font>
										<font style="margin-left: 20px">性别：</font>
										<label>
											<input type="radio" value="${userSexEnumMan.id}" ${patient.sexId eq userSexEnumMan.id?'checked="checked"':''} name="sexId" />${userSexEnumMan.name}
										</label>
										&nbsp;
										<label>
											<input type="radio" value="${userSexEnumWoman.id}" name="sexId" ${patient.sexId eq userSexEnumWoman.id?'checked="checked"':''} />${userSexEnumWoman.name}
										</label>
										<font color="red" style="margin-left: 5px">*</font>
										<font style="margin-left: 80px">年龄：</font>
										<input type="text" class="validate[required,custom[number]]" name="patientAge" value="${patient.patientAge}" style="width: 100px"/>
										<font color="red" style="margin-left: 5px">*</font>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 25px">
										联系方式：
										<input type="text" class="validate[custom[mobile]]" name="patientPhone" value="${patient.patientPhone}" style="width: 100px"/>
										<font style="margin-left: 35px">来源：</font>
										<label>
											<input type="radio" value="${patientSourceEnumOutPatient.id}" ${patient.patientSourceId eq patientSourceEnumOutPatient.id?'checked="checked"':''} name="patientSourceId" />${patientSourceEnumOutPatient.name}
										</label>
										&nbsp;
										<label>
											<input type="radio" value="${patientSourceEnumInPatient.id}" ${patient.patientSourceId eq patientSourceEnumInPatient.id?'checked="checked"':''} name="patientSourceId" />${patientSourceEnumInPatient.name}
										</label>
										<font style="margin-left: 25px">门诊/住院号：</font>
										<input type="text" name="patientNo" value="${patient.patientNo}" style="width: 100px"/>
									</td>
								</tr>
						</table>
					</form>
				</div>
				<div style="text-align: center; margin-top: 10px;">
					<input type="button" class="search" value="保&#12288;存" onclick="savePatient();" />
					<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>