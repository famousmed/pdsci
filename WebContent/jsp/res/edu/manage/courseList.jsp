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
function editCourse(courseFlow){
	var url = "<s:url value='/jsp/res/edu/manage/editCourse.jsp'/>";
	window.location.href=url;
}

function courseMain() {
	window.location.href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=manage' />";
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<div style="margin-bottom: 10px;margin-right: 10px;">
		课程名称：<input type="text" class="xltext "/>
		课程类别：<select class="xlselect" style="width: 100px;">
					<option value="">请选择</option>
					<option value="">普通培训</option>
					<option value="">岗前培训</option>
				</select>
		上传日期：<input type="text" name="signDateStart"  class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~&nbsp;
				<input type="text" name="signDateEnd" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/> 
		<input type="button" class="search" value="查&#12288;询">
	</div>
	 <table class="xllist">
		<tr>
			<th width="30%">课程名称</th>
			<th width="10%">课程类别</th>
			<th width="10%">上传人</th>
			<th width="10%">科室</th>
			<th width="10%">工号</th>
			<th width="10%">职称</th>
			<th width="10%">学分</th>
			<th width="15%">上传日期</th>
			<th width="13%">操作</th>
		</tr>
		<tr>
			<td><a href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=manage' />" target="_blank">中医学</a></td>
			<td>普通培训</td>
			<td>周舟</td>
			<td>儿科</td>
			<td>0453</td>
			<td>主任医师</td>
			<td>5</td>
			<td>2015-04-06</td>
			<td>[<a href="javascript:void(0);" onclick="editCourse();">设置</a>]</td>
		</tr>
		<tr>
			<td><a href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=manage' />" target="_blank">预防医学</a></td>
			<td>普通培训</td>
			<td>张伟</td>
			<td>内科</td>
			<td>0267</td>
			<td>主任医师</td>
			<td>5</td>
			<td>2015-03-26</td>
			<td>[<a href="javascript:void(0);" onclick="editCourse();">设置</a>]</td>
		</tr>
		<tr>
			<td><a href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=manage' />" target="_blank">营养学</a></td>
			<td>普通培训</td>
			<td>李丽</td>
			<td>内科</td>
			<td>0235</td>
			<td>主任医师</td>
			<td>3</td>
			<td>2015-02-17</td>
			<td>[<a href="javascript:void(0);" onclick="editCourse();">设置</a>]</td>
		</tr>
		<tr>
			<td><a href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=manage' />" target="_blank">医学检验学</a></td>
			<td>岗前培训</td>
			<td>王伟</td>
			<td>心血管内科</td>
			<td>0267</td>
			<td>主任医师</td>
			<td>5</td>
			<td>2015-01-26</td>
			<td>[<a href="javascript:void(0);" onclick="editCourse();">设置</a>]</td>
		</tr>
		<tr>
			<td><a href="<s:url value='/jsp/res/edu/student/courseMain.jsp?source=manage' />" target="_blank">临床医学基础知识</a></td>
			<td>普通培训</td>
			<td>汪洋</td>
			<td>内科</td>
			<td>0267</td>
			<td>主任医师</td>
			<td>5</td>
			<td>2015-01-12</td>
			<td>[<a href="javascript:void(0);" onclick="editCourse();">设置</a>]</td>
		</tr>
	</table>
</div>
</div>
</div>
</body>