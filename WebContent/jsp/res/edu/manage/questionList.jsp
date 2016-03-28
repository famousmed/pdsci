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
		问卷名称：<input type="text" class="xltext "/>
		问卷状态：<select class="xlselect" style="width: 100px;">
					<option value="">请选择</option>
					<option value="">未发布</option>
					<option value="">已发布</option>
				</select>
		出卷日期：<input type="text" name="signDateStart"  class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~&nbsp;
				<input type="text" name="signDateEnd" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/> 
		<input type="button" class="search" value="查&#12288;询">
	</div>
	 <table class="xllist">
		<tr>
			<th width="20%">问卷名称</th>
			<th width="15%">出卷日期</th>
			<th width="20%">问卷调查范围</th>
			<th width="15%">问卷状态</th>
			<th width="15%">问卷</th>
			<th width="15%">操作</th>
		</tr>
		<tr>
			<td>科室职能管理问卷调查表</td>
			<td>2015-04-06</td>
			<td></td>
			<td>未发布</td>
			<td>[<a href="javascript:void(0);" onclick="">问卷</a>]</td>
			<td>[<a href="javascript:void(0);" onclick="">出卷</a>]</td>
		</tr>
		<tr>
			<td>医院环境卫生问卷调查表</td>
			<td>2015-03-15</td>
			<td></td>
			<td>已发布</td>
			<td>[<a href="javascript:void(0);" onclick="">问卷</a>]</td>
			<td></td>
		</tr>
		<tr>
			<td>医患关系问卷调查表</td>
			<td>2015-02-17</td>
			<td></td>
			<td>已发布</td>
			<td>[<a href="javascript:void(0);" onclick="">问卷</a>]</td>
			<td></td>
		</tr>
	</table>
</div>
</div>
</div>
</body>