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
	
	function send(){
		if($(".drugFlow:checked").length <= 0){
			jboxTip("请选择药物!");
			return;
		}
		if ($("#recipeForm").validationEngine("validate")) {
			jboxConfirm("确认保存该处方？",function(){
				var url = "<s:url value='/gcp/researcher/saveRecipe'/>";
				var getdata = "patientFlow=${patient.patientFlow}&visitFlow=${param.visitFlow}";
				$(".drugFlow:checked").each(function(){
					var key = $(this).val();
					getdata += ("&drugFlows="+key);
				});
				jboxPost(url, getdata, function(data) {
					window.parent.frames['mainIframe'].location.reload(true);
					jboxClose();
				},null,true);
			},null);
		}
	}
	
</script>
</head>
	<body>
			<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
		<div style="margin-top: 5px;">
			<form id="recipeForm">
			<input type="hidden" name="patientFlow" value="${patient.patientFlow}"/>
			<table class="xllist">
				<tbody>
					<tr>
						<th colspan="10" style="text-align: left;">
							&#12288;受试者信息
						</th>
					</tr>
					<tr>
						<td style="text-align: left;">
							&#12288;&#12288;受试者编号：${patient.patientCode} 
							&#12288;姓名缩写：${patient.patientNamePy}
						</td>
					</tr>
					<tr>
						<th colspan="10" style="text-align: left;">
							&#12288;药物信息
						</th>
					</tr>
					<c:forEach items="${drugList}" var="drug">
						<tr>
							<td style="text-align: left;">
								&#12288;&#12288;
								<label>
									<input type="checkbox" class="drugFlow" value="${drug.drugFlow}" ${gcpDrugTypeEnumExamDrug.id eq drug.drugTypeId?"checked='true'":""} />
									&nbsp;${drug.drugName}
								</label>
								（${drug.spec}）
							</td>
						</tr>
						<tr>
						<td style="text-align: left;padding-left: 50px;">用法：${drug.recipeUsage}</td>
						</tr>
					</c:forEach>
					<tr>
						<td style="text-align: right;padding-right: 20px;">
							<b>处方医生：</b>${sessionScope.currUser.userName}&#12288;&#12288;<b>处方时间：</b>${pdfn:getCurrDateTime('yyyy-MM-dd HH:mm:ss')}
						</td>
					</tr>
				</tbody>
			</table>
			</form>
		</div>
			<div style="text-align: center;margin-top: 10px;">
			<input type="button" class="search" value="保&#12288;存" onclick="send();"/>
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();"/></div>
		</div></div></div>
</body>
</html>