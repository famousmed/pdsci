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
				<font>科室：儿科</font>
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 100px;">医师姓名</th>
							<th style="text-align: center;">8月</th>
							<th style="text-align: center;">9月</th>
							<th style="text-align: center;">10月</th>
							<th style="text-align: center;">11月</th>
							<th style="text-align: center;">12月</th>
							<th style="text-align: center;">1月</th>
							<th style="text-align: center;">2月</th>
							<th style="text-align: center;">3月</th>
							<th style="text-align: center;">4月</th>
							<th style="text-align: center;">5月</th>
							<th style="text-align: center;">6月</th>
							<th style="text-align: center;">7月</th>
						</tr>
						<tr>
							<td >陆庆</td>
							<td colspan="2">儿科</td>
							<td>角膜组</td>
							<td >白内障组</td>
							<td >青光眼组</td>
							<td colspan="3">葡萄膜炎组</td>
							<td colspan="4">眼底病组及神经眼科组</td>
						</tr>
						<tr>
							<td >徐雯*</td>
							<td colspan="2">脱产理论</td>
							<td colspan="3">儿科</td>
							<td colspan="4">社区卫生服务中心</td>
							<td colspan="2">妇产科</td>
							<td colspan="2">普外（卢中心）</td>
						</tr>
						<tr>
							<td >孙昆*</td>
							<td colspan="1">儿科急诊</td>
							<td colspan="2">儿科门诊 </td>
							<td colspan="1">心电图</td>
							<td colspan="1">放射科</td>
							<td colspan="2">儿科内分泌  </td>
							<td colspan="1">儿科心血管 </td>
							<td colspan="2">儿科重症医学 </td>
							<td colspan="1">儿科肾脏 </td>
							<td colspan="1">儿科神经 </td>
						</tr>
					</table>
			</div>
	</div>
</div>
</div>
</body>
</html>