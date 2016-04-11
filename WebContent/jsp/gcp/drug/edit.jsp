<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
</jsp:include>
<style type="text/css">
	.basic tbody th{text-align: left;padding-left: 10px;}
	.basic td.title_td{text-align: right;padding:0;}
</style>
<script type="text/javascript">
	 function save(){
		var form = $("#saveForm");
		if(form.validationEngine("validate")){
			var url = "<s:url value='/gcp/drug/saveDrugInfo'/>";
			jboxSubmit(form,url,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.search();
					jboxClose();
				}
			},function(){
				jboxTip('${GlobalConstant.SAVE_FAIL}');
			},true);
		}
	} 
	function doClose(){
		jboxClose();
	}
	$(document).ready(function(){
		$("#projFlow").scombobox({
			forbidInvalid : true,
			invalidAsValue : true,
			expandOnFocus : false
		});
		$(".scombobox-display").css("height","25px");
		$(".scombobox-display").css("border","1px solid #bdbebe");
		$(".scombobox-display").css("width","81.5%");
	});
	function changeSpec(){
		var doseVal=$("#dose").val();
		var doseUnitVal=$("#doseUnitId").val();
		var doseUnitText=$("#doseUnitId").find("option:selected").text();
		var preparationUnitVal=$("#preparationUnitId").val();
		var preparationUnitText=$("#preparationUnitId").find("option:selected").text();
		if(doseVal!="" && doseUnitVal!="" && preparationUnitVal!=""){
			$("#spec").val(doseVal+doseUnitText+"/"+preparationUnitText);
		}
		
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
			<div class="title1 clearfix">
				<form id="saveForm"  method="post" style="position: relative;"> 
				<input type="hidden" name="drugFlow" value='${drug.drugFlow}'/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<tr>
					   <th colspan="4">药物基本信息</th>
					</tr>
					<tr>
					   <td style="text-align: right">药物名称：</td>
					   <td>
					      <input type="text" name="drugName" value="${drug.drugName }" class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					   <td style="text-align: right">药物类别：</td>
					   <td>
					     <select name="drugTypeId" class="xlselect validate[required]" style="margin-right: 17px;">
		                   <option value="">请选择</option>
		                   <c:forEach items="${gcpDrugTypeEnumList }" var="drugType">
		                     <option value="${drugType.id }" <c:if test="${drugType.id eq drug.drugTypeId }">selected="selected"</c:if>>${drugType.name }</option>
		                   </c:forEach>
		                 </select>
		                 <span class="red">*</span>
					   </td>
					</tr>
					<tr>
					   <td style="text-align: right">剂量：</td>
					   <td>
					      <input type="text" id="dose" name="dose" onchange="changeSpec()" value="${drug.dose }" class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					   <td style="text-align: right">剂量单位：</td>
					   <td>
					      <select name="doseUnitId" id="doseUnitId" onchange="changeSpec()" class="xlselect validate[required]" style="margin-right: 17px;">
		                   <option value="">请选择</option>
		                   <c:forEach items="${dictTypeEnumDoseUnitList }" var="dict">
		                     <option value="${dict.dictId }" <c:if test="${dict.dictId eq drug.doseUnitId }">selected="selected"</c:if>>${dict.dictName }</option>
		                   </c:forEach>
		                 </select>
		                 <span class="red">*</span>
					   </td>
					</tr>
					 <tr>
					   <td style="text-align: right">制剂单位：</td>
					   <td>
					      <select id="preparationUnitId" name="preparationUnitId" onchange="changeSpec()" class="xlselect validate[required]" style="margin-right: 17px;">
		                   <option value="">请选择</option>
		                   <c:forEach items="${dictTypeEnumPreparationUnitList }" var="dict">
		                     <option value="${dict.dictId }" <c:if test="${dict.dictId eq drug.preparationUnitId }">selected="selected"</c:if>>${dict.dictName }</option>
		                   </c:forEach>
		                 </select>
		                 <span class="red">*</span>
					   </td>
					   <td style="text-align: right">规格：</td>
					   <td>
					      <input type="text" name="spec" id="spec" value="${drug.spec }" class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">给药途径：</td>
					   <td>
					      <select name="usageId" class="xlselect" style="margin-right: 17px;">
		                   <option value="">请选择</option>
		                   <c:forEach items="${dictTypeEnumUsageList }" var="dict">
		                     <option value="${dict.dictId }" <c:if test="${dict.dictId eq drug.usageId }">selected="selected"</c:if>>${dict.dictName }</option>
		                   </c:forEach>
		                 </select>
					   </td>
					   <td style="text-align: right">溶液：</td>
					   <td>
					      <select name="solutionId" class="xlselect" style="margin-right: 17px;">
		                   <option value="">请选择</option>
		                   <c:forEach items="${dictTypeEnumSolutionList }" var="dict">
		                     <option value="${dict.dictId }" <c:if test="${dict.dictId eq drug.solutionId }">selected="selected"</c:if>>${dict.dictName }</option>
		                   </c:forEach>
		                 </select>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">最小包装单位：</td>
					   <td>
					       <select name="minPackUnitId" class="xlselect validate[required]" style="margin-right: 17px;">
		                   <option value="">请选择</option>
		                   <c:forEach items="${dictTypeEnumMiniPackUnitList }" var="dict">
		                     <option value="${dict.dictId }" <c:if test="${dict.dictId eq drug.minPackUnitId }">selected="selected"</c:if>>${dict.dictName }</option>
		                   </c:forEach>
		                 </select>
		                 <span class="red">*</span>
					   </td>
					   <td style="text-align: right">最小包装量：</td>
					   <td>
					      <input type="text" name="minPackAmount" value="${drug.minPackAmount }" class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">每个编码包装量：</td>
					   <td>
					      <input type="text" name="singlePackAmount" value="${drug.singlePackAmount }"class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					   <td style="text-align: right">规定总用量：</td>
					   <td>
					      <input type="text" name="provisionAmount" value="${drug.provisionAmount }"class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">储存条件：</td>
					   <td colspan="3">
					      <input type="text" name="storageCondition" value="${drug.storageCondition }"class="xltext" style="width:80%;"/>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">生产厂家：</td>
					   <td colspan="3">
					      <input type="text" name="manufacturer" value="${drug.manufacturer }"class="xltext" style="width:80%;"/>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">项目名称：</td>
					   <td colspan="3">
					     <c:choose>
					     <c:when test="${!empty currProj.projFlow or !empty drug.projFlow}">
					         ${currProj.projName }
					         <input type="hidden" name="projFlow" value='${currProj.projFlow}'/>
					     </c:when>
					     <c:otherwise>
					         <select id="projFlow" name="projFlow" class="xlselect">
		                   <option value="">请选择</option>
		                   <c:forEach items="${projList }" var="proj">
		                     <option value="${proj.projFlow }" <c:if test="${proj.projFlow eq drug.projFlow }">selected="selected"</c:if>>${proj.projName }</option>
		                   </c:forEach>
		                 </select>
					     </c:otherwise>
					   </c:choose>
					   </td>
					 </tr>
					 <tr>
					   <th colspan="4">处方用法</th>
					 </tr>
					 <tr>
					   <td style="text-align: right">处方用法：</td>
					   <td colspan="3">
					      <textarea name="recipeUsage"  style="width:81.5%;height: 100px;">${drug.recipeUsage }</textarea>
					   </td>
					 </tr>
				</table>
			</form>
			
		</div>
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="doClose()"  />
		</div>
</div></div>
</body>
</html>