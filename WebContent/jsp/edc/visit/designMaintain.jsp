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
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
.edit3{background:none;border:0;text-align: center;}
#.edit3{background:none;text-align: center;border:none;}
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
	<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
		return;
	</c:if>
	$(obj).removeClass(stylename);
}
function modModuleName(moduleFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			moduleFlow:moduleFlow,
			moduleName:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/saveEdcModule'/>",data,function(){
		if(window.parent.frames['mainIframe']){
			window.parent.frames['mainIframe'].window.location.reload(true);
		}
	},null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modModuleStyle(moduleFlow,obj){
	var data = {
			moduleFlow:moduleFlow,
			moduleStyleId:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/saveEdcModule'/>",data,function(){},null,false);
}

function modElementName(elementFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			elementFlow:elementFlow,
			elementName:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/modElementName'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
	$(obj).attr("title",$(obj).val());
}
function modElementVarName(elementCode,elementFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			elementFlow:elementFlow,
			elementVarName:$(obj).val()
	};
	
	jboxGet("<s:url value='/pub/module/saveElementConfirm'/>?elementCode="+elementCode+"&elementVarName="+$(obj).val(),null,function(resp){
		if(resp != '${GlobalConstant.OPRE_FAIL}'){
			jboxPost("<s:url value='/edc/design/modElementName'/>",data,function(){
				$(obj).attr("oldvalue",$(obj).val());
			},null,false);
		}else{
			jboxTip("系统已存在该变量名,请修改!");
			$(obj).attr("value",$(obj).attr("oldvalue"));
		}
	},null,false);
}

function modColumnCount(elementFlow,obj){
	var data = {
			elementFlow:elementFlow,
			columnCount:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/modElementName'/>",data,null,null,false);
}
function modFixedWidth(elementFlow,obj){
	var data = {
			elementFlow:elementFlow,
			fixedWidth:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/modElementName'/>",data,null,null,false);
}
function modElementIsViewName(elementFlow,obj){
	var data = {
			elementFlow:elementFlow,
			isViewName:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/modElementName'/>",data,null,null,false);
}


function modElementSerial(elementFlow,obj){
	var data = {
			elementFlow:elementFlow,
			elementSerial:$(obj).val()
	};
	
	jboxPost("<s:url value='/edc/design/modElementName'/>",data,null,null,false);
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
	
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
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
			jboxPost("<s:url value='/edc/design/modAttr'/>",data,function(){
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
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
}
function modAttrInputType(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			inputTypeId:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
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
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
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
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}

function modCodeValue(attrCode,codeValue,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	if($(obj).val()==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			attrCode:attrCode,
			codeValue:codeValue,
			codeName:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modCodeValue'/>",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}
function modAttrIsViewName(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			isViewName:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
}
function modAttrNewLine(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			attrNewLine:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
}
function modCodeNewLine(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			codeNewLine:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
}
function modUnit(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			attrUnit:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
}
function modNote(attrFlow,obj){
	var data = {
			attrFlow:attrFlow,
			attrNote:$(obj).val()
	};
	jboxPost("<s:url value='/edc/design/modAttr'/>",data,null,null,false);
}



function selModule(){
	window.location.href="<s:url value='/edc/visit/designManage'/>?moduleCode="+$("#moduleCode").val();
}

function modEdcElementOrdinal(elementFlow,obj) {
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit");
	var ordinal = $(obj).val();
	if(ordinal==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			elementFlow:elementFlow,
			ordinal:ordinal
	};
	jboxPost("<s:url value='/edc/design/modElementName'/>?type=noSelect",data,null,null,false);
	$(obj).attr("oldvalue",ordinal);
}

function modEdcModuleOrdinal(moduleFlow,obj){
	if(false==$("#form").validationEngine("validate")){
		return ;
	}
	
	$(obj).addClass("edit3");
	var ordinal = $(obj).val();
	if(ordinal==$(obj).attr("oldvalue")){
		return;
	}
	var data = {
			moduleFlow:moduleFlow,
			ordinal:ordinal
	};
	
	jboxPost("<s:url value='/edc/design/saveEdcModule'/>?type=noSelect",data,null,null,false);
	$(obj).attr("oldvalue",$(obj).val());
}

$(document).ready(function(){
	<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
	$("input").each(function(i){
		  $(this).attr("readonly",true);
	 });
	$("select[id!='moduleCode']").each(function(i){
		  $(this).attr("readonly",true);
	 });
	</c:if>
});

var fixHelper = function(e, ui) {
    ui.children().each(function() {
   	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
        $(this).width($(this).width());
    });
    return ui;
};
$(function() {
	<c:forEach	items="${edcDesignForm.moduleElementMap[param.moduleCode] }" var="element">
	$( "#attrSortable_${element.elementCode }" ).sortable({
		helper: fixHelper, 
		create: function(e, ui){
		},
		start:function(e, ui){
		     //拖动时的行，要用ui.helper
		    ui.helper.css({"background":"#eee"});
		    return ui; 
		}, 
		stop: function( event, ui ) {
			ui.item.css({"background":"#fff"});
			var sortedIds = $( "#attrSortable_${ element.elementCode}" ).sortable( "toArray" );
			var postdata = "";
			$.each(sortedIds,function(i,sortedId){
				postdata = postdata+"&attrCode="+sortedId;
			});
			var url = "<s:url value='/edc/visit/saveEdcAttributeOrder'/>?moduleCode="+'${param.moduleCode }';
			jboxPost(url, postdata, function() {
				},null,false);
		}
	});
	</c:forEach>
});
</script>
<body>
<div class="mainright">
	<div class="content">
	<div style="margin-top: 5px">
		模块：<select style="width: 300px" id="moduleCode" onchange="selModule();">
				<option></option>
				<c:forEach items="${edcDesignForm.moduleList}" var="module">
				<option value="${module.moduleCode }" <c:if test="${param.moduleCode eq module.moduleCode }">selected</c:if>>${module.moduleName }</option>	
				</c:forEach>
			</select>&#12288;
			<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
				<font color="red">当前项目已锁定设计，无法修改!</font>
			</c:if>
			<hr/>
	</div>
	<div class="title1 clearfix">
	<form id="form">
		<c:forEach items="${edcDesignForm.moduleList}" var="module">
		<c:if test="${!empty param.moduleCode &&  param.moduleCode  eq module.moduleCode }">
			<div style="margin-bottom: 5px">&nbsp;
			<input type="text" style="width: 25px;text-align: center;" onfocus="changeStyle(this,'edit3');" oldvalue="${module.ordinal }" class="edit3 validate[custom[integer]]" onblur="modEdcModuleOrdinal('${module.moduleFlow }',this);" value="${module.ordinal }" />
			&nbsp;<b>模块名称：</b><input type="text" style="text-align: left;" onfocus="changeStyle(this,'edit3');" oldvalue="${module.moduleName }" class="edit3 validate[required]"  onblur="modModuleName('${module.moduleFlow}',this);"  value="${module.moduleName}">
			&#12288;<b>展示类型：</b>
				<c:choose>
					<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
						<c:if test="${module.moduleStyleId == moduleStyleEnumSingle.id || empty module.moduleStyleId}">${moduleStyleEnumSingle.name }</c:if>
						<c:if test="${module.moduleStyleId == moduleStyleEnumDouble.id }">${moduleStyleEnumDouble.name }</c:if>
					</c:when>
					<c:otherwise>
						<select class="edit3" style="text-align: left;" onchange="modModuleStyle('${module.moduleFlow}',this);">
							<c:forEach var="moduleStyle" items="${moduleStyleEnumList}">
						     	<option value="${moduleStyle.id }" <c:if test="${module.moduleStyleId== moduleStyle.id }">selected</c:if>>${moduleStyle.name }</option>
						     </c:forEach>
					     </select>
					</c:otherwise>
				</c:choose>
				&#12288;&#12288;&#12288;&#12288;<b>所属域：</b>${module.moduleTypeName }(${module.moduleTypeId })
			</div>
			<table class="xllist" style="width: 100%">
				<tr height="40px">
					<th style="text-align: center" width="180px">属性名称</th>
					<th style="text-align: center" width="120px">变量名</th>
					<th style="text-align: center" width="80px">数据类型</th>
					<th style="text-align: center" width="80px">数据长度</th>
					<th style="text-align: center" width="80px">小数长度</th>
					<th style="text-align: center" width="80px">是否显示<br/>属性名</th>
					<th style="text-align: center" width="80px">属性<br/>单独行</th>
					<th style="text-align: center" width="80px">代码<br/>单独行</th>
					<th style="text-align: center" width="80px">录入方式</th>
					<th style="text-align: center" width="80px">单位</th>
					<th style="text-align: center" width="80px">备注</th>
					<th style="text-align: center" width="320px">代码</th>
				</tr>
					<c:forEach	items="${edcDesignForm.moduleElementMap[module.moduleCode] }" var="element"> 
					<tr>
						<th	colspan="12" style="text-align: left">&nbsp;
							<input type="text" style="width: 25px;text-align: center;" onfocus="changeStyle(this,'edit');" oldvalue="${element.ordinal }" class="edit validate[custom[integer]]" onblur="modEdcElementOrdinal('${element.elementFlow }',this);" value="${element.ordinal }" />
							&nbsp;元素名称：<input type="text" style="text-align: left;" onfocus="changeStyle(this,'edit');" oldvalue="${element.elementName }" title="${element.elementName }" class="edit validate[required]" onblur="modElementName('${element.elementFlow}',this);" value="${element.elementName }"/>
							&#12288;元素变量名：<input type="text" style="text-align: left;" value="${element.elementVarName}" onfocus="changeStyle(this,'edit');" class="edit validate[required]" onblur="modElementVarName('${element.elementCode}','${element.elementFlow}',this);" oldvalue="${element.elementVarName }"/>
							&#12288;多次录入：
							<c:choose>
								<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
									<span style="font-weight: normal;">
										<c:if test="${element.elementSerial eq  GlobalConstant.FLAG_N }">否</c:if>
										<c:if test="${element.elementSerial eq  GlobalConstant.FLAG_Y }">是</c:if>
									</span>&#12288;&#12288;
								</c:when>
								<c:otherwise>
									<select name="elementSerial"  class="edit" style="width: 50px;" onchange="modElementSerial('${element.elementFlow}',this);">
										<option value="${GlobalConstant.FLAG_N }"  <c:if test="${element.elementSerial eq  GlobalConstant.FLAG_N }">selected</c:if>>否</option>
										<option value="${GlobalConstant.FLAG_Y }"  <c:if test="${element.elementSerial eq  GlobalConstant.FLAG_Y }">selected</c:if>  >是</option>
									</select>
								</c:otherwise>
							</c:choose>
							&#12288;属性显示数：
							<c:choose>
								<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
									<span style="font-weight: normal;">${element.columnCount }</span>
								</c:when>
								<c:otherwise>
									<select name="columnCount" class="edit" style="width: 50px;" onchange="modColumnCount('${element.elementFlow}',this);">
										<option <c:if test="${element.columnCount eq  '' }">selected</c:if> value=""></option>
										<option <c:if test="${element.columnCount eq  '1' }">selected</c:if> value="1">1</option>
										<option <c:if test="${element.columnCount eq  '2' }">selected</c:if> value="2">2</option>
										<option <c:if test="${element.columnCount eq  '3' }">selected</c:if> value="3">3</option>
										<option <c:if test="${element.columnCount eq  '4' }">selected</c:if> value="4">4</option>
									</select>
								</c:otherwise>
							</c:choose>
							&#12288;固定宽度:
							<select name="fixedWidth" class="edit" style="width: 50px;" onchange="modFixedWidth('${element.elementFlow}',this);">
										<option value=""></option>
										<option <c:if test="${element.fixedWidth eq  '250' }">selected</c:if> value="250">250</option>
										<option <c:if test="${element.fixedWidth eq  '500' }">selected</c:if> value="500">500</option>
									</select>
									&#12288;元素名称是否展示:
							<select name="isViewName"  class="edit" style="width: 50px;" onchange="modElementIsViewName('${element.elementFlow}',this);">
										<option value="${GlobalConstant.FLAG_Y }"  <c:if test="${element.isViewName eq  GlobalConstant.FLAG_Y }">selected</c:if>  >是</option>
										<option value="${GlobalConstant.FLAG_N }"  <c:if test="${element.isViewName eq  GlobalConstant.FLAG_N }">selected</c:if>>否</option>
									</select>
							
						</th>
					</tr>
					<tbody id="attrSortable_${element.elementCode }">
					<c:forEach	items="${edcDesignForm.elementAttrMap[element.elementCode] }" var="attribute">
					<tr style="height: 30px" id="${attribute.attrCode }">
						<td style="text-align: center;width:180px;">
							<input type="text" style="text-align: center;width: 80%" onfocus="changeStyle(this,'edit3');" title="${attribute.attrName }" oldvalue="${attribute.attrName }" class="edit3 validate[required]" onblur="modAttrName('${attribute.attrFlow}',this);" value="${attribute.attrName}"/>
						</td>
						<td style="text-align: center;width:120px;"><input type="text" style="text-align: center;width: 80%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.attrVarName }" class="edit3 validate[required]" onblur="modAttrVarName('${attribute.elementCode}','${attribute.attrCode}','${attribute.attrFlow}',this);" value="${attribute.attrVarName}"/></td>
						<td style="width:80px;">
						<c:choose>
							<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
								${attribute.dataTypeName }
							</c:when>
							<c:otherwise>
								<select name="dataTypeId" class="edit3"  onchange="modAttrDataType('${attribute.attrFlow}',this);">
									<option value="${attrDataTypeEnumString.id }" <c:if test="${attrDataTypeEnumString.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumString.name }</option>
									<option value="${attrDataTypeEnumInteger.id }" <c:if test="${attrDataTypeEnumInteger.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumInteger.name }</option>
									<option value="${attrDataTypeEnumFloat.id }" <c:if test="${attrDataTypeEnumFloat.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumFloat.name }</option>
									<option value="${attrDataTypeEnumDate.id }" <c:if test="${attrDataTypeEnumDate.id eq attribute.dataTypeId }">selected</c:if>>${attrDataTypeEnumDate.name }</option>
								</select>
							</c:otherwise>
						</c:choose>
						</td>
						<td style="width:80px;">
							<input type="text" style="text-align: center;width: 80%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.dataLength}" class="edit3 validate[required]" onblur="modDataLength('${attribute.attrFlow}',this);" value="${attribute.dataLength}"/>
						</td>
						<td style="width:80px;">
							<input type="text" style="text-align: center;width: 80%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.dataDecimalLength}" class="edit3" onblur="modDataDecimalLength('${attribute.attrFlow}',this);" value="${attribute.dataDecimalLength}"/>
						</td>
						<td style="text-align: center;width:80px;">
							<c:choose>
								<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
									<c:if test="${attribute.isViewName == GlobalConstant.FLAG_Y }">是</c:if>
									<c:if test="${attribute.isViewName == GlobalConstant.FLAG_N }">否</c:if>
								</c:when>
								<c:otherwise>
									<select name="isViewName" style="text-align: center;" class="edit3"  onchange="modAttrIsViewName('${attribute.attrFlow}',this);">
										<option value="${ GlobalConstant.FLAG_Y  }" <c:if test="${attribute.isViewName == GlobalConstant.FLAG_Y }">selected</c:if>>是</option>
										<option value="${ GlobalConstant.FLAG_N }"  <c:if test="${attribute.isViewName == GlobalConstant.FLAG_N }">selected</c:if>>否</option>
									</select>
								</c:otherwise>
							</c:choose>
						</td> 
						<td style="text-align: center;width:80px;">
							<c:choose>
								<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
									<c:if test="${attribute.attrNewLine == GlobalConstant.FLAG_Y }">是</c:if>
									<c:if test="${attribute.attrNewLine == GlobalConstant.FLAG_N }">否</c:if>
								</c:when>
								<c:otherwise>
									<select name="attrNewLine" style="text-align: center;" class="edit3"  onchange="modAttrNewLine('${attribute.attrFlow}',this);">
										<option value="${ GlobalConstant.FLAG_N }"  <c:if test="${attribute.attrNewLine == GlobalConstant.FLAG_N }">selected</c:if>>否</option>
										<option value="${ GlobalConstant.FLAG_Y  }" <c:if test="${attribute.attrNewLine == GlobalConstant.FLAG_Y }">selected</c:if>>是</option>
									</select>
								</c:otherwise>
							</c:choose>
						</td>
						<td style="text-align: center;width:80px;">
							<c:choose>
								<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
									<c:if test="${attribute.codeNewLine == GlobalConstant.FLAG_Y }">是</c:if>
									<c:if test="${attribute.codeNewLine == GlobalConstant.FLAG_N }">否</c:if>
								</c:when>
								<c:otherwise>
									<select name="codeNewLine" style="text-align: center;" class="edit3"  onchange="modCodeNewLine('${attribute.attrFlow}',this);">
										<option value="${ GlobalConstant.FLAG_N }"  <c:if test="${attribute.codeNewLine == GlobalConstant.FLAG_N }">selected</c:if>>否</option>
										<option value="${ GlobalConstant.FLAG_Y  }" <c:if test="${attribute.codeNewLine == GlobalConstant.FLAG_Y }">selected</c:if>>是</option>
									</select>
								</c:otherwise>
							</c:choose>
						</td>  
						<td style="width:80px;">
							<c:choose>
								<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y  || projParam.projLock ==  GlobalConstant.FLAG_Y }">
									${attribute.inputTypeName }
								</c:when>
								<c:otherwise>
									<select name="inputTypeId" class="edit3"  onchange="modAttrInputType('${attribute.attrFlow}',this);">
										<option value=""></option>
										<option value="${attrInputTypeEnumText.id }" <c:if test="${attrInputTypeEnumText.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumText.name }</option>
										<option value="${attrInputTypeEnumRadio.id }" <c:if test="${attrInputTypeEnumRadio.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumRadio.name }</option>
										<option value="${attrInputTypeEnumCheckbox.id }" <c:if test="${attrInputTypeEnumCheckbox.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumCheckbox.name }</option>
										<option value="${attrInputTypeEnumSelect.id }" <c:if test="${attrInputTypeEnumSelect.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumSelect.name }</option>
										<option value="${attrInputTypeEnumDate.id }" <c:if test="${attrInputTypeEnumDate.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumDate.name }</option>
										<option value="${attrInputTypeEnumTextarea.id }" <c:if test="${attrInputTypeEnumTextarea.id eq attribute.inputTypeId }">selected</c:if>>${attrInputTypeEnumTextarea.name }</option>
									</select>
								</c:otherwise>
							</c:choose>
						</td>
						<td><input type="text" style="text-align: center;width: 80%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.attrUnit}" class="edit3" onblur="modUnit('${attribute.attrFlow}',this);" value="${attribute.attrUnit}"/></td>
						<td><input type="text" style="text-align: center;width: 80%" onfocus="changeStyle(this,'edit3');" oldvalue="${attribute.attrNote}" class="edit3" onblur="modNote('${attribute.attrFlow}',this);" title="${ attribute.attrNote}" value="${attribute.attrNote}"/></td>
						<td style="text-align: left;padding-left:10px;width:320px;" >
							<ul>
							<c:forEach	items="${edcDesignForm.attrCodeMap[attribute.attrCode] }" var="attrCode"> 
								<li>
									${attrCode.codeValue}-<input type="text"  onfocus="changeStyle(this,'edit3');" title="${attrCode.codeName}" oldvalue="${attrCode.codeName}" style="text-align: left;width: 90%" value="${attrCode.codeName}" onblur="modCodeValue('${attribute.attrCode}','${attrCode.codeValue}',this);" class="edit3 validate[required]" >&#12288; 
								</li>
							</c:forEach> 
							</ul>
						</td>
					</tr>
					</c:forEach>
					</tbody>
					</c:forEach>
					<c:if test="${empty edcDesignForm.moduleElementMap[module.moduleCode] }"> 
						<tr> 
							<td align="center" style="text-align: center;" colspan="10">无记录</td>
						</tr>
					</c:if>
				<c:if test="${empty param.moduleCode }"> 
					<tr> 
						<td align="center" style="text-align: center;" colspan="10">无记录</td>
					</tr>
				</c:if>
			</table>
			</c:if>
		</c:forEach>
			</form>
		</div>
	</div>
	</div>
</body>
</html>