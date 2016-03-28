<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function checkFile(file){
	var filePath = file.value;
	var types = "${sysCfgMap['inx_image_support_suffix']}".split(",");
	var regStr = "/";
	for(var i = 0 ;i<types.length;i++){
		if(types[i]){
			if(i==(types.length-1)){
				regStr = regStr+"\\"+types[i]+'$';
			}else{
				regStr = regStr+"\\"+types[i]+'$|';
			}
		}
	}
	regStr = regStr+'/i';
	regStr = eval(regStr);
	if($.trim(filePath)!="" && !regStr.test(filePath)){
		file.value = "";
		jboxTip("请上传&nbsp;${sysCfgMap['inx_image_support_suffix']}格式的图片");
	}
}

function checkUploadFile(){
	if ($("#uploadFileForm").validationEngine("validate")) {
		jboxStartLoading();
		$(":file.auto:hidden").attr("disabled",true);
		var url = "<s:url value='/inx/jsres/saveUploadFile'/>";
		$("#uploadFileForm").submit();
	}
}

function returnUrl(){
	window.parent.$('#${param.operType}').text("重新上传");
	window.parent.$('#${param.operType}Value').val("${filePath}");
	var filePath = "${sysCfgMap['upload_base_url']}/${filePath}";
	window.parent.$('#${param.operType}Del').show();
	window.parent.$('#${param.operType}Span').show();
	window.parent.$('#${param.operType}Span').find("a").attr('href',filePath);
	doClose();
}

function reUpload(){
	$('#uploadErrorDiv').hide();
	$('#uploadFileDiv').show();
}

function doClose() {
	var openDialog = top.dialog.get('openDialog');
	if(openDialog !=null && openDialog.open){
		openDialog.close().remove();
	}
}

$(document).ready(function(){
	if ("${GlobalConstant.FLAG_Y}"=="${result}") {
		returnUrl();
	}
});	
</script>
</head>
<body>
<div class="infoAudit">
	<form id="uploadFileForm" method="post" action="<s:url value='/inx/jsres/checkUploadFile'/>" enctype="multipart/form-data">
		<input type="hidden" name="operType" value="${param.operType}"/>
		<input type="hidden" name="userFlow" value="${param.userFlow}"/>
		<div id="uploadFileDiv" style="display: ${empty result?'':'none'}">
			<div style="height: 60px;text-align: center;vertical-align: middle;">
				<input type="file" name="uploadFile" class="validate[required] auto" style="border: none;" onchange="checkFile(this);" accept="${sysCfgMap['inx_image_support_mime']}"/>
			</div>
			<div class="button">
				<input class="btn_blue" type="button" value="确&#12288;定" onclick="checkUploadFile();" />
				<input class="btn_blue" type="button" value="取&#12288;消" onclick="doClose();" />
			</div>
		</div>
		<div id="uploadErrorDiv" style="display: ${result==GlobalConstant.FLAG_N?'':'none'}">
			<div style="color: red;height: 60px;text-align: center;vertical-align: middle;">${fileErrorMsg}</div>
			<div class="button">
				<input class="btn_blue" type="button" value="重新上传" onclick="reUpload();" />
				<input class="btn_blue" type="button" value="取&#12288;消" onclick="doClose();" />
			</div>
		</div>
	</form>
</div>
</body>
</html>