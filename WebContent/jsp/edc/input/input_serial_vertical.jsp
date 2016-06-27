<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<style>
.repVertb{margin-top: 5px;margin-bottom: 5px;margin-right: 5px;}
</style>
</head>
<body>
	<c:set var="commAttrCode" value="${param.commAttrCode }" />
	<c:set var="elementCode" value="${param.elementCode }" />
	<c:set var="columnCount" value="${param.columnCount }" />
	<!-- 设置宽度 -->
	<c:set var="attrWidth" value="150px" />
	<c:set var="attrCodeWidth" value="150px" />
	<c:if test="${ empty columnCount || (columnCount == '1')}">
		<c:set var="attrWidth" value="150px;" />
		<c:set var="attrCodeWidth" value="" />
	</c:if> 
	<table  class="basic repVertb" >
		<tr>
			<th style="width: 50px;text-align: center;padding: 0;" class="${elementCode }_tbody"><img title="新增"
				src="<s:url value="/css/skin/${skinPath}/images/add3.png" />"
				style="cursor: pointer;" onclick="addTr('${elementCode}');" /> <img
				title="删除"
				src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>"
				onclick="delTr('${elementCode}')" style="cursor: pointer;" />
			</th>
			<th style="width: 50px;text-align: center;padding: 0;">序号</th>
			<th></th>
		</tr>
		<tbody id="${elementCode }_TBODY">
			<c:set var="seqValueMap" value="${elementSerialSeqValueMap[elementCode]}"></c:set>
			<c:choose>
				<c:when test="${fn:length(elementSerialSeqValueMap[elementCode])>0}">
					<c:forEach items="${seqValueMap }" var="valueMapRecord">
						<tr id="serialSeqTr">
							<td style="text-align: center;padding: 0;"><input type="checkbox" name="elementSerialSeq"value="${valueMapRecord.key }" /></td>
							<td style="text-align: center;padding: 0;"><div>${valueMapRecord.key }</div></td>
							<td>
										<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"
											varStatus="status">
											<c:if test="${empty columnCount}">
												<c:set var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }" />
											</c:if>
											<c:if test="${status.index % columnCount eq 0}">
													<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" 
															    begin="${status.index}" end="${status.index+columnCount-1}">
														<c:set var="commCodeFlow" value="${commAttrCode }_${ attr.attrCode}"></c:set>
														<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,valueMapRecord.value,param.inputOperFlow,edcPatientVisit) }"></c:set>
														<c:set var="commNormalValueKey" value="${patient.orgFlow }_${elementCode }" />
														<c:set var="attrType" value="" />
													<!-- 单位 -->
														<c:if test="${empty value && sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
															<c:set var="value" value="${sessionScope.projDescForm.elementStandardUnitMap[elementCode] }" />
														</c:if>
													<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNewLine eq  GlobalConstant.FLAG_Y 
														or columnCount == '1'}">
															<div style="clear: both !important" attrName="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"></div>
														</c:if>
														<div style="float:left;margin-right: 10px;">
														<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
															<div  style="float: left;width: ${attrWidth}"> 
																${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}:
															</div> 
														</c:if>
														<div style="float: left;">
															<!-- 文本/日期-->
															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
																	empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
																	sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																<c:set var="dateClass" value="" />
																<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
																	<c:set var="attrType" value="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }" />
																</c:if>
																<span title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }">
																	<input type="text" 
																	name="${attr.attrCode }_${valueMapRecord.key }"
																	attrCode="${ attr.attrCode }" value="${value }" 
																		elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																	codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
																	attrType="${attrType }"
																	<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																	  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
																	  onblur="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" 
																	  <c:set var="dateClass" value="dateClass"/>
																	</c:if>
																	class="${dateClass} validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input mer_input"
																	onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" />
																</span>&#12288;
															</c:if>
															<!-- 大文本 -->
															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumTextarea.id}">
																<c:set var="dateClass" value="" />
																<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
																	<c:set var="attrType" value="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }" />
																</c:if>
																<span title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }">
																	<input type="text" 
																	name="${attr.attrCode }_${valueMapRecord.key }"
																	style="width:400px;"
																	attrCode="${ attr.attrCode }" value="${value }" 
																		elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																	codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
																	attrType="${attrType }"
																	<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																	  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
																	  onblur="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" 
																	  <c:set var="dateClass" value="dateClass"/>
																	</c:if>
																	class="${dateClass} validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input mer_input"
																	onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" />
																</span>&#12288;
															</c:if>
															<!-- 单选 /复选-->
															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
																		  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
																<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
																<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																	<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																	<input type="${inputTypeId }"
																		name="${attr.attrCode }_${valueMapRecord.key }"
																		attrCode="${ attr.attrCode }" 
																		elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																		<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if>
																		onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
																		value="${edcAttrCode.codeValue }"
																		id="${attr.attrCode }_${edcAttrCode.codeValue }_${valueMapRecord.key}"
																		class="input" attrType="${attrType }" />
																	<label for="${attr.attrCode }_${edcAttrCode.codeValue }_${valueMapRecord.key}">${edcAttrCode.codeName }&#12288;</label>
																</c:forEach>
															</c:if>
															
															<!-- 下拉-->
															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
																<select name="${attr.attrCode }_${valueMapRecord.key }"
																	attrCode="${ attr.attrCode }" 
																	elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																	onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
																	class="input event_select"
																	attrType="${attrType }">
																	<option value=""></option>
																	<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																		<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																		<option value="${edcAttrCode.codeValue }"
																			<c:if test="${edcAttrCode.codeValue == value}">selected</c:if>>${edcAttrCode.codeName}
																		</option>
																	</c:forEach>
																</select>
															</c:if>
															</div>
															</div>
													</c:forEach>
													<div style="clear: both !important" ></div>
											</c:if>
										</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<!-- 默认存在一条空记录 -->
					<tr id="serialSeqTr">
						<td width="50px" style="text-align: center;padding: 0;"><input type="checkbox" name="elementSerialSeq" value="1" /></td>
						<td width="50px" style="text-align: center;padding: 0;"><div>1</div></td>
						<td>
									<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }"
											   var="attrList" varStatus="status">
										<c:if test="${empty columnCount}">
											<c:set var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }" />
										</c:if>
										<c:if test="${status.index % columnCount eq 0}">
										<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" 
														   varStatus="attrStatus" begin="${status.index}" end="${status.index+columnCount-1}">
													<c:set var="commCodeFlow" value="${commAttrCode }_${ attr.attrCode}"></c:set>
													<c:set var="value" value=""></c:set>
													<c:set var="commNormalValueKey" value="${patient.orgFlow }_${elementCode }" />
													<c:set var="attrType" value="" />
													<!-- 单位 -->
													<c:if test="${empty value && sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
														<c:set var="value" value="${sessionScope.projDescForm.elementStandardUnitMap[elementCode] }" />
													</c:if>
													<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNewLine eq  GlobalConstant.FLAG_Y 
														or columnCount == '1'}">
															<div style="clear: both !important" attrName="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"></div>
													</c:if>
													<div style="float:left;margin-right: 10px;">
													<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
														<div  style="float: left;width: ${attrWidth}"> 
															${sessionScope.projDescForm.attrMap[attr.attrCode].attrName}:
														</div>
													</c:if>
														<!-- 文本 /日期-->
														<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
																empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
																sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
															<c:set var="dateClass" value="" />
															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
																<c:set var="attrType" value="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }" />
															</c:if>
															<span title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }">
																<input type="text" 
																name="${attr.attrCode }_1" attrCode="${ attr.attrCode }" 
																	elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																value="${value }"
																codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
																attrType="${attrType }"
																<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
																   onblur="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
																   <c:set var="dateClass" value="dateClass"/>
																</c:if>
																class="validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input mer_input"
																onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" />
															</span>&#12288;
														</c:if>
														<!-- 大文本 -->
														<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumTextarea.id }">
															<c:set var="dateClass" value="" />
															<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
																<c:set var="attrType" value="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }" />
															</c:if>
															<span title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }">
																<input type="text" 
																name="${attr.attrCode }_1" attrCode="${ attr.attrCode }" 
																	elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																value="${value }"
																style="width:400px;"
																codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }"
																attrType="${attrType }"
																<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
																  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
																   onblur="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
																   <c:set var="dateClass" value="dateClass"/>
																</c:if>
																class="validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input mer_input"
																onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);" />
															</span>&#12288;
														</c:if>
														<!-- 单选/复选 -->
														<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
																	  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
															<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
															<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																<input type="${inputTypeId }" name="${attr.attrCode }_1"
																	attrCode="${ attr.attrCode }" 
																		elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																	value="${edcAttrCode.codeValue }"
																	onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
																	id="${attr.attrCode }_${edcAttrCode.codeValue }_${valueMapRecord.key}"
																	class="input" attrType="${attrType }" />
																<label for="${attr.attrCode }_${edcAttrCode.codeValue }_${valueMapRecord.key}">${edcAttrCode.codeName }&#12288;</label>
															</c:forEach>
														</c:if>
														<!-- 下拉-->
														<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
															<select name="${attr.attrCode }_1"
																onchange="doSave('${GlobalConstant.FLAG_Y }','${attr.attrCode }',this);"
																class="input event_select" 
																attrCode="${ attr.attrCode }" 
																elementSerialSeq="${GlobalConstant.FLAG_Y }"  
																attrType="${attrType }">
																<option value=""></option>
																<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
																	<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
																	<option value="${edcAttrCode.codeValue }">${edcAttrCode.codeName}</option>
																</c:forEach>
															</select>
														</c:if>
														</div>
												</c:forEach>
										</c:if>
									</c:forEach>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</body>