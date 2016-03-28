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
	function editFundIn(){
		jboxOpen("<s:url value='/irb/office/editFund'/>","盖章登记", 600,300);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm"
				method="post">
				<p>
					项目名称：<input type="text" style="width: 300px"/> &#12288;项目编号：<input type="text" style="width: 150px"/> 
					经费日期：<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> ~ <input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> 
					<input type="button" value="查询" class="search"/><input type="button" value="新增" class="search" onclick="editFundIn();"/>
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="100" >日期</th>
					<th width="300px" >项目名称</th>
					<th width="100" >期类别</th>
					<th width="200px" >项目来源</th>
					<th width="80" >金额</th>
					<th width="80" >操作</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<td>2014--05-10</td>
						<td>喉返神经损伤、再支配机制的实验研究</td>
						<td>临床科研</td>
						<td>公益性行业专项</td>
						<td>50000</td>
						<td>[<a href="#">编辑</a>]&#12288;[<a href="#">删除</a>]</td>
					</tr>
					<tr>
						<td>2014-03-10</td>
						<td>硫化氢对腹膜透析腹膜纤维化的干预作用及机制研究</td>
						<td>药物试验-II期</td>
						<td>成都中医药，太极集团</td>
						<td>50000</td>
						<td>[<a href="#">编辑</a>]&#12288;[<a href="#">删除</a>]</td>
					</tr>
			</tbody>
		</table>
		<p style="float: right;color: red">合计：100000</p>
	</div>
</div>
</body>
</html>