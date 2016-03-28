<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
</head>
<body>
	<c:set var="visitFlow" value="${param.visitFlow}" />
	<c:set var="commAttrCode" value="${param.commAttrCode }" />
	<c:set var="elementCode" value="${param.elementCode }" />
	<c:set var="edcPatientVisit"
		value="${patientSubmitVisitMap[visitFlow].edcPatientVisit }" />
	<table class="reptb">
		<tr>
			<th style="width: 50px;min-width: 0;"></th>
			<th style="width: 50px;min-width: 0;">序号</th>
			<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
				<th>${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}</th>
			</c:forEach>
		</tr>
		<tbody id="${elementCode }_TBODY">
			<c:set var="seqValueMap" value="${patientCrfDataMap[visitFlow][elementCode]}"></c:set>
			<c:choose>
				<c:when test="${fn:length(patientCrfDataMap[visitFlow][elementCode])>0 }">
					<c:forEach items="${seqValueMap }" var="valueMapRecord">
						<tr id="serialSeqTr">
							<td><input type="checkbox" name="elementSerialSeq" value="${valueMapRecord.key }" /></td>
							<td><div>${valueMapRecord.key }</div></td>
							<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr">
								<c:set var="commCodeFlow" value="${commAttrCode }_${ attr.attrCode}"></c:set>
								<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,edcPatientVisit.inputOperFlow,edcPatientVisit) }"></c:set>
								<c:set var="commNormalValueKey" value="${patient.orgFlow }_${elementCode }" />
								<!-- 疑问高亮 -->
								<c:set var="queryClass" value="${visitAttrMap[visitFlow][valueMapRecord.key][attr.attrCode]}" />
								<td>
									<span class="${queryClass}">
									<!-- 文本/日期-->
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
												  empty projDescForm.attrMap[attr.attrCode].inputTypeId or 
												  projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
										<input type="text" 
											name="${visitFlow}_${attr.attrCode }_${valueMapRecord.key }"
											attrCode="${ attr.attrCode }" value="${value }"
											title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }"
											codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
											<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
 								  				onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
 								  				onblur="doSave('${ visitFlow}','${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
 											</c:if>
											class="validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input serial_input"
											onchange="doSave('${ visitFlow}','${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
											/>&#12288;
									 </c:if>
									<!-- 单选 /复选-->
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
												  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
										<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
										<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
											<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
											<input type="${inputTypeId }"
													name="${visitFlow}_${attr.attrCode }_${valueMapRecord.key }"
													attrCode="${ attr.attrCode }"
													<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if>
													onchange="doSave('${visitFlow}','${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
													value="${edcAttrCode.codeValue }"
													id="${visitFlow }_${attr.attrCode }_${edcAttrCode.codeValue }_${valueMapRecord.key}"
													class="input" />
											<label for="${visitFlow }_${attr.attrCode }_${edcAttrCode.codeValue }_${valueMapRecord.key}">${edcAttrCode.codeName }&#12288;</label>
										</c:forEach>
									</c:if>
									<!-- 下拉-->
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
										<select name="${visitFlow}_${attr.attrCode }_${valueMapRecord.key }"
												attrCode="${ attr.attrCode }"
												onchange="doSave('${visitFlow}','${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
												class="input serial_select">
												<option value=""></option>
												<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
													<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
													<option value="${edcAttrCode.codeValue }"
														<c:if test="${edcAttrCode.codeValue == value}">selected</c:if>>${edcAttrCode.codeName}
													</option>
												</c:forEach>
											</select>
										</c:if>
								</span></td>
							</c:forEach>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</tbody>
	</table>
</body>