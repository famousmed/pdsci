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
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumScheduleApplication.id}";
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
		<font size="3"><b>研究进展报告</b></font>
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
      			<th style="text-align: left;">&nbsp;一、受试者信息</th>
      		</tr>	
      		<tr>
      			<td>●&#12288;合同研究总例数：<input type="text" class="inputText" name="patientCount" value="${formDataMap['patientCount']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;已入组例数：<input type="text" class="inputText" name="inPatientNum" value="${formDataMap['inPatientNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;完成观察例数：<input type="text" class="inputText" name="finishPatientNum" value="${formDataMap['finishPatientNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;提前退出例数：<input type="text" class="inputText" name="termiPatientNum" value="${formDataMap['termiPatientNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;严重不良事件例数：<input type="text" class="inputText" name="saeNum" value="${formDataMap['saeNum']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;已报告的严重不良事件例数：<input type="text" class="inputText" name="saeReportNum" value="${formDataMap['saeReportNum']}">
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;二、研究进展情况</th>
      		</tr>
      		<tr>
      			<td>●&#12288;研究阶段：<input type="checkbox" id="researchProgress10" name="researchProgress1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'0')>-1 }">checked</c:if>><label for="researchProgress10">研究尚未启动</label>
      			&#12288;<input type="checkbox" id="researchProgress11" name="researchProgress1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'1')>-1 }">checked</c:if>><label for="researchProgress11">正在招募受试者（尚未入组）</label>
      				&#12288;<input type="checkbox" id="researchProgress12" name="researchProgress1" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'2')>-1 }">checked</c:if>><label for="researchProgress12">正在实施研究</label>
      				&#12288;<input type="checkbox" id="researchProgress13" name="researchProgress1" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'3')>-1 }">checked</c:if>><label for="researchProgress13">受试者的试验干预已经完成</label>
      				&#12288;<input type="checkbox" id="researchProgress14" name="researchProgress1" value="4" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress1'],'4')>-1 }">checked</c:if>><label for="researchProgress14">后期数据处理阶段</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否存在影响研究进行的情况：<input type="checkbox" id="researchProgress20" name="researchProgress2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress2'],'0')>-1 }">checked</c:if>><label for="researchProgress20">否</label>
      			&#12288;<input type="checkbox" id="researchProgress21" name="researchProgress2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress2'],'1')>-1 }">checked</c:if>><label for="researchProgress21">是</label> →请说明：
      			<input type="text" name="factSheets" value="${formDataMap['factSheets']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否存在于试验干预相关的、非预期的、严重不良事件：<input type="checkbox" id="researchProgress31" name="researchProgress3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress3'],'1')>-1 }">checked</c:if>><label for="researchProgress31">是</label>
      				&#12288;<input type="checkbox" id="researchProgress30" name="researchProgress3" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress3'],'0')>-1 }">checked</c:if>><label for="researchProgress30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;研究风险是否超过预期：<input type="checkbox" id="researchProgress41" name="researchProgress4" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress4'],'1')>-1 }">checked</c:if>><label for="researchProgress41">是</label>
      				&#12288;<input type="checkbox" id="researchProgress40" name="researchProgress4" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress4'],'0')>-1 }">checked</c:if>><label for="researchProgress40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;是否存在影响研究风险与受益的任何新信息、新进展：<input type="checkbox" id="researchProgress50" name="researchProgress5" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress5'],'0')>-1 }">checked</c:if>><label for="researchProgress50">否</label>
      				&#12288;<input type="checkbox" id="researchProgress51" name="researchProgress5" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress5'],'1')>-1 }">checked</c:if>><label for="researchProgress51">是</label> →请说明：
      				<input type="text" name="newInfo" value="${formDataMap['newInfo']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;研究中是否存在影响受试者权益的问题：<input type="checkbox" id="researchProgress60" name="researchProgress6" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress6'],'0')>-1 }">checked</c:if>><label for="researchProgress60">否</label>
      				&#12288;<input type="checkbox" id="researchProgress61" name="researchProgress6" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress6'],'1')>-1 }">checked</c:if>><label for="researchProgress61">是</label> →请说明：
      				<input type="text" name="quesDesc" value="${formDataMap['quesDesc']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;严重不良事件或方案规定必须报告的重要医学事件已经及时报告：<input type="checkbox" id="researchProgress71" name="researchProgress7" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress7'],'1')>-1 }">checked</c:if>><label for="researchProgress71">不适用</label>
      				&#12288;<input type="checkbox" id="researchProgress72" name="researchProgress7" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress7'],'2')>-1 }">checked</c:if>><label for="researchProgress72">是</label>
      				&#12288;<input type="checkbox" id="researchProgress73" name="researchProgress7" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researchProgress7'],'3')>-1 }">checked</c:if>><label for="researchProgress73">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;三、其他</th>
      		</tr>
      		<tr>
      			<td>是否申请延长伦理审查批件的有效期：<input type="checkbox" id="isExtendDocValid1" name="isExtendDocValid" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isExtendDocValid'],'1')>-1 }">checked</c:if>><label for="isExtendDocValid1">是</label>
      				&#12288;<input type="checkbox" id="isExtendDocValid0" name="isExtendDocValid" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isExtendDocValid'],'0')>-1 }">checked</c:if>><label for="isExtendDocValid0">否</label>
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