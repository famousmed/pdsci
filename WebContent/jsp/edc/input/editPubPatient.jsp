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
	function savePubPatient() {
		if(false==$("#form").validationEngine("validate")){
			return ;
		}
		jboxConfirm("确认入组该受试者？",  function() {
			jboxPost("<s:url value='/edc/input/savePubPatient'/>?patientFlow=${patientFlow}&patientTypeId=${patientType}", $('#form').serialize(), function(){
				if(window.parent.frames['mainIframe']){
					if ("${param.source}" == "manage") {
						window.parent.frames['mainIframe'].window.location.href="<s:url value='/pub/patient/manage/${param.actionScope}?orgFlow=${param.orgFlow}'/>";
						jboxClose();
					} else {
						window.parent.frames['mainIframe'].window.location.href="<s:url value='/edc/input/inputMain?patientScope=${patientScope}&patientType=${patientType}&patientFlow=${patientFlow}&visitFlow=${visitFlow}&inputOperFlow=${currOperFlow}&inputStatusId=${inputStatusId}'/>";
						jboxClose();
					}
				}
			},null,false);
		});
	}
	 function doClose(){
		 if ("input" == "${param.source}") {
			 window.parent.frames['mainIframe'].window.$("#patientFlow").val("${param.oldPatientFlow}");
		 }
		 jboxClose();
	 }
</script>
<style type="text/css">
.none {
	border-collapse: collapse;
	table-layout: fixed;
}

.none td {
	border: 0 none;
	border-collapse: collapse;
	padding-bottom: 3px;
	padding-top: 3px;
}
</style>
</head>
<body>
<form id="form" style="height: 100%" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0" align="center">				
				<table width="400" cellpadding="0" cellspacing="0" class="basic">	
					<tr>
						<th style="text-align: right" width="150px">受试者姓名：</th>
						<td >
							<input type="text" name="patientName" class="validate[required] text" value=""/>
						</td>
					</tr>
					<tr>
						<th style="text-align: right" width="150px">性&#12288;&#12288;别：</th>
						<td >
							<input id="${userSexEnumMan.id }" class="validate[required]" type="radio" name="sexId"  value="${userSexEnumMan.id }"/>
			                <label for="${userSexEnumMan.id }">${userSexEnumMan.name}</label>&#12288;
			                <input id="${userSexEnumWoman.id }" class="validate[required]" type="radio"  name="sexId" value="${userSexEnumWoman.id }" />
			                <label for="${userSexEnumWoman.id }">${userSexEnumWoman.name }</label>
						</td>
					</tr>
					<tr>
						<th style="text-align: right" width="150px">手机号码：</th>
						<td>
							<input type="text" name="patientPhone" value="" class="text"/>
						</td>
					</tr>
					<tr>
						<th style="text-align: right" width="150px">出生日期：</th>
						<td >
							<input type="text" id="patientBirthday" name="patientBirthday" class="validate[required] " value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
						</td>  
					</tr>
					<tr>
						<th style="text-align: right" width="150px">入组日期：</th>
						<td >
							<input type="text" name="inDate" class="validate[required] " value="${pdfn:getCurrDateTime('yyyy-MM-dd HH:mm:ss')}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
						</td>
					</tr>
				</table>
				<div class="button" style="width: 400px;">
					<input type="button" class="search" value="保&#12288;存" onclick="savePubPatient();"/>
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>