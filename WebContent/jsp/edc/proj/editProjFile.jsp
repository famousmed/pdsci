<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
$(function(){
	if($("#fileList").find("tr").length<2){
		addFileInput();
	}
});

function addFileInput(){
	$("#fileList").append("<tr><td style='width:5%'><input type='checkbox' value='' class='delFiles'/></td><td><input type='file' class='validate[required]' name='file' style='float: left;margin-left: 10px'/></td></tr>");
}

function save(){
	if($("#fileForm").validationEngine("validate")){
		var url = "<s:url value='/edc/proj/savePubFile'/>";
		jboxSubmit($("#fileForm"),url,function(resp){
					window.parent.frames['mainIframe'].location.reload(true);
					doClose();				
				},function(resp){
					jboxTip("${GlobalConstant.SAVE_FAIL}");
				});
	}
}

function delFiles(){
	if($(".delFiles:checked").length > 0){
		jboxConfirm("确认删除?",function () {
			$(".delFiles:checked").each(function(){
				var fileFlow = $(this).val();
				if (fileFlow!="") {
					jboxGet("<s:url value='/edc/proj/modPubFile'/>?projFlow=${param.projFlow}&fileFlow="+fileFlow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}",null,null,null,false);
				}
				$(this).parent().parent().remove();
			});
		});
	}else{
		jboxTip("请选择要删除的文件!");
	}
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="fileForm" style="position: relative;" enctype="multipart/form-data" method="post">
				<input type="hidden" name="projFlow" value="${param.projFlow}"/> 
				<table id="fileList" class="xllist" width="100%">
				<tr>
					<th colspan="2">
						<font style="float: left;margin-left: 10px">项目文件</font>
						<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="delFiles();"/>
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="addFileInput();"/>
					</th>
				</tr>
				<c:forEach items="${fileList}" var="file">
					<tr>
					<td style="width: 5%">
						<input type="checkbox" class="delFiles" name="fileFlow" value="${file.fileFlow}"/>
					</td>
					<td>
						<a title="下载" style="color: blue;float: left;margin-left: 10px" href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName}</a>
					</td>
					</tr>
				</c:forEach>
			</table>
			</form>
			<div style="width: 100%;margin-top: 10px;" align="center" >
				<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
				<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
			</div>
		</div>
	</div>
</div>
</body>
</html>