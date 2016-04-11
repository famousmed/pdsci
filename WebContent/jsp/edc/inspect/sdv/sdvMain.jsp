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
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
</head>
<script type="text/javascript">
function doBack(){
	window.location.href="<s:url value='/edc/inspect/sdv?orgFlow=${patient.orgFlow}&groupFlow=${param.groupFlow}'/>";
}
function doSdv(recordFlow,emptyDataKey,key,dataItem){
	jboxGet("<s:url value='/edc/inspect/confirmQuerySend'/>?recordFlow="+recordFlow,null,function(resp){
		if(resp == '${GlobalConstant.OPRE_SUCCESSED}' ){
			jboxConfirm("确认发出 <b>"+dataItem+"</b> 电子数据与源数据不一致（SDV） 的疑问吗?",function(){
				jboxGet("<s:url value='/edc/inspect/sdvQuery'/>?recordFlow="+recordFlow+"&orgFlow=${patient.orgFlow}&emptyDataKey="+emptyDataKey,null,null,null,true);
				$('#'+key).attr("bgcolor","pink");
			});
		}else {
			jboxTip("该数据存在未解决的疑问，无法重复发送!");
		}
	},null,false);
	
}
function doSdvSubmit(recordFlow){
	jboxConfirm("确认审核完成?",function(){
		jboxGet("<s:url value='/edc/inspect/doSdvSubmit'/>?recordFlow="+recordFlow,null,function(){
			$("#submitBtn").hide();
		},null,true);
	});
}
$(document).ready(function(){
	init();
	$('#inputForm').validationEngine('validate');
});
function init(){
	$(".sdvDiv").hover(function() {
		$(this).find("div").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
	},function(){
		$(this).find("div").stop().animate({left: "0", opacity: 0}, "slow");
	});
}
</script>
<body>


<form id="headForm">
<div class="title1 clearfix"> 
     	&#12288;<b>访视名称：</b>${visit.visitName }&#12288;
     	<b>受试者编号：</b>${patient.patientCode }（${patient.patientNamePy }）&#12288;
     	 <c:if test="${visit.isVisit eq  GlobalConstant.FLAG_Y}">
     	<font color="red">*</font><b>本次访视日期：</b>${patientVisitForm.patientVisit.visitDate }	
     	</c:if>
     			<!--  <input type="button" value="refresh" class="search" onclick="window.location.reload(true);" />  -->
     			<c:if test="${edcSdvStatusEnumSdved.id != patientVisitForm.edcPatientVisit.sdvOperStatusId }">
     			<input type="button" value="审&#12288;核" id="submitBtn" class="search" onclick="doSdvSubmit('${patientVisitForm.patientVisit.recordFlow}');"  />
     			</c:if>
     			<input type="button" value="返&#12288;回"  class="search" onclick="doBack();"  />
     			<img src='<s:url value="/css/skin/${skinPath}/images/tip.png" />'/><font color="red">鼠标移动发送SDV疑问，红色背景为已发过SDV项</font>
     			
     <hr />
</div>
</form>
<div class="main_fix">
		<div id="main">
<form id="inputForm" style="height: 100%">
<div>
 <c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
 <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
 <c:set var="commCode" value="${visit.visitFlow }_${moduleCode }"></c:set>
 <fieldset>
 	<legend>${visitModule.moduleName}</legend>
 		<table class="basic" width="100%" >
	 		<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<!-- 设置moduleCode -->
	 		<c:if test="${!empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitElement.moduleCode }"></c:set>
	 		</c:if>
	 		<c:if test="${empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
	 		</c:if>
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}"></c:set>
	 		<c:set var="columnCount" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].columnCount }"/>
	 		<c:set var="showEleName" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].isViewName!=GlobalConstant.FLAG_N}"/>
	 		<c:set var="fixWidth" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].fixedWidth }"/>
	 		<c:if test="${empty sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId || moduleStyleEnumSingle.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr>
	 				<c:if test="${showEleName}">
	 				<th width="15%">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
	 				</th>
	 				</c:if>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="sdv_single.jsp" flush="true">
		 						<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 							<jsp:param name="fixWidth" value="${fixWidth}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.elementAttrMap[visitElement.elementCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
	 				<td>
	 					<jsp:include page="sdv_serial.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
	 				</td>
	 				</c:when>
	 				<c:otherwise>
	 					<td>
	 					<jsp:include page="sdv_serial_vertical.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
	 				</td>
	 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
	 		</c:if>
	 		<c:if test="${moduleStyleEnumDouble.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
	 				</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 				<jsp:include page="sdv_single.jsp" flush="true">
		 						<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.elementAttrMap[visitElement.elementCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
	 				<td>
	 					<jsp:include page="sdv_serial.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
	 				</td>
	 				</c:when>
	 				<c:otherwise>
	 					<td>
	 					<jsp:include page="sdv_serial_vertical.jsp" flush="true"> 
	 							<jsp:param name="patientFlow" value="${patient.patientFlow }" /> 
	 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
	 							<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount }" />
	 					</jsp:include>
	 				</td>
	 				</c:otherwise>
	 				</c:choose>
	 			</c:if>
	 			</tr>
	 		</c:if>
	 		</c:forEach>
 		</table></fieldset>
 </c:forEach>
</div></form>
</div></div>
</body>
</html>