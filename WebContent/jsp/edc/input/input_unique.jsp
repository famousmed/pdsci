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
</jsp:include>
</head>
<script type="text/javascript">
function doSubmit(){
	if(false==$("#inputForm").validationEngine("validate")){
		return ;
	}
	if($("#inputStatus").val() != "1" ){
		jboxTip("该访视未录入数据,无法提交!");
		return;
	} 
	
	if("${edcPatientVisit.inputOperStatusId}" == "${edcInputStatusEnumSubmit.id}"){
		jboxGet("<s:url value='/edc/input/checkDiff'/>",$("#inputForm").serialize(),function(resp){
			if(resp==0){
				doSubmitCheck();//全部相同 默认核对提交
			}else {
				jboxConfirm("双份录入存在&#12288<font color=red>"+data+"</font>&#12288处不同,核对录入后才能提交!" , function(){
					window.location.href="<s:url value='/edc/input/check'/>";
				});
			}
		});	
	}else {
		doSubmitCommit();
	}
}
function doSubmitCheck(){
	jboxGet("<s:url value='/edc/input/doSubmitCheck'/>",null,function(){
		$("#submitBtn").hide();
		$("#inputStatus").val("${edcInputStatusEnumSubmit.id}");
		disInput();					
	});	
}
function doSubmitCommit(){
	var url = "<s:url value='/edc/input/submitData'/>";
	jboxConfirm("确认提交?提交后无法修改数据!" , function(){
		jboxGet(url , $("#inputForm").serialize() , function(){
				$("#submitBtn").hide();
				$("#inputStatus").val("${edcInputStatusEnumSubmit.id}");
				disInput();
		} , null , true);
	});
	
}
function doSave(isSerialSeq,attrCode,obj){
	if("${edcInputStatusEnumSubmit.id }" == $("#inputStatus").val()){
		jboxTip("该页面已提交,无法修改!");
		return ;
	}
	var attrValue = "";
	var elementSerialSeq = ( isSerialSeq=="${GlobalConstant.FLAG_N}" ?"1" : $(obj).parent().parent().find("input[name='elementSerialSeq']").val());
	
	if($(obj).attr("type") == "checkbox" ){
		$("[name='"+attrCode+"_"+elementSerialSeq+"']").each(function(){
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
	/*
	$("[name='"+attrCode+"_"+elementSerialSeq+"']").each(function(){
		if($(this).attr("type") == "checkbox" || $(this).attr("type") == "radio" ){
			if($(this).attr("checked")){
				if(attrValue!=""){
					attrValue += ","+$(this).val();
				}else {
					attrValue = $(this).val();
				}
	        }
		}else {
			attrValue = $(this).val();
		}
	});
	*/
	var datas ={
			attrCode:attrCode,
			value: attrValue,
			elementSerialSeq:elementSerialSeq
	};
	//alert("attrCode="+attrCode+";name:"+$(obj).attr("name")+",value:"+attrValue+",elementSerialSeq:"+elementSerialSeq);
	jboxPost("<s:url value='/edc/input/saveData'/>", datas, function() {
		$("#inputStatus").val("${edcInputStatusEnumSave.id}");
		});
}
function saveVisitDate(){
	if("${edcInputStatusEnumSubmit.id }" == $("#inputStatus").val()){
		jboxTip("该页面已提交,无法修改!");
		return ;
	}
	if($("#visitDate").val()!=""){
		jboxGet("<s:url value='/edc/input/saveVisitDate'/>?visitDate="+$("#visitDate").val(),null,function(){
			$("#inputStatus").val("${edcInputStatusEnumSave.id}");			
		});	
	}
}
function disInput(){
	$("input").each(function(i){
		  $(this).attr("disabled",true);
	 });
	$("select").each(function(i){
		  $(this).attr("disabled",true);
	 });
}
$(document).ready(function(){
	if("${edcInputStatusEnumSubmit.id }" == $("#inputStatus").val()){
		disInput();
	}
	$('#inputForm').validationEngine('validate');
});
function addTr(elementCode){
	var currTrCount = $("#"+elementCode+"_TBODY").children().length;
	 var tr =  ($("#"+elementCode+"_TBODY tr:eq(0)").clone());
	 
	 //重置序号列以外的name
	  tr.find("td .input").each(function(){
		 $(this).attr("name",$(this).attr("attrCode")+"_"+(currTrCount+1));
		 /*
		 	页面label可随机生成，无需下方组织 
		 */
		 if($(this).attr("type") == "checkbox" || $(this).attr("type") == "radio" ){
			 $(this).attr("id",$(this).attr("attrCode")+"_"+$(this).val()+"_"+(currTrCount+1));
			 $(this).find("~ label").attr("for",$(this).attr("attrCode")+"_"+$(this).val()+"_"+(currTrCount+1));
		 }
	  });
	 
	 $("#"+elementCode+"_TBODY").append(tr);
	 
	 //重置值
	 tr.find("td input[name=elementSerialSeq] :first").val(currTrCount+1);
	 tr.find("td div :first").html(currTrCount+1);
	 //tr.find("td input[name$=SerialSeq]").val(currTrCount+1);
	  
  	 tr.find("td :text").val("");
	 tr.find("td :checkbox").attr("checked",false);
	 tr.find("td :radio").attr("checked",false);
	 tr.find("td select").val("");
}
function delTr(elementCode){
	var seqStr  ="";
	$("#"+elementCode+"_TBODY").find("input[name=elementSerialSeq]:checked").each(function(){
		if(seqStr==""){
			seqStr+=$(this).val();
		}else {
			seqStr+=","+$(this).val();
		}
	});
	if(seqStr != ""){
		jboxConfirm("确认删除？",function () {
			jboxGet("<s:url value='/edc/input/delSerialSeqData'/>?elementCode="+elementCode+"&elementSerialSeq="+seqStr,null,function(){
				window.location.reload(true);
			},null);	
			
			//$(this).parent().parent().remove();			
		});
	}else {
		jboxTip("请选择要删除的数据!");
	}
	//window.location.href="<s:url value='/edc/input/inputMain?patientFlow='/>"+patientFlow+"&visitFlow="+visitFlow+"&inputOperFlow="+currOperFlow+"&inputStatusId="+inputStatusId;
}

</script>
<body>
<form id="inputForm" style="height: 100%">
<div class="mainright">
		<div class="content">
<div class="title1 clearfix"> 
     	访视名称：${visit.visitName }&#12288;&#12288;
     	受试者序号：${patient.patientSeq } &#12288;&#12288;  
     	受试者编号：${patient.patientCode } &#12288;&#12288; 
     	缩写：${patient.patientNamePy }   
     	&#12288;&#12288;&#12288;&#12288;<font color="red">*</font>本次访视日期：<input type="text" id="visitDate" readonly="readonly" name="visitDate" class="validate[required] ctime" value="${patientVisit.visitDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" onblur="saveVisitDate();"/>		
     			 <input type="button" value="refresh" class="search" onclick="window.location.reload(true);" /> 
     			<c:if test="${edcInputStatusEnumSubmit.id != param.inputStatusId }">
     			<input type="button" value="提交" id="submitBtn" class="search" onclick="doSubmit();"  />
     			</c:if>
     <hr />
</div>
<div>
 <c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
 <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
 <c:set var="commCode" value="${visit.visitFlow }_${visitModule.moduleCode }"></c:set>
 <fieldset>
 	<legend><h4>${sessionScope.projDescForm.moduleMap[moduleCode].moduleName}</h4></legend>
 		<table class="xllist nofix" >
	 		<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${visitModule.moduleCode }_${ visitElement.elementCode}"></c:set>
	 			<tr>
	 				<td style="text-align: right;color:#c00" width="150px" valign="top">
	 					${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;
	 				</td>
	 				<!-- 单次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_N}">
		 			<td><c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
		 					<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[visitElement.elementCode]['1'],param.inputOperFlow,edcPatientVisit) }"></c:set>
		 					<c:set var="commNormalValueKey" value="${patient.orgFlow }_${visitElement.elementCode }"/>
		 					<!-- 标准单位 -->
		 					<c:if test="${value == '' && sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
		 						<c:set var="value" value="${sessionScope.projDescForm.elementStandardUnitMap[visitElement.elementCode] }"/>
		 					</c:if>
		 					<!-- 校验 -->
		 					<c:set var="condition" value=""/>
		 					<span style="float: left;" >&#12288;
		 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
		 						${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
		 						</c:if>
		 						<!-- 文本/日期 -->
		 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
		 							<input type="text" name="${attr.attrCode }_1" value="${value }" 
		 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
		 								  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
		 								</c:if>
		 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].dataTypeId == attrDataTypeEnumInteger.id }">
		 									<c:set var="condition" value="custom[integer],"/>
		 								</c:if>
		 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].dataTypeId == attrDataTypeEnumFloat.id }">
		 									<c:set var="condition" value="custom[number],"/>
		 								</c:if>
	 									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME and ! empty sessionScope.projDescForm.normalValueMap[commNormalValueKey] }">
		 									<c:choose>
		 										<c:when test="${!empty sessionScope.projDescForm.normalValueMap[commNormalValueKey][userSexEnumUnknown.id]  }">
		 											<c:set var="min" value="${sessionScope.projDescForm.normalValueMap[commNormalValueKey][userSexEnumUnknown.id].lowerValue}"/>
		 											<c:set var="max" value="${sessionScope.projDescForm.normalValueMap[commNormalValueKey][userSexEnumUnknown.id].upperValue }"/>
		 											<c:set var="condition" value="${condition },min[${min }], max[${max }]"/>
		 										</c:when>
		 										<c:otherwise>
		 											<c:set var="min" value="${sessionScope.projDescForm.normalValueMap[commNormalValueKey][patient.sexId].lowerValue}"/>
		 											<c:set var="max" value="${sessionScope.projDescForm.normalValueMap[commNormalValueKey][patient.sexId].upperValue }"/>
		 											<c:set var="condition" value="${condition },min[${min }], max[${max }]"/>
		 										</c:otherwise>
		 									</c:choose>
		 								</c:if>
		 									class="validate[${condition }]"
		 							     onblur="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);"/>&#12288; 
		 						</c:if>
		 						<!-- 单选/复选 -->
		 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
							 		<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }"/>
		 							<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">	 
		 								<input type="${inputTypeId }" name="${attr.attrCode }_1" <c:if test="${fn:indexOf(value,code.codeValue)>-1 }">checked="checked"</c:if> onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" value="${code.codeValue }" id="${attr.attrCode }_${code.codeValue}"/> <label for="${attr.attrCode }_${code.codeValue}">${code.codeName }&#12288;</label> 
		 							</c:forEach>
		 						</c:if>
		 						<!-- 下拉-->
		 						<c:if test="${ sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
		 							<select name="${attr.attrCode }_1"  attrCode="${ attr.attrCode }" onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);">
			 							<option value=""></option>
			 							<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">	 
			 								<option value="${code.codeValue }" <c:if test="${ code.codeValue == value}">selected</c:if>>${code.codeName }</option>
			 							</c:forEach>
		 							</select>
		 						</c:if>
		 					</span> 
		 				</c:forEach>
		 			</td>
	 			</c:if> 
	 			<!-- 多次录入 -->
	 			<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
	 				<td>
	 					 <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">	
	 					 <!-- 
	 					 	  <tr>
					               <th colspan="${fn:length( sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] )+2}" class="bs_name"><img src="<s:url value='/css/skin/${skinPath}/images/del.png'/>" onclick="delTr('${visitElement.elementCode}')" style="cursor: pointer;"></img><img src="<s:url value="/css/skin/${skinPath}/images/add.png"/>" style="cursor: pointer;" onclick="addTr('${visitElement.elementCode}');"></img></th>
					           </tr>
					            -->
					           <tr>
					           		<th width="50px"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addTr('${visitElement.elementCode}');" /> <img title="删除" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('${visitElement.elementCode}')" style="cursor: pointer;" /></th>
					           		<th width="50px">序号</th> 
					           		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
					              	<th >${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }</th>
					                </c:forEach>
					           </tr>
					            <tbody id="${visitElement.elementCode }_TBODY">
							        <c:set var="seqValueMap" value="${elementSerialSeqValueMap[visitElement.elementCode]}"></c:set>
					            	<c:choose>
						            	<c:when test="${fn:length(elementSerialSeqValueMap[visitElement.elementCode])>0 }">
							            	<c:forEach items="${seqValueMap }" var="valueMapRecord">
								           <tr >
								           		<td><input type="checkbox" name="elementSerialSeq"   value="${valueMapRecord.key }" /></td>
								           		<td><div>${valueMapRecord.key }</div></td>
												<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
													<!-- 校验 -->
		 											<c:set var="condition" value=""/>
												<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,param.inputOperFlow,edcPatientVisit) }"></c:set>
												<td>
								 					<!-- 文本/日期-->
							 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or empty projDescForm.attrMap[attr.attrCode].inputTypeId or projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
							 							<input type="text" name="${attr.attrCode }_${valueMapRecord.key }" attrCode="${ attr.attrCode }" value="${value }"  
							 							<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
						 								  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
						 								</c:if>
						 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].dataTypeId == attrDataTypeEnumInteger.id }">
						 									<c:set var="condition" value="custom[integer],"/>
						 								</c:if>
						 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].dataTypeId == attrDataTypeEnumFloat.id }">
						 									<c:set var="condition" value="custom[number],"/>
						 								</c:if>
						 								class="validate[${condition }]"
						 								
							 							 onblur="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" class="input"/>&#12288; 
							 						</c:if>
							 						<!-- 单选 /复选-->
							 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
							 								<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }"/>
							 								<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">	 
								 								<input type="${inputTypeId }" name="${attr.attrCode }_${valueMapRecord.key }" attrCode="${ attr.attrCode }" <c:if test="${fn:indexOf(value,code.codeValue)>-1 }">checked="checked"</c:if> onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" value="${code.codeValue }" id="${attr.attrCode }_${code.codeValue }_${valueMapRecord.key}" class="input"/><label for="${attr.attrCode }_${code.codeValue }_${valueMapRecord.key}"> ${code.codeName }&#12288;</label>
								 							</c:forEach>
							 						</c:if>
							 						<!-- 下拉-->
							 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
							 							<select name="${attr.attrCode }_${valueMapRecord.key }"  attrCode="${ attr.attrCode }" onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" class="input">
								 							<option value=""></option>
								 							<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">	 
								 								<option value="${code.codeValue }" <c:if test="${code.codeValue == value}">selected</c:if>>${code.codeName }</option>
								 							</c:forEach>
							 							</select>
							 						</c:if>
												</td>				
												</c:forEach>	           	
								           </tr>
								           </c:forEach>
							           </c:when>
							           <c:otherwise><!-- 默认存在一条空记录 -->
							           		<tr >
							           			<td><input type="checkbox" name="elementSerialSeq"  value="1" /></td>
								           		<td><div>1</div></td>
												<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
													<!-- 校验 -->
		 											<c:set var="condition" value=""/>
												<td>
								 					<!-- 文本 /日期-->
							 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
							 							<input type="text" name="${attr.attrCode }_1" attrCode="${ attr.attrCode }"  
							 							<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
						 								  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
						 								</c:if>
						 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].dataTypeId == attrDataTypeEnumInteger.id }">
						 									<c:set var="condition" value="custom[integer],"/>
						 								</c:if>
						 								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].dataTypeId == attrDataTypeEnumFloat.id }">
						 									<c:set var="condition" value="custom[number],"/>
						 								</c:if>
						 								class="validate[${condition }]"
						 								
							 							 onblur="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" class="input"/>&#12288; 
							 						</c:if>
							 						<!-- 单选/复选 -->
							 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
					 									<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }"/>
						 								<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">	  
							 								<input type="${inputTypeId }" name="${attr.attrCode }_1" attrCode="${ attr.attrCode }"  onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"  id="${attr.attrCode }_${code.codeValue }_${valueMapRecord.key}" class="input"/><label for="${attr.attrCode }_${code.codeValue }_${valueMapRecord.key}"> ${code.codeName }&#12288;</label>
							 							</c:forEach>
							 						</c:if>
							 						<!-- 下拉-->
							 						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
							 							<select name="${attr.attrCode }_1" onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" class="input">
							 								<option value=""></option>
								 							<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">	 
								 								<option value="${code.codeValue }" >${code.codeName }</option>
								 							</c:forEach>
							 							</select>
							 						</c:if>
												</td>				
												</c:forEach>	           	
								           </tr>
							           </c:otherwise>
						           </c:choose>
					           </tbody>
	 					 </table>
	 				</td>
	 			</c:if>
	 			</tr>
	 		</c:forEach>
 		</table></fieldset>
 </c:forEach>
</div>
</div></div>
<input type="hidden" name="inputStatus" id="inputStatus" value="${param.inputStatusId}" />
</form>
</body>
</html>