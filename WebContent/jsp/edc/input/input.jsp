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
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
.selected {
background-color:pink;
}
</style>
</head>
<script type="text/javascript">
$(function(){
	$('#validateForm').validationEngine('attach', { 
		  validateNonVisibleFields:true
		});
});

function doSubmit(){
	if(false==$("#headForm").validationEngine("validate")){
		return ;
	}
	if($("#inputStatus").val() != "${edcInputStatusEnumSave.id}" ){
		jboxTip("该访视未录入数据,无法提交!");
		return;
	} 
	
	var datas =[];
	//默认保存单位
	$("[attrType='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").each(function(){
		//$(this).change();
		var elementSerialSeq = ( $(this).attr("elementSerialSeq")=="${GlobalConstant.FLAG_N}" ?"1" : ($(this).closest("tr[id='serialSeqTr']").find("input[name='elementSerialSeq']").val())); 
		var data ={
			attrCode:$(this).attr("attrCode"),
			attrValue: $(this).val(),
			elementSerialSeq:elementSerialSeq 
		};
		datas.push(data);
	});
	//保存空属性值
	//saveEmptyAttrValueTip();
	$("[onchange]").each(function(){
		var val = $.trim($(this).val());
		if(val == null || val==""){
			var elementSerialSeq = ( $(this).attr("elementSerialSeq")=="${GlobalConstant.FLAG_N}" ?"1" : ($(this).closest("tr[id='serialSeqTr']").find("input[name='elementSerialSeq']").val()));
			var data ={
				attrCode:$(this).attr("attrCode"),
				attrValue: $(this).val(),
				elementSerialSeq:elementSerialSeq
			};
			//alert($(this).attr("name")+"-"+data.attrCode);
			datas.push(data);
		}
	});
	//alert(datas.length);
	//return;
	$("#submitBtn").val("数据提交中...请耐心等待");
	$("#submitBtn").attr("disabled",true);
	jboxStartLoading();
	jboxPostJson("<s:url value='/edc/input/saveEmptyDataAndUnit'/>?inputType=${param.inputType}",JSON.stringify(datas),function(resp){
		if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
			if("${edcPatientVisit.inputOperStatusId}" == "${edcInputStatusEnumSubmit.id}"){ 
				jboxGet("<s:url value='/edc/input/checkDiff'/>",$("#inputForm").serialize(),function(resp){
					if(resp==0){
						doSubmitCheck();//全部相同 默认核对提交
					} else {
						jboxConfirm("双份录入存在&#12288<font color=red>"+resp+"</font>&#12288处不同,核对录入后才能提交!" , function(){
							window.location.href="<s:url value='/edc/input/check?patientScope=${patientScope}&patientType=${patientType}&groupFlow=${groupFlow}'/>";
						});
					}				
				},null,false);	
			}else { 
				doSubmitCommit();
			}
		}
	},null,false);
}

//保存空属性值
function saveEmptyAttrValueTip(){
	$("[onchange]").each(function(){
		var val = $.trim($(this).val());
		if(val == null || val==""){
			$(this).blur();
			$(this).change();
		}
	});
}

function doSubmitCheck(){
	jboxGet("<s:url value='/edc/input/doSubmitCheck'/>",null,function(){
		$("#submitBtn").hide();
		$("#inputStatus").val("${edcInputStatusEnumSubmit.id}");
		disInput();	
		if ("${patientTypeEnumTest.id}" == "${patientType}") {
			$("#cancleSubmitBtn").show();
		}
	});	
}
function doSubmitCommit(){
	var url = "<s:url value='/edc/input/submitData'/>?inputType=${param.inputType}";
	jboxConfirm("确认提交?提交后无法修改数据!" , function(){
		jboxGet(url , $("#inputForm").serialize() , function(){
				$("#submitBtn").hide();
				$("#inputStatus").val("${edcInputStatusEnumSubmit.id}");
				disInput();
				if ("${patientTypeEnumTest.id}" == "${patientType}") {
					$("#cancleSubmitBtn").show();
				}
		} , null , true);
	});
}
function doSave(isSerialSeq,attrCode,obj){
	if("${edcInputStatusEnumSubmit.id }" == $("#inputStatus").val()){
		jboxTip("该页面已提交,无法修改!");
		return;
	}
	
	//数值校验、代码校验不通过不可以保存
	if ($(obj).attr("class") != null && $(obj).attr("class") != ""
			&& ($(obj).attr("class").indexOf('custom[number]')>-1 || $(obj).attr("class").indexOf('funcCall[checkCode]')>-1)) {
		$("#validateObj").val($(obj).val());
		if ($(obj).attr("class").indexOf('custom[number]')>-1) {
			$("#validateObj").addClass("validate[custom[number]]");
		}
		if ($(obj).attr("class").indexOf('funcCall[checkCode]')>-1) {
			$("#validateObj").addClass("validate[funcCall[checkCode]]");
			$("#validateObj").attr("codeValues",$(obj).attr("codeValues"));
		}
		if ($("#validateObj").validationEngine('validate')) {
			$(obj).validationEngine('validate');
			$(obj).val("");
			$("#validateObj").val("");
			$("#validateObj").removeClass();
			$("#validateObj").attr("codeValues","");
		}
	}
	
	var attrValue = "";
	var elementSerialSeq = ( isSerialSeq=="${GlobalConstant.FLAG_N}" ?"1" : ($(obj).closest("tr[id='serialSeqTr']").find("input[name='elementSerialSeq']").val())); 
	if($(obj).attr("type") == "checkbox" ){
		$("[name='"+attrCode+"_"+elementSerialSeq+"']").each(function(){
			if($(this).attr("checked")=="checked"){
				if(attrValue!=""){
					attrValue += ","+$(this).val();
				}else {
					attrValue = $(this).val();
				}
	        }
		});
	}else {
		attrValue = $(obj).val();
	}
	var datas ={
			attrCode:attrCode,
			value: attrValue,
			elementSerialSeq:elementSerialSeq,
			inputType:"${param.inputType}"
	};
	jboxPost("<s:url value='/edc/input/saveData'/>", datas, function() {
		$("#inputStatus").val("${edcInputStatusEnumSave.id}");
		},null,false);
}

function saveVisitDate(){
	if("${edcInputStatusEnumSubmit.id }" == $("#inputStatus").val()){
		jboxTip("该页面已提交,无法修改!");
		return ;
	}
	if($("#visitDate").val()!=""){
		jboxGet("<s:url value='/edc/input/saveVisitDate'/>?visitDate="+$("#visitDate").val()+"&inputType=${param.inputType}",null,function(){
			$("#inputStatus").val("${edcInputStatusEnumSave.id}");			
		},null,false);	
	}
}
function disInput(){
	$("input").each(function(i){
		  $(this).attr("disabled",true);
	 });
	$("select").each(function(i){
		  $(this).attr("disabled",true);
	 });
	$("img[class!='actionImg']").each(function(i){			//多次录入元素的新增删除不可操作
		  $(this).attr("onclick",false);
	 });
	$("#visitFlow").attr("disabled",false);	//访视名称切换
	$("#patientFlow").attr("disabled",false);	//受试者序号切换
	$("#backBtn").attr("disabled",false);	//返回按钮
	$("#cancleSubmitBtn").attr("disabled",false);	//取消提交按钮
}
$(document).ready(function(){
	if("${edcInputStatusEnumSubmit.id }" == $("#inputStatus").val() || "${edcInputStatusEnumChecked.id }" == $("#inputStatus").val()){
		disInput();
	}
	$('#inputForm').validationEngine('validate');
});
function addTr(elementCode){
	var currTrCount = $("#"+elementCode+"_TBODY").children().length;
	 var tr =  ($("#"+elementCode+"_TBODY tr:eq(0)").clone());
	 
	 //重置序号列以外的name
	  tr.find("td .input").each(function(){
		 $(this).attr("name",$(this).attr("attrCode")+"_"+(currTrCount+1));
		
		 if($(this).attr("type") == "checkbox" || $(this).attr("type") == "radio" ){
			 $(this).attr("id",$(this).attr("attrCode")+"_"+$(this).val()+"_"+(currTrCount+1));
			 $(this).find("~ label").attr("for",$(this).attr("attrCode")+"_"+$(this).val()+"_"+(currTrCount+1));
		 }
	  });
	 
	 $("#"+elementCode+"_TBODY").append(tr);
	 
	 //重置值
	 tr.find("td input[name=elementSerialSeq] :first").val(currTrCount+1);
	 tr.find("td div :first").html(currTrCount+1);
	 //tr.find("td input[name$=SerialSeq]").val(currTrCount+1);
	  
	 tr.find("td :text[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").val("");
	 tr.find("td :checkbox[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").attr("checked",false);
	 tr.find("td :radio[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").attr("checked",false);
	 tr.find("td select[attrType!='${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}']").val("");
}
function delTr(elementCode){
	var seqStr  ="";
	$("#"+elementCode+"_TBODY").find("input[name=elementSerialSeq]:checked").each(function(){
		if(seqStr==""){
			seqStr+=$(this).val();
		}else {
			seqStr+=","+$(this).val();
		}
	});
	if(seqStr != ""){
		jboxConfirm("确认删除？",function () {
			jboxGet("<s:url value='/edc/input/delSerialSeqData'/>?elementCode="+elementCode+"&elementSerialSeq="+seqStr,null,function(){
				window.location.href="<s:url value='/edc/input/inputMain?patientScope=${patientScope}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}&patientFlow='/>"+$("#patientFlow").val()+"&visitFlow="+$("#visitFlow").val()+"&elementCode="+elementCode;
			},null);	
			
			//$(this).parent().parent().remove();			
		});
	}else {
		jboxTip("请选择要删除的数据!");
	}
	//window.location.href="<s:url value='/edc/input/inputMain?patientFlow='/>"+patientFlow+"&visitFlow="+visitFlow+"&inputOperFlow="+currOperFlow+"&inputStatusId="+inputStatusId;
}

$(document).ready(function(){
	var length = $(":input[type!='button'][type!='hidden'][id!='visitDate']").length;
	$(":input[type!='button'][type!='hidden'][id!='visitDate']").keyup(function(e) {
	    var key = e.which;
	    if (40 == key || 13 == key) {
		    var index = $(":input[type!='button'][type!='hidden'][id!='visitDate']").index(this);
		    var newIndex = index + 1;
		    if(newIndex>=length){
		         newIndex = 0;
		    }		
		    $(":input[type!='button'][type!='hidden'][id!='visitDate']:eq(" + newIndex + ")").focus();  
	    }
	    if (38 == key) {
		    var index = $(":input[type!='button'][type!='hidden'][id!='visitDate']").index(this);
		    var newIndex = 0;
		    if(index<=0){
		         newIndex = length-1;
		    }else{
		         newIndex = index-1;
		    }	
		    $(":input[type!='button'][type!='hidden'][id!='visitDate']:eq(" + newIndex + ")").focus();	 
	    }	    
    });
});
/* 修改为onchange事件
$(document).ready(function(){
	$("input:text").not(".dateClass").focus(function(){
		$(this).attr("oldvalue",$(this).val());
	});
});
*/
$(document).ready(function(){
	$(":input[type!='button'][type!='hidden'][id!='visitDate']").focus(function(){
		if($(this).attr("type")=='text' || $(this)[0].tagName == "SELECT"){
			$(this).addClass("selected");			
		}else{
			$(this).next().addClass("selected");
		}
	});
});
$(document).ready(function(){
	$(":input[type!='button'][type!='hidden'][id!='visitDate']").blur(function(){
		if($(this).attr("type")=='text' || $(this)[0].tagName == "SELECT"){
			$(this).removeClass("selected");			
		}else{
			$(this).next().removeClass("selected");
		}
	});
});
function checkCode(field,rules, i,options){
	if(field.attr('codeValues').indexOf(field.val())<0){
		return "只能填写"+field.attr('codeValues');
	}
}

function doBack(){
	window.location.href="<s:url value='/edc/input/listMain/${patientScope}?orgFlow=${patient.orgFlow}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}'/>";
}

function selVisit(visitFlow) {
	jboxGet("<s:url value='/edc/input/selPatientConfirm'/>?&visitFlow="+visitFlow+"&patientFlow="+$("#patientFlow").val(),null,function(resp){
		if(resp == '${GlobalConstant.OPERATE_SUCCESSED}'){
			window.location.href="<s:url value='/edc/input/selVisit'/>?patientScope=${patientScope}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}&visitFlow="+
			visitFlow+"&patientFlow="+$("#patientFlow").val();
		}else {
			jboxTip("该受试者的该次访视已有录入员，您不能进行录入!");
			$("#visitFlow").attr("value","${visit.visitFlow}");
			return;
		}
	},null,false);
}

function selPatient(patientFlow,oldPatientFlow) {
	jboxGet("<s:url value='/edc/input/selPatientConfirm'/>?&visitFlow="+$("#visitFlow").val()+"&patientFlow="+patientFlow,null,function(resp){
		if(resp == '${GlobalConstant.OPERATE_SUCCESSED}'){
			window.location.href="<s:url value='/edc/input/selVisit'/>?patientScope=${patientScope}&patientType=${patientType}&inputType=${param.inputType}&groupFlow=${groupFlow}&visitFlow="+
			$("#visitFlow").val()+"&patientFlow="+patientFlow;
		}else if(resp == '${GlobalConstant.OPRE_FAIL}'){
			jboxTip("该受试者的本次访视已有录入员，您不能进行录入!");
			$("#patientFlow").attr("value","${patient.patientFlow}");
			return;
		}else if(resp == '${GlobalConstant.OPRE_FAIL_FLAG}'){
			jboxOpen("<s:url value='/edc/input/editPubPatient'/>?patientScope=${patientScope}&patientType=${patientType}&patientFlow="
					+ patientFlow+"&visitFlow="+$("#visitFlow").val()+"&oldPatientFlow="+oldPatientFlow+"&source=input", "病人基本信息", 500, 325,false);
		}
	},null,false);
}

$(document).ready(function(){
	if ($("#elementCode").val() != '') {
		$(".main_fix").scrollTo('.'+$("#elementCode").val()+'_tbody', 1000, { offset:{ top:-20} } );
	}
});

function cancleSubmit(){
	var url = "<s:url value='/edc/input/cancleSubmit'/>";
	jboxConfirm("确认取消提交?" , function(){
		jboxGet(url , null , function(){
			$("#cancleSubmitBtn").hide();
			cancleDisInput();
			$("#submitBtn").show();
			$("#inputStatus").val("${edcInputStatusEnumSave.id}");
		} , null , true);
	});
}

function cancleDisInput(){
	$("input").each(function(i){
		  $(this).attr("disabled",false);
	 });
	$("select").each(function(i){
		  $(this).attr("disabled",false);
	 });
	$("img").each(function(i){			//多次录入元素的新增删除不可操作
		  $(this).attr("onclick",false);
	 });
}
function togleShow(moduleCode){
	var img = $("#"+moduleCode+"_img");
	if($("#"+moduleCode+"_tbody").is(":visible")==true){
		img.attr("src","<s:url value='/css/skin/${skinPath}/images/zTreeStandard_03.png'/>");
		$("#"+moduleCode+"_tbody").hide();
	}else {
		img.attr("src","<s:url value='/css/skin/${skinPath}/images/zTreeStandard_05.png'/>");
		$("#"+moduleCode+"_tbody").show();
	}
}
$(document).ready(function(){
	$(".moduleBody").not(":first").hide();
});
function expAll(){
	$(".moduleBody").show();
}
function cosAll(){
	$(".moduleBody").hide();
}
function showPatientCase(){
	jboxOpen("<s:url value='/edc/input/showPatientCase'/>","病例查看",600,500);
}
</script>
<style>
.select2{height: 25px; line-height: 25px; padding: 0 3px; border: 1px solid #bdbebe; margin-right: 20px;  cursor: pointer;}
</style>
<body>
		<form id="headForm">
			<div class="title1 clearfix" style="border-bottom:1px solid #F0F0F0;"> 
			     	&#12288;&#12288;访视名称：
			     		<select id="visitFlow" name="visitFlow"  style="width: 300px; " class="select2" 
							onchange="selVisit(this.value);">
							<c:forEach items="${visitList}" var="pVisit">
								<option value="${pVisit.visitFlow}"
									<c:if test="${pVisit.visitFlow==visit.visitFlow }">selected</c:if>>${pVisit.visitName}
								</option>
							</c:forEach>
						</select>
						 <c:if test="${visit.isVisit eq  GlobalConstant.FLAG_Y}">
			     		<font color="red">*</font>本次访视日期：<input type="text" style="width: 120px;" id="visitDate" readonly="readonly" name="visitDate" class="validate[required] ctime" value="${patientVisit.visitDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" onblur="saveVisitDate();"/>	
			     	</c:if>
			     	
			     			<!--  
			     			<input type="button" value="refresh" class="search" onclick="window.location.reload(true);" />  
			     			-->
			     			<input type="button" style="display:${edcInputStatusEnumSubmit.id != inputStatusId && edcInputStatusEnumChecked.id != inputStatusId?'':'none'} " value="提&#12288;交" id="submitBtn" class="search" onclick="doSubmit();"  />
			     			<input type="button" style="display:${(edcInputStatusEnumSubmit.id eq inputStatusId || edcInputStatusEnumChecked.id eq inputStatusId) && patientTypeEnumTest.id eq patientType?'':'none'} " value="取消提交" id="cancleSubmitBtn" class="search" onclick="cancleSubmit();"  />
			     			<span><input type="button" value="返&#12288;回" id="backBtn" class="search" onclick="doBack();"  /></span>
						
						<span style="float: right;padding-right: 2.5%">
					<img style="cursor: pointer;" class="actionImg" onclick="showPatientCase();" src="<s:url value='/css/skin/${skinPath}/images/camera.png'/>"/>
			     	<img style="cursor: pointer;"  class="actionImg" title="全部展开" onclick="expAll();" src="<s:url value='/css/skin/${skinPath}/images/arrow_expand.png'/>"/>
			     	<img style="cursor: pointer;"  class="actionImg" title="全部收缩" onclick="cosAll();" src="<s:url value='/css/skin/${skinPath}/images/arrow_contract.png'/>"/>
			     	</span>
						<br/><br/>
			     	&#12288;&#12288;受试者信息：&#12288;序号
			     		<select id="patientFlow" name="patientFlow"  class="select2"  style="width: 50px;"
							onfocus="selectValue=this.value" onchange="selPatient(this.value,selectValue);">
							<c:forEach items="${patientList}" var="pubPatient">
								<option value="${pubPatient.patientFlow}"
									<c:if test="${pubPatient.patientFlow==patient.patientFlow }">selected</c:if>>${pubPatient.patientSeq}
								</option>
							</c:forEach>
						</select>
			     	&#12288;&#12288;受试者编号：${patient.patientCode }
			     	&#12288;&#12288;缩写：${patient.patientNamePy }
			</div>			
			</form>  
		<div class="main_fix" style="margin-top: 40px;">
		<div id="main">
<form id="inputForm" style="height:70%;valign:top;position: relative;">
<div style="width:95%;margin-left: 2.5%;margin-right: 2.5%;">
 <c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
 <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
 <c:set var="commCode" value="${visit.visitFlow }_${moduleCode }"></c:set>
 <c:if test="${fn:length(sessionScope.projDescForm.visitModuleElementMap[commCode])>0 }">
 		<table class="basic" width="100%" style="margin-top: 20px;margin-bottom: 20px;" >
	 			<tr style="cursor: pointer;">
	 				<th colspan="10"  onclick="togleShow('${visitModule.moduleCode }');" style="text-align: left;padding-left: 20px;font-size: 16px;">${visitModule.moduleName}
	 				<img id="${visitModule.moduleCode }_img" src="<s:url value='/css/skin/${skinPath}/images/zTreeStandard_05.png'/>" style="float: right;padding-right: 10px;padding-top: 5px;">
	 				</th>
	 			</tr>
 			<tbody id="${visitModule.moduleCode  }_tbody" class="moduleBody">
	 		<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<!-- 设置moduleCode -->
	 		<c:if test="${!empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitElement.moduleCode }"></c:set>
	 		</c:if>
	 		<c:if test="${empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
	 		</c:if>
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}"></c:set>
	 		<c:set var="columnCount" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].columnCount }"></c:set>	
	 		<c:set var="fixWidth" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].fixedWidth }"/>
	 		<c:set var="showEleName" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].isViewName!=GlobalConstant.FLAG_N}"/>
	 		<c:if test="${empty sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId || moduleStyleEnumSingle.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr>
	 				<c:if test="${showEleName}">
		 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
		 				</th>
	 				</c:if>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td <c:if test="${!showEleName}">colspan="2"</c:if>>
		 				<jsp:include page="input_single.jsp" flush="true"> 
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 							<jsp:param name="inputOperFlow" value="${inputOperFlow}" />
	 							<jsp:param name="fixWidth" value="${fixWidth}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<!-- 多属性分横向、纵向排版 -->
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
			 				<td <c:if test="${!showEleName}">colspan="2"</c:if>>
			 					<jsp:include page="input_serial.jsp" flush="true"> 
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 							<jsp:param name="inputOperFlow" value="${inputOperFlow}" />
			 					</jsp:include>
			 				</td>
		 				</c:when>
		 				<c:otherwise>
		 					<td <c:if test="${!showEleName}">colspan="2"</c:if>>
			 					<jsp:include page="input_serial_vertical.jsp" flush="true"> 
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 							<jsp:param name="columnCount" value="${columnCount}" />
			 							<jsp:param name="inputOperFlow" value="${inputOperFlow}" />
			 					</jsp:include>
			 				</td>
		 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
	 			</c:if>
	 			<c:if test="${moduleStyleEnumDouble.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }
	 				</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="input_single.jsp" flush="true"> 
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 							<jsp:param name="inputOperFlow" value="${inputOperFlow}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<!-- 多属性分横向、纵向排版 -->
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
			 				<td>
			 					<jsp:include page="input_serial.jsp" flush="true"> 
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 							<jsp:param name="inputOperFlow" value="${inputOperFlow}" />
			 					</jsp:include>
			 				</td>
		 				</c:when>
		 				<c:otherwise>
		 					<td>
			 					<jsp:include page="input_serial_vertical.jsp" flush="true"> 
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 							<jsp:param name="columnCount" value="${columnCount}" />
			 							<jsp:param name="inputOperFlow" value="${inputOperFlow}" />
			 					</jsp:include>
			 				</td>
		 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
	 			</c:if>
	 		</c:forEach>
	 		</tbody>
 		</table>
 		</c:if>
 </c:forEach>
</div></form>
</div></div>
<input type="hidden" id="inputStatus" value="${inputStatusId }"/>
<input type="hidden" id="elementCode" value="${param.elementCode }"/>
<form id="validateForm">
<input type="hidden" id="validateObj" value="" codeValues="" class="" />
</form>
</body>
</html>