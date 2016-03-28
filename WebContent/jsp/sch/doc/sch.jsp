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
				科室：<select style="width: 200px;"  class="xlselect">
						<option></option>
						<option>内科科室</option>
						<option>外科科室</option>
				</select>
				&#12288;
				医师姓名：<input type="text" id="docName" class="xltext" style="width: 100px;"/>
				&#12288;<input type="button" class="search" value="查询" onclick="search();"/> &#12288;<input type="button" class="search" value="导出Excel"/>
				&#12288;&#12288;&#12288;标注*号表示未取得执业医师证书
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr><th colspan="20">2014年住院医师规范化培训轮转计划(2014.08-2015.07)</th></tr>
						<tr>
							<th style="text-align: center;width: 100px;" >科系</th>
							<th style="text-align: center;width: 100px;">科室</th>
							<th style="text-align: center;">届数</th>
							<th style="text-align: center;">2014.08</th>
							<th style="text-align: center;">2014.09</th>
							<th style="text-align: center;">2014.10</th>
							<th style="text-align: center;">2014.11</th>
							<th style="text-align: center;">2014.12</th>
							<th style="text-align: center;">2015.01</th>
							<th style="text-align: center;">2015.02</th>
							<th style="text-align: center;">2015.03</th>
						</tr>
						<tr>
							<td rowspan="8">内科科室</td>
							<td rowspan="4">消化内科</td>
							<td rowspan="2">2013</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							
							<td></td>
							<td></td>
							<td>马前军*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td >钱喆</td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td >张俊</td>
							
							<td></td>
							<td></td>
							<td>何巧平*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td rowspan="2">2014</td>
							<td ></td>
							<td >陈亚东</td>
							<td ></td>
							<td >张俊</td>
							<td>马前军*</td>
							<td>周国宝</td>
							<td>陈琳*</td>
							<td>钱喆</td>
						</tr>
						<tr>
							<td ></td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td ></td>
							<td></td>
							<td>张俊</td>
							<td>何巧平*</td>
							<td></td>
						</tr>
						<!--  -->
						<tr>
							<td rowspan="4">肿瘤科</td>
							<td rowspan="2">2013</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							
							<td></td>
							<td></td>
							<td>马前军*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td >钱喆</td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td >张俊</td>
							
							<td></td>
							<td></td>
							<td>何巧平*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td rowspan="2">2014</td>
							<td ></td>
							<td >陈亚东</td>
							<td ></td>
							<td >张俊</td>
							<td>马前军*</td>
							<td>周国宝</td>
							<td>陈琳*</td>
							<td>钱喆</td>
						</tr>
						<tr>
							<td ></td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td ></td>
							<td></td>
							<td>张俊</td>
							<td>何巧平*</td>
							<td></td>
						</tr>
						<tr>
							<td rowspan="8">外科科室</td>
							<td rowspan="4">普外门诊</td>
							<td rowspan="2">2013</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							
							<td></td>
							<td></td>
							<td>马前军*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td >钱喆</td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td >张俊</td>
							
							<td></td>
							<td></td>
							<td>何巧平*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td rowspan="2">2014</td>
							<td ></td>
							<td >陈亚东</td>
							<td ></td>
							<td >张俊</td>
							<td>马前军*</td>
							<td>周国宝</td>
							<td>陈琳*</td>
							<td>钱喆</td>
						</tr>
						<tr>
							<td ></td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td ></td>
							<td></td>
							<td>张俊</td>
							<td>何巧平*</td>
							<td></td>
						</tr>
						<!--  -->
						<tr>
							<td rowspan="4">骨科</td>
							<td rowspan="2">2013</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							<td >周国宝</td>
							
							<td></td>
							<td></td>
							<td>马前军*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td >钱喆</td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td >张俊</td>
							
							<td></td>
							<td></td>
							<td>何巧平*</td>
							<td>马前军*</td>
						</tr>
						<tr>
							<td rowspan="2">2014</td>
							<td ></td>
							<td >陈亚东</td>
							<td ></td>
							<td >张俊</td>
							<td>马前军*</td>
							<td>周国宝</td>
							<td>陈琳*</td>
							<td>钱喆</td>
						</tr>
						<tr>
							<td ></td>
							<td >陈亚东</td>
							<td >周国宝</td>
							<td ></td>
							<td></td>
							<td>张俊</td>
							<td>何巧平*</td>
							<td></td>
						</tr>
					</table>
			</div>
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;display: none;" id="doc" >
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 100px;" >姓名</th>
							<th style="text-align: center;width: 100px;" >时间</th>
							<th style="text-align: center;" colspan="12">轮转科室及轮转日期（<font color="red">红色为当前轮转科室</font>）</th>
						</tr>
						<tr>
						<td rowspan="2">周国宝*</td>
						<td rowspan="2">3年</td>
						<td>14.01-14.03</td>
						<td>14.04-14.06</td>
						<td style="color: red">14.07-14.09</td>
						<td >14.10-14.12</td>
						<td>15.01-15.03</td>
						<td>15.04-15.06</td>
						<td>15.07-15.09</td>
						<td>15.10-15.12</td>
						<td>16.01-16.03</td>
						<td>16.04-16.06</td>
						<td>16.07-16.09</td>
						<td>16.10-16.12</td>
						</tr>
						<tr>
							<td>骨内科</td>
							<td>感染科</td>
							<td style="color: red">SICU</td>
							<td>神内科</td>
							<td>急诊科</td>
							<td>放射科</td>
							<td>心内科</td>
							<td>呼吸科</td>
							<td>消化科</td>
							<td>血液科</td>
							<td>内分泌科</td>
							<td>自选科</td>
						</tr>
					</table>
		</div>
	</div>
</div>
</div>
</body>
</html>