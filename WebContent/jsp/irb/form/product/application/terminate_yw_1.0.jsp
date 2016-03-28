<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script>
if ("${param.type}" == 'show') {
	$(document).ready(function(){
		hideButton();
	});
}
function hideButton() {
	$(":input[type='button'][showFlag!='${GlobalConstant.FLAG_Y }']").each(function(){
		$(this).hide();
	});
	$('input').attr("readonly","readonly");
	$('textarea').attr("readonly","readonly");
	$("select").attr("disabled", "disabled");
	$(":checkbox").attr("disabled", "disabled");
	$(":radio").attr("disabled", "disabled");
}

function saveForm(){
	jboxPost("<s:url value='/irb/researcher/saveApplication'/>?formFileName=${formFileName}",$('#initApplicationForm').serialize(),null,null,true);
}

function print(){
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumTerminateApplication.id}";
	window.location.href= url;
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

function doClose() {
	top.$.jBox.close('jbox-iframe');
}
</script> 
</head>
<body>
	<div class="mainright">
	<div class="content" align="center">
	<div style="margin-top: 5px;text-align: center;width: 100%;">
		<font size="3" ><b>暂停/终止研究报告</b></font>
	</div>
	<div class="title1 clearfix">
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
				<th colspan="4" style="text-align: left;">&nbsp;项目信息</th>
			</tr>		
      		<tr>
				<td width="20%" style="text-align: right;">项目名称：</td>
				<td width="30%" colspan="3">
					${proj.projName}
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">期类别：</td>
				<td width="30%">
					${proj.projSubTypeName }
				</td>
				<td width="20%" style="text-align: right;">项目来源：</td>
				<td width="30%">
					${proj.projDeclarer }
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">专业组：</td>
				<td width="30%">
					${proj.applyDeptName }
				</td>
				<td width="20%" style="text-align: right;">主要研究者：</td>
				<td width="30%">
					${proj.applyUserName }
				</td>
			</tr>
		</table>
</div>
<div class="title1 clearfix">
<form id="initApplicationForm" >
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th style="text-align: left;">&nbsp;一、一般信息</th>
      		</tr>	
      		<tr>
      			<td>●&#12288;研究开始日期：<input type="text" name="projStartTime" value="${formDataMap['projStartTime'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;研究暂停/终止日期：<input type="text" name="projEndTime" value="${formDataMap['projEndTime'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;二、受试者信息</th>
      		</tr>
      		<tr>
      			<td>●&#12288;合同研究总例数：<input type="text" name="patientCount" value="${formDataMap['patientCount']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;已入组例数：<input type="text" name="inPatientNum" value="${formDataMap['inPatientNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;完成观察例数：<input type="text" name="finishPatientNum" value="${formDataMap['finishPatientNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;提前退出例数：<input type="text" name="termiPatientNum" value="${formDataMap['termiPatientNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;严重不良事件例数：<input type="text" name="saeNum" value="${formDataMap['saeNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;已报告的严重不良事件例数：<input type="text" name="saeReportNum" value="${formDataMap['saeReportNum']}">
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;三、暂停/终止研究的原因</th>
      		</tr>
      		<tr>
      			<td><textarea name="termiProjReason" style="width: 100%;border: 0;min-height: 70px;" placeholder="请填写暂停/终止研究的原因">${formDataMap['termiProjReason'] }</textarea></td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;四、有序终止研究的程序</th>
      		</tr>
      		<tr>
      			<td>●&#12288;是否要求召回已完成研究的受试者进行随访：<input type="checkbox" id="termiProjProgram11" name="termiProjProgram1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram1'],'1')>-1 }">checked</c:if>><label for="termiProjProgram11">是</label>
      			&#12288;<input type="checkbox" id="termiProjProgram10" name="termiProjProgram1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram1'],'0')>-1 }">checked</c:if>><label for="termiProjProgram10">否</label> →请说明：
      			<input type="text" name="program1Explain" value="${formDataMap['program1Explain']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否通知在研的受试者，研究已经提前终止：<input type="checkbox" id="termiProjProgram21" name="termiProjProgram2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram2'],'1')>-1 }">checked</c:if>><label for="termiProjProgram21">是</label>
      			&#12288;<input type="checkbox" id="termiProjProgram20" name="termiProjProgram2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram2'],'0')>-1 }">checked</c:if>><label for="termiProjProgram20">否</label> →请说明：
      			<input type="text" name="program2Explain" value="${formDataMap['program2Explain']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;在研受试者是否提前终止研究：<input type="checkbox" id="termiProjProgram31" name="termiProjProgram3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram3'],'1')>-1 }">checked</c:if>><label for="termiProjProgram31">是</label>
      			&#12288;<input type="checkbox" id="termiProjProgram30" name="termiProjProgram3" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram3'],'0')>-1 }">checked</c:if>><label for="termiProjProgram30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;提前终止研究受试者的后续医疗与随访安排：<input type="checkbox" id="termiProjProgram41" name="termiProjProgram4" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram4'],'1')>-1 }">checked</c:if>><label for="termiProjProgram41">转入常规医疗</label>
      			&#12288;<input type="checkbox" id="termiProjProgram40" name="termiProjProgram4" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['termiProjProgram4'],'0')>-1 }">checked</c:if>><label for="termiProjProgram40">有针对性地安排随访检查与后续治疗</label> →请说明：
      			<input type="text" name="program4Explain" value="${formDataMap['program4Explain']}">
      			</td>
      		</tr>
		</table>
		<div class="title1 clearfix">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<tr>
					<th width="20%" style="text-align: center;">申请人签字</th>
					<td width="30%">
						<input type="text" name="applyManName" value="${empty formDataMap['applyManName'] ?sessionScope.currUser.userName:formDataMap['applyManName']}">
					</td>
					<th width="20%" style="text-align: center;">日期</th>
					<td width="30%">
						<input type="text" name="applyDate" value="${empty formDataMap['applyDate']?pdfn:getCurrDate():formDataMap['applyDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					</td>
				</tr>
			</table>
		</div>
</form>
</div>
<div class="button" >
	<c:if test="${sessionScope.currIrb.irbStageId==irbStageEnumApply.id || 'edit' eq param.operType}">
		<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
	</c:if>
	<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
	<c:if test="${param.open==GlobalConstant.FLAG_Y && param.showType != 'messager'}">
		<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
	</c:if>
</div>
</div></div>
</body>
</html>