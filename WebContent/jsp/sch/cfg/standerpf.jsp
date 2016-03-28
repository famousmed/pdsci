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

<script type="text/javascript">


</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		 <div class="title1 clearfix">
			<span style="float: right;padding-right: 30px;"><input type="text" class="xltext"/><input class="search" type="button" value="添加"/>
			</span>
		</div>		
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="80px">专业编号</th>
				<th>专业名称</th>
				<th width="100px" >操作</th>
			</tr>
			</thead>
			<tr>
				<td>55</td>
				<td>儿科</td>
				<td>
					<a href="#" style="color: blue">编辑</a>&#12288;|&#12288;<a href="#" style="color: blue">删除</a>
				</td>
			</tr>
			<tr>
				<td>60</td>
				<td>耳鼻咽喉科</td>
				<td>
					<a href="#" style="color: blue">编辑</a>&#12288;|&#12288;<a href="#" style="color: blue">删除</a>
				</td>
			</tr>
			<tr>
				<td>54</td>
				<td>妇产科</td>
				<td>
					<a href="#" style="color: blue">编辑</a>&#12288;|&#12288; <a href="#" style="color: blue">删除</a>
				</td>
			</tr>
			<tr>
				<td>56</td>
				<td>急诊科</td>
				<td>
					<a href="#" style="color: blue">编辑</a>&#12288;|&#12288;<a href="#" style="color: blue">删除</a>
				</td>
			</tr>
		</table>
	</div> 
</div>
</body>
</html>