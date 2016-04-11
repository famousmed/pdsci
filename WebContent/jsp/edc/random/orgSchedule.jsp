<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</head>
<script type="text/javascript">
</script>
<body> 
	<div style="width: 55%;margin: 20px auto;">
			<table class="xllist">
				<tr><th colspan="2">随机进度情况</th></tr> 
				<tr><td width="30%">中心号</td><td style="text-align: left;padding-left: 10px;" width="70%">${randomMap['centerNo']}</td></tr>
				<tr><td>机构名称</td><td style="text-align: left;padding-left: 10px;">${randomMap['orgName']}</td></tr>
				<tr><td>入组例数</td><td style="text-align: left;padding-left: 10px;">${randomMap['inCount']}</td></tr>
				<tr><td>发药次数</td><td style="text-align: left;padding-left: 10px;">${randomMap['assignCount']}</td></tr>
				<tr><td>第一例入组日期</td><td style="text-align: left;padding-left: 10px;">${pdfn:transDateTime(randomMap['minInDate'])}</td></tr>
				<tr><td>最后一例入组日期</td><td style="text-align: left;padding-left: 10px;">${pdfn:transDateTime(randomMap['maxInDate'])}</td></tr>
			</table>
		</div>
</body>
</html>