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
	function sae(){
		jboxOpen("<s:url value='/jsp/gcp/patient/sae_yw_1.0.jsp'/>","严重不良事件报告",800,500);
	}
</script>
</head>
	<body>
		<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<div>
				当前研究项目：西尼必利片 &#12288;&#12288;不良事件数：<font style="color: red">4</font>
			</div>
			<div class="title1">
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="10%">受试者编号</th>
					<th width="10%">受试者姓名缩写</th>
					<th width="10%">SAE名称</th>
					<th width="10%">因果关系</th>
					<th width="20%">报告类型</th>
					<th width="10%">报告日期</th>
					<th width="10%">是否提交伦理</th>
					<th width="10%">明细</th>
				</tr>
				</thead>
				<tbody>
						<tr>
							<td>1</td>
							<td>YXG</td>
							<td>COPD急性加重</td>
							<td>肯定无关</td>
							<td>■首次 □跟踪 □总结</td>
							<td>2010-10-13</td>
							<td>已提交</td>
							<td>[<a href="javascript:sae();">明细</a>]</td>
						</tr>
						<tr>
							<td>1-1</td>
							<td>YXG</td>
							<td>COPD急性加重</td>
							<td>肯定无关</td>
							<td>□首次 ■跟踪 ■总结</td>
							<td>2010-11-08</td>
							<td>已提交</td>
							<td>[<a href="javascript:sae();">明细</a>]</td>
						</tr>
						<tr>
							<td>2</td>
							<td>HYD</td>
							<td>COPD急性加重</td>
							<td>肯定无关</td>
							<td>■首次 □跟踪 □总结</td>
							<td>2010-12-14 </td>
							<td>已提交</td>
							<td>[<a href="javascript:sae();">明细</a>]</td>
						</tr>
						<tr>
							<td>2-1</td>
							<td>HYD</td>
							<td>COPD急性加重</td>
							<td>肯定无关</td>
							<td>□首次 ■跟踪 ■总结</td>
							<td>2010-12-30 </td>
							<td>已提交</td>
							<td>[<a href="javascript:sae();">明细</a>]</td>
						</tr>
				</tbody>
			</table></div>
		</div></div></div>
</body>
</html>