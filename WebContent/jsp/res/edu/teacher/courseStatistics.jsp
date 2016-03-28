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
function scoreDetail(){
	var url = "<s:url value='/jsp/res/edu/teacher/scoreDetail.jsp'/>";
	jboxOpen(url, "成绩情况", 1000, 500);
}

function updateLogs(){
	var url = "<s:url value='/jsp/res/edu/teacher/updateLogs.jsp'/>";
	jboxOpen(url, "历史修改记录", 600, 400);
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
		课程名称：<input type="text" class="xltext "/>
		课程类别：<select class="xlselect" style="width: 100px;">
					<option value="">请选择</option>
					<option value="">普通培训</option>
					<option value="">岗前培训</option>
				</select>
		更新时间：<input type="text" name="signDateStart"  class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~&nbsp;
				<input type="text" name="signDateEnd" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/> 
		<input type="button" class="search" value="查&#12288;询">
		<input type="button" class="search" value="导&#12288;出">
	</div>
	 <table class="xllist">
		<tr>
			<th width="12%">课程名称</th>
			<th width="7%">课程类别</th>
			<th width="12%">最后更新时间</th>
			<th width="7%">必修人数</th>
			<th width="7%">必修完成人数</th>
			<th width="7%">必修未完成人数</th>
			<th width="7%">参加学习人数</th>
			<th width="7%">已学完人数</th>
			<th width="7%">未通过人数</th>
			<th width="7%">学习参与度</th>
			<th width="7%">成绩情况</th>
		</tr>
		<tr>
			<td>医学检验学</td>
			<td>普通培训</td>
			<td><a href="javascript:void(0);" onclick="updateLogs();" style="text-decoration: underline;">2015-04-02 18:10 张伟</a></td>
			<td>63</td>
			<td>36</td>
			<td>37</td>
			<td>80</td>
			<td>37</td>
			<td>43</td>
			<td>57%</td>
			<td>[<a href="javascript:void(0);" onclick="scoreDetail();">详情</a>] | [<a href="javascript:void(0);" onclick="">导出</a>]</td>
		</tr>
		<tr>
			<td>心内岗前</td>
			<td>岗前培训</td>
			<td><a href="javascript:void(0);" onclick="updateLogs();" style="text-decoration: underline;">2015-04-02 18:10 张伟</a></td>
			<td>63</td>
			<td>36</td>
			<td>37</td>
			<td>80</td>
			<td>37</td>
			<td>43</td>
			<td>57%</td>
			<td>[<a href="javascript:void(0);" onclick="scoreDetail();">详情</a>] | [<a href="javascript:void(0);" onclick="">导出</a>]</td>
		</tr>
	</table>
</div>
</div>
</div>
</body>