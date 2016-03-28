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
	function breakBlind() {
		if(false==$("#breakForm").validationEngine("validate")){
			return ;
		}
		if('${randomInfo.patient.patientCode}' != $("#patientCode").val()){
			jboxTip("受试者编号不匹配!");
			return;
		}
		if('${randomInfo.patient.patientBirthday}' != $("#patientBirthday").val()){
			jboxTip("受试者出生日期不匹配!");
			return;
		}
		if('${randomInfo.randomRec.drugPack}' != $("#drugPack").val()){
			jboxTip("药物编码不匹配!");
			return;
		}
		jboxConfirm("确认揭盲?",function(){
			jboxPost("<s:url value='/edc/random/breakBlind'/>?patientFlow=${param.patientFlow}",null,
					function(resp){
				if(resp.indexOf("${GlobalConstant.PROMPT_SUCCESSED}")>-1){
					if ("${param.source}" == "manage") {
						window.parent.frames['mainIframe'].window.location.href="<s:url value='/pub/patient/manage/${param.actionScope}?orgFlow=${param.orgFlow}'/>";
						jboxInfo(resp);
						jboxClose();
					} else {
						window.parent.frames['mainIframe'].location.reload(true);
						jboxInfo(resp);
						jboxClose();
					}
				} else {
					jboxInfo(resp);
				}
			},null,false);
		});
	}
	function doClose(){
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

<form id="breakForm" style="height: 100%" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0" align="center">				
				<table width="400" cellpadding="0" cellspacing="0" class="basic">	
					<tr>
						<th>确认受试者编号：</th>
						<td>
							<input type="text" name="patientCode" id="patientCode"  class="validate[required] "/>
						</td>  
					</tr>				
					<tr>
						<th>受试者出生日期：</th>
						<td>
							<input type="text" name="patientBirthday" id="patientBirthday" class="validate[required] " value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
						</td>  
					</tr>
					<tr>
						<th>药物编码：</th>
						<td>
							<input type="text" name="drugPack" id="drugPack" class="validate[required] "/>
						</td>  
					</tr>
					
				</table>
				<div class="button" style="width: 400px;">
					<input type="button" class="search" value="揭&#12288;盲" onclick="breakBlind();" />
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>