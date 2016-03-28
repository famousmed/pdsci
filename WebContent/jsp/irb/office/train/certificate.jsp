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
function saveFile(){
	if(false==$("#fileForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/irb/office/saveCertificate'/>";
	jboxSubmit($('#fileForm'),url,function(resp){
		//window.parent.frames['mainIframe'].location.reload(true);
		jboxClose();				
	},function(resp){
		jboxTip("${GlobalConstant.SAVE_FAIL}");
	});
}

function doClose() {
	jboxClose();
}

function reCheck(obj){
	$(obj).hide();//[重新选择文件]隐藏
	$(obj).parent().parent().children().eq(1).hide();//下载链接隐藏
	$(obj).parent().parent().children().eq(2).show();//文件按钮显示
	$(obj).parent().parent().children().eq(2).addClass("validate[required]");//文件按钮加验证
	
}

</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<div class="title1 clearfix">
		<form id="fileForm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="trainCategoryId" value="${param.trainCategoryId}"/>
		<table class="xllist" width="100%">
			<thead>
				<tr>
					<th width="10%">姓名</th>
					<th width="30%">证书编号</th>
					<th width="50%">证书</th>
				</tr>
			</thead>
			<tbody id="fileBody">
				<c:forEach items="${userList}" var="user">
					<tr>
						<td width="15%">${user.userName}</td>
						<td width="30%">
							<input type="text" name="fileNo" value="${user.fileNo}"/>
						</td>
						<td style="text-align: left;">&#12288;
							<input type="hidden" name="recordFlows" value="${user.recordFlow}"/>
							<c:choose>
								<c:when test="${not empty fileMap[user.recordFlow].fileName}">
									<a id="link" href="<s:url value='/pub/file/down'/>?fileFlow=${fileMap[user.recordFlow].fileFlow}">${fileMap[user.recordFlow].fileName}</a>
									<input type="file" id="file" name="files" style="display: none;"/>
									<span style="float: right; padding-right: 10px;">
                   						 <a href="javascript:void(0);" onclick="reCheck(this);" class="lock">[重新选择文件]</a>
                   					</span>
								</c:when>
								<c:otherwise>
									<input type="file" name="files" id="file"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
		<p class="button" style="text-align: center;">
			<input type="button" class="search" value="保&#12288;存" onclick="saveFile();" />
			<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
		</p>
		</div>
	</div>
	</div>
</body>
</html>