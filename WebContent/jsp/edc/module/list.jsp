<script type="text/javascript">
function saveModuleSingle(obj){
	var actionFalg;
	if(obj.checked==true){
		actionFlag = "${GlobalConstant.FLAG_Y}	";
	}else {
		actionFlag = "${GlobalConstant.FLAG_N}	";
	}
	jboxGet("<s:url value='/edc/design/saveModuleSingle'/>?moduleCode="+$(obj).val()+"&actionFlag="+actionFlag,null,function(){
		count('${param.projFlow}');
		if($(obj).attr("checked")=="checked"){
			$("#"+$(obj).attr("moduleTypeId")).css("color","red");
		}else {
			if($("input[moduleTypeId='"+$("#"+$(obj).attr("moduleTypeId"))+"']:checked").length==0){
				$("#"+$(obj).attr("moduleTypeId")).css("color","");
			}
		}
		window.parent.frames['mainIframe'].window.refresh();
	},null,false);
} 
</script>
<form id="moudleForm">
<table class="xllist">
<tr><th></th><th>模块名称</th><th>模块缩写</th><th>模块类型</th></tr>
<c:forEach items="${moduleList }" var="module">
<tr>
<td><input type="checkbox" name="moduleCode" moduleTypeId="${module.moduleTypeId }" onclick="saveModuleSingle(this);" value="${module.moduleCode }" <c:if test="${pdfn: contain(module.moduleCode,existCodeList)}">checked</c:if>></td>
<td>${module.moduleName }</td>
<td>${module.moduleShortName }</td>
<td>${module.moduleTypeName }</td>
</tr>
</c:forEach> 
<input type="hidden" name="domain" value="${param.domain }"/>
</table>
</form>
