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
function logDetail(){
	var url = "<s:url value='/jsp/res/edu/manage/logDetail.jsp'/>";
	jboxOpen(url, "日志详情", 700, 500);
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
		工号：<input type="text" class="xltext " style="width: 100px;"/>
		时间：<input type="text" name="signDateStart"  value="2015-04" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly" style="width:100px;"/>
		科室：<select class="xlselect" style="width: 100px;">
					<option value="">请选择</option>
					<option value="">内科</option>
					<option value="">外科</option>
					<option value="">妇产科</option>
				</select>
		<input type="button" class="search" value="查&#12288;询">
	</div>
	 <table class="xllist">
		<tr>
			<th width="10%">科室</th>
			<th width="10%">姓名</th>
			<th width="10%">工号</th>
			<th width="10%">职位</th>
			<th width="10%">年月</th>
			<th width="10%">登录次数</th>
			<th width="10%">时长统计（时:分:秒）</th>
			<th width="10%">详情</th>
		</tr>
		<tr>
			<td>儿科</td>
			<td>张伟</td>
			<td>0340</td>
			<td>主任医师</td>
			<td>2015年4月</td>
			<td>19</td>
			<td>10:23:28</td>
			<td><a href="javascript:void(0);" onclick="logDetail();">详情</a></td>
		</tr>
		<tr>
			<td>内科</td>
			<td>周舟</td>
			<td>0210</td>
			<td>主任医师</td>
			<td>2015年4月</td>
			<td>12</td>
			<td>07:11:02</td>
			<td><a href="javascript:void(0);" onclick="logDetail();">详情</a></td>
		</tr>
		<tr>
			<td>妇产科</td>
			<td>张伟</td>
			<td>0223</td>
			<td>主任医师</td>
			<td>2015年4月</td>
			<td>19</td>
			<td>14:36:17</td>
			<td><a href="javascript:void(0);" onclick="logDetail();">详情</a></td>
		</tr>
		<tr>
			<td>儿科</td>
			<td>王伟</td>
			<td>0340</td>
			<td>主任医师</td>
			<td>2015年4月</td>
			<td>11</td>
			<td>15:23:28</td>
			<td><a href="javascript:void(0);" onclick="logDetail();">详情</a></td>
		</tr>
	</table>
</div>
</div>
</div>
</body>