<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_fixedtable" value="false"/>
</jsp:include>
<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.title_td{text-align: right;padding:0;}
	textarea{width: 98%;height: 150px;overflow:scroll;margin: 0px 0px 5px;}
	div.option{height: 30px;line-height: 30px; vertical-align: middle;}
</style>
<script>
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-bottom: 10px;">
					<tr>
						<th>1、审核时间：2014-11-26 14:13:49&#12288;&#12288;审核结果：商务审核不通过</th>
					</tr>
					<tr> 
						<td>开票内容不详细</td>
					</tr>
				</table>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="margin-bottom: 10px;">
					<tr>
						<th>2、审核时间：2014-11-26 15:03:22&#12288;&#12288;审核结果：商务审核不通过</th>
					</tr>
					<tr> 
						<td>开票抬头错误</td>
					</tr>
				</table>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose()"  />
		</div>
</div></div></div>
</body>
</html>