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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		dataCount();
		selPatientStage($(".selOne:checked").val());
		var listWidth = document.body.clientWidth - 30;
		var listHeight = document.body.clientHeight - 68;
		$("#listDiv").css({
			width:listWidth,
			height:listHeight,
			overflow:"auto"
		});
	});
	
	function dataCount(){
		if($(".data").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
</script>
</head>
	<body>
		<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div>
				当前研究项目：西尼必利片 &#12288;&#12288;
				<input type="checkbox" id="in"/><label for="in">提前三天</label>
			</div>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="10%">受试者编号</th>
					<th width="10%">受试者姓名缩写</th>
					<th width="10%">受试者随机号</th>
					<th width="10%">药物编号</th>
					<th width="10%">入组日期</th>
					<th width="10%">入组医生</th>
					<th width="10%">上次随访日期</th>
					<th width="10%">距下次随访天数</th>
					<th width="10%">手机号</th>
					<th width="10%">是否通知</th>
				</tr>
				</thead>
				<tbody>
						<tr>
							<td>1</td>
							<td>JZXI</td>
							<td>001</td>
							<td>01</td>
							<td>2014-07-10</td>
							<td>王军</td>
							<td>2014-07-10</td>
							<td>5</td>
							<td>15229872123</td>
							<td></td>
						</tr>
						<tr>
							<td>2</td>
							<td>TPY</td>
							<td>002</td>
							<td>02</td>
							<td>2014-07-10</td>
							<td>王军</td>
							<td>入组</td>
							<td>10</td>
							<td>15229872123</td>
							<td></td>
						</tr>
						<tr>
							<td>3</td>
							<td>LZY</td>
							<td>003</td>
							<td>03</td>
							<td>2014-07-14</td>
							<td>王军</td>
							<td>入组</td>
							<td style="color: red">3</td>
							<td>15229872123</td>
							<td><img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/></td>
						</tr>
						<tr>
							<td>7</td>
							<td>WZZH</td>
							<td>007</td>
							<td>07</td>
							<td>2014-08-24</td>
							<td>王军</td>
							<td>入组</td>
							<td>5</td>
							<td>15229872123</td>
							<td></td>
						</tr>
						<tr>
							<td>9</td>
							<td>ZLSO</td>
							<td>009</td>
							<td>09</td>
							<td>2014-09-11</td>
							<td>王军</td>
							<td>入组</td>
							<td>5</td>
							<td>15229872123</td>
							<td></td>
						</tr>
				</tbody>
			</table></div>
		</div></div></div>
</body>
</html>