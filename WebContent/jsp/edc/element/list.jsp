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

function selectChildren(obj){
	$("input[elementId='"+obj.id+"']").each(function(){
			if(obj.checked==true){
	        	 $(this).attr("checked", true);     
	        }else {
	        	 $(this).attr("checked", false);  
	        }
    	});
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
function saveDesign(){
	if($("input[name='elementCode']:checked").val()==undefined){
		jboxTip("请至少选择一个元素!");
		return;
	}
	if($("input[name='attrCode']:checked").val()==undefined){
		jboxTip("请至少选择一个属性!");
		return;
	}
	
	jboxPost("<s:url value='/edc/design/saveDesign'/>?moduleCode=${edcModule.moduleCode}",$('#dataForm').serialize(),null,null,true);
}
</script>
<body>

<div style="width: 100%">
	  <p  style=" color:#c00; line-height:25px; background:url('<s:url value='/css/skin/${skinPath}/images/tb.png'/>') no-repeat 20px -11px; padding:18px 0 6px 40px;">
	  当前模块：${edcModule.moduleName }&#12288;
	  <input type="button" value="保存" class="dingdan-d" onclick="saveDesign();" style="float: right"/>
	  <input type="button" value="关闭" class="dingdan-d" onclick="jboxClose();" style="float: right"/></p>
<hr/>
</div>
<form id="dataForm">
<div style="overflow: auto;" >
<c:forEach items="${pubModuleForm.elements }" var="element">
<div id="elementDiv_${ element.elementCode}">
	<table class="xllist">
		<tr>
			<th width="50px"><input type="checkbox" id="${element.elementCode }" onclick="selectChildren(this);" name="elementCode" value="${element.elementCode }"  <c:if test="${pdfn:contain(element.elementCode,edcModuleForm.elementCodes)}">checked</c:if> /></th>
			<th style="text-align: left" colspan="3"><label for="${element.elementCode }">&#12288;${element.elementName }</label></th>
		</tr>
		<c:forEach items="${pubModuleForm.eleAttrMap[element.elementCode] }" var ="attr"> 
		<tr><td></td><td width="150px" style="text-align: left;"><input type="checkbox" onclick="selectFahter(this.checked,'${element.elementCode}');selectCode(this);" elementId="${element.elementCode }" name="attrCode" value="${attr.attrCode }" id="${attr.attrCode }"  <c:if test="${pdfn:contain(attr.attrCode,edcModuleForm.attrCodes)}">checked</c:if>  /><label for="${attr.attrCode }">&#12288;${attr.attrName }</label></td>
		<td style="text-align: left">
			<c:if test="${!empty pubModuleForm.attrCodeMap[attr.attrCode] }">
			代码：
			<c:forEach items="${ pubModuleForm.attrCodeMap[attr.attrCode] }" var="code">
				<c:set var="key" value="${attr.attrCode }.${code.codeValue}"/>
				<input type="checkbox" elementId="${element.elementCode }" onclick="selectAttrEle(this);"  attrId="${attr.attrCode }" name="codeValue" value="${key}" id="${key}" <c:if test="${pdfn:contain(key,edcModuleForm.codeValue)}">checked</c:if>/> <label for="${key}">&#12288;${code.codeValue }-${code.codeName }&#12288;</label>
			</c:forEach>
			</c:if>
		</td>
		</tr>
		</c:forEach>
	</table>
</div>
</c:forEach>
</div>
</form>
