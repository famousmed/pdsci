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
</head>
<script type="text/javascript">

function selectChildren(elementCode){
	var obj = $("#"+elementCode);
	$("input[elementId='"+elementCode+"']").each(function(){
		if($(obj).attr("checked")=="checked"){
	        $(this).attr("checked", true);     
	    }else {
	        $(this).attr("checked", false);  
	    }
    });
	if($(obj).attr("checked")!="checked"){
		$("#ordinal_"+elementCode).val(""); 
		$("#ordinal_"+elementCode).attr("recordFlow","");
		$("#ordinal_"+elementCode).attr("oldvalue",""); 
		$("#placehold_"+elementCode).val(""); 
		$("#placehold_"+elementCode).attr("recordFlow","");
		$("#placehold_"+elementCode).attr("oldvalue",""); 
    }
}

function selectFahter(checked,id){
   	if(checked){
   		$("#"+id).attr("checked",true);
   	}
}
function selectCode(obj){
	$("input[attrId='"+obj.id+"']").each(function(){
		if(obj.checked==true){
        	 $(this).attr("checked", true);     
        }else {
        	 $(this).attr("checked", false);  
        }
	});
}
function selectAttrEle(obj){
	if(obj.checked==true){
		$("#"+$(obj).attr("elementId")).attr("checked", true); 
		$("#"+$(obj).attr("attrId")).attr("checked", true); 
	}
}
/* function saveDesign(){
	if($("input[name='elementCode']:checked").val()==undefined){
		jboxTip("请至少选择一个元素!");
		return;
	}
	if($("input[name='attrCode']:checked").val()==undefined){
		jboxTip("请至少选择一个属性!");
		return;
	}
	jboxPost("<s:url value='/edc/design/saveVisitDesign'/>?moduleCode=${module.moduleCode}&visitFlow=${visit.visitFlow}",
			$('#dataForm').serialize(),null,null,true);
} */
function doClose(){
	jboxClose();
}

function saveVisitDesignSingle(oprateEleCode,ordinalObj){
	jboxPost("<s:url value='/edc/design/saveVisitDesignSingle'/>?moduleCode=${pubModuleForm.module.moduleCode}&oprateEleCode="+oprateEleCode+"&projFlow=${param.projFlow}&visitFlow=${visit.visitFlow}",
			$("#elementDiv_"+oprateEleCode).serialize(),function(resp){
				$("#ordinal_"+oprateEleCode).attr("recordFlow",resp);
				$("#placehold_"+oprateEleCode).attr("recordFlow",resp);
				if(ordinalObj != null && $("#"+oprateEleCode).attr("checked")=="checked"){
					modVisitElementOrdinal(oprateEleCode,ordinalObj);    
			    }
	},null,false);
}

function modVisitModuleName(obj){
	var moduleName = $(obj).val();
	if(moduleName==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			recordFlow:"${visitModule.recordFlow}",
			moduleName:moduleName
	};
	jboxPost("<s:url value='/edc/design/modVisitModuleName'/>",data,function(){
	},null,false);
	$(obj).attr("oldvalue",moduleName);
}

function modVisitElementOrdinalConfirm(elementCode,obj){
	if(false==$("#elementDiv_"+elementCode).validationEngine("validate")){
		return ;
	}
	var ordinal = $(obj).val();
	if(ordinal==$(obj).attr("oldvalue")){
		return;
	}
	var recordFlow = $(obj).attr("recordFlow");
	if (recordFlow == null || recordFlow == "") {
		$("#"+elementCode).attr("checked",true);
		selectChildren(elementCode);
		saveVisitDesignSingle(elementCode,obj);
	} else {
		modVisitElementOrdinal(elementCode,obj);
	}
}

function modVisitElementOrdinal(elementCode,obj) {
	var ordinal = $(obj).val();
	if(ordinal==$(obj).attr("oldvalue")){
		return;
	}
	var recordFlow = $(obj).attr("recordFlow");
	var data = {
			recordFlow:recordFlow,
			ordinal:ordinal
	};
	jboxPost("<s:url value='/edc/design/modVisitElement'/>?type=noSelect",data,null,null,false);
	$(obj).attr("oldvalue",ordinal);
}

function showModules(obj){
	if(obj.checked==true){
   	 $(".moduleSelect").show();     
   }else {
	   $("[class='moduleSelect'][show!='y']").hide();      
   }
}

function selPlaceholdModule(elementCode,obj) {
	var placeholdModuleCode = $(obj).val();
	if(placeholdModuleCode==$(obj).attr("oldvalue")){
		return;
	}
	var recordFlow = $(obj).attr("recordFlow");
	if (recordFlow == null || recordFlow == "") {
		jboxTip("请先保存该元素！");
		$(obj).val("");
	} else {
		var data = {
				recordFlow:recordFlow,
				placeholdModuleCode:placeholdModuleCode
		};
		jboxPost("<s:url value='/edc/design/modVisitElement'/>",data,function(resp){
		},null,false);
		$(obj).attr("oldvalue",placeholdModuleCode);
	}
}

</script>
<body>

<div class="title1 clearfix"> 
	&#12288;当前访视：<b>${visit.visitName }</b>&#12288;当前模块：<b>${pubModuleForm.module.moduleName }</b>&#12288;
	CRF显示名称：<input type="text" style="text-align: left;" oldvalue="${visitModule.moduleName}" onblur="modVisitModuleName(this);"  value="${visitModule.moduleName}"> 
	&nbsp;<font class="red">红色为当前项目修改后名称</font>
	&nbsp;<input type="checkbox" id="showModuleSelect" onclick="showModules(this);"><label for="showModuleSelect">显示关联模块</label>
<hr/>
</div>
<div class="main_fix">
<div id="main">
<div>
<c:forEach items="${pubModuleForm.elements }" var="element">
<form id="elementDiv_${ element.elementCode}">
	<table class="xllist nofix">
		<tr>
			<th width="80px" >
			<c:set var="visitElement" value="${visitElementMap[element.elementCode] }"></c:set>
			<input type="text" class="validate[custom[integer]]" style="width: 30px;text-align: center;" id="ordinal_${element.elementCode }" recordFlow="${visitElement.recordFlow}" oldvalue="${visitElement.ordinal }" onblur="modVisitElementOrdinalConfirm('${element.elementCode }',this);" value="${visitElement.ordinal }" />
			&nbsp;<input type="checkbox" id="${element.elementCode }" onclick="selectChildren('${element.elementCode }');saveVisitDesignSingle('${element.elementCode}');" name="elementCode" value="${element.elementCode }"  <c:if test="${pdfn:contain(element.elementCode,visitEleCodes)}">checked</c:if> />
			</th>
			<th style="text-align: left" colspan="2">
				<label for="${element.elementCode }">&#12288;${element.elementName }</label><c:if test="${ !empty edcModuleForm.elementMap[element.elementCode] &&( edcModuleForm.elementMap[element.elementCode].elementName != element.elementName )}">&#12288;<font color="red">(${edcModuleForm.elementMap[element.elementCode].elementName })</font></c:if>
				<span class="moduleSelect" show="${!empty visitElement.placeholdModuleCode?'y':''}" style="float:right;display: ${empty visitElement.placeholdModuleCode?'none':''};">
				关联模块：<select style="width: 150px" id="placehold_${element.elementCode }" recordFlow="${visitElement.recordFlow}" oldvalue="${visitElement.placeholdModuleCode }" onchange="selPlaceholdModule('${element.elementCode }',this);">
							<option></option>
							<c:forEach items="${moduleList}" var="module">
							<option value="${module.moduleCode }" <c:if test="${visitElement.placeholdModuleCode eq module.moduleCode }">selected</c:if>>${module.moduleName }</option>	
							</c:forEach>
						</select>&#12288;&#12288;
				</span>
			</th>
		</tr>
		<c:forEach items="${pubModuleForm.eleAttrMap[element.elementCode] }" var ="attr"> 
		<tr><td></td>
		<td  width="150px" style="text-align: left;"><input type="checkbox" onclick="selectFahter(this.checked,'${element.elementCode}');selectCode(this);saveVisitDesignSingle('${element.elementCode}');" elementId="${element.elementCode }" name="attrCode" value="${attr.attrCode }" id="${attr.attrCode }"  <c:if test="${pdfn:contain(attr.attrCode,visitAttrCodes)}">checked</c:if>  /><label for="${attr.attrCode }">&#12288;${attr.attrName }</label><c:if test="${!empty edcModuleForm.attrMap[attr.attrCode] && (edcModuleForm.attrMap[attr.attrCode].attrName != attr.attrName) }">&#12288;<font color="red">(${edcModuleForm.attrMap[attr.attrCode].attrName })</font></c:if></td>
		<td style="text-align: left">
			<c:if test="${!empty pubModuleForm.attrCodeMap[attr.attrCode] }">
			代码：
			<c:forEach items="${ pubModuleForm.attrCodeMap[attr.attrCode] }" var="code">
				<c:set var="key" value="${attr.attrCode }.${code.codeValue}"/>
				<input type="checkbox" elementId="${element.elementCode }" onclick="selectAttrEle(this);saveVisitDesignSingle('${element.elementCode}');"  attrId="${attr.attrCode }" name="codeValue" value="${key}" id="${key}" <c:if test="${pdfn:contain(key,visitCodeKeys)}">checked</c:if>/> 
				<label for="${key}">
					&#12288;${code.codeValue }-${code.codeName }
					<c:if test="${!empty edcModuleForm.codeMap[key] && (edcModuleForm.codeMap[key].codeName != code.codeName) }">&#12288;<font color="red">(${edcModuleForm.codeMap[key].codeName})</font></c:if>&#12288;
				</label>
			</c:forEach>
			</c:if>
		</td>
		</tr>
		</c:forEach>
	</table>
</form>
</c:forEach>
</div>
</div></div>
