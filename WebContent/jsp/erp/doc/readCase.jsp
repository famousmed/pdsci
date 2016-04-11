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
</script>
</head>
<body>
<div class="mainright">
<div class="content">
<div class="title1 clearfix">
	<table class="comments">
		<tbody>
		<c:forEach items="${docLogList}" var="docLog">
		<tr>
			<td>
				<span class="cm_name" style="float:left;">${docLog.userName}</span>
				<span class="cm_date">已${docLog.operName}&#12288;${pdfn:transDateTime(docLog.logTime)}</span>
			</td>
		</tr>
		</c:forEach>
		</tbody>
		<c:if test="${empty docLogList}">
			<tr>
				<td>无记录！</td>
			</tr>
		</c:if>
	</table> 
</div>
</div>
</div>
</body>
</html>