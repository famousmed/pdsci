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
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumReviseApplication.id}";
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
		<font size="3"><b>修正案审查申请</b></font>
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
      			<td>●&#12288;提出修正者：<input type="checkbox" id="proposeAmender1" name="proposeAmender" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['proposeAmender'],'1')>-1 }">checked</c:if>><label for="proposeAmender1">项目资助方</label>
      				&#12288;<input type="checkbox" id="proposeAmender2" name="proposeAmender" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['proposeAmender'],'2')>-1 }">checked</c:if>><label for="proposeAmender2">研究中心</label>
      				&#12288;<input type="checkbox" id="proposeAmender3" name="proposeAmender" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['proposeAmender'],'3')>-1 }">checked</c:if>><label for="proposeAmender3">主要研究者</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;修正类别：<input type="checkbox" id="reviseCategory1" name="reviseCategory" value="1" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'1')>-1 }">checked</c:if>><label for="reviseCategory1">研究设计</label>
      				&#12288;<input type="checkbox" id="reviseCategory2" name="reviseCategory" value="2" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'2')>-1 }">checked</c:if>><label for="reviseCategory2">研究步骤</label>
      				&#12288;<input type="checkbox" id="reviseCategory3" name="reviseCategory" value="3" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'3')>-1 }">checked</c:if>><label for="reviseCategory3">受试者例数</label>
      				&#12288;<input type="checkbox" id="reviseCategory4" name="reviseCategory" value="4" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'4')>-1 }">checked</c:if>><label for="reviseCategory4">纳入排除标准</label>
      				&#12288;<input type="checkbox" id="reviseCategory5" name="reviseCategory" value="5" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'5')>-1 }">checked</c:if>><label for="reviseCategory5">干预措施</label>
      				&#12288;<input type="checkbox" id="reviseCategory6" name="reviseCategory" value="6" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'6')>-1 }">checked</c:if>><label for="reviseCategory6">知情同意书</label>
      				&#12288;<input type="checkbox" id="reviseCategory7" name="reviseCategory" value="7" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'7')>-1 }">checked</c:if>><label for="reviseCategory7">招募材料</label>
      				&#12288;<input type="checkbox" id="reviseCategory8" name="reviseCategory" value="8" <c:if test="${fn:indexOf(formDataMap['reviseCategory'],'8')>-1 }">checked</c:if>><label for="reviseCategory8">其他</label>
      				：<input type="text" name="otherReviseCategory" value="${formDataMap['otherReviseCategory']}">
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;为了避免对受试者造成紧急伤害，在提交伦理委员会审查批准前对方案进行了修改并实施：<input type="checkbox" id="isModifyImple1" name="isModifyImple" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isModifyImple'],'1')>-1 }">checked</c:if>><label for="isModifyImple1">不适用</label>
      				&#12288;<input type="checkbox" id="isModifyImple2" name="isModifyImple" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['isModifyImple'],'2')>-1 }">checked</c:if>><label for="isModifyImple2">是</label>
      			</td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;二、修正的具体内容与原因</th>
      		</tr>
      		<tr>
      			<td><textarea style="width: 100%;border: 0;min-height: 70px;" name="reviseContentReason" placeholder="请填写修正的具体内容与原因">${formDataMap['reviseContentReason'] }</textarea></td>
      		</tr>
      		<tr>
      			<th style="text-align: left;">&nbsp;三、修正案对研究的影响</th>
      		</tr>
      		<tr>
      			<td>●&#12288;修正案是否增加研究的预期风险：<input type="checkbox" id="reviseAffect11" name="reviseAffect1" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect1'],'1')>-1 }">checked</c:if>><label for="reviseAffect11">是</label>
      				&#12288;<input type="checkbox" id="reviseAffect10" name="reviseAffect1" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect1'],'0')>-1 }">checked</c:if>><label for="reviseAffect10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;修正案是否降低受试者预期受益：<input type="checkbox" id="reviseAffect21" name="reviseAffect2" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect2'],'1')>-1 }">checked</c:if>><label for="reviseAffect21">是</label>
      				&#12288;<input type="checkbox" id="reviseAffect20" name="reviseAffect2" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect2'],'0')>-1 }">checked</c:if>><label for="reviseAffect20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;修正案是否涉及弱势群体：<input type="checkbox" id="reviseAffect31" name="reviseAffect3" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect3'],'1')>-1 }">checked</c:if>><label for="reviseAffect31">是</label>
      				&#12288;<input type="checkbox" id="reviseAffect30" name="reviseAffect3" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect3'],'0')>-1 }">checked</c:if>><label for="reviseAffect30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;修正案是否增加受试者参加研究的持续时间或花费：<input type="checkbox" id="reviseAffect41" name="reviseAffect4" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect4'],'1')>-1 }">checked</c:if>><label for="reviseAffect41">是</label>
      				&#12288;<input type="checkbox" id="reviseAffect40" name="reviseAffect4" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect4'],'0')>-1 }">checked</c:if>><label for="reviseAffect40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;如果研究已经开始，修正案是否对已纳入的受试者造成影响：<input type="checkbox" id="reviseAffect51" name="reviseAffect5" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect5'],'1')>-1 }">checked</c:if>><label for="reviseAffect51">不适用</label>
      				&#12288;<input type="checkbox" id="reviseAffect52" name="reviseAffect5" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect5'],'2')>-1 }">checked</c:if>><label for="reviseAffect52">是</label>
      				&#12288;<input type="checkbox" id="reviseAffect53" name="reviseAffect5" value="3" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect5'],'3')>-1 }">checked</c:if>><label for="reviseAffect53">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td>●&#12288;在研受试者是否需要重新获取知情同意：<input type="checkbox" id="reviseAffect61" name="reviseAffect6" onclick="selectSingle(this);" value="1" <c:if test="${fn:indexOf(formDataMap['reviseAffect6'],'1')>-1 }">checked</c:if>><label for="reviseAffect61">是</label>
      				&#12288;<input type="checkbox" id="reviseAffect60" name="reviseAffect6" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['reviseAffect6'],'0')>-1 }">checked</c:if>><label for="reviseAffect60">否</label>
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