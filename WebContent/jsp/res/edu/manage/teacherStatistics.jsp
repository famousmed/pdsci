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
function courseDetail(){
	var url = "<s:url value='/jsp/res/edu/manage/courseDetail.jsp'/>";
	jboxOpen(url, "上传课程详情", 700, 400);
}

function examDetail(){
	var url = "<s:url value='/jsp/res/edu/manage/examDetail.jsp'/>";
	jboxOpen(url, "出卷详情", 700, 400);
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
		上传人：<input type="text" class="xltext " style="width: 100px;"/>
		科室：<select class="xlselect" style="width: 100px;">
					<option value="">请选择</option>
					<option value="">内科</option>
					<option value="">外科</option>
					<option value="">妇产科</option>
				</select>
		工号：<input type="text" class="xltext " style="width: 100px;"/>
		<input type="button" class="search" value="查&#12288;询">
		<input type="button" class="search" value="导&#12288;出">
	</div>
	 <table class="xllist">
		<tr>
			<th width="10%">上传人</th>
			<th width="10%">科室</th>
			<th width="10%">工号</th>
			<th width="10%">职称</th>
			<th width="10%">上传课程数量</th>
			<th width="10%">出卷次数</th>
			<th width="10%">出题总量</th>
		</tr>
		<tr>
			<td>张伟</td>
			<td>儿科</td>
			<td>0340</td>
			<td>主任医师</td>
			<td><a href="javascript:void(0);" onclick="courseDetail();">15</a></td>
			<td><a href="javascript:void(0);" onclick="examDetail();">15</a></td>
			<td>350</td>
		</tr>
		<tr>
			<td>周舟</td>
			<td>内科</td>
			<td>0432</td>
			<td>主任医师</td>
			<td><a href="javascript:void(0);" onclick="courseDetail();">12</a></td>
			<td><a href="javascript:void(0);" onclick="examDetail();">12</a></td>
			<td>310</td>
		</tr>
		<tr>
			<td>李丽</td>
			<td>妇产科</td>
			<td>0340</td>
			<td>主任医师</td>
			<td><a href="javascript:void(0);" onclick="courseDetail();">9</a></td>
			<td><a href="javascript:void(0);" onclick="examDetail();">9</a></td>
			<td>215</td>
		</tr>
	</table>
</div>
</div>
</div>
</body>