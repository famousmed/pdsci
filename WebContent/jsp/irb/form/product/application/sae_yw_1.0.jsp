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
if ("${param.type}" == 'show' || "${param.editFlag}" == "${GlobalConstant.FLAG_N}") {
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
	if("${param.type}" == "GCP"){
		var url = "<s:url value='/gcp/researcher/savePatientAe'/>?formFileName=${formFileName}";
		jboxPost(url,$('#initApplicationForm').serialize(), 
				function(recordFlow){
					if(recordFlow != ""){
						jboxTip("保存成功！");
						//var url = "<s:url value='/gcp/researcher/editAe'/>?type=GCP&patientFlow=${param.patientFlow}&orgFlow=${param.orgFlow}&patientCode=${param.patientCode}&patientNamePy=${param.patientNamePy}&visitFlow=${param.visitFlow}&recordFlow=" + recordFlow;
						//window.location.href = url;
					}
				},null,false);
	}else{
		jboxPost("<s:url value='/irb/researcher/saveApplication'/>?formFileName=${formFileName}",$('#initApplicationForm').serialize(),null,null,true);
	}
}

function print(){
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumSaeApplication.id}&recordFlow=${param.recordFlow}";
	window.location.href= url;
}

function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}

function back(){
	if("${param.recordFlow}" == ""){
		jboxConfirm("信息尚未保存，确认返回？" , function(){
			doBack();
		});
	}else{
		doBack();
	}
}

function doBack(){
	var url = "";
	if(${!empty param.visitFlow}){
		url = "<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${param.patientFlow}&visitFlow=${param.visitFlow}&infoType=ae";
	}else{
		if("${param.backFlag}" == "${GlobalConstant.FLAG_N}"){
			url ="<s:url value='/gcp/researcher/visit'/>" 
		}else{
			url = "<s:url value='/gcp/researcher/aeList'/>?type=GCP&patientFlow=${param.patientFlow}&orgFlow=${param.orgFlow}&patientCode=${param.patientCode}&patientNamePy=${param.patientNamePy}";
		}
	}
	
	window.location.href = url;
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
		<font size="3" ><b>严重不良事件报告表</b></font>
	</div>
<div class="title1 clearfix">
<form id="initApplicationForm" >
		<input type="hidden" name="recordFlow" value="${param.recordFlow}"/>
		<input type="hidden" name="patientFlow" value="${param.patientFlow}"/>
		<input type="hidden" name="orgFlow" value="${param.orgFlow}"/>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;试验相关资料</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">研究药物名称</td>
      			<td colspan="3">
      				<input type="text" name="drugName" style="width: 500px;" value="${formDataMap['drugName'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">研究药物分类</td>
      			<td colspan="3">
	      			<input type="checkbox" id="drugCategory1" name="drugCategory" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugCategory'],'1')>-1 }">checked</c:if>><label for="drugCategory1">中药</label>
	      			&#12288;<input type="checkbox" id="drugCategory2" name="drugCategory" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugCategory'],'2')>-1 }">checked</c:if>><label for="drugCategory2">化学药品</label>
	      			&#12288;<input type="checkbox" id="drugCategory3" name="drugCategory" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugCategory'],'3')>-1 }">checked</c:if>><label for="drugCategory3">预防用生物制品</label>
	      			&#12288;<input type="checkbox" id="drugCategory4" name="drugCategory" value="4" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugCategory'],'4')>-1 }">checked</c:if>><label for="drugCategory4">治疗用生物制品</label>
	      			&#12288;<input type="checkbox" id="drugCategory5" name="drugCategory" value="5" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugCategory'],'5')>-1 }">checked</c:if>><label for="drugCategory5">其它</label>
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">临床试验批准文号</td>
      			<td colspan="3">
      				<input type="text" name="irbNo" style="width: 500px;" value="${formDataMap['irbNo'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">研究分类</td>
      			<td colspan="3">
	      			<input type="checkbox" id="projSubType1" name="projSubType" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['projSubType'],'1')>-1 }">checked</c:if>><label for="projSubType1">Ⅰ期</label>
	      			&#12288;<input type="checkbox" id="projSubType2" name="projSubType" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['projSubType'],'2')>-1 }">checked</c:if>><label for="projSubType2">Ⅱ期</label>
	      			&#12288;<input type="checkbox" id="projSubType3" name="projSubType" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['projSubType'],'3')>-1 }">checked</c:if>><label for="projSubType3">Ⅲ期</label>
	      			&#12288;<input type="checkbox" id="projSubType4" name="projSubType" value="4" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['projSubType'],'4')>-1 }">checked</c:if>><label for="projSubType4">Ⅳ期</label>
	      			&#12288;<input type="checkbox" id="projSubType5" name="projSubType" value="5" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['projSubType'],'5')>-1 }">checked</c:if>><label for="projSubType5">生物等效性试验</label>
      				&#12288;<input type="checkbox" id="projSubType6" name="projSubType" value="6" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['projSubType'],'6')>-1 }">checked</c:if>><label for="projSubType6">其它</label>
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">&nbsp;<input type="checkbox" id="reportType1" name="reportType" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reportType'],'1')>-1 }">checked</c:if>><label for="reportType1">首次报告</label>
      			（日期：<input type="text" name="firstReportDate" value="${formDataMap['firstReportDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />）
      			&#12288;<input type="checkbox" id="reportType2" name="reportType" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reportType'],'2')>-1 }">checked</c:if>><label for="reportType2">随访报告</label>
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;申办单位</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">申办单位名称</td>
      			<td colspan="3">
      				<input type="text" name="projDeclarer" style="width: 500px;" value="${formDataMap['projDeclarer'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">申办单位地址</td>
      			<td colspan="3">
      				<input type="text" name="projDeclarerAddress" style="width: 500px;" value="${formDataMap['projDeclarerAddress'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">电话</td>
      			<td width="32%">
      				<input type="text" name="projDeclarerPhone" value="${formDataMap['projDeclarerPhone'] }">
      			</td>
      			<td style="text-align: center;" width="14%">传真</td>
      			<td width="32%">
      				<input type="text" name="projDeclarerFax" value="${formDataMap['projDeclarerFax'] }">
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;研究单位</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">研究机构名称</td>
      			<td colspan="3">
      				<input type="text" name="applyOrgName" style="width: 500px;" value="${formDataMap['applyOrgName'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">研究机构地址</td>
      			<td colspan="3">
      				<input type="text" name="applyOrgAddress" style="width: 500px;" value="${formDataMap['applyOrgAddress'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">电话</td>
      			<td width="32%">
      				<input type="text" name="applyOrgPhone" value="${formDataMap['applyOrgPhone'] }">
      			</td>
      			<td style="text-align: center;" width="14%">传真</td>
      			<td width="32%">
      				<input type="text" name="applyOrgFax" value="${formDataMap['applyOrgFax'] }">
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;受试者</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">姓名拼音首字母缩写</td>
      			<td colspan="3">
      				<input type="text" name="patientNamePy" value="${formDataMap['patientNamePy'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">受试者（药物/随机）编码</td>
      			<td colspan="3">
      				<input type="text" name="patientCode" value="${formDataMap['patientCode'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">出生日期</td>
      			<td colspan="3">
      				<input type="text" name="patientBirthday" value="${formDataMap['patientBirthday'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">性别</td>
      			<td colspan="3">
      				<input type="checkbox" id="patientSex1" name="patientSex" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['patientSex'],'1')>-1 }">checked</c:if>><label for="patientSex1">男</label>
      				&#12288;<input type="checkbox" id="patientSex2" name="patientSex" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['patientSex'],'2')>-1 }">checked</c:if>><label for="patientSex2">女</label>
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">体重</td>
      			<td colspan="3">
      				<input type="text" name="patientWeight" value="${formDataMap['patientWeight'] }">公斤
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">身高</td>
      			<td colspan="3">
      				<input type="text" name="patientHeight" value="${formDataMap['patientHeight'] }">厘米
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;SAE分类</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">&nbsp;<input type="checkbox" id="aeResult1" name="aeResult" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeResult'],'1')>-1 }">checked</c:if>><label for="aeResult1">住院</label>
      			&#12288;<input type="checkbox" id="aeResult2" name="aeResult" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeResult'],'2')>-1 }">checked</c:if>><label for="aeResult2">延长住院时间</label>
      			&#12288;<input type="checkbox" id="aeResult3" name="aeResult" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeResult'],'3')>-1 }">checked</c:if>><label for="aeResult3">致畸</label>
      			&#12288;<input type="checkbox" id="aeResult4" name="aeResult" value="4" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeResult'],'4')>-1 }">checked</c:if>><label for="aeResult4">危及生命</label>
      			&#12288;<input type="checkbox" id="aeResult5" name="aeResult" value="5" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeResult'],'5')>-1 }">checked</c:if>><label for="aeResult5">永久或严重致残</label>
      			&#12288;<input type="checkbox" id="aeResult6" name="aeResult" value="6" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeResult'],'6')>-1 }">checked</c:if>><label for="aeResult6">其他重要医学事件</label>
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">&nbsp;<input type="checkbox" id="isDead1" name="isDead" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isDead'],'1')>-1 }">checked</c:if>><label for="isDead1">死亡</label>
      			&#12288;死亡时间：<input type="text" name="deathTime" value="${formDataMap['deathTime'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;SAE名称及描述</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">SAE名称</td>
      			<td colspan="3">
      				<input type="text" name="saeName" placeholder="(如可能，请做出诊断，并使用专业术语)" style="width: 500px;" value="${formDataMap['saeName'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">SAE是否预期</td>
      			<td colspan="3">
      				<input type="checkbox" id="saeExpected0" name="saeExpected" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['saeExpected'],'0')>-1 }">checked</c:if>><label for="saeExpected0">否</label>
      				&#12288;<input type="checkbox" id="saeExpected1" name="saeExpected" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['saeExpected'],'1')>-1 }">checked</c:if>><label for="saeExpected1">是</label>（已在临床试验方案/知情同意书中说明）
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">SAE发生时间</td>
      			<td colspan="3">
      				<input type="text" name="saeStartDate" value="${formDataMap['saeStartDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">SAE获知日期</td>
      			<td colspan="3">
      				<input type="text" name="saeInfromedDate" value="${formDataMap['saeInfromedDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">SAE描述</td>
      			<td colspan="3">
      				<input type="text" name="saeDescription" style="width: 500px;" value="${formDataMap['saeDescription'] }">
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;可能与SAE有关的药物（如非药物因素导致SAE，此栏内容可不填）</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">可能与SAE有关的药物名称</td>
      			<td colspan="3">
      				<input type="text" name="relatedDrugName" style="width: 500px;" value="${formDataMap['relatedDrugName'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">该药物属于本临床试验的</td>
      			<td colspan="3">
      				<input type="checkbox" id="drugType1" name="drugType" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugType'],'1')>-1 }">checked</c:if>><label for="drugType1">研究用药</label>
      				（如果非盲/破盲：<input type="checkbox" id="drugGroup1" name="drugGroup" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugGroup'],'1')>-1 }">checked</c:if>><label for="drugGroup1">试验药物</label>
      					&#12288;<input type="checkbox" id="drugGroup2" name="drugGroup" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugGroup'],'2')>-1 }">checked</c:if>><label for="drugGroup2">对照药物</label>
      				）
      				&#12288;<input type="checkbox" id="drugType2" name="drugType" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['drugType'],'2')>-1 }">checked</c:if>><label for="drugType2">伴随用药</label>
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">该药物适应症</td>
      			<td colspan="3">
      				<input type="text" name="drugIndications" style="width: 500px;" value="${formDataMap['drugIndications'] }">
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">首次用药至SAE发生的时间</td>
      			<td colspan="3">
      				<input type="text" name="firstDateToSaeD" style="width: 80px;" value="${formDataMap['firstDateToSaeD'] }">天
      				（如果能够精确计算：<input type="text" name="firstDateToSaeH" style="width: 80px;" value="${formDataMap['firstDateToSaeH'] }">时
      				<input type="text" name="firstDateToSaeM" style="width: 80px;" value="${formDataMap['firstDateToSaeM'] }">分）
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" width="22%">末次用药至SAE发生的时间</td>
      			<td colspan="3">
      				<input type="text" name="lastDateToSaeD" style="width: 80px;" value="${formDataMap['lastDateToSaeD'] }">天
      				（如果能够精确计算：<input type="text" name="lastDateToSaeH" style="width: 80px;" value="${formDataMap['lastDateToSaeH'] }">时
      				<input type="text" name="lastDateToSaeM" style="width: 80px;" value="${formDataMap['lastDateToSaeM'] }">分）
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;SAE与研究用药的关系（因果关系）</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">&nbsp;<input type="checkbox" id="aeRelations1" name="aeRelations" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeRelations'],'1')>-1 }">checked</c:if>><label for="aeRelations1">无关</label>
      			&#12288;<input type="checkbox" id="aeRelations2" name="aeRelations" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeRelations'],'2')>-1 }">checked</c:if>><label for="aeRelations2">可能无关</label>
      			&#12288;<input type="checkbox" id="aeRelations3" name="aeRelations" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeRelations'],'3')>-1 }">checked</c:if>><label for="aeRelations3">可能有关</label>
      			&#12288;<input type="checkbox" id="aeRelations4" name="aeRelations" value="4" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeRelations'],'4')>-1 }">checked</c:if>><label for="aeRelations4">很可能有关</label>
      			&#12288;<input type="checkbox" id="aeRelations5" name="aeRelations" value="5" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeRelations'],'5')>-1 }">checked</c:if>><label for="aeRelations5">有关</label>
      			&#12288;<input type="checkbox" id="aeRelations6" name="aeRelations" value="6" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeRelations'],'6')>-1 }">checked</c:if>><label for="aeRelations6">现有信息无法判断</label>
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;采取的措施</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">&nbsp;<input type="checkbox" id="aeMeasures1" name="aeMeasures" value="1" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'1')>-1 }">checked</c:if>><label for="aeMeasures1">无</label>
      			&#12288;<input type="checkbox" id="aeMeasures2" name="aeMeasures" value="2" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'2')>-1 }">checked</c:if>><label for="aeMeasures2">调整研究用药剂量</label>
      			&#12288;<input type="checkbox" id="aeMeasures3" name="aeMeasures" value="3" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'3')>-1 }">checked</c:if>><label for="aeMeasures3">暂停研究用药</label>
      			&#12288;<input type="checkbox" id="aeMeasures4" name="aeMeasures" value="4" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'4')>-1 }">checked</c:if>><label for="aeMeasures4">停用研究用药</label>
      			&#12288;<input type="checkbox" id="aeMeasures5" name="aeMeasures" value="5" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'5')>-1 }">checked</c:if>><label for="aeMeasures5">停用伴随用药</label>
      			&#12288;<input type="checkbox" id="aeMeasures6" name="aeMeasures" value="6" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'6')>-1 }">checked</c:if>><label for="aeMeasures6">增加新的治疗药物</label>
      			&#12288;<input type="checkbox" id="aeMeasures7" name="aeMeasures" value="7" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'7')>-1 }">checked</c:if>><label for="aeMeasures7">应用非药物治疗</label>
      			&#12288;<input type="checkbox" id="aeMeasures8" name="aeMeasures" value="8" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'8')>-1 }">checked</c:if>><label for="aeMeasures8">延长住院时间</label>
      			&#12288;<input type="checkbox" id="aeMeasures9" name="aeMeasures" value="9" <c:if test="${fn:indexOf(formDataMap['aeMeasures'],'9')>-1 }">checked</c:if>><label for="aeMeasures9">修改方案/知情同意书</label>
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;转归</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">&nbsp;<input type="checkbox" id="aeOutcome1" name="aeOutcome" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeOutcome'],'1')>-1 }">checked</c:if>><label for="aeOutcome1">完全痊愈</label>
      			&#12288;<input type="checkbox" id="aeOutcome2" name="aeOutcome" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeOutcome'],'2')>-1 }">checked</c:if>><label for="aeOutcome2">症状改善</label>
      			&#12288;<input type="checkbox" id="aeOutcome3" name="aeOutcome" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeOutcome'],'3')>-1 }">checked</c:if>><label for="aeOutcome3">症状恶化</label>
      			&#12288;<input type="checkbox" id="aeOutcome4" name="aeOutcome" value="4" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeOutcome'],'4')>-1 }">checked</c:if>><label for="aeOutcome4">痊愈，有后遗症</label>
      			&#12288;<input type="checkbox" id="aeOutcome5" name="aeOutcome" value="5" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeOutcome'],'5')>-1 }">checked</c:if>><label for="aeOutcome5">症状无变化</label>
      			&#12288;<input type="checkbox" id="aeOutcome6" name="aeOutcome" value="6" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['aeOutcome'],'6')>-1 }">checked</c:if>><label for="aeOutcome6">死亡</label>
      			</td>
      		</tr>
      		<tr>
      			<td style="text-align: left;" colspan="4">尸检：
      				<input type="checkbox" id="isAutopsy0" name="isAutopsy" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isAutopsy'],'0')>-1 }">checked</c:if>><label for="isAutopsy0">否</label>
      				&#12288;<input type="checkbox" id="isAutopsy1" name="isAutopsy" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isAutopsy'],'1')>-1 }">checked</c:if>><label for="isAutopsy1">是</label>（请附尸检报告）
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;不良事件详细内容</th>
      		</tr>	
      		<tr>
      			<td colspan="4"><textarea style="width: 100%;border: 0;min-height: 90px;" name="aeDetail" placeholder="请填写不良事件详细内容">${formDataMap['aeDetail'] }</textarea></td>
      		</tr>
      		<tr>
      			<th style="text-align: left;" colspan="4">&nbsp;报告</th>
      		</tr>
      		<tr>
				<td style="text-align: left;" width="22%">报告人签字</td>
				<td colspan="3">
					<input type="text" name="reportManName" value="${empty formDataMap['reportManName'] ?sessionScope.currUser.userName:formDataMap['reportManName']}">
				</td>
			</tr>
			<tr>
				<td style="text-align: left;" width="22%">本次报告日期</td>
				<td colspan="3">
					<input type="text" name="reportDate" value="${empty formDataMap['reportDate']?pdfn:getCurrDate():formDataMap['reportDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				</td>
			</tr>	
		</table>
</form>
</div>
<div class="button" >
	<c:if test="${sessionScope.currIrb.irbStageId==irbStageEnumApply.id || 'edit' eq param.operType || param.type eq 'GCP'}">
		<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
	</c:if>
	<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
	<c:if test="${(param.open==GlobalConstant.FLAG_Y && param.showType != 'messager') || param.editFlag eq GlobalConstant.FLAG_N}">
		<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y}" value="关&#12288;闭" onclick="doClose();" />
	</c:if>
	<c:if test="${param.type eq 'GCP'}">
		<input class="search" type="button" value="返&#12288;回" onclick="back();" />
	</c:if>
</div>
</div></div>
</body>
</html>