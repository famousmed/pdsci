<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<style type="text/css">
.moduleDiv{color:#fff;line-height:35px;float:left;height:35px;background-color:#1CA1E2;text-align: center;vertical-align: middle;padding-left:20px;padding-right:20px;margin-left: 20px;margin-top: 10px;cursor: pointer; }
</style>
<script>

function callOut(moduleFlow,moduleTypeId){
	hideJCallOut();
	 var msg = '[<a href=javascript:editModule(\''+moduleFlow+'\',\''+moduleTypeId+'\');>编辑</a>][<a href=javascript:delModule(\''+moduleFlow+'\',\''+moduleTypeId+'\');>删除</a>]';
	 $('#'+moduleFlow).jCallout({
		   message: msg, 
		   backgroundColor: "#F7F3B1",
		   textColor: "#3B3b3B",
		   position:"top",
		  // hideEffect:"explode",
		   showEffect:"blind",
		   showSpeed:"fast",
		   $closeElement: $("<span style='float: right; cursor: pointer'>&#12288;&#12288;[<a href=javascript:doClose(\'"+moduleFlow+"\');>关闭</a>]</span>"),
		   hideSpeed:"fast"
	});
}
function doClose(moduleFlow){
	$('#'+moduleFlow).jCallout('hide');
}
function add(){
	jboxOpen("<s:url value='/pub/module/addModule?moduleTypeId=${param.domain}'/>"
			, "新增模块信息", 500, 300);
}
function hideJCallOut(){
	$('.callout').each(function(){
		$(this).hide();
	}); 
}
</script>
</head>
<body>
<table>
<tr>
<td>
<div class="moduleDiv" title="新增" onclick="add();" style="background-color:;border:1px ;background-image: url('<s:url value='/css/skin/${skinPath}/images/add6.png' />'); background-repeat: no-repeat;background-position: center;">
</div>
</td><td style="padding-left: 20px;font-size: 14px">
<p>当前域：${pdfn:getDictName(dictTypeEnumModuleType,param.domain) }(${param.domain })</p>
<p>模块数：${fn:length(moduleList) }</p>
</td>
</tr>
</table>
<table> 
<tr><td>
<c:forEach items="${moduleList }" var="module">
	<div class="moduleDiv" id="${module.moduleFlow }" onclick="list('${module.moduleCode}');" >${module.moduleName }(${module.moduleShortName})&#12288;&#12288;</div>
</c:forEach>
</td></tr>
</table>
</body>
</html>