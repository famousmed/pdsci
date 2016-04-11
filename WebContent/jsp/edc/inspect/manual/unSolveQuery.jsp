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
<script>
function search(){
	window.location.href="<s:url value='/edc/query/dcflist'/>?orgFlow="+$("#orgFlow").val();
}
</script>
</head>

<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<table>
				<tr height="30px;">
					<td colspan="4" align="left"><font color="red">该数据项还存在以下疑问未解决,无法继续发送疑问!</font></td>
				</tr>
				<tr height="30px;">
					<td align="right" width="80px">当前机构：</td>
					<td align="left">${sysOrgMap[queryList[0].orgFlow].orgName }</td>
					<td align="right" width="80px">受试者编号：</td>
					<td align="left">${queryList[0].patientCode}</td>
				</tr>
				<tr height="30px;">
					<td align="right" width="80px">疑问序号：</td>
					<td align="left">${queryList[0].querySeq }</td>
					<td align="right" width="80px">发送方式：</td>
					<td align="left">${queryList[0].sendWayName}</td>
				</tr>
				<tr height="30px;">
					<td align="right" width="80px">疑问类型：</td>
					<td align="left" colspan="3">${queryList[0].queryTypeName}</td>
				</tr>
				<tr height="30px;">
					<td align="right" width="80px">疑问内容：</td>
					<td align="left" colspan="3">${queryList[0].queryContent }</td>
				</tr>
				<tr height="30px;">
					<td align="right" width="80px">发送时间：</td>
					<td align="left">${pdfn:transDateTime( queryList[0].sendTime)}</td>
					<td align="right" width="80px">发 送 人：</td>
					<td align="left">${queryList[0].sendUserName }</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="xllist">
				<tr> 
					<th width="30%">访视名称</th>
					<th width="20%">模块名称</th>
					<th width="30%">检查项</th>
					<th width="20%">原始值</th>
				</tr>
				<c:forEach items="${queryEventMap[queryList[0].queryFlow] }" var="data">
					<tr>
						<td width="30%">${data.visitName }</td>
						<td width="20%">${data.moduleName }</td>
						<td width="30%">${data.elementName }.${data.attrName }</td>
						<td width="20%">${data.attrValue }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="button" align="center">
				<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
			</div>
	</div>
	</div>
</body>
</html>