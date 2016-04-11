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
	if(false==$("#initApplicationForm").validationEngine("validate")){
		return;
	}
	jboxPost("<s:url value='/irb/committee/saveWorksheet'/>?formFileName=${formFileName}&irbFlow=${irbForm.irb.irbFlow}&irbUserFlow=${irbUserFlow}",
			$('#initApplicationForm').serialize(),function(){
		if ("${param.source}" == "quickOpinion") {	//更新快审主审综合意见的主审决定和意见
			window.parent.frames['mainIframe'].$("#authDecision_${irbUserFlow}").html($(":input[name='decision']:checked").attr("desc"));
			window.parent.frames['mainIframe'].$("#authNote_${irbUserFlow}").html($("#irbSuggest").val());
		}
	},null,true);
}

function print(){
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&userFlow=${userFlow}&irbFlow=${irbForm.irb.irbFlow}&recTypeId=${irbRecTypeEnumInitWorksheetPRO.id}";
	window.location.href= url;
}

function selectSingle(obj) {
	var id = $(obj).attr("id");
	var name = $(obj).attr("name");
	$("input[name="+name+"][id!="+id+"]:checked").attr("checked",false);
}


$(document).ready(function(){
	$("[related]").each(function(){
		var cont = $(this).attr("related").split(";");
		var researchType = cont[0];
		if (researchType != '' && '${researchType}' == researchType) {
			$(this).css("display","");	
			return;
		}
		if (cont.length>1) {
			var obserStudyTypes = cont[1];
			if (obserStudyTypes != '') {
				obserStudyTypes = obserStudyTypes.split(",");
				for (var i=0;i<obserStudyTypes.length;i++) {
					var obserStudyType = obserStudyTypes[i];
					if ('${obserStudyType}' == obserStudyType) {
						$(this).css("display","");	
						return;
					}
				}
			}
		}
	});
	$("[class]").each(function(){
		var id = $(this).attr("class");
		if($("#"+id).attr("checked")){
			$(this).css("display","none");	
		}else{
			if (id != 'selectTag' && id != 'xllist') {	//避免研究者查看页面冲突
				$(this).css("display","");	
			}
		}
	});
	
	if ("${param.type}" == 'show') {
		hideButton();
	}
	
});

function checkDisplay(obj){ 
	var name = $(obj).attr("name");
	$("[name='"+name+"']").each(function(){
		var object = $(this);
		$("."+$(object).attr("id")).each(function(){
			if($(object).attr("checked")){
				$(this).css("display","none");
			}else{
				if ($(object).attr("id") != 'selectTag' && $(object).attr("id") != 'xllist') {	//避免研究者查看页面冲突
					$(this).css("display","");	
				}
			}
		});
	});
}

function reviewSuggest(type) {
	jboxOpen("<s:url value='/jsp/irb/form/product/worksheet/reviewSuggest.jsp'/>?type="+type,"意见",500,300);
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
		<font size="3"><b>方案审查工作表</b></font>
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
				<td width="20%" style="text-align: right;">项目来源：</td>
				<td width="30%" colspan="3">
					${proj.projDeclarer}
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">方案版本号：</td>
				<td width="30%">
					${proVersion}
				</td>
				<td width="20%" style="text-align: right;">方案版本日期：</td>
				<td width="30%">
					${proVersionDate}
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">知情同意书版本号：</td>
				<td width="30%">
					${icfVersion}
				</td>
				<td width="20%" style="text-align: right;">知情同意书版本日期：</td>
				<td width="30%">
					${icfVersionDate}
				</td>
			</tr>
			<tr>
				<td width="20%" style="text-align: right;">受理号：</td>
				<td width="30%">
					${irbForm.irb.irbNo }
				</td>
				<td width="20%" style="text-align: right;">主审委员：</td>
				<td width="30%">
					${irbUserName }
				</td>
			</tr>
		</table>
</div>
<form id="initApplicationForm" >
	<div class="title1 clearfix">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;一、研究的科学设计与实施
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;符合公认的科学原理，并有充分的相关科学文献作为依据
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究方法合乎研究目的并适用于研究领域
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究者和其它研究人员胜任该项研究
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究是否具有科学和社会价值？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review1');">
      				<input type="hidden" id="review1" value="研究是否具有科学和社会价值？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究预期能获得可推广的知识：
      				<input type="checkbox" id="designImp11" name="designImp1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp1']=='1'}">checked</c:if>><label for="designImp11">不适用</label>
      				&#12288;<input type="checkbox" id="designImp12" name="designImp1" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp1']=='2'}">checked</c:if>><label for="designImp12">是</label>
      				&#12288;<input type="checkbox" id="designImp13" name="designImp1" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp1']=='3'}">checked</c:if>><label for="designImp13">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;将改进现有的预防、诊断和治疗干预措施（方法、操作程序和治疗）：
      				<input type="checkbox" id="designImp21" name="designImp2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp2']=='1'}">checked</c:if>><label for="designImp21">不适用</label>
      				&#12288;<input type="checkbox" id="designImp22" name="designImp2" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp2']=='2'}">checked</c:if>><label for="designImp22">是</label>
      				&#12288;<input type="checkbox" id="designImp23" name="designImp2" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp2']=='3'}">checked</c:if>><label for="designImp23">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究是否有充分的依据？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review2');">
      				<input type="hidden" id="review2" value="研究是否有充分的依据？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究有既往临床经验、文献资料、药学药理、前期临床研究的结果支持：
      				<input type="checkbox" id="designImp31" name="designImp3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp3']=='1'}">checked</c:if>><label for="designImp31">是</label>
      				&#12288;<input type="checkbox" id="designImp30" name="designImp3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp3']=='0'}">checked</c:if>><label for="designImp30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究设计是否能够回答研究问题？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review3');">
      				<input type="hidden" id="review3" value="研究设计是否能够回答研究问题？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;观察指标的选择合适：
      				<input type="checkbox" id="designImp41" name="designImp4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp4']=='1'}">checked</c:if>><label for="designImp41">是</label>
      				&#12288;<input type="checkbox" id="designImp40" name="designImp4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp4']=='0'}">checked</c:if>><label for="designImp40">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究期限足以观察到终点指标/替代指标的变化：
      				<input type="checkbox" id="designImp51" name="designImp5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp5']=='1'}">checked</c:if>><label for="designImp51">是</label>
      				&#12288;<input type="checkbox" id="designImp50" name="designImp5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp5']=='0'}">checked</c:if>><label for="designImp50">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;采用了公认有效的干预措施作为对照：
      				<input type="checkbox" id="designImp61" name="designImp6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp6']=='1'}">checked</c:if>><label for="designImp61">是</label>
      				&#12288;<input type="checkbox" id="designImp60" name="designImp6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp6']=='0'}">checked</c:if>><label for="designImp60">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;安慰剂或空白对照是基于：
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◆&#12288;当前不存在被证明有效的干预措施：
      				<input type="checkbox" id="designImp71" name="designImp7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp7']=='1'}">checked</c:if>><label for="designImp71">不适用</label>
      				&#12288;<input type="checkbox" id="designImp72" name="designImp7" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp7']=='2'}">checked</c:if>><label for="designImp72">是</label>
      				&#12288;<input type="checkbox" id="designImp73" name="designImp7" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp7']=='3'}">checked</c:if>><label for="designImp73">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◆&#12288;出于令人信服的以及科学合理的方法学上的理由，使用安慰剂是确定一种干预措施的有效性或安全性所必须的，而且使用安慰剂或不予治疗不会使患者遭受任何严重的风险或不可逆的伤害：
      				<input type="checkbox" id="designImp81" name="designImp8" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp8']=='1'}">checked</c:if>><label for="designImp81">不适用</label>
      				&#12288;<input type="checkbox" id="designImp82" name="designImp8" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp8']=='2'}">checked</c:if>><label for="designImp82">是</label>
      				&#12288;<input type="checkbox" id="designImp83" name="designImp8" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp8']=='3'}">checked</c:if>><label for="designImp83">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究设计避免了选择性偏倚：
      				<input type="checkbox" id="designImp91" name="designImp9" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp9']=='1'}">checked</c:if>><label for="designImp91">是</label>
      				&#12288;<input type="checkbox" id="designImp90" name="designImp9" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp9']=='0'}">checked</c:if>><label for="designImp90">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;样本量计算及其统计学依据是否合理：
      				<input type="checkbox" id="designImp101" name="designImp10" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp10']=='1'}">checked</c:if>><label for="designImp101">不适用</label>
      				&#12288;<input type="checkbox" id="designImp102" name="designImp10" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp10']=='2'}">checked</c:if>><label for="designImp102">是</label>
      				&#12288;<input type="checkbox" id="designImp103" name="designImp10" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp10']=='3'}">checked</c:if>><label for="designImp103">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related=";1,2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;样本量相对于检验假设是合理的：
      				<input type="checkbox" id="designImp111" name="designImp11" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp11']=='1'}">checked</c:if>><label for="designImp111">不适用</label>
      				&#12288;<input type="checkbox" id="designImp112" name="designImp11" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp11']=='2'}">checked</c:if>><label for="designImp112">是</label>
      				&#12288;<input type="checkbox" id="designImp113" name="designImp11" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp11']=='3'}">checked</c:if>><label for="designImp113">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;纳入/排除标准是否恰当？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review4');">
      				<input type="hidden" id="review4" value="纳入/排除标准是否恰当？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;所选择的受试者能够代表目标人群：
      				<input type="checkbox" id="designImp121" name="designImp12" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp12']=='1'}">checked</c:if>><label for="designImp121">是</label>
      				&#12288;<input type="checkbox" id="designImp120" name="designImp12" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp12']=='0'}">checked</c:if>><label for="designImp120">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;排除了对试验风险高危的人群：
      				<input type="checkbox" id="designImp131" name="designImp13" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp13']=='1'}">checked</c:if>><label for="designImp131">是</label>
      				&#12288;<input type="checkbox" id="designImp130" name="designImp13" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp13']=='0'}">checked</c:if>><label for="designImp130">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;限制了混杂因素：
      				<input type="checkbox" id="designImp141" name="designImp14" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp14']=='1'}">checked</c:if>><label for="designImp141">是</label>
      				&#12288;<input type="checkbox" id="designImp140" name="designImp14" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp14']=='0'}">checked</c:if>><label for="designImp140">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究步骤是否具有控制风险的措施，避免将受试者暴露于不必要的风险？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review5');">
      				<input type="hidden" id="review5" value="研究步骤是否具有控制风险的措施，避免将受试者暴露于不必要的风险？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;筛选步骤合理：
      				<input type="checkbox" id="designImp151" name="designImp15" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp15']=='1'}">checked</c:if>><label for="designImp151">不适用</label>
      				&#12288;<input type="checkbox" id="designImp152" name="designImp15" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp15']=='2'}">checked</c:if>><label for="designImp152">是</label>
      				&#12288;<input type="checkbox" id="designImp153" name="designImp15" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp15']=='3'}">checked</c:if>><label for="designImp153">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;耐受性研究是剂量逐级递增 ，进行下一剂量组研究应基于上一剂量组的结果：
      				<input type="checkbox" id="designImp161" name="designImp16" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp16']=='1'}">checked</c:if>><label for="designImp161">不适用</label>
      				&#12288;<input type="checkbox" id="designImp162" name="designImp16" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp16']=='2'}">checked</c:if>><label for="designImp162">是</label>
      				&#12288;<input type="checkbox" id="designImp163" name="designImp16" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp16']=='3'}">checked</c:if>><label for="designImp163">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;受试者参加该研究是否需要终止其现有治疗：
      				<input type="checkbox" id="designImp171" name="designImp17" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp17']=='1'}">checked</c:if>><label for="designImp171">是</label>
      				&#12288;<input type="checkbox" id="designImp170" name="designImp17" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp17']=='0'}">checked</c:if>><label for="designImp170">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;参加该研究是否需要终止或推迟常规治疗：
      				<input type="checkbox" id="designImp181" name="designImp18" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp18']=='1'}">checked</c:if>><label for="designImp181">是</label>
      				&#12288;<input type="checkbox" id="designImp180" name="designImp18" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp18']=='0'}">checked</c:if>><label for="designImp180">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;在清洗期对受试者的监护充分：
      				<input type="checkbox" id="designImp191" name="designImp19" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp19']=='1'}">checked</c:if>><label for="designImp191">不适用</label>
      				&#12288;<input type="checkbox" id="designImp192" name="designImp19" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp19']=='2'}">checked</c:if>><label for="designImp192">是</label>
      				&#12288;<input type="checkbox" id="designImp193" name="designImp19" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp19']=='3'}">checked</c:if>><label for="designImp193">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;根据研究目的，应用放射性、侵入性诊断方法合理：
      				<input type="checkbox" id="designImp201" name="designImp20" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp20']=='1'}">checked</c:if>><label for="designImp201">不适用</label>
      				&#12288;<input type="checkbox" id="designImp202" name="designImp20" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp20']=='2'}">checked</c:if>><label for="designImp202">是</label>
      				&#12288;<input type="checkbox" id="designImp203" name="designImp20" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp20']=='3'}">checked</c:if>><label for="designImp203">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究所使用受试者活检组织标本、和/或术后切除组织，已进行了医疗所必需的病理学诊断：
      				<input type="checkbox" id="designImp211" name="designImp21" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp21']=='1'}">checked</c:if>><label for="designImp211">不适用</label>
      				&#12288;<input type="checkbox" id="designImp212" name="designImp21" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp21']=='2'}">checked</c:if>><label for="designImp212">是</label>
      				&#12288;<input type="checkbox" id="designImp213" name="designImp21" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp21']=='3'}">checked</c:if>><label for="designImp213">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;随访的程序与频率合理，能有效观察效应的变化：
      				<input type="checkbox" id="designImp221" name="designImp22" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp22']=='1'}">checked</c:if>><label for="designImp221">不适用</label>
      				&#12288;<input type="checkbox" id="designImp222" name="designImp22" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp22']=='2'}">checked</c:if>><label for="designImp222">是</label>
      				&#12288;<input type="checkbox" id="designImp223" name="designImp22" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp22']=='3'}">checked</c:if>><label for="designImp223">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;提前退出研究的标准恰当：
      				<input type="checkbox" id="designImp231" name="designImp23" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp23']=='1'}">checked</c:if>><label for="designImp231">是</label>
      				&#12288;<input type="checkbox" id="designImp230" name="designImp23" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp23']=='0'}">checked</c:if>><label for="designImp230">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;如果受试者退出研究，是否安排了适当的随访或会推荐其他治疗：
      				<input type="checkbox" id="designImp241" name="designImp24" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp24']=='1'}">checked</c:if>><label for="designImp241">是</label>
      				&#12288;<input type="checkbox" id="designImp240" name="designImp24" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp24']=='0'}">checked</c:if>><label for="designImp240">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;暂停或终止整个研究的标准恰当：
      				<input type="checkbox" id="designImp251" name="designImp25" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp25']=='1'}">checked</c:if>><label for="designImp251">是</label>
      				&#12288;<input type="checkbox" id="designImp250" name="designImp25" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp25']=='0'}">checked</c:if>><label for="designImp250">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;不良事件处理预案恰当：
      				<input type="checkbox" id="designImp261" name="designImp26" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp26']=='1'}">checked</c:if>><label for="designImp261">是</label>
      				&#12288;<input type="checkbox" id="designImp260" name="designImp26" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp26']=='0'}">checked</c:if>><label for="designImp260">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;根据研究风险程度，制定了合理的数据与安全监察计划：
      				<input type="checkbox" id="designImp271" name="designImp27" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp27']=='1'}">checked</c:if>><label for="designImp271">是</label>
      				&#12288;<input type="checkbox" id="designImp270" name="designImp27" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp27']=='0'}">checked</c:if>><label for="designImp270">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究实施条件是否满足试验需要？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review6');">
      				<input type="hidden" id="review6" value="研究实施条件是否满足试验需要？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;主要研究者经过GCP培训，具有试验方案中所要求的专业知识和经验，有充分的时间参加临床研究：
      				<input type="checkbox" id="designImp281" name="designImp28" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp28']=='1'}">checked</c:if>><label for="designImp281">是</label>
      				&#12288;<input type="checkbox" id="designImp280" name="designImp28" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp28']=='0'}">checked</c:if>><label for="designImp280">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;参与研究的人员在教育与经验方面都有资格承担他们的研究任务：
      				<input type="checkbox" id="designImp291" name="designImp29" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp29']=='1'}">checked</c:if>><label for="designImp291">是</label>
      				&#12288;<input type="checkbox" id="designImp290" name="designImp29" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp29']=='0'}">checked</c:if>><label for="designImp290">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究场所、仪器条件能够满足研究任务的需要：
      				<input type="checkbox" id="designImp301" name="designImp30" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp30']=='1'}">checked</c:if>><label for="designImp301">是</label>
      				&#12288;<input type="checkbox" id="designImp300" name="designImp30" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp30']=='0'}">checked</c:if>><label for="designImp300">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究结果的发表或公开是否符合赫尔辛基宣言的要求？&#12288;<input type="button" value="  意&nbsp;&nbsp;见  " onclick="reviewSuggest('review7');">
      				<input type="hidden" id="review7" value="研究结果的发表或公开是否符合赫尔辛基宣言的要求？">
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;方案规定阴性的或未得出结论的研究结果应同阳性结果一样发表或公开：
      				<input type="checkbox" id="designImp311" name="designImp31" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp31']=='1'}">checked</c:if>><label for="designImp311">是</label>
      				&#12288;<input type="checkbox" id="designImp310" name="designImp31" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['designImp31']=='0'}">checked</c:if>><label for="designImp310">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix">
		<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;二、研究的风险与受益
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者的权益、安全和健康必须高于对科学和社会利益的考虑
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者的风险相对于预期的受益应合理，并且风险最小化
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;风险与受益的评估
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;风险的等级：
      				<input type="checkbox" id="riskBenefit11" name="riskBenefit1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit1']=='1'}">checked</c:if>><label for="riskBenefit11">最小风险</label>
      				&#12288;<input type="checkbox" id="riskBenefit10" name="riskBenefit1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit1']=='0'}">checked</c:if>><label for="riskBenefit10">大于最小风险</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;受试者的受益：
      				<input type="checkbox" id="riskBenefit21" name="riskBenefit2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit2']=='1'}">checked</c:if>><label for="riskBenefit21">有直接受益的可能</label>
      				&#12288;<input type="checkbox" id="riskBenefit20" name="riskBenefit2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit2']=='0'}">checked</c:if>><label for="riskBenefit20">没有直接受益</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;风险相对于受益是否合理？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;有直接受益的可能：与任何可得到的替代方法相比，研究预期受益至少是同样有利的；风险相对于受试者预期受益而言是合理的：
      				<input type="checkbox" id="riskBenefit31" name="riskBenefit3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit3']=='1'}">checked</c:if>><label for="riskBenefit31">不适用</label>
      				&#12288;<input type="checkbox" id="riskBenefit32" name="riskBenefit3" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit3']=='2'}">checked</c:if>><label for="riskBenefit32">是</label>
      				&#12288;<input type="checkbox" id="riskBenefit33" name="riskBenefit3" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit3']=='3'}">checked</c:if>><label for="riskBenefit33">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;没有直接受益：受试者参与研究的风险相对于社会预期受益而言是合理的；研究所获得的知识是重要的：
      				<input type="checkbox" id="riskBenefit41" name="riskBenefit4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit4']=='1'}">checked</c:if>><label for="riskBenefit41">不适用</label>
      				&#12288;<input type="checkbox" id="riskBenefit42" name="riskBenefit4" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit4']=='2'}">checked</c:if>><label for="riskBenefit42">是</label>
      				&#12288;<input type="checkbox" id="riskBenefit43" name="riskBenefit4" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['riskBenefit4']=='3'}">checked</c:if>><label for="riskBenefit43">否</label>
      			</td>
      		</tr>
      		</table>
		</div>
		
		<div class="title1 clearfix">
		<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;三、受试者的招募
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者的选择是公正的
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;尊重受试者的隐私，避免胁迫和不正当的影响
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;合理的激励与补偿，避免过度劝诱
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;受试者选择是否公正？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;考虑到研究目的与开展研究的环境，计划招募的人群特征（包括性别、年龄、文化程度、文化背景、经济状况和种族）是合理的：
      				<input type="checkbox" id="recruitSubject11" name="recruitSubject1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject1']=='1'}">checked</c:if>><label for="recruitSubject11">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject10" name="recruitSubject1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject1']=='0'}">checked</c:if>><label for="recruitSubject10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;招募方式是否合理？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;接触与招募受试者的方式避免侵犯/泄露受试者的隐私：
      				<input type="checkbox" id="recruitSubject21" name="recruitSubject2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject2']=='1'}">checked</c:if>><label for="recruitSubject21">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject20" name="recruitSubject2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject2']=='0'}">checked</c:if>><label for="recruitSubject20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;招募材料避免夸大研究的潜在受益、低估研究的预期风险：
      				<input type="checkbox" id="recruitSubject31" name="recruitSubject3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject3']=='1'}">checked</c:if>><label for="recruitSubject31">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject30" name="recruitSubject3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject3']=='0'}">checked</c:if>><label for="recruitSubject30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;招募者的身份不会对受试者造成不正当的影响：
      				<input type="checkbox" id="recruitSubject41" name="recruitSubject4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject4']=='1'}">checked</c:if>><label for="recruitSubject41">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject40" name="recruitSubject4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject4']=='0'}">checked</c:if>><label for="recruitSubject40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;激励与补偿是否合理？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;不给予受试者激励与补偿是否合理：
      				<input type="checkbox" id="recruitSubject51" name="recruitSubject5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject5']=='1'}">checked</c:if>><label for="recruitSubject51">不适用</label>
      				&#12288;<input type="checkbox" id="recruitSubject52" name="recruitSubject5" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject5']=='2'}">checked</c:if>><label for="recruitSubject52">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject53" name="recruitSubject5" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject5']=='3'}">checked</c:if>><label for="recruitSubject53">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;给予受试者激励与补偿的数量是否合理：
      				<input type="checkbox" id="recruitSubject61" name="recruitSubject6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject6']=='1'}">checked</c:if>><label for="recruitSubject61">不适用</label>
      				&#12288;<input type="checkbox" id="recruitSubject62" name="recruitSubject6" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject6']=='2'}">checked</c:if>><label for="recruitSubject62">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject63" name="recruitSubject6" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject6']=='3'}">checked</c:if>><label for="recruitSubject63">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;激励与补偿的支付方式是否合理（参考以下要点）：
      				<input type="checkbox" id="recruitSubject71" name="recruitSubject7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject7']=='1'}">checked</c:if>><label for="recruitSubject71">不适用</label>
      				&#12288;<input type="checkbox" id="recruitSubject72" name="recruitSubject7" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject7']=='2'}">checked</c:if>><label for="recruitSubject72">是</label>
      				&#12288;<input type="checkbox" id="recruitSubject73" name="recruitSubject7" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['recruitSubject7']=='3'}">checked</c:if>><label for="recruitSubject73">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◆&#12288;受试者因与研究有关的原因（如药物副作用、健康原因）退出研究，应作为完成全部研究而获报酬或补偿
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◆&#12288;受试者因其它理由退出研究，应按参加工作量的比例而获得报酬
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◆&#12288;研究者因受试者故意不依从而必需从研究中淘汰，有权扣除其部分或全部报酬
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◆&#12288;受试者的监护人不应得到除交通费用和有关开支以外的其它补偿
      			</td>
      		</tr>
      		</table>
		</div>
		
		<div class="title1 clearfix">
		<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;四、受试者的医疗和保护
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究者负责做出与临床试验相关的医疗决定，并保证所做出的任何医疗决定都是基于受试者的利益
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者不能因参加研究而被剥夺合理治疗的权利
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究者能否胜任受试者的医疗与保护？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究人员的医疗执业资格和经验，能胜任受试者的安全保护与医疗：
      				<input type="checkbox" id="medicalCareProtect11" name="medicalCareProtect1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect1']=='1'}">checked</c:if>><label for="medicalCareProtect11">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect10" name="medicalCareProtect1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect1']=='0'}">checked</c:if>><label for="medicalCareProtect10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究过程中受试者是否获得适当的医疗与保护？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;因研究目的而撤消或不给予标准治疗的设计理由合理：
      				<input type="checkbox" id="medicalCareProtect21" name="medicalCareProtect2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect2']=='1'}">checked</c:if>><label for="medicalCareProtect21">不适用</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect22" name="medicalCareProtect2" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect2']=='2'}">checked</c:if>><label for="medicalCareProtect22">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect23" name="medicalCareProtect2" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect2']=='3'}">checked</c:if>><label for="medicalCareProtect23">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;在研究过程中，为受试者提供适当的医疗保健：
      				<input type="checkbox" id="medicalCareProtect31" name="medicalCareProtect3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect3']=='1'}">checked</c:if>><label for="medicalCareProtect31">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect30" name="medicalCareProtect3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect3']=='0'}">checked</c:if>><label for="medicalCareProtect30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;为受试者提供适当的医疗监测、心理与社会支持：
      				<input type="checkbox" id="medicalCareProtect41" name="medicalCareProtect4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect4']=='1'}">checked</c:if>><label for="medicalCareProtect41">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect40" name="medicalCareProtect4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect4']=='0'}">checked</c:if>><label for="medicalCareProtect40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;受试者自愿退出研究时拟采取的措施恰当：
      				<input type="checkbox" id="medicalCareProtect51" name="medicalCareProtect5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect5']=='1'}">checked</c:if>><label for="medicalCareProtect51">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect50" name="medicalCareProtect5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect5']=='0'}">checked</c:if>><label for="medicalCareProtect50">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究结束后受试者是否获得适当的医疗与保护？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;在研究结束后，为受试者提供适当的医疗保健：
      				<input type="checkbox" id="medicalCareProtect61" name="medicalCareProtect6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect6']=='1'}">checked</c:if>><label for="medicalCareProtect61">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect60" name="medicalCareProtect6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect6']=='0'}">checked</c:if>><label for="medicalCareProtect60">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;延长使用、紧急使用、和/或出于同情而使用研究产品的标准：
      				<input type="checkbox" id="medicalCareProtect71" name="medicalCareProtect7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect7']=='1'}">checked</c:if>><label for="medicalCareProtect71">不适用</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect72" name="medicalCareProtect7" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect7']=='2'}">checked</c:if>><label for="medicalCareProtect72">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect73" name="medicalCareProtect7" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect7']=='3'}">checked</c:if>><label for="medicalCareProtect73">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究结束后，受试者可获得研究产品的计划的说明：
      				<input type="checkbox" id="medicalCareProtect81" name="medicalCareProtect8" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect8']=='1'}">checked</c:if>><label for="medicalCareProtect81">不适用</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect82" name="medicalCareProtect8" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect8']=='2'}">checked</c:if>><label for="medicalCareProtect82">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect83" name="medicalCareProtect8" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect8']=='3'}">checked</c:if>><label for="medicalCareProtect83">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;受损伤受试者的治疗和补偿是否合理？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;由于参与研究造成受试者的损伤/残疾/死亡的补偿或治疗的规定合理：
      				<input type="checkbox" id="medicalCareProtect91" name="medicalCareProtect9" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect9']=='1'}">checked</c:if>><label for="medicalCareProtect91">是</label>
      				&#12288;<input type="checkbox" id="medicalCareProtect90" name="medicalCareProtect9" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['medicalCareProtect9']=='0'}">checked</c:if>><label for="medicalCareProtect90">否</label>
      			</td>
      		</tr>
      		</table>
		</div>
		
		<div class="title1 clearfix">
		<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;五、隐私和保密
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;采取的措施足以保护受试者的隐私与数据的机密性
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;保密措施是否恰当？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;规定了可以接触受试者个人资料（包括医疗记录、生物学标本）人员范围：
      				<input type="checkbox" id="privacyConfi11" name="privacyConfi1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi1']=='1'}">checked</c:if>><label for="privacyConfi11">是</label>
      				&#12288;<input type="checkbox" id="privacyConfi10" name="privacyConfi1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi1']=='0'}">checked</c:if>><label for="privacyConfi10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;制定了数据安全的措施（如数据匿名），保护受试者数据的机密：
      				<input type="checkbox" id="privacyConfi21" name="privacyConfi2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi2']=='1'}">checked</c:if>><label for="privacyConfi21">是</label>
      				&#12288;<input type="checkbox" id="privacyConfi20" name="privacyConfi2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi2']=='0'}">checked</c:if>><label for="privacyConfi20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究结果发表/公开是否恰当？
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;规定了研究结果的发表将不会泄露受试者的个人信息：
      				<input type="checkbox" id="privacyConfi31" name="privacyConfi3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi3']=='1'}">checked</c:if>><label for="privacyConfi31">是</label>
      				&#12288;<input type="checkbox" id="privacyConfi30" name="privacyConfi3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi3']=='0'}">checked</c:if>><label for="privacyConfi30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;某些可能对团体、社会、或以人种/民族定义的人群利益带来风险的研究，考虑了有关各方的利益，以适当的方式发表研究结果，或在某些情况下不公开：
      				<input type="checkbox" id="privacyConfi41" name="privacyConfi4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi4']=='1'}">checked</c:if>><label for="privacyConfi41">不适用</label>
      				&#12288;<input type="checkbox" id="privacyConfi42" name="privacyConfi4" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi4']=='2'}">checked</c:if>><label for="privacyConfi42">是</label>
      				&#12288;<input type="checkbox" id="privacyConfi43" name="privacyConfi4" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['privacyConfi4']=='3'}">checked</c:if>><label for="privacyConfi43">否</label>
      			</td>
      		</tr>
      		</table>
		</div>
		
		<div class="title1 clearfix">
		<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;六、弱势群体的考虑
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;纳入弱势人群作为受试者的理由是正当与合理的
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;采取特殊的措施，确保该人群的权益和健康
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究是否涉及弱势群体：
      				<input type="checkbox" id="vulnerGroup10" name="vulnerGroup1" value="0" onclick="selectSingle(this);checkDisplay(this);" <c:if test="${formDataMap['vulnerGroup1']=='0'}">checked</c:if>><label for="vulnerGroup10">否</label>
      				&#12288;<input type="checkbox" id=vulnerGroup11 name="vulnerGroup1" value="1" onclick="selectSingle(this);checkDisplay(this);" <c:if test="${formDataMap['vulnerGroup1']=='1' }">checked</c:if>><label for="vulnerGroup11">是</label>
      			<span class="vulnerGroup10" style="display:">→ 请选择人员类别（可多选）：</span>
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;<input type="checkbox" id="vulnerGroup21" name="vulnerGroup2" value="1" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'1')>-1 }">checked</c:if>><label for="vulnerGroup21">儿童/未成年人</label>
        			&#12288;<input type="checkbox" id="vulnerGroup22" name="vulnerGroup2" value="2" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'2')>-1 }">checked</c:if>><label for="vulnerGroup22">认知障碍或健康状况而没有能力做出知情同意的成人</label>
        			&#12288;<input type="checkbox" id="vulnerGroup23" name="vulnerGroup2" value="3" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'3')>-1 }">checked</c:if>><label for="vulnerGroup23">申办者/研究者的雇员或学生</label>
        			&#12288;<input type="checkbox" id="vulnerGroup24" name="vulnerGroup2" value="4" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'4')>-1 }">checked</c:if>><label for="vulnerGroup24">教育/经济地位低下的人员</label>
        			&#12288;<input type="checkbox" id="vulnerGroup25" name="vulnerGroup2" value="5" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'5')>-1 }">checked</c:if>><label for="vulnerGroup25">疾病终末期患者</label>
        			&#12288;<input type="checkbox" id="vulnerGroup26" name="vulnerGroup2" value="6" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'6')>-1 }">checked</c:if>><label for="vulnerGroup26">囚犯</label>
        			&#12288;<input type="checkbox" id="vulnerGroup27" name="vulnerGroup2" value="7" <c:if test="${fn:indexOf(formDataMap['vulnerGroup2'],'7')>-1 }">checked</c:if>><label for="vulnerGroup27">其他&nbsp;</label>
        			&#12288;<input type="text" name="vulnerGroup3" value="${formDataMap['vulnerGroup3'] }">
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td colspan="3">
      				&nbsp;●&#12288;选择弱势人群为受试者的理由是否正当与合理？
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;以比弱势群体情况较好者为受试者，研究不能同样很好地进行：
      				<input type="checkbox" id="vulnerGroup41" name="vulnerGroup4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup4']=='1'}">checked</c:if>><label for="vulnerGroup41">是</label>
      				&#12288;<input type="checkbox" id="vulnerGroup40" name="vulnerGroup4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup4']=='0'}">checked</c:if>><label for="vulnerGroup40">否</label>
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;研究是为获得该弱势群体特有的、或独特疾病/健康问题的诊断、预防或治疗知识；并且成功的研究成果将能合理地用于该人群：
      				<input type="checkbox" id="vulnerGroup51" name="vulnerGroup5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup5']=='1'}">checked</c:if>><label for="vulnerGroup51">是</label>
      				&#12288;<input type="checkbox" id="vulnerGroup50" name="vulnerGroup5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup5']=='0'}">checked</c:if>><label for="vulnerGroup50">否</label>
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td colspan="3">
      				&nbsp;●&#12288;该人群的权益和健康的考虑是否适当？
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;对受试者没有直接受益前景的研究，研究所伴随的风险不大于该类人群的常规体格检查或心理学检查的风险：
      				<input type="checkbox" id="vulnerGroup61" name="vulnerGroup6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup6']=='1'}">checked</c:if>><label for="vulnerGroup61">不适用</label>
      				&#12288;<input type="checkbox" id="vulnerGroup62" name="vulnerGroup6" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup6']=='2'}">checked</c:if>><label for="vulnerGroup62">是</label>
      				&#12288;<input type="checkbox" id="vulnerGroup63" name="vulnerGroup6" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup6']=='3'}">checked</c:if>><label for="vulnerGroup63">否</label>
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;对受试者没有直接受益前景的研究，研究所伴随的风险轻微或较小地超过该类人群的常规体格检查或心理学检查的风险：研究干预措施符合医疗常规的适应症，或与受试者曾经历的、或在研究条件下可能经历的临床干预措施比较是相当的：
      				<input type="checkbox" id="vulnerGroup71" name="vulnerGroup7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup7']=='1'}">checked</c:if>><label for="vulnerGroup71">不适用</label>
      				&#12288;<input type="checkbox" id="vulnerGroup72" name="vulnerGroup7" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup7']=='2'}">checked</c:if>><label for="vulnerGroup72">是</label>
      				&#12288;<input type="checkbox" id="vulnerGroup73" name="vulnerGroup7" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup7']=='3'}">checked</c:if>><label for="vulnerGroup73">否</label>
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;依据风险程度，方案制定了专门的实质性或程序性保护措施：
      				<input type="checkbox" id="vulnerGroup81" name="vulnerGroup8" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup8']=='1'}">checked</c:if>><label for="vulnerGroup81">不适用</label>
      				&#12288;<input type="checkbox" id="vulnerGroup82" name="vulnerGroup8" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup8']=='2'}">checked</c:if>><label for="vulnerGroup82">是</label>
      				&#12288;<input type="checkbox" id="vulnerGroup83" name="vulnerGroup8" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup8']=='3'}">checked</c:if>><label for="vulnerGroup83">否</label>
      			</td>
      		</tr>
      		<tr class="vulnerGroup10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;当受试者没有能力、或不能充分地给予知情同意时（如未到法定年龄，或严重痴呆病人），应获得其合法代表的同意；同时，应根据受试者可理解程度告知受试者有关试验情况；如可能，受试者应签署书面知情同意书并注明日期：
      				<input type="checkbox" id="vulnerGroup91" name="vulnerGroup9" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup9']=='1'}">checked</c:if>><label for="vulnerGroup91">是</label>
      				&#12288;<input type="checkbox" id="vulnerGroup90" name="vulnerGroup9" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['vulnerGroup9']=='0'}">checked</c:if>><label for="vulnerGroup90">否</label>
      			</td>
      		</tr>
      		</table>
		</div>
		
		<div class="title1 clearfix">
		<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;七、特定疾病人群、特定地区人群/族群的考虑
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;考虑该人群/族群的特点，采取特殊的措施，确保该人群的权益和健康
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;促进当地的医疗保健与研究能力的发展
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td colspan="3">
      				&nbsp;●&#12288;研究是否涉及特定疾病人群、特定地区人群/族群：
      				<input type="checkbox" id="specificPeople10" name="specificPeople1" value="0" onclick="selectSingle(this);checkDisplay(this);" <c:if test="${formDataMap['specificPeople1']=='0'}">checked</c:if>><label for="specificPeople12">否</label>
      				&#12288;<input type="checkbox" id="specificPeople11" name="specificPeople1" value="1" onclick="selectSingle(this);checkDisplay(this);" <c:if test="${formDataMap['specificPeople1']=='1'}">checked</c:if>><label for="specificPeople11">是</label>
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td colspan="3">
      				&nbsp;●&#12288;研究与该人群特点的相互影响是否妥善处理？
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;合理考虑了研究对特殊疾病人群、特定地区人群/族群造成的影响：
      				<input type="checkbox" id="specificPeople21" name="specificPeople2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople2']=='1'}">checked</c:if>><label for="specificPeople21">是</label>
      				&#12288;<input type="checkbox" id="specificPeople20" name="specificPeople2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople2']=='0'}">checked</c:if>><label for="specificPeople20">否</label>
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;合理考虑了外界因素对个人知情同意的影响：
      				<input type="checkbox" id="specificPeople31" name="specificPeople3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople3']=='1'}">checked</c:if>><label for="specificPeople31">是</label>
      				&#12288;<input type="checkbox" id="specificPeople30" name="specificPeople3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople3']=='0'}">checked</c:if>><label for="specificPeople30">否</label>
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;必要时，有向该人群进行咨询的计划：
      				<input type="checkbox" id="specificPeople41" name="specificPeople4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople4']=='1'}">checked</c:if>><label for="specificPeople41">是</label>
      				&#12288;<input type="checkbox" id="specificPeople40" name="specificPeople4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople4']=='0'}">checked</c:if>><label for="specificPeople40">否</label>
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td colspan="3">
      				&nbsp;●&#12288;研究是否促进地区医疗保健与研究能力的发展？
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;培训研究和卫生保健人员：
      				<input type="checkbox" id="specificPeople51" name="specificPeople5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople5']=='1'}">checked</c:if>><label for="specificPeople51">是</label>
      				&#12288;<input type="checkbox" id="specificPeople50" name="specificPeople5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople5']=='0'}">checked</c:if>><label for="specificPeople50">否</label>
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;根据能力培养的需要，提供适当的财务与其它帮助：
      				<input type="checkbox" id="specificPeople61" name="specificPeople6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople6']=='1'}">checked</c:if>><label for="specificPeople61">是</label>
      				&#12288;<input type="checkbox" id="specificPeople60" name="specificPeople6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople6']=='0'}">checked</c:if>><label for="specificPeople60">否</label>
      			</td>
      		</tr>
      		<tr class="specificPeople10" style="display:">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				◇&#12288;加强当地的卫生保健服务，提高应对公共卫生需求的能力，提供必要的物质条件：
      				<input type="checkbox" id="specificPeople71" name="specificPeople7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople7']=='1'}">checked</c:if>><label for="specificPeople71">是</label>
      				&#12288;<input type="checkbox" id="specificPeople70" name="specificPeople7" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['specificPeople7']=='0'}">checked</c:if>><label for="specificPeople70">否</label>
      			</td>
      		</tr>
      		</table>
		</div>
		<div class="title1 clearfix">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<tr>
					<th colspan="2" style="text-align: left;">&nbsp;审查意见</th>
				</tr>
				<tr>
					<td colspan="2" style="text-align: left;">
					建议：<textarea class="validate[maxSize[1000]]" style="width: 100%;border: 0;min-height: 70px;" id="irbSuggest" name="suggest" placeholder="请填写建议">${formDataMap['suggest'] }</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: left;">&nbsp;
						<c:forEach items="${irbDecisionEnumList}" var="dec">
							<c:if test="${pdfn:countMatches(dec.irbTypeId,irbForm.irb.irbTypeId)==1 }">
							<input type="checkbox" id="decision_${dec.id }" name="decision" desc="${dec.name }" value="${dec.id}" onclick="selectSingle(this);"<c:if test="${formDataMap['decision']==dec.id}">checked="checked"</c:if>  />
							<label for="decision_${dec.id }" >${dec.name }</label>&#12288;
							</c:if>
						</c:forEach>
					</td>
				</tr>
				<%--<c:if test="${irbForm.irb.reviewWayId== irbReviewTypeEnumFast.id}">
					<tr>
						<td colspan="2" style="text-align: left;">&nbsp;
							<input type="checkbox" id="submitMeetingReview" name="submitMeetingReview" value="1" onclick="selectSingle(this);"<c:if test="${formDataMap['submitMeetingReview']=='1'}">checked="checked"</c:if>  />
							<label for="submitMeetingReview" >提交会议审查</label>
						</td>
					</tr>
				</c:if>--%>
				<tr>
					<td width="20%" style="text-align: center;">伦理委员会</td>
					<td width="80%">
					${irbInfo.irbName }
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">主审委员声明</td>
					<td width="80%">
					作为审查人员,我与该研究项目之间不存在相关的利益冲突
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">签名</td>
					<td width="80%">
						<input type="text" name="preCommitteeName" value="${empty formDataMap['preCommitteeName'] ?irbUserName:formDataMap['preCommitteeName']}">
					</td>
				</tr>
				<tr>
					<td width="20%" style="text-align: center;">日期</td>
					<td width="80%">
						<input type="text" name="signDate" value="${empty formDataMap['signDate']?pdfn:getCurrDate():formDataMap['signDate'] }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					</td>
				</tr>
			</table>
		</div>
</form>
<div class="button">
	<input class="search" id="saveButton" type="button" value="保&#12288;存" onclick="saveForm();" />
	<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
	<c:if test="${param.open==GlobalConstant.FLAG_Y }">
		<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
	</c:if>
</div>
</div></div>
</body>
</html>