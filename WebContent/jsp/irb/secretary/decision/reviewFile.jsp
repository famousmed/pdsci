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
	function showForm(url,fileName) {
		url = url + "&showType=messager";
		var mainIframe = window.parent.frames["mainIframe"];
		var height = mainIframe.document.body.scrollHeight;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,fileName,800,height);
	}
	
	function saveReviewFile(){
		var inputs = $("input[name='fileFlows']:checked");
		if (inputs == null || inputs.length==0) {
			jboxTip("请至少选择一条记录！");
			return;
		}
		var values = [];
		inputs.each(function(){
			value = this.value;
			var obj = {"fileFlow":value,"fileTempId":$("#fileTempId_"+value).val(),"fileName":$("#fileName_"+value).val(),"fileType":$("#fileType_"+value).val(),
					"version":$("#version_"+value).val(),"versionDate":$("#versionDate_"+value).val(),"url":$("#url_"+value).val()};
			values.push(obj);
		});
		var requestData= {"irbFlow":"${irbFlow}","applyFileForms":values,"irbRecTypeId":"${fileType}"};
		jboxPostJson("<s:url value='/irb/secretary/saveReviewFile' />",JSON.stringify(requestData),function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames["mainIframe"].location.href="<s:url value='/irb/secretary/decision'/>?irbFlow=${irbFlow}&tagId=decisionDetail";
				doClose();
			}
		},null,true);
	}
	
	function doClose() {
		jboxClose();
	}
</script>
</head>
<body>
<div class="mainright" style="height: 90%">
	<div class="content">
		<div class="title1 clearfix">
		<form id="reviewFileForm">
		<table class="xllist" > 
			<tr>
				<th width="10px"></th>
				<th width="110px" style="text-align: center">文件名</th>
				<th width="50px" style="text-align: center">版本号</th>
				<th width="50px" style="text-align: center">版本日期</th>
			</tr>
			<c:forEach items="${applyList}" var="irb">
			<tr>	
				<th colspan="4" style="text-align: left;padding-left: 10px;">${irb.irbTypeName}</th>	
			</tr>
			<c:forEach items="${fileMap[irb.irbFlow]}" var="file">
				<tr>	
					<td width="10px">
						<c:set var="key" value="${file.fileTempId }_${irb.irbFlow }"></c:set>
						<c:set var="fileFlow" value="${empty file.fileFlow?key:file.fileFlow }"></c:set>
						<input type="checkbox"  name="fileFlows" id="${fileFlow }" value="${fileFlow }" 
							<c:if test="${pdfn:contain(empty file.fileFlow?file.url:file.fileFlow,existFileFlow) || (empty existFileFlow && irb.irbFlow eq irbFlow)}"> checked</c:if>/>
						<input type="hidden"  id="fileTempId_${fileFlow }" value="${file.fileTempId }" >
						<input type="hidden"  id="fileName_${fileFlow }" value="${file.fileName }" >
						<input type="hidden"  id="fileType_${fileFlow }" value="${file.fileType }" >
						<input type="hidden"  id="version_${fileFlow }" value="${file.version }" >
						<input type="hidden"  id="versionDate_${fileFlow }" value="${file.versionDate }" >
						<input type="hidden"  id="url_${fileFlow }" value="${file.url }" >
					</td>	
					<td width="110px" style="text-align: left;padding-left: 10px;">
						<a <c:choose>
							<c:when test="${!empty file.fileFlow }">href="${ctxPath}/pub/file/down?fileFlow=${file.fileFlow}"</c:when>
							<c:otherwise>href="javascript:showForm('${file.url}','${file.fileName}')"</c:otherwise>
						</c:choose>  >
						${file.fileName}</a>
					</td>
					<td width="50px">${file.version}</td>
					<td width="50px">${file.versionDate}</td>
				</tr>			
			</c:forEach>
		   </c:forEach>
	</table>
	</form>
	</div>
	</div>
</div>
<div class="button" align="center">
		<input type="button" class="search" onclick="saveReviewFile();" value="保&#12288;存">
		<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
	</div>
</body>
</html>