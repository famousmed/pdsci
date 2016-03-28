<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<script type="text/javascript">
   
   function search(){
	   $("#dept").toggle();
	   $("#doc").toggle();
	   if($("#doc").is(":visible")){
		   $("#docName").val("周国宝");
	   }else {
		   $("#docName").val("");
	   }
   }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				<font>科室：角膜组</font>
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
			<fieldset>
				<legend>已选本科医师</legend>
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 100px;">医师姓名</th>
							<th style="text-align: center;">性别</th>
							<th style="text-align: center;">届数</th>
							<th style="text-align: center;">培训专业</th>
							<th style="text-align: center;">毕业院校</th>
							<th style="text-align: center;">操作</th>
						</tr>
						<tr>
							<td >陆庆</td>
							<td>男</td>
							<td>2008</td>
							<td >眼科</td>
							<td >爱丁堡大学</td>
							<td ><a href="#" style="color: blue">取消</a></td>
						</tr>
						<tr>
							<td >徐雯*</td>
							<td>男</td>
							<td>2008</td>
							<td >眼科</td>
							<td >爱丁堡大学</td>
							<td ><a href="#" style="color: blue">取消</a></td>
						</tr>
						<tr>
							<td >孙昆*</td>
							<td >男</td>
							<td>2008</td>
							<td >眼科</td>
							<td>爱丁堡大学</td>
							<td ><a href="#" style="color: blue">取消</a></td>
						</tr>
					</table>
					</fieldset>
			</div>
	</div>
</div>
</div>
</body>
</html>