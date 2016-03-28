<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<%@page import="java.util.*"%> 
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
	var url ="<s:url value='/irb/print'/>?watermarkFlag=${GlobalConstant.FLAG_N}&irbFlow=${sessionScope.currIrb.irbFlow}&recTypeId=${irbRecTypeEnumInitApplication.id}";
	window.location.href= url;
}

function showTip(type){ 
	if(type == 0){ 
		jboxTip("实验性研究（Experimental Research）：实验性研究将实验室中运用的方法用到人群研究之中。<br/>在研究过程中，人为地对研究对象或其环境施加干预因素，然后，通过随访观察和分析，来检验或考核干预因素所起作用的大小。"); 
	}else { 
		jboxTip("观察性研究（Observational Research）：观察性研究又称非实验性研究。该研究不能人为设置处理因素。<br/>如研究母乳喂养与人工喂养儿童的生长发育情况，儿童是否喂养、以及喂养的方式不是由研究者所确定的，而是根据母亲的实际情况确定的。"); 
	} 
}

function checkAbled(obj){ 
	var name = $(obj).attr("name");
	$("[name='"+name+"']").each(function(){
		var object = $(this);
		var id = $(object).attr("id");
		$("[related*='"+id+"']").each(function(){
			var ids = $(this).attr("related").split(";");
			if (ids.indexOf(id) > -1) {		//避免id部分相同情况
				var subFlag = subTypeDis($(this).attr("id"));
				if($(object).attr("checked") && subFlag ){
					$(this).attr("disabled",false);	
				}else{
					$(this).attr("disabled",true);	
					//值清空
					if ($(this).attr("checked")) {
						if ($(this).attr("checked",true)) {
							$(this).attr("checked",false);
						}
					} else {
						$(this).val("");
					}
				}
			}
		});
	});
}

function checkDisabled(obj){ 
	var name = $(obj).attr("name");
	var flag = false;
	var factor = "";
	if ($(obj).attr("type") == "checkbox") {
		factor = "[id='"+$(obj).attr("id")+"']";
	}
	$("[name='"+name+"']"+factor).each(function(){
		if (flag && num == total) {
			return false;
		}
		var num = 0;
		var total = 0;
		var object = $(this);
		var id = $(object).attr("id");
		$("[disRelated*='"+id+"']").each(function(){
			var ids = $(this).attr("disRelated").split(",");
			if (ids.indexOf(id) > -1) {
				total++;
			}
		});
		$("[disRelated*='"+id+"']").each(function(){
			var ids = $(this).attr("disRelated").split(",");
			if (ids.indexOf(id) > -1) {
				num++;
				var subFlag = subTypeDis($(this).attr("id"));
				if($(object).attr("checked")){
					flag = true;
					$(this).attr("disabled",true);
					//值清空
					if ($(this).attr("checked")) {
						if ($(this).attr("checked",true)) {
							$(this).attr("checked",false);
						}
					} else {
						$(this).val("");
					}
					
					//处理对应的dispaly
					checkDisplay($(this));
				}else if (subFlag) {
					$(this).attr("disabled",false);
				}
			}
		});
	});
}

function checkDisplay(obj){ 
	var name = $(obj).attr("name");
	$("[name='"+name+"']").each(function(){
		var object = $(this);
		$("."+$(object).attr("id")).each(function(){
			if($(object).attr("checked")){
				$(this).css("display","");
			}else{
				$(this).css("display","none");
			}
		});
	});
}

$(document).ready(function(){
	$("[related]").each(function(){
		var ids = $(this).attr("related").split(";");
		for (var i=0;i<ids.length;i++) {
			var id = ids[i];
			var subFlag = subTypeDis($(this).attr("id"));
			if($("#"+id).attr("checked") && subFlag){
				$(this).attr("disabled",false);			
			}else{
				$(this).attr("disabled",true);	
			}
		}
	});
	
	$("[disRelated]").each(function(){
		var ids = $(this).attr("disRelated").split(",");
		for (var i=0;i<ids.length;i++) {
			var id = ids[i];
			var subFlag = subTypeDis($(this).attr("id"));
			if($("#"+id).attr("checked")){	
				$(this).attr("disabled",true);	
				return;		//有一个关联项被选中则disabled为true
			}else if (subFlag) {
				$(this).attr("disabled",false);	
			}
		}
	});
	
	$("tr:hidden").each(function(){
		var id = $(this).attr("class");
		if($("#"+id).attr("checked")){
			$(this).css("display","");	
		}else{
			$(this).css("display","none");	
		}
	});
	
	if ('${proj.projCategoryId}'!= 'qx') {
		$("[name='researchInfo6']").attr("disabled",true);
	}
	
	$("[dis]").each(function(){
		var dis = $(this).attr("dis");
		var id = dis.split(",")[0];
		var type = dis.split(",")[1];
		isDisabled(id,type);
	});
	
	$("[isChecked]").each(function(){
		var id = $(this).attr("isChecked");
		isChecked(id);
	});
	
});

function isDisabled(id,type){ 
	var isPjPeriod = false; 
	var projSubTypes = new Array("Ⅰ","Ⅱ","Ⅲ","Qx");
	if (projSubTypes.indexOf('${proj.projSubTypeId}') > -1){ 
		isPjPeriod = true; 
	}
	
	if (type == "1") {
		if (isPjPeriod || '${proj.projSubTypeId}' == 'Ⅳ') {
			$("#"+id).attr("disabled",true);	
		}
	} else {
		if (isPjPeriod) {
			$("#"+id).attr("disabled",true);	
		}
	}
}

function isChecked(id){ 
	var isPjPeriod = false; 
	var projSubTypes = new Array("Ⅰ","Ⅱ","Ⅲ","Qx");
	if (projSubTypes.indexOf('${proj.projSubTypeId}') > -1){ 
		isPjPeriod = true; 
	}
	
	if (isPjPeriod) {
		$("#"+id).attr("checked",true);	
	}
}

function subTypeDis(id){
	//Ⅳ期：不能选择回顾性观察性研究,不能选“申请免除知情同意签字”
	if ((id=="obserStudyType1" || id=="informException4" ||id=="informException5") && '${proj.projSubTypeId}' == 'Ⅳ'){
		return false;
	} else {
		return true;
	}
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
		<font size="3"><b>初始审查申请</b></font>
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
        		<th colspan="3" style="text-align: left;">&nbsp;方案设计类型</th>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        			<input type="radio" id="researchType1" name="researchType" value="1" ischecked="researchType1" onclick="showTip(0);checkAbled(this);checkDisabled(this);" <c:if test="${fn:indexOf(formDataMap['researchType'],'1')>-1}">checked</c:if>><label for="researchType1">实验性研究</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        			<input type="radio" id="researchType2" name="researchType" value="2" dis="researchType2,0" onclick="showTip(1);checkAbled(this);checkDisabled(this);"<c:if test="${fn:indexOf(formDataMap['researchType'],'2')>-1 }">checked</c:if>><label for="researchType2">观察性研究：</label>
        			<input type="checkbox" id="obserStudyType1" name="obserStudyType" related="researchType2" dis="obserStudyType1,1" value="1"  onclick="checkDisabled(this);"<c:if test="${fn:indexOf(formDataMap['obserStudyType'],'1')>-1 }">checked</c:if>><label for="obserStudyType1">回顾性分析</label>
        			&#12288;<input type="checkbox" id="obserStudyType2" name="obserStudyType" related="researchType2" dis="obserStudyType2,0" value="2"  onclick="checkDisabled(this);checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['obserStudyType'],'2')>-1 }">checked</c:if>><label for="obserStudyType2">前瞻性研究</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        			<input type="radio" id="researchType3" name="researchType" value="3" dis="researchType3,0" onclick="checkAbled(this);checkDisabled(this);"<c:if test="${fn:indexOf(formDataMap['researchType'],'3')>-1 }">checked</c:if>><label for="researchType3">利用人的生物标本的研究：</label>
        			<input type="checkbox"  id="pastAcquisition1" name="pastAcquisition" related="researchType3" value="1" <c:if test="${fn:indexOf(formDataMap['pastAcquisition'],'1')>-1 }">checked</c:if>><label for="pastAcquisition1">以往采集保存</label>
        			&#12288;<input type="checkbox"  id="pastAcquisition2" name="pastAcquisition" related="researchType3" value="2" <c:if test="${fn:indexOf(formDataMap['pastAcquisition'],'2')>-1 }">checked</c:if>><label for="pastAcquisition2">研究采集</label>
        		</td>
      		</tr>
      		<tr>
        		<th colspan="3" style="text-align: left;">&nbsp;研究信息</th>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">资金来源：
        			<input type="checkbox" id="researchInfo11" name="researchInfo1" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo1'],'1')>-1 }">checked</c:if>><label for="researchInfo11">企业</label>
        			&#12288;<input type="checkbox" id="researchInfo12" name="researchInfo1" value="2" <c:if test="${fn:indexOf(formDataMap['researchInfo1'],'2')>-1 }">checked</c:if>><label for="researchInfo12">政府</label>
        			&#12288;<input type="checkbox" id="researchInfo13" name="researchInfo1" value="3" <c:if test="${fn:indexOf(formDataMap['researchInfo1'],'3')>-1 }">checked</c:if>><label for="researchInfo13">学术团体</label>
        			&#12288;<input type="checkbox" id="researchInfo14"name="researchInfo1" value="4" <c:if test="${fn:indexOf(formDataMap['researchInfo1'],'4')>-1 }">checked</c:if>><label for="researchInfo14">本单位</label>
        			&#12288;<input type="checkbox" id="researchInfo15" name="researchInfo1" value="5" <c:if test="${fn:indexOf(formDataMap['researchInfo1'],'5')>-1 }">checked</c:if>><label for="researchInfo15">自筹</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">数据与安全监察委员会：
        			<input type="radio" id="researchInfo21" name="researchInfo2" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo2'],'1')>-1 }">checked</c:if>><label for="researchInfo21">有</label>
        			&#12288;<input type="radio" id="researchInfo20" name="researchInfo2" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo2'],'0')>-1 }">checked</c:if>><label for="researchInfo20">无</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">其它伦理委员会对该项目的否定性、或提前中止的决定：
        			<input type="radio" id="researchInfo30" name="researchInfo3" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo3'],'0')>-1 }">checked</c:if>><label for="researchInfo30">无</label>
        			&#12288;<input type="radio" id="researchInfo31" name="researchInfo3" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo3'],'1')>-1 }">checked</c:if>><label for="researchInfo31">有</label> →请提交相关文件
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">研究需要使用人体生物标本：
        			<input type="radio" id="researchInfo401" name="researchInfo4" value="1" onclick="checkAbled(this);"  <c:if test="${fn:indexOf(formDataMap['researchInfo4'],'1')>-1 }">checked</c:if>><label for="researchInfo401">是</label>
        			&#12288;<input type="radio" id="researchInfo400" name="researchInfo4" value="0" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['researchInfo4'],'0')>-1 }">checked</c:if>><label for="researchInfo400">否</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;采集生物标本：
      				<input type="radio" id="researchInfo411" name="researchInfo41" related="researchInfo401" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo41'],'1')>-1 }">checked</c:if>><label for="researchInfo411">是</label>
        			&#12288;<input type="radio" id="researchInfo410" name="researchInfo41" related="researchInfo401" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo41'],'0')>-1 }">checked</c:if>><label for="researchInfo410">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;利用以往保存的生物标本：
      				<input type="radio" id="researchInfo421" name="researchInfo42" related="researchInfo401" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo42'],'1')>-1 }">checked</c:if>><label for="researchInfo421">是</label>
        			&#12288;<input type="radio" id="researchInfo420" name="researchInfo42" related="researchInfo401" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo42'],'0')>-1 }">checked</c:if>><label for="researchInfo420">否</label>
      			</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">研究药物/医疗器械的使用超出产品说明书范围，并且没有获得药监管理部门的临床研究批件：
        			<input type="radio" id="researchInfo501" name="researchInfo5" value="1" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['researchInfo5'],'1')>-1 }">checked</c:if>><label for="researchInfo501">是</label>
        			&#12288;<input type="radio" id="researchInfo500" name="researchInfo5" value="0" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['researchInfo5'],'0')>-1 }">checked</c:if>><label for="researchInfo500">否</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;研究结果是否用于注册或修改说明书：
      				<input type="radio" id="researchInfo511" name="researchInfo51" related="researchInfo501" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo51'],'1')>-1 }">checked</c:if>><label for="researchInfo511">是</label>
        			&#12288;<input type="radio" id="researchInfo510" name="researchInfo51" related="researchInfo501" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo51'],'0')>-1 }">checked</c:if>><label for="researchInfo510">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;研究是否用于产品的广告：
      				<input type="radio" id="researchInfo521" name="researchInfo52" related="researchInfo501" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo52'],'1')>-1 }">checked</c:if>><label for="researchInfo521">是</label>
        			&#12288;<input type="radio" id="researchInfo520" name="researchInfo52" related="researchInfo501" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo52'],'0')>-1 }">checked</c:if>><label for="researchInfo520">否</label>
      			</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;超出说明书使用该产品，是否显著增加了风险：
      				<input type="radio" id="researchInfo531" name="researchInfo53" related="researchInfo501" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo53'],'1')>-1 }">checked</c:if>><label for="researchInfo531">是</label>
        			&#12288;<input type="radio" id="researchInfo530" name="researchInfo53" related="researchInfo501" value="0" <c:if test="${fn:indexOf(formDataMap['researchInfo53'],'0')>-1 }">checked</c:if>><label for="researchInfo530">否</label>
      			</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">医疗器械的类别：
        			<input type="radio" id="researchInfo61" name="researchInfo6" value="1" <c:if test="${fn:indexOf(formDataMap['researchInfo6'],'1')>-1 }">checked</c:if>><label for="researchInfo61">Ⅰ类</label>
        			&#12288;<input type="radio" id="researchInfo62" name="researchInfo6" value="2" <c:if test="${fn:indexOf(formDataMap['researchInfo6'],'2')>-1 }">checked</c:if>><label for="researchInfo62">Ⅱ类</label>
        			&#12288;<input type="radio" id="researchInfo63" name="researchInfo6" value="3" <c:if test="${fn:indexOf(formDataMap['researchInfo6'],'3')>-1 }">checked</c:if>><label for="researchInfo63">Ⅲ类</label>
        			&#12288;<input type="radio" id="researchInfo64" name="researchInfo6" value="4" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['researchInfo6'],'4')>-1 }">checked</c:if>><label for="researchInfo64">体外诊断试剂</label>
        		</td>
      		</tr>
      		<tr>
        		<th colspan="3" style="text-align: left;">&nbsp;招募受试者</th>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">谁负责招募：
        			<input type="checkbox" id="recruSubject11" name="recruSubject1" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject1'],'1')>-1 }">checked</c:if>><label for="recruSubject11">医生</label>
        			&#12288;<input type="checkbox" id="recruSubject12" name="recruSubject1" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject1'],'2')>-1 }">checked</c:if>><label for="recruSubject12">研究者</label>
        			&#12288;<input type="checkbox" id="recruSubject13" name="recruSubject1" value="3" <c:if test="${fn:indexOf(formDataMap['recruSubject1'],'3')>-1 }">checked</c:if>><label for="recruSubject13">研究助理</label>
        			&#12288;<input type="checkbox" id="recruSubject14" name="recruSubject1" value="4" <c:if test="${fn:indexOf(formDataMap['recruSubject1'],'4')>-1 }">checked</c:if>><label for="recruSubject14">研究护士</label>
        			&#12288;<input type="checkbox" id="recruSubject15" name="recruSubject1" value="5" <c:if test="${fn:indexOf(formDataMap['recruSubject1'],'5')>-1 }">checked</c:if>><label for="recruSubject15">其他</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">招募方式：
        			<input type="checkbox" id="recruSubject21" name="recruSubject2" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject2'],'1')>-1 }">checked</c:if>><label for="recruSubject21">广告</label>
        			&#12288;<input type="checkbox" id="recruSubject22" name="recruSubject2" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject2'],'2')>-1 }">checked</c:if>><label for="recruSubject22">诊疗过程</label>
        			&#12288;<input type="checkbox" id="recruSubject23" name="recruSubject2" value="3" <c:if test="${fn:indexOf(formDataMap['recruSubject2'],'3')>-1 }">checked</c:if>><label for="recruSubject23">数据库</label>
        			&#12288;<input type="checkbox" id="recruSubject24" name="recruSubject2" value="4" <c:if test="${fn:indexOf(formDataMap['recruSubject2'],'4')>-1 }">checked</c:if>><label for="recruSubject24">中介</label>
        			&#12288;<input type="checkbox" id="recruSubject25" name="recruSubject2" value="5" <c:if test="${fn:indexOf(formDataMap['recruSubject2'],'5')>-1 }">checked</c:if>><label for="recruSubject25">其它</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">招募人群特征：
        			<input type="checkbox" id="recruSubject301" name="recruSubject3" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject3'],'1')>-1 }">checked</c:if>><label for="recruSubject301">健康者</label>
        			&#12288;<input type="checkbox" id="recruSubject302" name="recruSubject3" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject3'],'2')>-1 }">checked</c:if>><label for="recruSubject302">患者</label>
        			&#12288;<input type="checkbox" id="recruSubject303" name="recruSubject3" value="3" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['recruSubject3'],'3')>-1 }">checked</c:if>><label for="recruSubject303">弱势群体</label>
        			&#12288;<input type="checkbox" id="recruSubject304" name="recruSubject3" value="4" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['recruSubject3'],'4')>-1 }">checked</c:if>><label for="recruSubject304">孕妇</label>
     			    &#12288;<input type="checkbox" id="recruSubject305" name="recruSubject3" value="5" onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['recruSubject3'],'5')>-1 }">checked</c:if>><label for="recruSubject305">特定疾病人群或特定地区人群/族群</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;弱势群体的特征：
      				<input type="checkbox" id="recruSubject311" name="recruSubject31" related="recruSubject303" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'1')>-1 }">checked</c:if>><label for="recruSubject311">儿童/未成年人</label>
        			&#12288;<input type="checkbox" id="recruSubject312" name="recruSubject31" related="recruSubject303" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'2')>-1 }">checked</c:if>><label for="recruSubject312">认知障碍或健康状况而没有能力做出知情同意的成人</label>
        			&#12288;<input type="checkbox" id="recruSubject313" name="recruSubject31" related="recruSubject303" value="3" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'3')>-1 }">checked</c:if>><label for="recruSubject313">申办者/研究者的雇员或学生</label>
        			&#12288;<input type="checkbox" id="recruSubject314" name="recruSubject31" related="recruSubject303" value="4" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'4')>-1 }">checked</c:if>><label for="recruSubject314">教育/经济地位低下的人员</label>
        			&#12288;<input type="checkbox" id="recruSubject315" name="recruSubject31" related="recruSubject303" value="5" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'5')>-1 }">checked</c:if>><label for="recruSubject315">疾病终末期患者</label>
        			&#12288;<input type="checkbox" id="recruSubject316" name="recruSubject31" related="recruSubject303" value="6" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'6')>-1 }">checked</c:if>><label for="recruSubject316">囚犯</label>
        			&#12288;<input type="checkbox" id="recruSubject317" name="recruSubject31" related="recruSubject303" value="7" <c:if test="${fn:indexOf(formDataMap['recruSubject31'],'7')>-1 }">checked</c:if>><label for="recruSubject317">其他&nbsp;</label>
        			&#12288;<input type="text" name="recruSubject31_other" related="recruSubject303" value="${formDataMap['recruSubject31_other'] }">
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;知情同意能力的评估方式：
      				<input type="checkbox" id="recruSubject321" name="recruSubject32" related="recruSubject303" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject32'],'1')>-1 }">checked</c:if>><label for="recruSubject321">临床判断</label>
        			&#12288;<input type="checkbox" id="recruSubject322" name="recruSubject32" related="recruSubject303" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject32'],'2')>-1 }">checked</c:if>><label for="recruSubject322">量表</label>
        			&#12288;<input type="checkbox" id="recruSubject323" name="recruSubject32" related="recruSubject303" value="3" <c:if test="${fn:indexOf(formDataMap['recruSubject32'],'3')>-1 }">checked</c:if>><label for="recruSubject323">仪器</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;涉及孕妇研究的信息：
      				<input type="checkbox" id="recruSubject331" name="recruSubject33" related="recruSubject304" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject33'],'1')>-1 }">checked</c:if>><label for="recruSubject331">不适用</label>
        			&#12288;<input type="checkbox" id="recruSubject332" name="recruSubject33" related="recruSubject304" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject33'],'2')>-1 }">checked</c:if>><label for="recruSubject332">没有通过经济利益引诱其中止妊娠</label>
        			&#12288;<input type="checkbox" id="recruSubject333" name="recruSubject33" related="recruSubject304" value="3" <c:if test="${fn:indexOf(formDataMap['recruSubject33'],'3')>-1 }">checked</c:if>><label for="recruSubject333">研究人员不参与中止妊娠的决策</label>
        			&#12288;<input type="checkbox" id="recruSubject334" name="recruSubject33" related="recruSubject304" value="4" <c:if test="${fn:indexOf(formDataMap['recruSubject33'],'4')>-1 }">checked</c:if>><label for="recruSubject334">研究人员不参与新生儿生存能力的判断</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;涉及特定疾病人群或特定地区人群/族群研究的信息：
      				<input type="checkbox" id="recruSubject341" name="recruSubject34" related="recruSubject305" value="1" <c:if test="${fn:indexOf(formDataMap['recruSubject34'],'1')>-1 }">checked</c:if>><label for="recruSubject341">是否合理考虑了研究对特殊疾病人群、特定地区人群/族群造成的影响</label>
        			&#12288;<input type="checkbox" id="recruSubject342" name="recruSubject34" related="recruSubject305" value="2" <c:if test="${fn:indexOf(formDataMap['recruSubject34'],'2')>-1 }">checked</c:if>><label for="recruSubject342">是否合理考虑了外界因素对个人知情同意的影响</label>
        			&#12288;<input type="checkbox" id="recruSubject343" name="recruSubject34" related="recruSubject305" value="3" <c:if test="${fn:indexOf(formDataMap['recruSubject34'],'3')>-1 }">checked</c:if>><label for="recruSubject343">是否有向该人群/族群进行咨询的计划</label>
        			&#12288;<input type="checkbox" id="recruSubject344" name="recruSubject34" related="recruSubject305" value="4" <c:if test="${fn:indexOf(formDataMap['recruSubject34'],'4')>-1 }">checked</c:if>><label for="recruSubject344">研究是否包括促进地区医疗保健与研究能力发展的计划</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">受试者报酬：
        			<input type="radio" id="recruSubject351" name="recruSubject35" value="1"  onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['recruSubject35'],'1')>-1 }">checked</c:if>><label for="recruSubject351">有</label>
        			&#12288;<input type="radio" id="recruSubject350" name="recruSubject35" value="0"  onclick="checkAbled(this);" <c:if test="${fn:indexOf(formDataMap['recruSubject35'],'0')>-1 }">checked</c:if>><label for="recruSubject350">无</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;报酬金额：<input type="text" name="sum" related="recruSubject351" value="${formDataMap['sum'] }">
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
      			<td>◇&#12288;报酬支付方式：
      				<input type="radio" id="payType1" name="payType" related="recruSubject351" value="1" <c:if test="${fn:indexOf(formDataMap['payType'],'1')>-1 }">checked</c:if>><label for="payType1">按随访观察时点，分次支付</label>
        			&#12288;<input type="radio" id="payType2" name="payType" related="recruSubject351" value="2" <c:if test="${fn:indexOf(formDataMap['payType'],'2')>-1 }">checked</c:if>><label for="payType2">按完成的随访观察工作量，一次性支付</label>
        			&#12288;<input type="radio" id="payType3" name="payType" related="recruSubject351" value="3" <c:if test="${fn:indexOf(formDataMap['payType'],'3')>-1 }">checked</c:if>><label for="payType3">完成全部随访观察后支付</label>
        		</td>
      		</tr>
      		<tr>
        		<th colspan="3" style="text-align: left;">&nbsp;知情同意的过程</th>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">谁获取知情同意：
        			<input type="checkbox" id="informProcess11" name="informProcess1" value="1" <c:if test="${fn:indexOf(formDataMap['informProcess1'],'1')>-1 }">checked</c:if>><label for="informProcess11">医生/研究者</label>
        			&#12288;<input type="checkbox" id="informProcess12" name="informProcess1" value="2" <c:if test="${fn:indexOf(formDataMap['informProcess1'],'2')>-1 }">checked</c:if>><label for="informProcess12">医生</label>
        			&#12288;<input type="checkbox" id="informProcess13" name="informProcess1" value="3" <c:if test="${fn:indexOf(formDataMap['informProcess1'],'3')>-1 }">checked</c:if>><label for="informProcess13">研究者</label>
        			&#12288;<input type="checkbox" id="informProcess14" name="informProcess1" value="4" <c:if test="${fn:indexOf(formDataMap['informProcess1'],'4')>-1 }">checked</c:if>><label for="informProcess14">研究护士</label>
        			&#12288;<input type="checkbox" id="informProcess15" name="informProcess1" value="5" <c:if test="${fn:indexOf(formDataMap['informProcess1'],'5')>-1 }">checked</c:if>><label for="informProcess15">研究助理</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">获取知情同意地点：
        			<input type="checkbox" id="informProcess21" name="informProcess2" value="1" <c:if test="${fn:indexOf(formDataMap['informProcess2'],'1')>-1 }">checked</c:if>><label for="informProcess21">私密房间/受试者接待室</label>
        			&#12288;<input type="checkbox" id="informProcess22" name="informProcess2" value="2" <c:if test="${fn:indexOf(formDataMap['informProcess2'],'2')>-1 }">checked</c:if>><label for="informProcess22">诊室</label>
        			&#12288;<input type="checkbox" id="informProcess23" name="informProcess2" value="3" <c:if test="${fn:indexOf(formDataMap['informProcess2'],'3')>-1 }">checked</c:if>><label for="informProcess23">病房</label>
        			&#12288;<input type="checkbox" id="informProcess24" name="informProcess2" value="4" <c:if test="${fn:indexOf(formDataMap['informProcess2'],'4')>-1 }">checked</c:if>><label for="informProcess24">其它</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">知情同意签字：
        			<input type="checkbox" id="informProcess31" name="informProcess3" disRelated="informException2,informException3" value="1" <c:if test="${fn:indexOf(formDataMap['informProcess3'],'1')>-1 }">checked</c:if>><label for="informProcess31">受试者签字</label>
        			&#12288;<input type="checkbox" id="informProcess32" name="informProcess3" disRelated="informException2,informException3" value="2" <c:if test="${fn:indexOf(formDataMap['informProcess3'],'2')>-1 }">checked</c:if>><label for="informProcess32">法定代理人签字</label>
        		</td>
      		</tr>
			<tr>
        		<th colspan="3" style="text-align: left;">&nbsp;知情同意的例外</th>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">申请开展在紧急情况下无法获得知情同意的研究</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2"><input type="radio" id="informException1" name="informException" disRelated="obserStudyType1,obserStudyType2" value="A" onclick="checkDisplay(this);checkDisabled(this);" <c:if test="${fn:indexOf(formDataMap['informException'],'A')>-1 }">checked</c:if>><label for="informException1">研究人群处于危及生命的紧急状况，需要在发病后很快进行干预；在该紧急情况下，大部分病人无法给予知情同意，且没有时间找到合法代表人；缺乏已被证实有效的治疗方法，而试验药物或干预有望挽救生命，恢复健康，或减轻病痛。</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">申请免除知情同意</td>
      		</tr>
      		<tr> 
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2"><input type="radio" id="informException2" name="informException" related="researchInfo64" dis="informException2,0" disRelated="researchType1,obserStudyType2"  value="B" onclick="checkDisplay(this);checkDisabled(this);" <c:if test="${fn:indexOf(formDataMap['informException'],'B')>-1 }">checked</c:if>><label for="informException2">利用以往临床诊疗中获得的病历/生物标本的研究</label>
        		</td>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2"><input type="radio" id="informException3" name="informException" related="researchInfo64" dis="informException3,0" disRelated="researchType1,obserStudyType2"  value="C" onclick="checkDisplay(this);checkDisabled(this);"  <c:if test="${fn:indexOf(formDataMap['informException'],'C')>-1 }">checked</c:if>><label for="informException3">研究病历/生物标本的二次利用</label>
        		</td>
      		</tr>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">申请免除知情同意签字</td>
      		</tr>
       		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2"><input type="radio" id="informException4" name="informException" related="obserStudyType2" dis="informException4,1" disRelated="researchType1,obserStudyType1"  value="D" onclick="checkDisplay(this);checkDisabled(this);" <c:if test="${fn:indexOf(formDataMap['informException'],'D')>-1 }">checked</c:if>><label for="informException4">签了字的知情同意书会对受试者的隐私构成不正当的威胁，联系受试者真实身份和研究的唯一记录是知情同意文件，并且主要风险就来自于受试者身份或个人隐私的泄露。</label>
        		</td>
      		<tr>
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2"><input type="radio" id="informException5" name="informException" related="obserStudyType2" dis="informException5,1" disRelated="researchType1,obserStudyType1"  value="E" onclick="checkDisplay(this);checkDisabled(this);" <c:if test="${fn:indexOf(formDataMap['informException'],'E')>-1 }">checked</c:if>><label for="informException5">研究对受试者的风险不大于最小风险，并且如果脱离“研究”背景，相同情况下的行为或程序不要求签署书面知情同意。如访谈研究，邮件/电话调查。</label>
        		</td>
      		</tr>
      		
      		<tr class="informException1" style="display: none;">
        		<th colspan="3" style="text-align: left;">&nbsp;申请开展在紧急情况下无法获得知情同意的研究</th>
      		</tr>
      		<tr class="informException1" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        		<span style="font-weight:bold;">适用性判断：</span>本项研究同时满足以下条件：
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;处于危及生命的紧急状况，需要在发病后很快进行干预：<input type="checkbox" id="informException111" name="informException11" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException11'],'1')>-1 }">checked</c:if>><label for="informException111">是</label>
      				&#12288;<input type="checkbox" id="informException110" name="informException11" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException11'],'0')>-1 }">checked</c:if>><label for="informException110">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;在该紧急情况下，大部分病人无法给予知情同意，且没有时间找到合法代表人：<input type="checkbox" id="informException121" name="informException12" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException12'],'1')>-1 }">checked</c:if>><label for="informException121">是</label>
      				&#12288;<input type="checkbox" id="informException120" name="informException12" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException12'],'0')>-1 }">checked</c:if>><label for="informException120">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;缺乏已被证实有效的治疗方法，而试验药物或干预有望挽救生命，恢复健康，或减轻病痛：<input type="checkbox" id="informException131" name="informException13" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException13'],'1')>-1 }">checked</c:if>><label for="informException131">是</label>
      				&#12288;<input type="checkbox" id="informException130" name="informException13" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException13'],'0')>-1 }">checked</c:if>><label for="informException130">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2" style="font-weight:bold;">相关信息</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案根据目前的科学证据，制定了必须给予试验干预的治疗窗；该治疗窗包括了一个合适的联系合法代表人的时间段：<input type="checkbox" id="informException141" name="informException14" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException14'],'1')>-1 }">checked</c:if>><label for="informException141">是</label>
      				&#12288;<input type="checkbox" id="informException140" name="informException14" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException14'],'0')>-1 }">checked</c:if>><label for="informException140">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;研究者承诺在开始研究之前，在治疗窗的分段时间内，尽力联系患者的合法代表人，并有证明努力尝试联系的文件记录：<input type="checkbox" id="informException151" name="informException15" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException15'],'1')>-1 }">checked</c:if>><label for="informException151">是</label>
      				&#12288;<input type="checkbox" id="informException150" name="informException15" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException15'],'0')>-1 }">checked</c:if>><label for="informException150">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定：一旦病人的状态许可，或找到其合法代表人，应告知所有相关信息，并尽可能早地获得其反对或继续参加研究的意见：<input type="checkbox" id="informException161" name="informException16" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException16'],'1')>-1 }">checked</c:if>><label for="informException161">是</label>
      				&#12288;<input type="checkbox" id="informException160" name="informException16" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException16'],'0')>-1 }">checked</c:if>><label for="informException160">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;研究项目制定了社区咨询计划，向研究人群利益相关方充分告知研究的风险与预期受益，征求他们的意见；伦理委员会部分/全体成员将参加咨询活动：<input type="checkbox" id="informException171" name="informException17" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException17'],'1')>-1 }">checked</c:if>><label for="informException171">是</label>
      				&#12288;<input type="checkbox" id="informException170" name="informException17" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException17'],'0')>-1 }">checked</c:if>><label for="informException170">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;研究项目制定了在研究开始前公开披露信息计划，以保证更广泛的研究人群利益相关方获知研究计划及其风险与预期受益：<input type="checkbox" id="informException181" name="informException18" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException18'],'1')>-1 }">checked</c:if>><label for="informException181">是</label>
      				&#12288;<input type="checkbox" id="informException180" name="informException18" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException18'],'0')>-1 }">checked</c:if>><label for="informException180">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;建立了独立的数据与安全监查委员会：<input type="checkbox" id="informException191" name="informException19" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException19'],'1')>-1 }">checked</c:if>><label for="informException191">是</label>
      				&#12288;<input type="checkbox" id="informException190" name="informException19" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException19'],'0')>-1 }">checked</c:if>><label for="informException190">否</label>
        		</td>
      		</tr>
      		<tr class="informException1" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;对既未获得受试者个体知情同意，又未得到法定代理人许可，方案规定受试者个体参加研究的最大时限是：<input type="text" style="width: 50px;" name="informException110" value="${formDataMap['informException110'] }">（天）
        		</td>
      		</tr>
      		<tr class="informException1" id="aaa" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;如果疾病是周期性复发的（如癫痫），是否可能确定将来发生符合研究条件疾病的人群，在其有充分能力给出知情同意的时候与之联系，并请其同意在将来疾病发作、无能力表达同意的时候参加试验：<input type="checkbox" id="informException1111" name="informException111" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException111'],'1')>-1 }">checked</c:if>><label for="informException1111">是</label>
      				&#12288;<input type="checkbox" id="informException1110" name="informException111" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException111'],'0')>-1 }">checked</c:if>><label for="informException1110">否</label>
        		</td>
      		</tr>

			<tr class="informException2" style="display: none;"> 
        		<th colspan="3" style="text-align: left;">&nbsp;申请免除知情同意</th>
      		</tr>
      		<tr class="informException2" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        		<span style="font-weight:bold;">适用性判断</span>
        		</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;本项研究为：利用在临床诊疗中获得的病历/生物标本的观察性研究：<input type="checkbox" id="informException211" name="informException21" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException21'],'1')>-1 }">checked</c:if>><label for="informException211">是</label>
      				&#12288;<input type="checkbox" id="informException210" name="informException21" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException21'],'0')>-1 }">checked</c:if>><label for="informException210">否</label>
        		</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2" style="font-weight:bold;">相关信息</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;研究对受试者的风险不大于最小风险：<input type="checkbox" id="informException221" name="informException22" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException22'],'1')>-1 }">checked</c:if>><label for="informException221">是</label>
      				&#12288;<input type="checkbox" id="informException220" name="informException22" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException22'],'0')>-1 }">checked</c:if>><label for="informException220">否</label>
        		</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;免除知情同意不会对受试者的权利和健康产生不利的影响：<input type="checkbox" id="informException231" name="informException23" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException23'],'1')>-1 }">checked</c:if>><label for="informException231">是</label>
      				&#12288;<input type="checkbox" id="informException230" name="informException23" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException23'],'0')>-1 }">checked</c:if>><label for="informException230">否</label>
        		</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;受试者的隐私和身份信息的保密得到保证：<input type="checkbox" id="informException241" name="informException24" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException24'],'1')>-1 }">checked</c:if>><label for="informException241">是</label>
      				&#12288;<input type="checkbox" id="informException240" name="informException24" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException24'],'0')>-1 }">checked</c:if>><label for="informException240">否</label>
        		</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;若规定需获取知情同意，将使研究不可行（病人有权知道其病历/标本可能用于研究，其拒绝或不同意参加研究，不是研究无法实施、免除知情同意的证据）：<input type="checkbox" id="informException251" name="informException25" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException25'],'1')>-1 }">checked</c:if>><label for="informException251">是</label>
      				&#12288;<input type="checkbox" id="informException250" name="informException25" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException25'],'0')>-1 }">checked</c:if>><label for="informException250">否</label>
        		</td>
      		</tr>
      		<tr class="informException2" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;本研究不利用病人/受试者以前已明确地拒绝利用的医疗记录和标本：<input type="checkbox" id="informException261" name="informException26" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException26'],'1')>-1 }">checked</c:if>><label for="informException261">是</label>
      				&#12288;<input type="checkbox" id="informException260" name="informException26" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException26'],'0')>-1 }">checked</c:if>><label for="informException260">否</label>
        		</td>
      		</tr>

			<tr class="informException3" style="display: none;"> 
        		<th colspan="3" style="text-align: left;">&nbsp;申请免除知情同意</th>
      		</tr>
      		<tr class="informException3" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        		<span style="font-weight:bold;">适用性判断</span>
        		</td>
      		</tr>
      		<tr class="informException3" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;本项研究为：研究病历与生物标本的二次利用的观察性研究，即利用以往研究项目、经知情同意收集的病历或标本进行研究：
        			<input type="checkbox" id="informException311" name="informException31" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException31'],'1')>-1 }">checked</c:if>><label for="informException311">是</label>
      				&#12288;<input type="checkbox" id="informException310" name="informException31" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException31'],'0')>-1 }">checked</c:if>><label for="informException310">否</label>
        		</td>
      		</tr>
      		<tr class="informException3" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2" style="font-weight:bold;">相关信息</td>
      		</tr>
      		<tr class="informException3" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;原知情同意书同意其他研究项目利用病历或标本：<input type="checkbox" id="informException321" name="informException32" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException32'],'1')>-1 }">checked</c:if>><label for="informException321">是</label>
      				&#12288;<input type="checkbox" id="informException320" name="informException32" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException32'],'0')>-1 }">checked</c:if>><label for="informException320">否</label>
        		</td>
      		</tr>
      		<tr class="informException3" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;本次研究符合原知情同意条件的限制：<input type="checkbox" id="informException331" name="informException33" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException33'],'1')>-1 }">checked</c:if>><label for="informException331">是</label>
      				&#12288;<input type="checkbox" id="informException330" name="informException33" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException33'],'0')>-1 }">checked</c:if>><label for="informException330">否</label>
        		</td>
      		</tr>
      		<tr class="informException3" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定了受试者的隐私和身份信息的保密措施：<input type="checkbox" id="informException341" name="informException34" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException34'],'1')>-1 }">checked</c:if>><label for="informException341">是</label>
      				&#12288;<input type="checkbox" id="informException340" name="informException34" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException34'],'0')>-1 }">checked</c:if>><label for="informException340">否</label>
        		</td>
      		</tr>
      		
      		<tr class="informException4" style="display: none;"> 
        		<th colspan="3" style="text-align: left;">&nbsp;申请免除知情同意签字</th>
      		</tr>
      		<tr class="informException4" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        		<span style="font-weight:bold;">适用性判断</span>
        		</td>
      		</tr>
      		<tr class="informException4" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;本项研究为：当一份签了字的知情同意书会对受试者的隐私构成不正当的威胁，联系受试者真实身份和研究的唯一记录是知情同意文件，并且主要风险就来自于破坏机密：
        		<input type="checkbox" id="informException411" name="informException41" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException41'],'1')>-1 }">checked</c:if>><label for="informException411">是</label>
      				&#12288;<input type="checkbox" id="informException410" name="informException41" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException41'],'0')>-1 }">checked</c:if>><label for="informException410">否</label>
        		</td>
      		</tr>
      		<tr class="informException4" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2" style="font-weight:bold;">相关信息</td>
      		</tr>
      		<tr class="informException4" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定应遵循每一位受试者本人的意愿，签署或不签署书面知情同意文件：<input type="checkbox" id="informException421" name="informException42" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException42'],'1')>-1 }">checked</c:if>><label for="informException421">是</label>
      				&#12288;<input type="checkbox" id="informException420" name="informException42" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException42'],'0')>-1 }">checked</c:if>><label for="informException420">否</label>
        		</td>
      		</tr>
      		<tr class="informException4" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定向受试者或其合法代表人提供书面信息告知文件：<input type="checkbox" id="informException431" name="informException43" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException43'],'1')>-1 }">checked</c:if>><label for="informException431">是</label>
      				&#12288;<input type="checkbox" id="informException430" name="informException43" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException43'],'0')>-1 }">checked</c:if>><label for="informException430">否</label>
        		</td>
      		</tr>
      		<tr class="informException4" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定应获得受试者或其合法代表人的口头知情同意：<input type="checkbox" id="informException441" name="informException44" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException44'],'1')>-1 }">checked</c:if>><label for="informException441">是</label>
      				&#12288;<input type="checkbox" id="informException440" name="informException44" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException44'],'0')>-1 }">checked</c:if>><label for="informException440">否</label>
        		</td>
      		</tr>
      		
      		<tr class="informException5" style="display: none;"> 
        		<th colspan="3" style="text-align: left;">&nbsp;申请免除知情同意签字</th>
      		</tr>
      		<tr class="informException5" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">
        		<span style="font-weight:bold;">适用性判断</span>
        		</td>
      		</tr>
      		<tr class="informException5" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;本项研究为：研究对受试者的风险不大于最小风险，并且如果脱离“研究”背景，相同情况下的行为或程序不要求签署书面知情同意（如访谈研究，邮件/电话调查）：
        		<input type="checkbox" id="informException511" name="informException51" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException51'],'1')>-1 }">checked</c:if>><label for="informException511">是</label>
      				&#12288;<input type="checkbox" id="informException510" name="informException51" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException51'],'0')>-1 }">checked</c:if>><label for="informException510">否</label>
        		</td>
      		</tr>
      		<tr class="informException5" style="display: none;">
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2" style="font-weight:bold;">相关信息</td>
      		</tr>
      		<tr class="informException5" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定向受试者或其合法代表人提供书面信息告知文件：<input type="checkbox" id="informException521" name="informException52" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException52'],'1')>-1 }">checked</c:if>><label for="informException521">是</label>
      				&#12288;<input type="checkbox" id="informException520" name="informException52" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException52'],'0')>-1 }">checked</c:if>><label for="informException520">否</label>
        		</td>
      		</tr>
      		<tr class="informException5" style="display: none;">
        		<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">●&#12288;方案规定应获得受试者或其合法代表人的口头知情同意：<input type="checkbox" id="informException531" name="informException53" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException53'],'1')>-1 }">checked</c:if>><label for="informException531">是</label>
      				&#12288;<input type="checkbox" id="informException530" name="informException53" value="0" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['informException53'],'0')>-1 }">checked</c:if>><label for="informException530">否</label>
        		</td>
      		</tr>

      		<tr>
        		<th colspan="3" style="text-align: left;">&nbsp;主要研究者信息</th>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">主要研究者声明：<input type="checkbox" id="researcherDeclare1" name="researcherDeclare" value="1" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researcherDeclare'],'1')>-1 }">checked</c:if>><label for="researcherDeclare1">本人与该研究项目不存在利益冲突</label>
      				&#12288;<input type="checkbox" id="researcherDeclare2" name="researcherDeclare" value="2" onclick="selectSingle(this);" <c:if test="${fn:indexOf(formDataMap['researcherDeclare'],'2')>-1 }">checked</c:if>><label for="researcherDeclare2">本人与该研究项目存在利益冲突</label>
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">主要研究者负责的在研项目数：<input name="inProjNum" type="text" value="${formDataMap['inProjNum'] }" style="width: 50px;">&nbsp;项
        		</td>
      		</tr>
      		<tr>
      			<td width="5px" style="border-right: 0;">&nbsp;</td>
        		<td colspan="2">主要研究者负责的在研项目中，与本项目的目标疾病相同的项目数：<input name="targetProjNum" type="text" value="${formDataMap['targetProjNum'] }" style="width: 50px;">&nbsp;项
        		</td>
      		</tr>
      	</table>
      	<div class="title1 clearfix">
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<tr>
					<th width="20%" style="text-align: center;">声明</th>
					<td colspan="3">
					我将遵循GCP的原则以及伦理委员会的要求，开展本项临床研究
					</td>
				</tr>
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
</form></div>
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