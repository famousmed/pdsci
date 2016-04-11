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
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumFinishApplication.id}";
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
		<font size="3"><b>结题报告</b></font>
	</div>
	<div class="title1 clearfix">
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
				<th width="20%">项目名称：</th>
				<td width="30%" colspan="3">
					${proj.projName}
				</td>
			</tr>
			<tr>
				<th width="20%">期类别：</th>
				<td width="30%" colspan="3">
					${proj.projSubTypeName }
				</td>
			</tr>
			<tr>
				<th width="20%">项目来源：</th>
				<td width="30%" colspan="3">
					${proj.projDeclarer }
				</td>
			</tr>
			<tr>
				<th width="20%">专业组：</th>
				<td width="30%">
					${proj.applyDeptName }
				</td>
				<th width="20%">主要研究者：</th>
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
      			<th style="text-align: left;">&nbsp;一、受试者信息</th>
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
      			<th style="text-align: left;">&nbsp;二、研究情况</th>
      		</tr>
      		<tr>
      			<td>●&#12288;研究开始日期：<input type="text" name="projStartTime" value="${formDataMap['projStartTime'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;最后完成日期：<input type="text" name="projEndTime" value="${formDataMap['projEndTime'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否存在于研究干预相关的、非预期的严重不良事件：<input type="checkbox" name="researchProgress1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'1')>-1 }">checked</c:if>>是
      				&#12288;<input type="checkbox" name="researchProgress1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'0')>-1 }">checked</c:if>>否
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;研究中是否存在影响受试者权益的问题：<input type="checkbox" name="researchProgress2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress2'],'0')>-1 }">checked</c:if>>否
      			&#12288;<input type="checkbox" name="researchProgress2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress2'],'1')>-1 }">checked</c:if>>是 →请说明：
      			<input type="text" name="progress2Explain" value="${formDataMap['progress2Explain']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;严重不良事件或方案规定必须报告的重要医学事件已经及时报告：<input type="checkbox" name="researchProgress3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress3'],'1')>-1 }">checked</c:if>>不适用
      				&#12288;<input type="checkbox" name="researchProgress3" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress3'],'2')>-1 }">checked</c:if>>是
      				&#12288;<input type="checkbox" name="researchProgress3" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress3'],'3')>-1 }">checked</c:if>>否
      			</td>
      		</tr>
		</table>
		<div class="title1 clearfix">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<tr>
					<th width="20%">申请人签字：</th>
					<td width="30%">
						<input type="text" name="applyManName" value="${empty formDataMap['applyManName'] ?sessionScope.currUser.userName:formDataMap['applyManName']}">
					</td>
					<th width="20%">日期：</th>
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