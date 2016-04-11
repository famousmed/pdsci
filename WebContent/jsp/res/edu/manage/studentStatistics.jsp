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
function testDetail(){
	var url = "<s:url value='/jsp/res/edu/student/testDetail.jsp'/>";
	jboxOpen(url, "考试详情", 700, 400);
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
		学员姓名：<input type="text" class="xltext " style="width: 100px;"/>
		工号：<input type="text" class="xltext " style="width: 100px;"/>
		科室：<select class="xlselect" style="width: 100px;">
					<option value="">请选择</option>
					<option value="">内科</option>
					<option value="">儿科</option>
					<option value="">心内科</option>
					<option value="">妇产科</option>
				</select>
		学习时间：<input type="text" name="signDateStart"  class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;margin: 0"/>&nbsp;~&nbsp;
				<input type="text" name="signDateEnd" class="ctime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="width:100px;"/> 
		<input type="button" class="search" value="查&#12288;询">
		<input type="button" class="search" value="导&#12288;出">
	</div>
	 <table class="xllist">
		<tr>
			<th width="7%">发布科室</th>
			<th width="7%">是否必修</th>
			<th width="12%">课程名称</th>
			<th width="7%">课程状态</th>
			<th width="7%">姓名</th>
			<th width="7%">工号</th>
			<th width="7%">职称</th>
			<th width="10%">专业</th>
			<th width="7%">当前科室</th>
			<th width="7%">人员类别</th>
			<th width="10%">开始学习时间</th>
			<th width="10%">完成学习时间</th>
			<th width="7%">考试次数</th>
			<th width="7%">及格情况</th>
			<th width="7%">考试详情</th>
		</tr>
		<tr>
			<td>儿科</td>
			<td>是</td>
			<td>医学检验学</td>
			<td>已学完</td>
			<td>张伟</td>
			<td>0340</td>
			<td>初级</td>
			<td>中医学</td>
			<td>儿科</td>
			<td>本院规培</td>
			<td>2015-04-03</td>
			<td>2015-04-05</td>
			<td>2</td>
			<td>及格</td>
			<td>[<a href="javascript:void(0);" onclick="testDetail();">详情</a>]</td>
		</tr>
		<tr>
			<td>儿科</td>
			<td>否</td>
			<td>预防医学</td>
			<td>学习中</td>
			<td>李丽</td>
			<td>0341</td>
			<td>中级</td>
			<td>中医学</td>
			<td>内科</td>
			<td>进修人员</td>
			<td>2015-03-11</td>
			<td>2015-04-02</td>
			<td>3</td>
			<td>不及格</td>
			<td>[<a href="javascript:void(0);" onclick="testDetail();">详情</a>]</td>
		</tr>
		<tr>
			<td>内科</td>
			<td>是</td>
			<td>预防医学</td>
			<td>已学完</td>
			<td>周舟</td>
			<td>0432</td>
			<td>中级</td>
			<td>西医学</td>
			<td>内科</td>
			<td>进修人员</td>
			<td>2015-03-26</td>
			<td>2015-03-30</td>
			<td>1</td>
			<td>及格</td>
			<td>[<a href="javascript:void(0);" onclick="testDetail();">详情</a>]</td>
		</tr>
		<tr>
			<td>内科</td>
			<td>是</td>
			<td>营养学</td>
			<td>已学完</td>
			<td>王伟</td>
			<td>0760</td>
			<td>初级</td>
			<td>中医学</td>
			<td>内科</td>
			<td>实习生</td>
			<td>2015-02-12</td>
			<td>2015-02-25</td>
			<td>1</td>
			<td>及格</td>
			<td>[<a href="javascript:void(0);" onclick="testDetail();">详情</a>]</td>
		</tr>
	</table>
</div>
</div>
</div>
</body>