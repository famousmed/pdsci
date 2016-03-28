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
	function doDispensDrug(){
		jboxConfirm("确认发药？",function(){
			var url = "<s:url value='/gcp/drug/dispensDrug'/>?recipeFlow=${recipe.recipeFlow}&drugPack="+$("#drugPack").val();
			jboxPost(url, null, function(resp) {
				if ('发药成功' == resp) {
					jboxTip(resp);
					window.parent.frames['mainIframe'].window.location.reload();
					jboxClose();
				}else if('${GlobalConstant.OPRE_FAIL}' == resp){
					jboxTip(resp);
				}else{
					jboxInfo(resp);
				}
			},null,false);
		},null);		
	}
	
</script>
</head>
	<body>
			<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
		<div style="margin-top: 5px;">
			<table class="xllist">
				<tbody>
					<tr>
						<th colspan="10" style="text-align: left;">
							&#12288;受试者信息
						</th>
					</tr>
					<tr>
						<td style="text-align: left;">
							&#12288;&#12288;受试者编号：${recipe.patientCode} 
							&#12288;姓名缩写：${recipe.patientNamePy}
						</td>
					</tr>
					<tr>
						<th colspan="10" style="text-align: left;">
							&#12288;处方信息
							&#12288;&#12288;&#12288;
							<font style="font-weight: normal;">药物编码：</font><input type="text" id="drugPack" class="validate[required,custom[number]]" value="${defaultPack}" style="width: 80px;"/>
							&nbsp;
							<font color="red">*</font>
						</th>
					</tr>
					<c:forEach items="${recipeDrugList}" var="recipeDrug">
						<tr>
							<td style="text-align: left;">
								&#12288;&#12288;${recipeDrug.drugName}（${drugMap[recipeDrug.drugFlow].spec}）
							</td>
						</tr>
						<tr>
							<td style="text-align: left;padding-left: 40px;">用法：${drugMap[recipeDrug.drugFlow].recipeUsage}</td>
						</tr>
					</c:forEach>
					<tr>
						<td style="text-align: right;padding-right: 20px;">
							<b>处方医生：</b>${recipe.recipeDoctorName}&#12288;&#12288;<b>处方时间：</b>${pdfn:transDateTime(recipe.recipeDate)}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
			<div style="text-align: center;margin-top: 20px;">
			<input type="button" class="search" value="发&#12288;药" onclick="doDispensDrug();"/>
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();"/></div>
		</div></div></div>
</body>
</html>