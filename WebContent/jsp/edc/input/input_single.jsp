<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
</head>
<body>
	<c:set var="commAttrCode" value="${param.commAttrCode }" />
	<c:set var="elementCode" value="${param.elementCode }" />
	<c:set var="columnCount" value="${param.columnCount }" />
	<c:set var="fixWidth" value="${param.fixWidth }" />
	<!-- 设置宽度 -->
	<c:set var="attrWidth" value="120px" />
	<c:set var="attrCodeWidth" value="150px" />
	<c:if test="${ empty columnCount || (columnCount == '1')}">
		<c:set var="attrWidth" value="" />
		<c:set var="attrCodeWidth" value="" />
	</c:if>
		<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode] }" varStatus="status">
			<c:if test="${empty columnCount}">
				<c:set var="columnCount" value="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode].size() }" />
			</c:if>
			<c:if test="${status.index % columnCount eq 0}">
						<c:forEach items="${sessionScope.projDescForm.visitElementAttributeMap[commAttrCode]}" var="attr" 
								begin="${status.index}" end="${status.index+columnCount-1}">
							<c:set var="commCodeFlow" value="${commAttrCode}_${attr.attrCode}"></c:set>
							<c:set var="value" value="${pdfn:getVisitData(attr.attrCode,elementSerialSeqValueMap[elementCode]['1'],param.inputOperFlow,edcPatientVisit) }"></c:set>
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
							<c:if test="${!empty fixWidth }">
								<c:set var="fixStyle" value="width:${fixWidth }px;text-align: right;"/>
							</c:if>
							<div style="float:left;${fixStyle}"> 
								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
									<span width="${attrWidth }" > 
										${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }：
									</span>
								</c:if>
								<!-- 文本/日期 --> 
								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or 
									empty sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId or 
									sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
									<c:set var="dateClass" value="" />
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
										<c:set var="attrType" value="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }" />
									</c:if>
									<span title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }" >
										<input type="text"
										name="${attr.attrCode }_1" value="${value}"
										codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }" attrType="${attrType }" 
										attrCode="${attr.attrCode }" elementSerialSeq="${GlobalConstant.FLAG_N }"
										<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
							  				onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" onblur="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" 
							  				<c:set var="dateClass" value="dateClass"/>
										</c:if>
										class="${dateClass} validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input mer_input"
										onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" />
									</span>&#12288;
								</c:if>
								<!-- 大文本 -->
							<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumTextarea.id}">
								<c:set var="dateClass" value="" />
								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
									<c:set var="attrType" value="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }" />
								</c:if>
								<span title="${pdfn:getCodeTitle(attr.attrCode,commAttrCode) }">
									<input type="text" style="width:400px;"
									name="${attr.attrCode }_1" value="${value}"
									codeValues="${pdfn:getCodeValues(attr.attrCode,commAttrCode) }" attrType="${attrType }"  
									attrCode="${attr.attrCode}" elementSerialSeq="${GlobalConstant.FLAG_N }"
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
						  				onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" onblur="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" 
						  				<c:set var="dateClass" value="dateClass"/>
									</c:if>
									class="${dateClass} validate[${pdfn:getCondition(attr.attrCode,commAttrCode,commNormalValueKey,patient.sexId) }] input mer_input"
									onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" />
								</span>&#12288;
							</c:if>
							<!-- 单选/复选 -->
							<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or 
										  sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
								<c:set var="inputTypeId" value="${sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId }" />
								<c:forEach items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
									<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
									<input type="${inputTypeId }" name="${attr.attrCode }_1"
										<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if>
										onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);"
										value="${edcAttrCode.codeValue }" 
										attrCode="${attr.attrCode}" elementSerialSeq="${GlobalConstant.FLAG_N }"
										id="${attr.attrCode }_${edcAttrCode.codeValue}"
										attrType="${attrType }" />
									<label for="${attr.attrCode }_${edcAttrCode.codeValue}">${edcAttrCode.codeName}&#12288;</label>
									<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].codeNewLine eq GlobalConstant.FLAG_Y}">
										<br/>
									</c:if>
								</c:forEach>
							</c:if>
							<!-- 下拉-->
							<c:if
								test="${ sessionScope.projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
								<select name="${attr.attrCode }_1" attrCode="${ attr.attrCode }"
									onchange="doSave('${GlobalConstant.FLAG_N }','${attr.attrCode }',this);" 
										attrCode="${attr.attrCode}" elementSerialSeq="${GlobalConstant.FLAG_N }"
									class="input event_select" attrType="${attrType }">
									<option value=""></option>
									<c:forEach items="${ sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
										<c:set var="edcAttrCode" value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
										<option value="${edcAttrCode.codeValue }"
											<c:if test="${ edcAttrCode.codeValue == value}">selected</c:if>>${edcAttrCode.codeName}
										</option>
									</c:forEach>
								</select>
							</c:if>
								</div>
								<!-- 
								<c:if test="${sessionScope.projDescForm.attrMap[attr.attrCode].attrNewLine eq  GlobalConstant.FLAG_Y 
							or columnCount == '1'}">
								<div style="clear: both !important" attrName="${sessionScope.projDescForm.attrMap[attr.attrCode].attrName }"></div>
							</c:if>
								 -->
						</c:forEach>
						<div style="clear: both !important" ></div>
			</c:if>
		</c:forEach>
</body>