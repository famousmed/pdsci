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
<script type="text/javascript">
function nextOpt(step){
	var form = $('#projForm');
	var action = form.attr('action');
	action+="?nextPageName="+step;
	form.attr("action" , action);
	form.submit();
}

function addFile(){
	var url = "?pageName=file&itemGroupName=fileEdit&projRecFlow=${param.projRecFlow}&projFlow=${param.projFlow}";
	jboxOpen("<s:url value='/srm/proj/mine/showPageGroupStep'/>"+url, "添加信息", 500,350);
}

function delFile(fileFlow) {
	jboxConfirm("确认删除？" , function(){
		doDelFile(fileFlow);
	});
}
function doDelFile(fileFlow){
	var url = "<s:url value='/pub/file/delete?fileFlow='/>" + fileFlow;
	jboxGet(url ,null , function(){
		window.parent.frames['mainIframe'].location.reload(true);
	} , null , true);
}

</script>
</head>
<body>
第五步 文件上传 流水号：${param.projFlow}
<a href="javascript:void(0)" onclick="addFile();">新增</a><br/>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
	<input type="hidden" name="pageName" value="file"/>
	<input type="hidden" name="projRecFlow" value="${param.projRecFlow}"/>
	<input type="hidden" name="projFlow" value="${param.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<table class="xllist">
			<tr>
				<th width="100px">文件名</th>
				<th width="200px">备注</th>
				<th width="100px">文件类型</th>
				<th width="100px">上传日期</th>
				<th width="80px">操作</th>
			</tr>
			<c:forEach items="${fileList}" var="file">
				<tr style="height: 20px">
					<td style="text-align: left">&#12288;${file.fileName}</td>
					<td>${file.fileRemark}</td>
					<td>${file.fileSuffix}</td>
					<td>${file.createUserFlow}</td>
					<td>
					[<a href="javascript:delFile('${file.fileFlow}');">删除</a>]
					</td>
				</tr>
			</c:forEach>
		</table>
</form>





<a href="javascript:void(0)" target="_self" onclick="nextOpt('step4')" id="next">上一步</a>
<a href="javascript:void(0)" target="_self" onclick="nextOpt('finish')">完成</a>
</body>
</html>