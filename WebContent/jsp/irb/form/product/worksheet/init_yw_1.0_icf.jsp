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
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&userFlow=${userFlow}&irbFlow=${irbForm.irb.irbFlow}&recTypeId=${irbRecTypeEnumInitWorksheetICF.id}";
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
	
	$("[dis]").each(function(){
		var type = $(this).attr("dis");
		if (type == "A") {
			if ('${informException}' == "A") {
				$(this).css("display","");	
			}
		} else if (type == "B") {
			if ('${informException}' == "B") {
				$("[dis='BC']").css("display","none");	
				$(this).css("display","");	
			}
		} else if (type == "C") {
			if ('${informException}' == "C") {
				$("[dis='BC']").css("display","none");
				$(this).css("display","");	
			}
		} else if (type == "D") {
			if ('${informException}' == "D") {
				$(this).css("display","");	
			}
		} else if (type == "E") {
			if ('${informException}' == "E") {
				$(this).css("display","");	
			}
		}
	});
	
	if ("${param.type}" == 'show') {
		hideButton();
	}
	
});

function doClose() {
	top.$.jBox.close('jbox-iframe');
}
</script> 
</head>
<body>
	<div class="mainright">
	<div class="content" align="center">
	<div style="margin-top: 5px;text-align: center;width: 100%;">
		<font size="3"><b>知情同意书审查工作表</b></font>
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
	<div class="title1 clearfix" style="display: ;" dis="BC">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;一、知情告知的要素
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;在要求个体同意参加研究之前，研究者必须以其能理解的语言或其它交流形式提供信息（CIOMS 第5条）
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;书面知情同意书以及其它提供给受试者的书面资料均应包括对下列内容的解释（ICH GCP 4.8.10）
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;试验为研究性质：
      				<input type="checkbox" id="informElement11" name="informElement1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement1']=='1'}">checked</c:if>><label for="informElement11">是</label>
      				&#12288;<input type="checkbox" id="informElement10" name="informElement1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement1']=='0'}">checked</c:if>><label for="informElement10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究目的：
      				<input type="checkbox" id="informElement21" name="informElement2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement2']=='1'}">checked</c:if>><label for="informElement21">是</label>
      				&#12288;<input type="checkbox" id="informElement20" name="informElement2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement2']=='0'}">checked</c:if>><label for="informElement20">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;试验治疗，以及随机分到各组的可能性：
      				<input type="checkbox" id="informElement31" name="informElement3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement3']=='1'}">checked</c:if>><label for="informElement31">是</label>
      				&#12288;<input type="checkbox" id="informElement30" name="informElement3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement3']=='0'}">checked</c:if>><label for="informElement30">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;所需遵循的试验程序，包括所有侵入性操作：
      				<input type="checkbox" id="informElement41" name="informElement4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement4']=='1'}">checked</c:if>><label for="informElement41">是</label>
      				&#12288;<input type="checkbox" id="informElement40" name="informElement4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement4']=='0'}">checked</c:if>><label for="informElement40">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related=";1,2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究方法，以及准备收集的信息种类：
      				<input type="checkbox" id="informElement51" name="informElement5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement5']=='1'}">checked</c:if>><label for="informElement51">是</label>
      				&#12288;<input type="checkbox" id="informElement50" name="informElement5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement5']=='0'}">checked</c:if>><label for="informElement50">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者责任：
      				<input type="checkbox" id="informElement61" name="informElement6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement6']=='1'}">checked</c:if>><label for="informElement61">是</label>
      				&#12288;<input type="checkbox" id="informElement60" name="informElement6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement6']=='0'}">checked</c:if>><label for="informElement60">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;试验性干预措施/程序的说明：
      				<input type="checkbox" id="informElement71" name="informElement7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement7']=='1'}">checked</c:if>><label for="informElement71">是</label>
      				&#12288;<input type="checkbox" id="informElement70" name="informElement7" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement7']=='0'}">checked</c:if>><label for="informElement70">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;与试验相关的预期风险和不适（必要时，包括对胚胎、胎儿或哺乳婴儿）：
      				<input type="checkbox" id="informElement81" name="informElement8" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement8']=='1'}">checked</c:if>><label for="informElement81">是</label>
      				&#12288;<input type="checkbox" id="informElement80" name="informElement8" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement8']=='0'}">checked</c:if>><label for="informElement80">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related=";1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;与试验相关的预期风险和不适（必要时，包括对家族相关成员）：
      				<input type="checkbox" id="informElement91" name="informElement9" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement9']=='1'}">checked</c:if>><label for="informElement91">是</label>
      				&#12288;<input type="checkbox" id="informElement90" name="informElement9" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement9']=='0'}">checked</c:if>><label for="informElement90">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;合理预期的受益。如果对受试者没有预期受益，应加以告知：
      				<input type="checkbox" id="informElement101" name="informElement10" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement10']=='1'}">checked</c:if>><label for="informElement101">是</label>
      				&#12288;<input type="checkbox" id="informElement100" name="informElement10" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement10']=='0'}">checked</c:if>><label for="informElement100">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者可能获得的其他备选治疗或疗法，及其重要的受益和风险：
      				<input type="checkbox" id="informElement111" name="informElement11" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement11']=='1'}">checked</c:if>><label for="informElement111">是</label>
      				&#12288;<input type="checkbox" id="informElement110" name="informElement11" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement11']=='0'}">checked</c:if>><label for="informElement110">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;如发生与试验有关的伤害事件，受试者可能获得的补偿和/或治疗：
      				<input type="checkbox" id="informElement121" name="informElement12" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement12']=='1'}">checked</c:if>><label for="informElement121">是</label>
      				&#12288;<input type="checkbox" id="informElement120" name="informElement12" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement12']=='0'}">checked</c:if>><label for="informElement120">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;对受试者参加研究所预定的、按比例支付的补偿（如有）：
      				<input type="checkbox" id="informElement131" name="informElement13" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement13']=='1'}">checked</c:if>><label for="informElement131">是</label>
      				&#12288;<input type="checkbox" id="informElement130" name="informElement13" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement13']=='0'}">checked</c:if>><label for="informElement130">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者参加试验的预期花费（如有）：
      				<input type="checkbox" id="informElement141" name="informElement14" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement14']=='1'}">checked</c:if>><label for="informElement141">是</label>
      				&#12288;<input type="checkbox" id="informElement140" name="informElement14" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement14']=='0'}">checked</c:if>><label for="informElement140">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者参加试验是自愿的，受试者可以拒绝参加或在任何时候退出试验而不会因此受到处罚或其应得利益不会遭受损失：
      				<input type="checkbox" id="informElement151" name="informElement15" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement15']=='1'}">checked</c:if>><label for="informElement151">是</label>
      				&#12288;<input type="checkbox" id="informElement150" name="informElement15" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement15']=='0'}">checked</c:if>><label for="informElement150">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;监察员、稽查员、机构审查委员会/独立伦理委员会和管理当局应被准予在不违反适用法律和法规所准许的范围内，在不侵犯受试者的隐私的情况下，直接查阅受试者的原始医疗记录以便核查临床试验的程序和/或数据受试者或其合法代理人在签署书面知情同意书时即授权这种查阅：
      				<input type="checkbox" id="informElement161" name="informElement16" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement16']=='1'}">checked</c:if>><label for="informElement161">是</label>
      				&#12288;<input type="checkbox" id="informElement160" name="informElement16" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement16']=='0'}">checked</c:if>><label for="informElement160">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;在适用法律和/或法规准许的范围内，有关识别受试者的记录应保密，不得公开这些记录，如公开发表试验结果，受试者的身份仍然是保密的：
      				<input type="checkbox" id="informElement171" name="informElement17" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement17']=='1'}">checked</c:if>><label for="informElement171">是</label>
      				&#12288;<input type="checkbox" id="informElement170" name="informElement17" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement17']=='0'}">checked</c:if>><label for="informElement170">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;如果得到可能影响受试者继续参加试验的信息，受试者或其合法代理人将及时得到通报：
      				<input type="checkbox" id="informElement181" name="informElement18" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement18']=='1'}">checked</c:if>><label for="informElement181">是</label>
      				&#12288;<input type="checkbox" id="informElement180" name="informElement18" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement18']=='0'}">checked</c:if>><label for="informElement180">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;需要进一步了解有关试验资料和受试者的权益时的联系人以及如发生试验相关的伤害时的联系人：
      				<input type="checkbox" id="informElement191" name="informElement19" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement19']=='1'}">checked</c:if>><label for="informElement191">是</label>
      				&#12288;<input type="checkbox" id="informElement190" name="informElement19" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement19']=='0'}">checked</c:if>><label for="informElement190">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者参加试验可能被终止的预期情况和/或原因：
      				<input type="checkbox" id="informElement201" name="informElement20" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement20']=='1'}">checked</c:if>><label for="informElement201">是</label>
      				&#12288;<input type="checkbox" id="informElement200" name="informElement20" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement20']=='0'}">checked</c:if>><label for="informElement200">否</label>
      			</td>
      		</tr>
      		<tr style="display:none" related="1;2">
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者参加试验的预期持续时间：
      				<input type="checkbox" id="informElement211" name="informElement21" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement21']=='1'}">checked</c:if>><label for="informElement211">是</label>
      				&#12288;<input type="checkbox" id="informElement210" name="informElement21" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement21']=='0'}">checked</c:if>><label for="informElement210">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究涉及受试者的大致人数：
      				<input type="checkbox" id="informElement221" name="informElement22" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement22']=='1'}">checked</c:if>><label for="informElement221">是</label>
      				&#12288;<input type="checkbox" id="informElement220" name="informElement22" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement22']=='0'}">checked</c:if>><label for="informElement220">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;知情同意书没有任何要求受试者或其合法代表放弃其合法权益的内容，没有免除研究者、研究机构、申办者或其合法代表逃避过失责任的内容：
      				<input type="checkbox" id="informElement231" name="informElement23" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement23']=='1'}">checked</c:if>><label for="informElement231">是</label>
      				&#12288;<input type="checkbox" id="informElement230" name="informElement23" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement23']=='0'}">checked</c:if>><label for="informElement230">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;告知信息的语言表述适合受试者群体的理解水平：
      				<input type="checkbox" id="informElement241" name="informElement24" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement24']=='1'}">checked</c:if>><label for="informElement241">是</label>
      				&#12288;<input type="checkbox" id="informElement240" name="informElement24" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement24']=='0'}">checked</c:if>><label for="informElement240">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;上述告知的信息（特别是受试人群、试验干预与试验程序）是否与方案一致：
      				<input type="checkbox" id="informElement251" name="informElement25" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement25']=='1'}">checked</c:if>><label for="informElement251">是</label>
      				&#12288;<input type="checkbox" id="informElement250" name="informElement25" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informElement25']=='0'}">checked</c:if>><label for="informElement250">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix" style="display: ;" dis="BC">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;二、知情同意的过程
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;对于所有的人体生物医学研究，研究者必须获得受试者自愿做出的知情同意，若在个体不能给予知情同意的情况下，必须根据现行法律获得其法定代理人的许可（CIOMS 第4条）
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;只有在确定可能的受试对象充分了解了参加研究的有关实情和后果，并有充分的机会考虑是否参加以后，才能征求同意（CIOMS 第5条）
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;招募受试者过程没有胁迫和不正当的影响：
      				<input type="checkbox" id="informProcess11" name="informProcess1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess1']=='1'}">checked</c:if>><label for="informProcess11">是</label>
      				&#12288;<input type="checkbox" id="informProcess10" name="informProcess1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess1']=='0'}">checked</c:if>><label for="informProcess10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;获得知情同意前，受试者或其合法代表有足够的时间和机会以询问有关试验的细节，提出的所有与试验相关的问题均应得到令其满意的答复：
      				<input type="checkbox" id="informProcess21" name="informProcess2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess2']=='1'}">checked</c:if>><label for="informProcess21">是</label>
      				&#12288;<input type="checkbox" id="informProcess20" name="informProcess2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess2']=='0'}">checked</c:if>><label for="informProcess20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;参加试验前，受试者本人或其合法代表，以及负责知情同意讨论的人应签署书面知情同意书、并各自注明日期：
      				<input type="checkbox" id="informProcess31" name="informProcess3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess3']=='1'}">checked</c:if>><label for="informProcess31">是</label>
      				&#12288;<input type="checkbox" id="informProcess30" name="informProcess3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess3']=='0'}">checked</c:if>><label for="informProcess30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;应将获得伦理委员会批准，经签字并注明日期的知情同意书/更新件、任何其他提供给受试者的书面资料/更新件交给受试者或其合法代表：
      				<input type="checkbox" id="informProcess41" name="informProcess4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess4']=='1'}">checked</c:if>><label for="informProcess41">是</label>
      				&#12288;<input type="checkbox" id="informProcess40" name="informProcess4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess4']=='0'}">checked</c:if>><label for="informProcess40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;当受试者没有能力、或不能充分地给予知情同意时（如未到法定年龄，或严重痴呆病人），应获得其合法代表的同意；同时，应根据受试者可理解程度告知受试者有关试验情况；如可能，受试者应签署书面知情书并注明日期：
      				<input type="checkbox" id="informProcess51" name="informProcess5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess5']=='1'}">checked</c:if>><label for="informProcess51">是</label>
      				&#12288;<input type="checkbox" id="informProcess50" name="informProcess5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess5']=='0'}">checked</c:if>><label for="informProcess50">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;同时开展2项研究，有一项研究使用本项临床试验受试者的生物材料（包括遗传物质），应以单独的一个章节的方式告知受试者并征得同意：
      				<input type="checkbox" id="informProcess61" name="informProcess6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess6']=='1'}">checked</c:if>><label for="informProcess6">不适用</label>
      				&#12288;<input type="checkbox" id="informProcess62" name="informProcess6" value="2" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess6']=='2'}">checked</c:if>><label for="informProcess6">是</label>
      				&#12288;<input type="checkbox" id="informProcess63" name="informProcess6" value="3" onclick="selectSingle(this);" <c:if test="${formDataMap['informProcess6']=='3'}">checked</c:if>><label for="informProcess6">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix" style="display: none;" dis="A">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;三、申请开展在紧急情况下无法获得知情同意的研究
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;适用性判断</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本项研究同时满足以下条件：
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;处于危及生命的紧急状况，需要在发病后很快进行干预：
      				<input type="checkbox" id="informExceptA11" name="informExceptA1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA1']=='1'}">checked</c:if>><label for="informExceptA11">是</label>
      				&#12288;<input type="checkbox" id="informExceptA10" name="informExceptA1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA1']=='0'}">checked</c:if>><label for="informExceptA10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;在该紧急情况下，大部分病人无法给予知情同意，且没有时间找到合法代表人：
      				<input type="checkbox" id="informExceptA21" name="informExceptA2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA2']=='1'}">checked</c:if>><label for="informExceptA21">是</label>
      				&#12288;<input type="checkbox" id="informExceptA20" name="informExceptA2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA2']=='0'}">checked</c:if>><label for="informExceptA20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;缺乏已被证实有效的治疗方法，而试验药物或干预有望挽救生命，恢复健康，或减轻病痛：
      				<input type="checkbox" id="informExceptA31" name="informExceptA3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA3']=='1'}">checked</c:if>><label for="informExceptA31">是</label>
      				&#12288;<input type="checkbox" id="informExceptA30" name="informExceptA3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA3']=='0'}">checked</c:if>><label for="informExceptA30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;方案根据目前的科学证据，制定了必须给予试验干预的治疗窗；该治疗窗包括了一个合适的联系合法代表人的时间段：
      				<input type="checkbox" id="informExceptA41" name="informExceptA4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA4']=='1'}">checked</c:if>><label for="informExceptA41">是</label>
      				&#12288;<input type="checkbox" id="informExceptA40" name="informExceptA4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA4']=='0'}">checked</c:if>><label for="informExceptA40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究者承诺在开始研究之前，在治疗窗的分段时间内，尽力联系患者的合法代表人，并有证明努力尝试联系的文件记录：
      				<input type="checkbox" id="informExceptA51" name="informExceptA5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA5']=='1'}">checked</c:if>><label for="informExceptA51">是</label>
      				&#12288;<input type="checkbox" id="informExceptA50" name="informExceptA5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA5']=='0'}">checked</c:if>><label for="informExceptA50">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;一旦病人的状态许可，或找到其合法代表人，应告知所有相关信息，并尽可能早地获得其反对或继续参加研究的意见：
      				<input type="checkbox" id="informExceptA61" name="informExceptA6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA6']=='1'}">checked</c:if>><label for="informExceptA61">是</label>
      				&#12288;<input type="checkbox" id="informExceptA60" name="informExceptA6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA6']=='0'}">checked</c:if>><label for="informExceptA60">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究项目制定了社区咨询计划，向研究人群利益相关方充分告知研究的风险与预期受益，征求他们的意见；伦理委员会部分/全体成员将参加咨询活动：
      				<input type="checkbox" id="informExceptA71" name="informExceptA7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA7']=='1'}">checked</c:if>><label for="informExceptA71">是</label>
      				&#12288;<input type="checkbox" id="informExceptA70" name="informExceptA7" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA7']=='0'}">checked</c:if>><label for="informExceptA70">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究项目制定了在研究开始前公开披露信息计划，以保证更广泛的研究人群利益相关方获知研究计划及其风险与预期受益：
      				<input type="checkbox" id="informExceptA81" name="informExceptA8" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA8']=='1'}">checked</c:if>><label for="informExceptA81">是</label>
      				&#12288;<input type="checkbox" id="informExceptA80" name="informExceptA8" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA8']=='0'}">checked</c:if>><label for="informExceptA80">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究得到所在社会的支持：
      				<input type="checkbox" id="informExceptA91" name="informExceptA9" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA9']=='1'}">checked</c:if>><label for="informExceptA91">是</label>
      				&#12288;<input type="checkbox" id="informExceptA90" name="informExceptA9" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA9']=='0'}">checked</c:if>><label for="informExceptA90">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;建立了独立的数据与安全监查委员会：
      				<input type="checkbox" id="informExceptA101" name="informExceptA10" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA10']=='1'}">checked</c:if>><label for="informExceptA101">是</label>
      				&#12288;<input type="checkbox" id="informExceptA100" name="informExceptA10" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA10']=='0'}">checked</c:if>><label for="informExceptA100">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;对既未获得受试者个体知情同意，又未得到法定代理人许可，主审委员对受试者个体参加研究的最大时限的建议是：
      				<input type="text" style="width: 50px;" name="informExceptA11" value="${formDataMap['informExceptA11'] }">（天）
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;如果疾病是周期性复发的（如癫痫），研究者应设法确定将来可能发生符合研究条件疾病的人群，在可能的受试者有充分能力给出知情同意的时候与之联系，并请其同意在将来疾病发作、无能力表达同意的时候参加试验：
      				<input type="checkbox" id="informExceptA121" name="informExceptA12" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA12']=='1'}">checked</c:if>><label for="informExceptA121">是</label>
      				&#12288;<input type="checkbox" id="informExceptA120" name="informExceptA12" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptA12']=='0'}">checked</c:if>><label for="informExceptA120">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix" style="display: none;" dis="B">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;利用在临床诊疗中获得的病历/生物标本的研究，申请免除知情同意
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
			<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;通常情况下，医生必须寻求受试者对采集、分析、存放和/或再次使用人体材料或数据的同意意见
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;当研究涉及仅仅涉及极小的风险，并且要求病人/受试者的知情同意会使研究的实施不可行（例如，研究仅仅涉及摘录受试者病案的数据），伦理委员会可以部分或全部免除知情同意（CIOMS 第4条）
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;病人有权知道其病历/标本可能用于研究，其拒绝或不同意参加研究，不是研究无法实施、免除知情同意的证据（CIOMS 第4条）
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;病人/受试者以前已明确地拒绝利用的医疗记录和标本，只有在公共卫生紧急需要时才可利用（CIOMS 第4条）
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;适用性判断</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本项研究为：利用在临床诊疗中获得的病历/生物标本的观察性研究：
      				<input type="checkbox" id="informExceptB11" name="informExceptB1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB1']=='1'}">checked</c:if>><label for="informExceptB11">是</label>
      				&#12288;<input type="checkbox" id="informExceptB10" name="informExceptB1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB1']=='0'}">checked</c:if>><label for="informExceptB10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究目的重要：
      				<input type="checkbox" id="informExceptB21" name="informExceptB2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB2']=='1'}">checked</c:if>><label for="informExceptB21">是</label>
      				&#12288;<input type="checkbox" id="informExceptB20" name="informExceptB2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB2']=='0'}">checked</c:if>><label for="informExceptB20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;研究对受试者的风险不大于最小风险：
      				<input type="checkbox" id="informExceptB31" name="informExceptB3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB3']=='1'}">checked</c:if>><label for="informExceptB31">是</label>
      				&#12288;<input type="checkbox" id="informExceptB30" name="informExceptB3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB3']=='0'}">checked</c:if>><label for="informExceptB30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;免除知情同意不会对受试者的权利和健康产生不利的影响：
      				<input type="checkbox" id="informExceptB41" name="informExceptB4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB4']=='1'}">checked</c:if>><label for="informExceptB41">是</label>
      				&#12288;<input type="checkbox" id="informExceptB40" name="informExceptB4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB4']=='0'}">checked</c:if>><label for="informExceptB40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者的隐私和身份信息的保密得到保证：
      				<input type="checkbox" id="informExceptB51" name="informExceptB5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB5']=='1'}">checked</c:if>><label for="informExceptB51">是</label>
      				&#12288;<input type="checkbox" id="informExceptB50" name="informExceptB5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB5']=='0'}">checked</c:if>><label for="informExceptB50">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;若规定需获取知情同意，将使研究不可行（病人有权知道其病历/标本可能用于研究，其拒绝或不同意参加研究，不是研究无法实施、免除知情同意的证据）：
      				<input type="checkbox" id="informExceptB61" name="informExceptB6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB6']=='1'}">checked</c:if>><label for="informExceptB61">是</label>
      				&#12288;<input type="checkbox" id="informExceptB60" name="informExceptB6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB6']=='0'}">checked</c:if>><label for="informExceptB60">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本研究不利用病人/受试者以前已明确地拒绝利用的医疗记录和标本：
      				<input type="checkbox" id="informExceptB71" name="informExceptB7" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB7']=='1'}">checked</c:if>><label for="informExceptB71">是</label>
      				&#12288;<input type="checkbox" id="informExceptB70" name="informExceptB7" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptB7']=='0'}">checked</c:if>><label for="informExceptB70">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix" style="display: none;" dis="C">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;研究病历/生物标本的二次利用，申请免除知情同意
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
			<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查原则</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;如果最初处于研究目的、经知情同意而收集的病历或标本，二次利用通常受到原知情同意条件的限制（CIOMS 第4条）
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;重要的是在最初的知情同意过程中预见将来利用这些病历或标本用于研究的计划；如有必要，征求受试者同意：
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;如果有二次利用，是否局限于使用这些材料的研究类型
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;在什么情况下要求研究者与受试者联系，为二次利用寻求再次授权
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;若有的话，研究者销毁或去除病历或标本上个人标识符的计划
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;受试者要求对生物标本、或病历、或他们认为特别敏感的病历部分进行销毁或匿名的权利（CIOMS 第4条）
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;适用性判断</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本项研究为：研究病历与生物标本的二次利用的观察性研究，即利用以往研究项目、经知情同意收集的病历或标本进行研究，申请免除知情同意：
      				<input type="checkbox" id="informExceptC11" name="informExceptC1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC1']=='1'}">checked</c:if>><label for="informExceptC11">是</label>
      				&#12288;<input type="checkbox" id="informExceptC10" name="informExceptC1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC1']=='0'}">checked</c:if>><label for="informExceptC10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;原知情同意书同意其他研究项目利用病历或标本：
      				<input type="checkbox" id="informExceptC21" name="informExceptC2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC2']=='1'}">checked</c:if>><label for="informExceptC21">是</label>
      				&#12288;<input type="checkbox" id="informExceptC20" name="informExceptC2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC2']=='0'}">checked</c:if>><label for="informExceptC20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本次研究符合原知情同意条件的限制：
      				<input type="checkbox" id="informExceptC31" name="informExceptC3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC3']=='1'}">checked</c:if>><label for="informExceptC31">是</label>
      				&#12288;<input type="checkbox" id="informExceptC30" name="informExceptC3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC3']=='0'}">checked</c:if>><label for="informExceptC30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;受试者的隐私和身份信息的保密得到保证：
      				<input type="checkbox" id="informExceptC41" name="informExceptC4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC4']=='1'}">checked</c:if>><label for="informExceptC41">是</label>
      				&#12288;<input type="checkbox" id="informExceptC40" name="informExceptC4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptC4']=='0'}">checked</c:if>><label for="informExceptC40">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix" style="display: none;" dis="D">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;三、签了字的知情同意书会对受试者的隐私构成不正当的威胁，申请免除知情同意签字
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;适用性判断</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本项研究同时满足以下条件：
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;当一份签了字的知情同意书会对受试者的隐私构成不正当的威胁：
      				<input type="checkbox" id="informExceptD11" name="informExceptD1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD1']=='1'}">checked</c:if>><label for="informExceptD11">是</label>
      				&#12288;<input type="checkbox" id="informExceptD10" name="informExceptD1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD1']=='0'}">checked</c:if>><label for="informExceptD10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;联系受试者真实身份和研究的唯一记录是知情同意文件，并且主要风险就来自于破坏机密：
      				<input type="checkbox" id="informExceptD21" name="informExceptD2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD2']=='1'}">checked</c:if>><label for="informExceptD21">是</label>
      				&#12288;<input type="checkbox" id="informExceptD20" name="informExceptD2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD2']=='0'}">checked</c:if>><label for="informExceptD20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;遵循每一位受试者本人的意愿，签署或不签署书面知情同意文件：
      				<input type="checkbox" id="informExceptD31" name="informExceptD3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD3']=='1'}">checked</c:if>><label for="informExceptD31">是</label>
      				&#12288;<input type="checkbox" id="informExceptD30" name="informExceptD3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD3']=='0'}">checked</c:if>><label for="informExceptD30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;向受试者或其合法代表人提供书面信息告知文件：
      				<input type="checkbox" id="informExceptD41" name="informExceptD4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD4']=='1'}">checked</c:if>><label for="informExceptD41">是</label>
      				&#12288;<input type="checkbox" id="informExceptD40" name="informExceptD4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD4']=='0'}">checked</c:if>><label for="informExceptD40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;方案规定应获得受试者或其合法代表人的口头知情同意：
      				<input type="checkbox" id="informExceptD51" name="informExceptD5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD5']=='1'}">checked</c:if>><label for="informExceptD51">是</label>
      				&#12288;<input type="checkbox" id="informExceptD50" name="informExceptD5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptD5']=='0'}">checked</c:if>><label for="informExceptD50">否</label>
      			</td>
      		</tr>
		</table>
		</div>
		
	<div class="title1 clearfix" style="display: none;" dis="E">
	<div style="margin-bottom:5px;text-align: left;width: 100%;font-weight: bold;">
		&nbsp;三、与研究相同情况下的行为与程序不要求签署书面同意，申请免除知情同意签字
	</div>
		<table width="100%" cellpadding="0" cellspacing="0" class="basic">
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;适用性判断</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;本项研究同时满足以下条件：
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;研究对受试者的风险不大于最小风险：
      				<input type="checkbox" id="informExceptE11" name="informExceptE1" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE1']=='1'}">checked</c:if>><label for="informExceptE11">是</label>
      				&#12288;<input type="checkbox" id="informExceptE10" name="informExceptE1" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE1']=='0'}">checked</c:if>><label for="informExceptE10">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td>
      				◇&#12288;如果脱离“研究”背景，相同情况下的行为或程序不要求签署书面知情同意（如访谈研究，邮件/电话调查）：
      				<input type="checkbox" id="informExceptE21" name="informExceptE2" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE2']=='1'}">checked</c:if>><label for="informExceptE21">是</label>
      				&#12288;<input type="checkbox" id="informExceptE20" name="informExceptE2" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE2']=='0'}">checked</c:if>><label for="informExceptE20">否</label>
      			</td>
      		</tr>
      		<tr>
      			<th colspan="3" style="text-align: left;">&nbsp;审查要素</th>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;确认研究对受试者的风险不大于最小风险：
      				<input type="checkbox" id="informExceptE31" name="informExceptE3" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE3']=='1'}">checked</c:if>><label for="informExceptE31">是</label>
      				&#12288;<input type="checkbox" id="informExceptE30" name="informExceptE3" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE3']=='0'}">checked</c:if>><label for="informExceptE30">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;确认如果脱离“研究”背景，相同情况下的行为或程序不要求签署书面知情同意：
      				<input type="checkbox" id="informExceptE41" name="informExceptE4" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE4']=='1'}">checked</c:if>><label for="informExceptE41">是</label>
      				&#12288;<input type="checkbox" id="informExceptE40" name="informExceptE4" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE4']=='0'}">checked</c:if>><label for="informExceptE40">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;向受试者或其合法代表人提供书面信息告知文件：
      				<input type="checkbox" id="informExceptE51" name="informExceptE5" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE5']=='1'}">checked</c:if>><label for="informExceptE51">是</label>
      				&#12288;<input type="checkbox" id="informExceptE50" name="informExceptE5" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE5']=='0'}">checked</c:if>><label for="informExceptE50">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="10px" style="border-right: 0;">&nbsp;</td>
      			<td colspan="2">
      				●&#12288;方案规定应获得受试者或其合法代表人的口头知情同意：
      				<input type="checkbox" id="informExceptE61" name="informExceptE6" value="1" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE6']=='1'}">checked</c:if>><label for="informExceptE61">是</label>
      				&#12288;<input type="checkbox" id="informExceptE60" name="informExceptE6" value="0" onclick="selectSingle(this);" <c:if test="${formDataMap['informExceptE6']=='0'}">checked</c:if>><label for="informExceptE60">否</label>
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
	<input class="search" type="button" value="保&#12288;存" onclick="saveForm();" />
	<input class="search" type="button" showFlag="${GlobalConstant.FLAG_Y }" value="打&#12288;印" onclick="print();" />
	<c:if test="${param.open == GlobalConstant.FLAG_Y }">
		<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
	</c:if>
</div>
</div></div>
</body>
</html>