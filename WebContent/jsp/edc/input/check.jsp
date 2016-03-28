<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="false" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
</head>
<script type="text/javascript">
	function doSubmitCheck() {
		var url = "<s:url value='/edc/input/doSubmitCheck'/>";
		jboxConfirm("确认完成本次访视录入?提交后无法修改数据!",function() {
			jboxGet(url,null,function() {
				window.location.href = "<s:url value='/edc/input/inputMain?patientScope=${patientScope}&patientType=${param.patientType}&groupFlow=${param.groupFlow}"+
						"&patientFlow=${sessionScope.currPatient.patientFlow }'/>&visitFlow=${sessionScope.currVisit.visitFlow }"+
						"&inputOperFlow=${sessionScope.currUser.userFlow}&inputStatusId=${edcInputStatusEnumSubmit.id}";
			}, null, true);
		});
	}
	function doSave(elementSerialSeq, attrCode, obj) {
		var attrValue = "";
		if ($(obj).attr("type") == "checkbox") {
			$("[name=" + attrCode + "_" + elementSerialSeq + "] ").each(
					function() {
						if ($(this).attr("checked") == "checked") {
							if (attrValue != "") {
								attrValue += "," + $(this).val();
							} else {
								attrValue = $(this).val();
							}
						}
					});
			;
		} else {
			attrValue = $(obj).val();
		}

		var datas = {
			attrCode : attrCode,
			value : attrValue,
			elementSerialSeq : elementSerialSeq
		};
		//alert("attrCode="+attrCode+";name:"+$(obj).attr("name")+",value:"+attrValue+",elementSerialSeq:"+elementSerialSeq);

		jboxPost("<s:url value='/edc/input/saveData'/>", datas, null, null,
				false);
	}
	$(document).ready(function() {
		$('#inputForm').validationEngine('validate');
	});

	function checkCode(field, rules, i, options) {
		if (field.attr('codeValues').indexOf(field.val()) < 0) {
			return "只能填写" + field.attr('codeValues');
		}
	}
</script>
<body>
	<form id="inputForm" style="height: 100%">
		<div class="mainright">
			<div class="content">
				<div style="padding-top: 5px">
					访视名称：${sessionScope.currVisit.visitName }&#12288;&#12288;
					受试者序号：${sessionScope.currPatient.patientSeq } &#12288;&#12288;
					受试者编号：${sessionScope.currPatient.patientCode } &#12288;&#12288;
					缩写：${sessionScope.currPatient.patientNamePy }
					&#12288;&#12288;&#12288;&#12288;
					<c:if test="${visit.isVisit eq  GlobalConstant.FLAG_Y}">
						<font color="red">*</font>本次访视日期：<input type="text" id="visitDate"
							readonly="readonly" name="visitDate"
							class="validate[required] ctime"
							value="${patientVisit.visitDate }"
							onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
							onblur="saveVisitDate();" />
					</c:if>
					<!--  <input type="button" value="refresh" class="search" onclick="window.location.reload();" /> -->
					<c:if test="${edcInputStatusEnumSubmit.id != param.inputStatusId }">
						<input type="button" value="提&#12288;交" id="submitBtn" class="search" onclick="doSubmitCheck();" />
					</c:if>
					<hr />
				</div>
				<div class="title1 clearfix">
					<table class="xllist">
						<tr>
							<th width="10%"></th>
							<th width="45%">${edcPatientVisit.inputOper1StatusId eq edcInputStatusEnumSubmit.id?edcPatientVisit.inputOper1Name:edcPatientVisit.inputOper2Name }
								<c:set var="leftOperFlow" value="${edcPatientVisit.inputOper1StatusId eq edcInputStatusEnumSubmit.id ?edcPatientVisit.inputOper1Flow:edcPatientVisit.inputOper2Flow }"></c:set>
							</th>
							<th width="45%">${edcPatientVisit.inputOper1StatusId eq edcInputStatusEnumSave.id?edcPatientVisit.inputOper1Name:edcPatientVisit.inputOper2Name }
								<c:set var="rightOperFlow" value="${edcPatientVisit.inputOper1StatusId eq edcInputStatusEnumSave.id?edcPatientVisit.inputOper1Flow:edcPatientVisit.inputOper2Flow }"></c:set>
							</th>
						</tr>
					</table>
				</div>
				<c:forEach items="${sessionScope.projDescForm.visitModuleMap[sessionScope.currVisit.visitFlow]}" var="visitModule">
					<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
					<c:set var="commCode" value="${sessionScope.currVisit.visitFlow }_${moduleCode }"></c:set>
					<c:if test="${!empty  existDiffModuleMap[moduleCode]}">
						<div style="width: 100%">
							<fieldset>
								<legend>
									<h4>${sessionScope.projDescForm.moduleMap[moduleCode].moduleName}</h4>
								</legend>
								<table class="basic" style="width: 100%">
									<c:forEach items="${sessionScope.projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
										<!-- 设置moduleCode -->
										<c:if test="${!empty visitElement.placeholdModuleCode }">
											<c:set var="moduleCode" value="${visitElement.moduleCode }"></c:set>
										</c:if>
										<c:if test="${empty visitElement.placeholdModuleCode }">
											<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
										</c:if>
										<c:set var="commAttrCode" value="${sessionScope.currVisit.visitFlow }_${moduleCode }_${ visitElement.elementCode}"></c:set>
										<c:if test="${!empty existDiffElementMap[visitElement.elementCode] }">
											<c:if test="${empty sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId ||
														  moduleStyleEnumSingle.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
												<tr>
													<th width="10%">${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName}&#12288;</th>
													<!-- 单次、多次 统一展示 -->
													<c:set var="seqValueMap" value="${elementSerialSeqValueMap[visitElement.elementCode]}"></c:set>
													<td width="100%">
														<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
															<c:forEach items="${seqValueMap }" var="valueMapRecord">
																<c:set var="commElementSeq" value="${visitElement.elementCode}_${ valueMapRecord.key}"></c:set>
																<c:if test="${ !empty existDiffElementSeqMap[commElementSeq]}">
																	<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
																		<tr>
																			<th colspan="2" style="text-align: left;">&#12288;序号:${valueMapRecord.key}</th>
																		</tr>
																	</c:if>
																	<tr>
																		<td width="45%">
																			<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
																				<c:set var="commCodeFlow" value="${commAttrCode }_${ attr.attrCode}"></c:set>
																				<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[visitElement.elementCode][valueMapRecord.key],leftOperFlow,edcPatientVisit) }"></c:set>
																				<c:set var="commDiffCode" value="${visitElement.elementCode}_${valueMapRecord.key }_${attr.attrCode }" />
																				<c:if test="${!empty existDiffAttrValueMap[ commDiffCode]}">
																					<span style="float: left;">
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
						 																${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
						 															</c:if>
						 															<!-- 文本/日期 -->
						 															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
						 																		  empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
						 																		  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																						<input type="text" style="width: 120px;" value="${value }" disabled="disabled" />&#12288;
																					</c:if>
																					<!-- 单选/复选 -->
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
																								  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
																						<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
																						<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																							<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																							<input type="${inputTypeId }" disabled="disabled"
																								<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if> />${edcAttrCode.codeName }&#12288;
								 														</c:forEach>
																					</c:if>
																					<!-- 下拉-->
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
																						<select disabled="disabled" style="width: 120px;">
																							<option value=""></option>
																							<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																								<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																									<option value="${edcAttrCode.codeValue }"
																									<c:if test="${ edcAttrCode.codeValue == value}">selected</c:if>>${edcAttrCode.codeName}
																									</option>
																								</c:forEach>
																							</select>
																					</c:if>
																				</span>
																			</c:if>
																		</c:forEach>
																		</td>
																		<td width="45%">
																		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
																			<c:set var="commCodeFlow" value="${commAttrCode }_${ attr.attrCode}"></c:set>
																			<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[visitElement.elementCode][valueMapRecord.key],rightOperFlow,edcPatientVisit) }"></c:set>
																			<c:set var="commDiffCode" value="${visitElement.elementCode}_${valueMapRecord.key }_${attr.attrCode }" />
																			<c:set var="commNormalValueKey" value="${sessionScope.currPatient.orgFlow }_${visitElement.elementCode }" />
																			<c:if test="${!empty existDiffAttrValueMap[commDiffCode]}">
																				<span style="float: left;">
																				<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
							 														${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
							 													</c:if>
							 													<!-- 文本/日期 -->
							 													<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
							 																  empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
							 																  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																					<input type="text" style="width: 120px;"
																						name="${attr.attrCode }_${valueMapRecord.key}"
																						value="${value }" title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }"
																						codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
																						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"</c:if>
																						class="validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,sessionScope.currPatient.sexId) }]"
																						onblur="doSave('${ valueMapRecord.key }','${attr.attrCode }',this);" />&#12288;
																				</c:if>
																				<!-- 单选/复选 -->
																				<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
																							  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
																					<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
																					<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																						<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																						<input type="${inputTypeId }"
																							name="${attr.attrCode }_${valueMapRecord.key}"
																							<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if>
																							onchange="doSave('${ valueMapRecord.key }','${attr.attrCode }',this);"
																							value="${edcAttrCode.codeValue }"
																							id="${attr.attrCode }_${edcAttrCode.codeValue}_${valueMapRecord.key }" />
																						<label for="${attr.attrCode }_${edcAttrCode.codeValue}_${valueMapRecord.key }">${edcAttrCode.codeName}&#12288;</label>
																					</c:forEach>
																				</c:if>
																				<!-- 下拉-->
																				<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
																					<select name="${attr.attrCode }_${valueMapRecord.key}"
																							attrCode="${ attr.attrCode }"
																							onchange="doSave('${valueMapRecord.key }','${attr.attrCode }',this);"
																							style="width: 120px;">
																						<option value=""></option>
																						<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																							<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																							<option value="${edcAttrCode.codeValue }"
																								<c:if test="${ edcAttrCode.codeValue == value}">selected</c:if>>${edcAttrCode.codeName}
																							</option>
																						</c:forEach>
																					</select>
																				</c:if>
																			</span>
																		</c:if>
																	</c:forEach>
																	</td>
																	</tr>
																</c:if>
															</c:forEach>
														</table>
													</td>
												</tr>
											</c:if>
											<c:if test="${moduleStyleEnumDouble.id eq sessionScope.projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
												<tr>
													<th style="text-align: left; padding-left: 10px;" colspan="3">${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementName}</th>
												</tr>
												<tr>
													<td width="10%" valign="top"></td>
													<!-- 单次、多次 统一展示 -->
													<c:set var="seqValueMap" value="${elementSerialSeqValueMap[visitElement.elementCode]}"></c:set>
													<td width="100%">
														<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
															<c:forEach items="${seqValueMap }" var="valueMapRecord">
																<c:set var="commElementSeq" value="${visitElement.elementCode}_${ valueMapRecord.key}"></c:set>
																<c:if test="${ !empty existDiffElementSeqMap[commElementSeq]}">
																	<c:if test="${sessionScope.projDescForm.elementMap[visitElement.elementCode].elementSerial eq GlobalConstant.FLAG_Y}">
																		<tr>
																			<th colspan="2" style="text-align: left;">&#12288;序号:${valueMapRecord.key}</th>
																		</tr>
																	</c:if>
																	<tr>
																		<td width="45%">
																		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
																			<c:set var="commCodeFlow" value="${commAttrCode }_${ attr.attrCode}"></c:set>
																				<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[visitElement.elementCode][valueMapRecord.key],leftOperFlow,edcPatientVisit) }"></c:set>
																				<c:set var="commDiffCode" value="${visitElement.elementCode}_${valueMapRecord.key }_${attr.attrCode }" />
																				<c:if test="${!empty existDiffAttrValueMap[ commDiffCode]}">
																					<span style="float: left;">
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
						 																${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
						 															</c:if>
						 															<!-- 文本/日期 -->
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
																								  empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
																								  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																						<input type="text" style="width: 120px;" value="${value }" disabled="disabled" />&#12288;
																					</c:if><!-- 单选/复选 -->
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
																								  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
																						<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
																						<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																							<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																							<input type="${inputTypeId }" disabled="disabled"
																								<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if> />${edcAttrCode.codeName }&#12288;
								 														</c:forEach>
																						</c:if>
																						<!-- 下拉-->
																						<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
																							<select disabled="disabled" style="width: 120px;">
																								<option value=""></option>
																								<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																									<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																									<option value="${edcAttrCode.codeValue }"
																										<c:if test="${ edcAttrCode.codeValue == value}">selected</c:if>>${edcAttrCode.codeName}
																									</option>
																								</c:forEach>
																							</select>
																						</c:if>
																					</span>
																				</c:if>
																			</c:forEach>
																			</td>
																			<td width="45%">
																			<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
																				<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[visitElement.elementCode][valueMapRecord.key],rightOperFlow,edcPatientVisit) }"></c:set>
																				<c:set var="commDiffCode" value="${visitElement.elementCode}_${valueMapRecord.key }_${attr.attrCode }" />
																				<c:set var="commNormalValueKey" value="${sessionScope.currPatient.orgFlow }_${visitElement.elementCode }" />
																				<c:if test="${!empty existDiffAttrValueMap[commDiffCode]}">
																					<span style="float: left;">
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
							 															${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
							 														</c:if>
							 														<!-- 文本/日期 -->
							 														<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
							 																	  empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
							 																	  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																						<input type="text" style="width: 120px;"
																							name="${attr.attrCode }_${valueMapRecord.key}"
																							value="${value }" title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }"
																							codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
																							<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"</c:if>
																							class="validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,sessionScope.currPatient.sexId) }]"
																							onblur="doSave('${ valueMapRecord.key }','${attr.attrCode }',this);" />&#12288;
																					</c:if>
																					<!-- 单选/复选 -->
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
																								  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
																						<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
																						<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">
																							<input type="${inputTypeId }" name="${attr.attrCode }_${valueMapRecord.key}"
																								<c:if test="${fn:indexOf(value,code.codeValue)>-1 }">checked="checked"</c:if>
																								onchange="doSave('${ valueMapRecord.key }','${attr.attrCode }',this);"
																								value="${code.codeValue }"
																								id="${attr.attrCode }_${code.codeValue}_${valueMapRecord.key }" />
																							<label for="${attr.attrCode }_${code.codeValue}_${valueMapRecord.key }">${code.codeName}&#12288;</label>
																						</c:forEach>
																					</c:if>
																					<!-- 下拉-->
																					<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
																						<select name="${attr.attrCode }_${valueMapRecord.key}"
																								attrCode="${ attr.attrCode }"
																								onchange="doSave('${valueMapRecord.key }','${attr.attrCode }',this);"
																								style="width: 120px;">
																							<option value=""></option>
																							<c:forEach items="${ sessionScope.projDescForm.attrCodeMap[attr.attrCode]}" var="code">
																								<option value="${code.codeValue }"
																									<c:if test="${ code.codeValue == value}">selected</c:if>>${code.codeName}</option>
																							</c:forEach>
																						</select>
																					</c:if>
																				</span>
																			</c:if>
																		</c:forEach>
																		</td>
																	</tr>
																</c:if>
															</c:forEach>
														</table>
													</td>
												</tr>
											</c:if>
										</c:if>
									</c:forEach>
								</table>
							</fieldset>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</form>
</body>
</html>