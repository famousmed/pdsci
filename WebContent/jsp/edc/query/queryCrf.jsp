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
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_jcallout" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<style type="text/css">
.selected {
background-color:pink;
}
</style>
<script type="text/javascript">

function doSave(visitFlow,isSerialSeq,attrCode,obj){
	if (validateFlag(obj)) {
		var attrValue = "";
		//多了一次parent() ,span 方便显示疑问
		var elementSerialSeq = ( isSerialSeq=="${GlobalConstant.FLAG_N}" ?"1" : ($(obj).closest("tr[id='serialSeqTr']").find("input[name='elementSerialSeq']").val())); 
		if($(obj).attr("type") == "checkbox" ){
			$("[name='"+visitFlow+"_"+attrCode+"_"+elementSerialSeq+"']").each(function(){
				if($(this).attr("checked")=="checked"){
					if(attrValue!=""){
						attrValue += ","+$(this).val();
					}else {
						attrValue = $(this).val();
					}
		        }
			});;
		}else {
			attrValue = $(obj).val();
		}
		
		var datas ={
				attrCode:attrCode,
				value: attrValue,
				elementSerialSeq:elementSerialSeq,
				visitFlow:visitFlow,
				patientFlow:'${patient.patientFlow}'
		};
		jboxPost("<s:url value='/edc/input/saveData'/>",datas,null,null,false);
	}
}

function validateFlag(obj) {
	var flag = true;
	$(obj).bind('jqv.field.result', function(event, field, isError, promptText){
		if (isError && (promptText.indexOf("无效的整数")>0 || promptText.indexOf("无效的数值")>0)) {
			flag = false;
			$(obj).val("");
		}
	});
	return flag;
}

$(document).ready(function(){
	$(":input[type!='button'][type!='hidden'][id!='visitDate'][id!='queryFlow']").focus(function(){
		if($(this).attr("type")=='text'  || $(this)[0].tagName == "SELECT"){
			$(this).addClass("selected");			
		}else{
			$(this).next().addClass("selected");
		}
	});
});
$(document).ready(function(){
	$(":input[type!='button'][type!='hidden'][id!='visitDate']").blur(function(){
		if($(this).attr("type")=='text'  || $(this)[0].tagName == "SELECT"){
			$(this).removeClass("selected");			
		}else{
			$(this).next().removeClass("selected");
		}
	});
});
$(document).ready(function(){
	$('#inputForm').validationEngine('validate');
});
function showcrf(){
	window.location.href="<s:url value='/edc/query/crf?queryFlow='/>"+$("#queryFlow").val()+"&patientFlow=${patient.patientFlow}";
}
function doSolve(queryFlow,sendWayId){
	jboxConfirm("是否标记该疑问为解决?",function(){
		jboxGet("<s:url value='/edc/query/solveQuery'/>?queryFlow="+queryFlow,null,function(){
			//更新疑问数目
			$("#"+sendWayId).val(parseInt($("#"+sendWayId).val())-1); 
			//隐藏批注
			 $('.'+queryFlow).jCallout('hide');
			//去除selected
			removeQuerySelectClass(queryFlow);
			//刷新queryDiv
			if(window.parent.frames['jbox-message-iframe']){
				window.parent.frames['jbox-message-iframe'].window.location.reload(true);
			}
			//刷新button数目
			$("#"+sendWayId+"Btn").val($("#"+sendWayId).attr("name")+":"+$("#"+sendWayId).val());
			//无疑问自动关闭弹窗
			if($("#"+sendWayId).val()==0){
				jboxCloseMessager();
			}
		},null,false);
	});
}
function queryList(sendWayId){
	if($("#"+sendWayId).val()==0){
		jboxTip("暂无该类型疑问");
		return;
	}
	
	var url ="<s:url value='/edc/query/showQueryBySendWay'/>?sendWayId="+sendWayId+"&patientFlow=${patient.patientFlow}";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'疑问项明细',450,400,sendWayId);	
}
function showCallOut(queryFlow,queryTypeName,sendWayId,isSingle){
	if(isSingle){
		//隐藏其他的批注
		hideJCallOut();
		
		//去除所有selected
		hideSelect();
	}
	
	//展示对应query批注
	$('.'+queryFlow).jCallout({
		   message: queryTypeName,
		   backgroundColor: "#F7F3B1",
		   textColor: "#3B3b3B",
		   position:"right",
		   hideEffect:"explode",
		   showEffect:"blind",
		   showSpeed:"fast",
		   $closeElement: $("<span style='float: right; cursor: pointer'>&#12288;&#12288;[<a href=javascript:doSolve(\'"+queryFlow+"\',\'"+sendWayId+"\');>标记为解决</a>]</span>"),
		   hideSpeed:"fast"
	});
	
	addQuerySelectClass(queryFlow);
	//锚点定位
	//$.scrollTo('.'+queryFlow,1000,{ offset:{ top:-20} }); 
	$(".main_fix").scrollTo('.'+queryFlow, 1000, { offset:{ top:-20} } );
}
function addQuerySelectClass(queryFlow){
	$('.'+queryFlow).each(function(){
		if($(this).find(":input").stop().attr("type") == "text"  ){
			$(this).find("input:text").stop().addClass("selected");	
		}else if($(this).find(":input").stop().attr("type") == "checkbox" || $(this).find(":input").stop().attr("type") == "radio" ){
			$(this).addClass("selected");
		}else if($(this).find("select").stop().attr("name") !=""){
			$(this).find("select").stop().addClass("selected");
		}
	});
}
function removeQuerySelectClass(queryFlow){
		 if($('.'+queryFlow).find(":input").stop().attr("type") == "text"  ){
			$('.'+queryFlow).find("input:text").stop().removeClass("selected");	
		}else if($('.'+queryFlow).find(":input").stop().attr("type") == "checkbox" || $('.'+queryFlow).find(":input").stop().attr("type") == "radio" ){
			$('.'+queryFlow).removeClass("selected");
		}else if($('.'+queryFlow).find("select").stop().attr("name") !=""){
			$('.'+queryFlow).find("select").stop().removeClass("selected");
		}
}
function hideJCallOut(){
	$('.callout').each(function(){
		$(this).hide();
	});
}
function hideSelect(){
	$(".selected").each(function(){
		$(this).removeClass("selected");
	});
}

function checkCode(field,rules, i,options){
	if(field.attr('codeValues').indexOf(field.val())<0){
		return "只能填写"+field.attr('codeValues');
	}
}

</script>
</head>
<body>
	
		<div class="title1 clearfix" style="width: 100%;">  
	<table width="100%">
		<tr>
			<td style="width: 650px">
					&#12288;&#12288;受试者序号：${patient.patientSeq } &#12288;&#12288;  
		     	受试者编号：${patient.patientCode } &#12288;&#12288; 
		     	缩写：${patient.patientNamePy }   &#12288;&#12288; 
		   	<input type="button" id="SBtn" class="search" value="SDV:${fn:length(sdvQueryList)}" onclick="queryList('${edcQuerySendWayEnumSdv.id}');"/>
		    <input type="button" id="MBtn" class="search" value="Manual:${fn:length(manualQueryList)}" onclick="queryList('${edcQuerySendWayEnumManual.id}');"/>
		      <input type="button" id="LBtn" class="search" value="Logic:${fn:length(logicQueryList)}" onclick="queryList('${edcQuerySendWayEnumLogic.id}');"/>
		      <input type="hidden" id="S" name="SDV" value="${fn:length(sdvQueryList)}"/>
		      <input type="hidden" id="M" name="Manual" value="${fn:length(manualQueryList)}"/>
              <input type="hidden" id="L" name="Logic" value="${fn:length(logicQueryList)}"/>
		</td>
		</tr>
	</table>
	<hr/>
</div>
	
		<div class="main_fix">
<div id="main" >
<div>
<form id="inputForm" style="height: 100%;position: relative;">
<c:forEach items="${sessionScope.projDescForm.visitList }" var="visit">
<c:if test="${!empty patientSubmitVisitMap[visit.visitFlow] }">
<div align="center" style="font-size: 15px;font-weight:bold;">访视：<font color="blue">${visit.visitName }</font></div>
<div>
 <c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
 <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
 <c:set var="commCode" value="${visit.visitFlow }_${moduleCode }"></c:set>
 <fieldset>
 	<legend>${visitModule.moduleName}</legend>
 		<table  class="basic" width="100%" >
	 		<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<!-- 设置moduleCode -->
	 		<c:if test="${!empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitElement.moduleCode }"></c:set>
	 		</c:if>
	 		<c:if test="${empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
	 		</c:if>
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}"></c:set>
	 		<c:set var="edcPatientVisit" value="${patientSubmitVisitMap[visit.visitFlow].edcPatientVisit }"/>
	 		<c:set var="columnCount" value="${sessionScope.projDescForm.elementMap[visitElement.elementCode].columnCount }"></c:set>	
	 		<c:if test="${empty sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId || moduleStyleEnumSingle.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">	
	 			<tr>
	 				<th width="15%">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
	 				</th>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 					<jsp:include page="queryCrf_single.jsp" flush="true"> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
			 				<td>
			 					<jsp:include page="queryCrf_serial.jsp" flush="true"> 
				 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
				 						<jsp:param name="moduleCode" value="${moduleCode }" />
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 					</jsp:include>
			 				</td>
		 				</c:when>
		 				<c:otherwise>
		 					<td>
			 					<jsp:include page="queryCrf_serial_vertical.jsp" flush="true"> 
			 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
				 						<jsp:param name="moduleCode" value="${moduleCode }" />
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 							<jsp:param name="columnCount" value="${columnCount}" />
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
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }
	 				</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td>
		 					<jsp:include page="queryCrf_single.jsp" flush="true"> 
		 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
		 						<jsp:param name="moduleCode" value="${moduleCode }" />
	 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
	 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
	 							<jsp:param name="columnCount" value="${columnCount}" />
	 					</jsp:include>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<c:choose>
	 					<c:when test="${fn:length(sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]) <=  sysCfgMap['edc_serial_attr_count'] }">
			 				<td>
			 					<jsp:include page="queryCrf_serial.jsp" flush="true"> 
				 						<jsp:param name="visitFlow" value="${visit.visitFlow }" />
				 						<jsp:param name="moduleCode" value="${moduleCode }" />
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 					</jsp:include>
			 				</td>
		 				</c:when>
		 				<c:otherwise>
		 					<td>
			 					<jsp:include page="queryCrf_serial_vertical.jsp" flush="true"> 
			 							<jsp:param name="visitFlow" value="${visit.visitFlow }" />
				 						<jsp:param name="moduleCode" value="${moduleCode }" />
			 							<jsp:param name="commAttrCode" value="${commAttrCode }" />
			 							<jsp:param name="elementCode" value="${visitElement.elementCode }" />
			 							<jsp:param name="columnCount" value="${columnCount}" />
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
 </div>
 </c:if>
</c:forEach>
</form>
</div>
</div></div>
</body>
</html>