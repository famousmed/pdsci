<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
</jsp:include>
<script>
$(window).bind("load", function () {
    $('#fadeDiv').css('display', 'none');
});
</script>
</head>
<body>
	<div style="height: 100%;margin-left: 10px;margin-right: 10px;" align="center">
		<table style="width: 100%;height: 100%;">
			<tr><td height="50px;">下载：<a href="<s:url value='/pub/file/down?fileFlow=${file.fileFlow}'/>">${file.fileName }</a></td></tr>
			<tr>
					<c:if test="${convertFlag}">
				<td>
					<embed
						src="${url}"
						quality="best" width="100%" height="100%" align="Middle"
						name="Print2FlashDoc" play="true" loop="false"
						allowscriptaccess="sameDomain" type="application/x-shockwave-flash"
						pluginspage="http://www.macromedia.com/go/getflashplayer"/>
				</td>
				</c:if>
				<c:if test="${!convertFlag }">
				<td style="text-align: center;">
					<div style="overflow: auto;height: 100%">
						<img src="${url}" />
					</div>
					</td>						
				</c:if>
				
			</tr>
		</table>
		</div>
</body>
<div id="fadeDiv" style="display: ;position: absolute;top: 0%;left: 0%;width: 100%;height: 100%;background-color: #e4e4e4;z-index:1001;-moz-opacity: 0.8;opacity:.80;filter: alpha(opacity=80);">
	文件加载中...
</div>
</html>