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
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumViolateApplication.id}";
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
		<font size="3" ><b>违背方案报告</b></font>
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
      			<th style="text-align: left;">&nbsp;一、违背方案的情况</th>
      		</tr>
      		<tr>
      			<td style="text-align: left;">&nbsp;重大违背方案</td>
      		</tr>	
      		<tr>
      			<td>&#12288;&#12288;●&#12288;纳入不符合纳入标准的受试者：<input type="checkbox" id="majorViolation11" name="majorViolation1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation1'],'1')>-1 }">checked</c:if>><label for="majorViolation11">是</label>
      			&#12288;<input type="checkbox" id="majorViolation10" name="majorViolation1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation1'],'0')>-1 }">checked</c:if>><label for="majorViolation10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&#12288;&#12288;●&#12288;研究过程中，符合提前中止研究标准而没有让受试者退出：<input type="checkbox" id="majorViolation21" name="majorViolation2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation2'],'1')>-1 }">checked</c:if>><label for="majorViolation21">是</label>
      			&#12288;<input type="checkbox" id="majorViolation20"name="majorViolation2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation2'],'0')>-1 }">checked</c:if>><label for="majorViolation20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&#12288;&#12288;●&#12288;给予受试者错误的治疗或不正确的剂量：<input type="checkbox" id="majorViolation31" name="majorViolation3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation3'],'1')>-1 }">checked</c:if>><label for="majorViolation31">是</label>
      			&#12288;<input type="checkbox" id="majorViolation30" name="majorViolation3" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation3'],'0')>-1 }">checked</c:if>><label for="majorViolation30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&#12288;&#12288;●&#12288;给予受试者方案禁用的合并用药：<input type="checkbox" id="majorViolation41" name="majorViolation4" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation4'],'1')>-1 }">checked</c:if>><label for="majorViolation41">是</label>
      			&#12288;<input type="checkbox" id="majorViolation40" name="majorViolation4" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation4'],'0')>-1 }">checked</c:if>><label for="majorViolation40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&#12288;&#12288;●&#12288;任何偏离研究特定的程序或评估，从而对受试者的权益、安全和健康，或对研究结果产生显著影响的研究行为：<input type="checkbox" id="majorViolation51" name="majorViolation5" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation5'],'1')>-1 }">checked</c:if>><label for="majorViolation51">是</label>
      			&#12288;<input type="checkbox" id="majorViolation50" name="majorViolation5" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['majorViolation5'],'0')>-1 }">checked</c:if>><label for="majorViolation50">否</label>
      			</td>
      		</tr>
      		
      		
      		<tr>
      			<td>&nbsp;持续违背方案（不属于上述重大违背方案，但反复多次违背方案）：<input type="checkbox" id="violation11" name="violation1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violation1'],'1')>-1 }">checked</c:if>><label for="violation11">是</label>
      			&#12288;<input type="checkbox" id="violation10" name="violation1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violation1'],'0')>-1 }">checked</c:if>><label for="violation10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&nbsp;研究者不配合监查／稽查：<input type="checkbox" id="violation21" name="violation2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violation2'],'1')>-1 }">checked</c:if>><label for="violation21">是</label>
      			&#12288;<input type="checkbox" id="violation20" name="violation2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violation2'],'0')>-1 }">checked</c:if>><label for="violation20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&nbsp;对违规事件不予以纠正：<input type="checkbox" id="violation31" name="violation3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violation3'],'1')>-1 }">checked</c:if>><label for="violation31">是</label>
      			&#12288;<input type="checkbox" id="violation30" name="violation3" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violation3'],'0')>-1 }">checked</c:if>><label for="violation30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>&nbsp;违背方案事件的描述：<input type="text" name="violation4" style="width: 600px;" value="${formDataMap['violation4'] }">
      			</td>
      		</tr>
      		
      		
      		<tr>
      			<th style="text-align: left;">&nbsp;二、违背方案的影响</th>
      		</tr>
      		<tr>
      			<td>●&#12288;是否影响受试者的安全：<input type="checkbox" id="violationAffect11" name="violationAffect1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violationAffect1'],'1')>-1 }">checked</c:if>><label for="violationAffect11">是</label>
      			&#12288;<input type="checkbox" id="violationAffect10" name="violationAffect1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violationAffect1'],'0')>-1 }">checked</c:if>><label for="violationAffect10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否影响受试者的权益：<input type="checkbox" id="violationAffect21" name="violationAffect2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violationAffect2'],'1')>-1 }">checked</c:if>><label for="violationAffect21">是</label>
      			&#12288;<input type="checkbox" id="violationAffect20" name="violationAffect2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violationAffect2'],'0')>-1 }">checked</c:if>><label for="violationAffect20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否对研究结果产生显著影响：<input type="checkbox" id="violationAffect31" name="violationAffect3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violationAffect3'],'1')>-1 }">checked</c:if>><label for="violationAffect31">是</label>
      			&#12288;<input type="checkbox" id="violationAffect30" name="violationAffect3" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['violationAffect3'],'0')>-1 }">checked</c:if>><label for="violationAffect30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;三、违背方案的处理措施</th>
      		</tr>
      		<tr>
      			<td><textarea name="violateMeasures" style="width: 100%;border: 0;min-height: 70px;" placeholder="请填写违背方案的处理措施">${formDataMap['violateMeasures'] }</textarea></td>
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