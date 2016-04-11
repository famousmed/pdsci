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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
</head>
<style>
.edit3{text-align: left;border:none;}
</style>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="projForm" style="position: relative;"> 
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th width="20%">姓&#12288;名：</th>
						<td colspan="5">
							<input type="text" name="" class="xltext" />
						</td>
					</tr>
					<tr>
						<th >办公电话：</th>
						<td colspan="5">
							<input type="text" name="" class="xltext" />
						</td>
					</tr>
					<tr>
						<th>手&#12288;机：</th>
						<td colspan="5">
							<input type="text" name="" class="xltext" />
						</td>
					</tr>
					<tr>
						<th>邮&#12288;箱：</th>
						<td colspan="5">
							<input type="text" name="" class="xltext" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="jboxClose()"  />
		</div>
</div></div></div>
</body>
</html>