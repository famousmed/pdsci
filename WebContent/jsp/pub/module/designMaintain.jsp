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
<style>
.none {
	border-collapse: collapse;
	table-layout: fixed;
}

.none td {
	border: 0 none;
	border-collapse: collapse;
	padding-bottom: 3px;
	padding-top: 3px;
}
.edit{background:none;text-align: center;border:none;}
.edit3{background:none;text-align: center;border:none;}
.DivSelect
{
     position: relative;
     background-color: transparent;
     width:   50px;
     height: 17px;
     overflow: hidden; /*隐藏了小三角，因为宽度为110px,而select宽度为130px*/
     border-width:0px;
     border-top-style: none; 
     border-right-style: none; 
     border-left-style: none; 
     border-bottom-style: none;
}
/*设置Select样式*/
.SelectList
{
     position: relative;
     background-color: transparent;
     TOP:    -2px;
     left:-2px;
     border-width: 0px;
     border-top-style: none; 
     border-right-style: none; 
     border-left-style: none; 
     border-bottom-style: none;
     width:100px;
     display:block;
     height: 18px;
     overflow:hidden;
}
</style>
<script type="text/javascript">
function changeStyle(obj,stylename){
	$(obj).removeClass(stylename);
}
function modModuleName(moduleFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			moduleFlow:moduleFlow,
			moduleName:$(obj).val()
	};
	
	jboxPost("<s:url value='/pub/module/saveModule'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modModuleStyle(moduleFlow,obj){
	var data = {
			moduleFlow:moduleFlow,
			moduleStyleId:$(obj).val()
	};
	
	jboxPost("<s:url value='/pub/module/saveModule'/>",data,null,null,false);
}
function modElementName(elementFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			elementFlow:elementFlow,
			elementName:$(obj).val()
	};
	
	jboxPost("<s:url value='/pub/module/saveElement'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modElementVarName(elementCode,elementFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			elementFlow:elementFlow,
			elementVarName:$(obj).val()
	};
	
	jboxGet("<s:url value='/pub/module/saveElementConfirm'/>?elementCode="+elementCode+"&elementVarName="+$(obj).val(),null,function(resp){
		if(resp != '${GlobalConstant.OPRE_FAIL}'){
			jboxPost("<s:url value='/pub/module/saveElement'/>",data,function(){
				$(obj).attr("oldvalue",$(obj).val());
			},null,false);
		}else{
			jboxTip("系统已存在该变量名,请修改!");
			$(obj).attr("value",$(obj).attr("oldvalue"));
		}
	},null,false);
}


function modAttrName(attrFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			attrFlow:attrFlow,
			attrName:$(obj).val()
	};
	
	jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modAttrVarName(elementCode,attrCode,attrFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			attrFlow:attrFlow,
			attrVarName:$(obj).val()
	};
	
	jboxGet("<s:url value='/pub/module/saveAttrConfirm'/>?elementCode="+elementCode+"&attrCode="+attrCode+"&attrVarName="+$(obj).val(),null,function(resp){
		if(resp != '${GlobalConstant.OPRE_FAIL}'){
			jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,function(){
				$(obj).attr("oldvalue",$(obj).val());
			},null,false);
		}else{
			jboxTip("系统已存在该变量名,请修改!");
			$(obj).attr("value",$(obj).attr("oldvalue"));
		}
	},null,false);
}
function modAttrDataType(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			dataTypeId:$(obj).val()
	};
	jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,null,null,false);
}
function modAttrInputType(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			inputTypeId:$(obj).val()
	};
	jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,null,null,false);
}
function modDataLength(attrFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			attrFlow:attrFlow,
			dataLength:$(obj).val()
	};
	jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modDataDecimalLength(attrFlow,obj){
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			attrFlow:attrFlow,
			dataDecimalLength:$(obj).val()
	};
	jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}

function modCodeValue(codeFlow,codeValue,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			codeFlow:codeFlow,
			codeValue:codeValue,
			codeName:$(obj).val()
	};
	jboxPost("<s:url value='/pub/module/modCodeValue'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modAttrIsViewName(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			isViewName:$(obj).val()
	};
	jboxPost("<s:url value='/pub/module/modifyAttr'/>",data,null,null,false);
}
function selModule(){
	window.location.href="<s:url value='/pub/module/design'/>?moduleCode="+$("#moduleCode").val();
}


$(document).ready(function(){
	<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
	$("input").each(function(i){
		  $(this).attr("disabled",true);
	 });
	$("select[id!='moduleCode']").each(function(i){
		  $(this).attr("disabled",true);
	 });
	</c:if>
});
</script>
<body>
	<div class="mainright">
	<div class="content">
			<div style="margin-top: 5px">
				模块：<select style="width: 300px" id="moduleCode" onchange="selModule();">
						<option></option>
						<c:forEach items="${moduleList}" var="module">
						<option value="${module.moduleCode }" <c:if test="${param.moduleCode eq module.moduleCode }">selected</c:if>>${module.moduleName }</option>	
						</c:forEach>
				</select>
				&#12288;
				<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
					<font color="red">当前项目已锁定设计，无法修改!</font>
				</c:if>
				<hr/>
	</div>
			<div class="title1 clearfix">
			<form id="form">
			<table class="basic" style="width: 100%">
				<tr height="40px">
					<th style="text-align: center">元素名称</th>
					<th style="text-align: center">属性名称</th>
					<th style="text-align: center" width="100px">变量名</th>
					<th style="text-align: center" width="100px">数据类型</th>
					<th style="text-align: center" width="100px">数据长度</th>
					<th style="text-align: center" width="100px">小数长度</th>
					<th style="text-align: center" width="100px">是否显示属性名</th>
					<th style="text-align: center" width="100px">录入方式</th>
					<th style="text-align: center">代码</th>
				</tr>
				<c:forEach items="${moduleList}" var="module">
					<c:if test="${!empty param.moduleCode &&  param.moduleCode  eq module.moduleCode }">
					<tr>
					<th	colspan="10" style="text-align: left">
					&#12288;模块名称：<input type="text" style="text-align: left;" onfocus="changeStyle(this,'edit');" oldvalue="${module.moduleName }" class="edit validate[required]"  onblur="modModuleName('${module.moduleFlow}',this);"  value="${module.moduleName}">
					&#12288;展示类型：<select style="text-align: left;" class="edit" onchange="modModuleStyle('${module.moduleFlow}',this);">
				     			<c:forEach var="moduleStyle" items="${moduleStyleEnumList}">
				     				<option value="${moduleStyle.id }" <c:if test="${module.moduleStyleId== moduleStyle.id }">selected</c:if>>${moduleStyle.name }</option>
				     			</c:forEach>
			     			</select>
					</th>
					</tr>
					<c:forEach	items="${pubDesignForm.elements }" var="element"> 
					<tr>
						<td  width="100px"  rowspan="${fn:length(pubDesignForm.eleAttrMap[element.elementCode]) +1}"><input type="text" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');" oldvalue="${element.elementName }" class="edit3 validate[required]" onblur="modElementName('${element.elementFlow}',this);" value="${element.elementName }"/>
							<br/><input type="text" value="${element.elementVarName}" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');" class="edit3 validate[required]" onblur="modElementVarName('${element.elementCode}','${element.elementFlow}',this);" oldvalue="${element.elementVarName }"/>
						</td>
					</tr>
					<c:forEach	items="${pubDesignForm.eleAttrMap[element.elementCode] }" var="attribute">
					<tr style="height: 30px">
						<td  width="100px" style="text-align: center;">
							<input type="text" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.attrName }" class="edit3 validate[required]" onblur="modAttrName('${attribute.attrFlow}',this);" value="${attribute.attrName}"/>
						</td>
						<td style="text-align: center"><input type="text" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.attrVarName }" class="edit3 validate[required]" onblur="modAttrVarName('${attribute.elementCode}','${attribute.attrCode}','${attribute.attrFlow}',this);" value="${attribute.attrVarName}"/></td>
						<td>
							<div class="DivSelect">
							<select name="dataTypeId" class="SelectList"  onchange="modAttrDataType('${attribute.attrFlow}',this);">
								<option value="${attrDataTypeEnumString.id }" <c:if test="${attrDataTypeEnumString.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumString.name }</option>
								<option value="${attrDataTypeEnumInteger.id }" <c:if test="${attrDataTypeEnumInteger.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumInteger.name }</option>
								<option value="${attrDataTypeEnumFloat.id }" <c:if test="${attrDataTypeEnumFloat.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumFloat.name }</option>
								<option value="${attrDataTypeEnumDate.id }" <c:if test="${attrDataTypeEnumDate.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumDate.name }</option>
							</select>
							</div>
						</td>
						<td width="50px">
							<input type="text" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.dataLength}" class="edit3 validate[required]" onblur="modDataLength('${attribute.attrFlow}',this);" value="${attribute.dataLength}"/>
						</td>
						<td width="50px">
							<input type="text" style="text-align: center;width: 90%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.dataDecimalLength}" class="edit3" onblur="modDataDecimalLength('${attribute.attrFlow}',this);" value="${attribute.dataDecimalLength}"/>
						</td>
						<td width="25px" style="text-align: center;">
							<div class="DivSelect">
							<select name="isViewName" class="SelectList"  onchange="modAttrIsViewName('${attribute.attrFlow}',this);">
								<option value="${ GlobalConstant.FLAG_Y  }" <c:if test="${attribute.isViewName == GlobalConstant.FLAG_Y }">selected</c:if>>是</option>
								<option value="${ GlobalConstant.FLAG_N }"  <c:if test="${attribute.isViewName == GlobalConstant.FLAG_N }">selected</c:if>>否</option>
							</select>
							</div>
						</td> 
						<td>
							<div class="DivSelect">
							<select name="inputTypeId" class="SelectList"  onchange="modAttrInputType('${attribute.attrFlow}',this);">
								<option value=""></option>
								<option value="${attrInputTypeEnumText.id }" <c:if test="${attrInputTypeEnumText.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumText.name }</option>
								<option value="${attrInputTypeEnumRadio.id }" <c:if test="${attrInputTypeEnumRadio.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumRadio.name }</option>
								<option value="${attrInputTypeEnumCheckbox.id }" <c:if test="${attrInputTypeEnumCheckbox.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumCheckbox.name }</option>
								<option value="${attrInputTypeEnumSelect.id }" <c:if test="${attrInputTypeEnumSelect.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumSelect.name }</option>
								<option value="${attrInputTypeEnumDate.id }" <c:if test="${attrInputTypeEnumDate.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumDate.name }</option>
							</select>
							</div>
						</td>
						<td style="text-align: left;" >
							<ul>
							<c:forEach	items="${pubDesignForm.attrCodeMap[attribute.attrCode] }" var="attrCode"> 
								<li>
									${attrCode.codeValue}-<input type="text"  onfocus="changeStyle(this,'edit3');" oldvalue="${attrCode.codeName}" style="text-align: left;width: 90%" value="${attrCode.codeName}" onblur="modCodeValue('${attrCode.codeFlow}','${attrCode.codeValue}',this);" class="edit3 validate[required]" >&#12288; 
								</li>
							</c:forEach> 
							</ul>
						</td>
					</tr>
					</c:forEach>
					</c:forEach>
					</c:if>
				</c:forEach>
				
			</table>
			</form>
		</div>
	</div>
	</div>
</body>
</html>