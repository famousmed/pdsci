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
$(document).ready(function(){
	if($("#fileTbody tr").length<=0){
		add();
	}
});

function save(){
	var form = $("#fileForm");
	if(form.validationEngine("validate")){
		var url = "<s:url value='/gcp/rec/saveMeetingFiles'/>";
		jboxSubmit(
				form,
				url,
				function(resp){
					window.parent.frames['mainIframe'].window.loadStartMeeting();
					jboxClose();				
				},
				function(resp){
					jboxTip("${GlobalConstant.SAVE_FAIL}");
				}
		);
	}
}

function del(){
	var checkboxs =$("input[name='delId']:checked");
	if(checkboxs.length == 0){
		jboxTip("请勾选要删除的文件！");
		return false;
	}
	jboxConfirm("确认删除？", function() {
	var url = "<s:url value='/gcp/rec/delMeetingFiles'/>?projFlow=${param.projFlow}";
	var requestData = checkboxs.serialize();
	jboxPost(
			url,
			requestData,
			function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadStartMeeting();
					jboxClose();
				}
			},
			null,true
	);
	},null);
}
function add(){
	$("#fileTbody").append($("#clong").html());
}
function reupload(obj){
	$(obj).parent().html('<input type="file" name="file" class="validate[required]" />');
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="fileForm" style="position: relative;" enctype="multipart/form-data" method="post">
				<input type="hidden" name="projFlow" value="${param.projFlow}"/> 
				<table class="xllist" id="append" style="width: 100%">
					<tr>
						<th colspan="2">
						<font style="float: left;margin-left: 10px">会议文件</font>
						<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="del();"/>
						<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="add();"/>
						</th>
					</tr>
					<tbody id="fileTbody">
					<c:forEach items="${meetingForm.files}" var="file">
						<tr>
							<td style="width: 10%"><input type="checkbox" name="delId" value="${file.id }" /><input type="hidden" name="ids" value="${file.id }"><input type="hidden" name="fileFlows" value="${file.fileFlow }"></td>
							<td style="width: 90%;text-align: left;padding-left: 10px;">
							<c:choose>
								<c:when test="${empty file.fileFlow }">
									<input type="file" name="file" class="validate[required]" />
								</c:when>
								<c:otherwise>
									<a style="color: blue;" href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName }</a>&#12288;
									[<a href="javascript:void(0)" onclick="reupload(this)">重新上传</a>]
									<input type="file"  name="file" style="display: none;"/>
								</c:otherwise>
							</c:choose>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save();" />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
		</div>
	</div>
</div>
<table style="display: none;">
    <tbody id="clong">
	<tr>
		<td style="width: 10%"><input type="checkbox" name="delId" /><input type="hidden" name="ids"><input type="hidden" name="fileFlows"></td>
		<td style="width: 90%;text-align: left;padding-left: 10px;"><input type="file" name="file" class="validate[required]" /></td>
	</tr>
	</tbody>
</table>
</body>
</html>