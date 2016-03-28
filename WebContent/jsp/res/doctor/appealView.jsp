<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	function search(){
		$("#searchForm").submit();
	}
	function viewApp(){
		jboxOpen("<s:url value='/jsp/res/doctor/appealView.jsp'/>","申述查看",600,300);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
				<table class="xllist" >
						<tr>
							<th style="text-align: left;width: 150px;" >&#12288;申述类别<font color="red">*</font></th>
							<th style="text-align: left;" >&#12288;申述对象 <font color="red">*</font></th>
							<th style="text-align: left;" >&#12288;申述数量<font color="red">*</font>(完成情况：<font color="red">0</font>/2) </th>
						</tr>
						<tr>
							<td style="text-align: left;">&#12288;<select style="width: 80%"><option>病种</option><option>操作</option><option>手术</option></select></td>
							<td style="text-align: left;">&#12288;<input type="text"/></td>
							<td style="text-align: left;">&#12288;<input type="text"/></td>
						</tr>
					</table>
					
				<div>
					<p>申述理由<font color="red">*</font></p>
					<p/>
					<textarea style="width: 100%;height:100px; " placeholder="请输入申述理由"></textarea>
					<p style="text-align: center;">
					<input type="button" class="search" value="保&#12288;存"></p>
				</div>
	</div>
</div>
</div>
</body>
</html>