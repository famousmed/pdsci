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

<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.title_td{text-align: right;padding:0;}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		hideDept("${empty qcRecord?(empty qcRemind?'':qcRemind.qcTypeId):qcRecord.qcTypeId}");
		<c:set value="" var="record"/>
		<c:if test="${not empty qcRecord}">
			<c:set value="${qcRecord}" var="record"/>
		</c:if>
		<c:if test="${not empty qcRemind}">
			<c:set value="${qcRemind}" var="record"/>
		</c:if>
		<c:if test="${not empty record}">
			$("#qcTypeId").find("select,font").remove();
			$("#qcCategoryId").find("select,font").remove();
			$("#qcTypeId").append("<font>${record.qcTypeName}</font><input type='hidden' name='qcTypeId' value='${record.qcTypeId}'/>");
			$("#qcCategoryId").append("<font>${record.qcCategoryName}</font><input type='hidden' name='qcCategoryId' value='${record.qcCategoryId}'/>");
		</c:if>
		<c:if test="${empty qcRecord && empty qcRemind}">
			<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO}">
				$("[value='${gcpQcTypeEnumDept.id}']").remove();
				$("[value='${gcpQcCategoryEnumOneThirdGroup.id}']").remove();
			</c:if>
			<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_RESEARCHER}">
				$("#qcTypeId").find("select,font").remove();
				$("[value='${gcpQcCategoryEnumFirstCaseGroup.id}']").remove();
				$("#qcTypeId").append("<font>${gcpQcTypeEnumDept.name}</font><input type='hidden' name='qcTypeId' value='${gcpQcTypeEnumDept.id}'/>");
			</c:if>
		</c:if>
	});
	
	function save() {
		if($("#qcForm").validationEngine("validate")){
			if($("[name='qcTypeId']").val() != "${gcpQcTypeEnumInspection.id}"){
				$("[name='qcDepartment']").val("");
			}else{
				$("[name='qcCategoryId']").val("");
			}
			var url = "<s:url value='/gcp/qc/saveQcRecord'/>";
			var getdata = $('#qcForm').serialize();
			jboxPost(url, getdata, function(data) {
				if('${GlobalConstant.SAVE_FAIL}'!=data){
					var qcTypeId = $("[name='qcTypeId']").val();
					if("${gcpQcTypeEnumInspection.id}"!=qcTypeId && ${empty param.qcFlow}){
						var beforePage = ${empty param.beforePage}?"projInfo":"${param.beforePage}";
						window.parent.frames['mainIframe'].window.location.href = "<s:url value='/gcp/qc/qcDetail'/>?beforePage="+beforePage+"&projFlow=${param.projFlow}&qcFlow="+data+"&roleScope=${param.roleScope}";
					}else{
						window.parent.frames['mainIframe'].window.loadQualityControl();
					}
					jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
					jboxClose();		
				}else{
					jboxTip("${GlobalConstant.SAVE_FAIL}");
				}
			},null,false);
		}
	}
	
	function hideDept(type){
		if(type != "${gcpQcTypeEnumInspection.id}"){
			$("#dept").hide();
			$("#qcCategoryIdTr").show();
		}else{
			$("#dept").show();
			$("#qcCategoryIdTr").hide();
		}
	}
</script>

</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
				<form id="qcForm" style="position: relative;"> 
				<input type="hidden" name="qcFlow" value="${qcRecord.qcFlow}"/>
				<input type="hidden" name="projFlow" value="${param.projFlow}"/>
				<input type="hidden" name="remindRecordFlow" value="${qcRemind.recordFlow}"/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th colspan="6">质控记录</th>
					</tr>
					<tr>
						<td class="title_td">质控类型：</td>
						<td id="qcTypeId">
							<select name="qcTypeId" class="validate[required] xlselect" style="margin-right: 0px" onchange="hideDept(this.value);">
								<option></option>
								<c:forEach items="${gcpQcTypeEnumList}" var="qcTypeEnum">
									<option value="${qcTypeEnum.id}" ${qcRecord.qcTypeId eq qcTypeEnum.id?"selected='selected'":""}>${qcTypeEnum.name}</option>
								</c:forEach>
							</select>
							<font color="red" >*</font>
						</td>
					</tr>
					<tr id="qcCategoryIdTr">
						<td class="title_td">质控节点：</td>
						<td id="qcCategoryId">
							<select name="qcCategoryId" class="validate[required] xlselect" style="margin-right: 0px"">
								<option></option>
								<c:forEach items="${gcpQcCategoryEnumList}" var="qcCategory">
									<option value="${qcCategory.id}" ${qcRecord.qcCategoryId eq qcCategory.id?"selected='selected'":""}>${qcCategory.name}</option>
								</c:forEach>
							</select>
							<font color="red" >*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">检查开始日期：</td>
						<td>
							<input type="text" name="qcStartDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="xltext ctime validate[required]" value="${qcRecord.qcStartDate}" style="margin-right: 0px"/>
							<font color="red" >*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">检查结束日期：</td>
						<td>
							<input type="text" name="qcEndDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="xltext ctime validate[required]" value="${qcRecord.qcEndDate}" style="margin-right: 0px"/>
							<font color="red" >*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">检查人：</td>
						<td >
							<input type="text" name="qcOperator" class="xltext" value="${qcRecord.qcOperator}"/>
						</td>
					</tr>
					<tr id="dept">
						<td class="title_td">检查部门：</td>
						<td >
							<input type="text" name="qcDepartment" class="validate[required] xltext" value="${qcRecord.qcDepartment}" style="margin-right: 0px"/>
							<font color="red" >*</font>
						</td>
					</tr>
					<tr>
						<td class="title_td">检查病历/CRF编码：</td>
						<td>
							<input type="text" name="qcPatientCodes" class="xltext" value="${qcRecord.qcPatientCodes}"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose()"  />
		</div>
</div></div></div>
</body>
</html>