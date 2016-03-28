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
	$(document).ready(function(){
		$(".pp").css({color:"blue"});
		$(".pp").bind("click",rule);
	});
	
	function rule(){
		jboxOpen("<s:url value='/jsp/sch/doc/seldept_detail.jsp'/>","排班人员",800,500);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div>
				方案：<select class="xlselect" style="width: 200px">
						<option></option>
						<option>两年期住院医师轮转方案(外科)</option>
						<option>一年期住院医师轮转方案2011(外科)</option>
					</select>
				届数：<select class="xlselect" >
						<option>2012</option>
						<option>2013</option>
						<option>2014</option>
					</select>
				医师姓名：<input type="text" class="xltext"/>
				<input type="button" class="search" value="查&#12288;询"/>
			</div>
			<div id="dept" style="width:100%; margin-top: 10px;margin-bottom: 10px;">
			<fieldset>
				<legend>两年期住院医师轮转方案(外科)
				</legend>
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 100px;" rowspan="2">医师姓名</th>
							<th style="text-align: center;width: 100px;" rowspan="2">届数</th>
							<th style="text-align: center;" colspan="4" >外科四选一</th>
							<th style="text-align: center;" colspan="2">二选一</th>
						</tr>
						<tr>
							<th width="100px;">泌尿外科(<a href="#" class="pp">22</a>)</th>
							<th width="100px;">普胸外科(<a href="#" class="pp">12</a>)</th>
							<th width="100px;">神经外科(<a href="#" class="pp">13</a>)</th>
							<th width="100px;">心脏外科(<a href="#" class="pp">17</a>)</th>
							<th width="100px;">放射科(<a href="#" class="pp">6</a>)</th>
							<th width="100px;">超声科(<a href="#" class="pp">8</a>)</th>
						</tr>
						<tr>
							<td >蔡正昊</td>
							<td>2012</td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td  ></td>
							<td ></td>
							<td></td>
							<td  ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td ></td>
						</tr>
						<tr>
							<td >陈利红</td>
							<td>2012</td>
							<td></td>
							<td  ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td ></td>
							<td></td>
							<td  ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td ></td>
						</tr>
						<tr>
							<td >戴韵馨</td>
							<td>2012</td>
							<td></td>
							<td  ></td>
							<td ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td></td>
							<td  ></td>
							<td ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
						</tr>
						<tr>
							<td >黄燕华</td>
							<td>2012</td>
							<td></td>
							<td  ></td>
							<td ></td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td  ></td>
							<td ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
						</tr>
					</table>
			</fieldset>
				<fieldset>
				<legend>一年期住院医师轮转方案2011(外科)
				</legend>
				<table width="100%" class="xllist" style="font-size: 14px">
						<tr>
							<th style="text-align: center;width: 100px;" rowspan="2">医师姓名</th>
							<th style="text-align: center;width: 100px;" rowspan="2">届数</th>
							<th style="text-align: center;" colspan="6" >外科六选二</th>
						</tr>
						<tr>
							<th width="100px;">泌尿外科(<a href="#" class="pp">22</a>)</th>
							<th width="100px;">普胸外科(<a href="#" class="pp">12</a>)</th>
							<th width="100px;">神经外科(<a href="#" class="pp">13</a>)</th>
							<th width="100px;">心脏外科(<a href="#" class="pp">17</a>)</th>
							<th width="100px;">骨科(<a href="#" class="pp">17</a>)</th>
							<th width="100px;">麻醉科(<a href="#" class="pp">17</a>)</th>
						</tr>
						<tr>
							<td >黄燕华</td>
							<td>2012</td>
							<td></td>
							<td  ></td>
							<td ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td></td>
							<td  ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td ></td>
						</tr>
						<tr>
							<td >华子辰</td>
							<td>2012</td>
							<td></td>
							<td  ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td ></td>
							<td></td>
							<td  ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td ></td>
						</tr>
						<tr>
							<td >蒋毅弘</td>
							<td>2012</td>
							<td></td>
							<td  ></td>
							<td ></td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td  ></td>
							<td ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
						</tr>
						<tr>
							<td >李晟</td>
							<td>2012</td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td  ></td>
							<td ><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
							<td></td>
							<td  ></td>
							<td ></td>
						</tr>
					</table>
			</fieldset>
			<fieldset>
				<legend>自动排班</legend>
				<table>
					<tr><td>
					本届排班总人数：<font color="red">200</font> &#12288;其中已选科人数：<font color="red">180</font> &#12288;
					未选科人数：<font color="red">20</font> &#12288;您必须先确定所有选科才可以进行排班操作,未选科人员可通过随机选科操作后排班!
					 <input type="button" value="随机选科" class="search">&#12288;<input type="button" value="排&#12288;班" class="search">
					</td></tr>
				</table>
			</fieldset>
			</div>
	</div>
</div>
</div>
</body>
</html>