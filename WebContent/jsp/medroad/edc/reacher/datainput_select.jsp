<c:set var="showEleName" value="${param.showEleName }" />
<c:set var="moduleCode" value="${param.moduleCode }" />
<c:set var="elementName" value="${param.elementName }" />
<c:set var="attrName" value="${param.attrName}" />
<c:set var="value" value="${param.value }" />
<c:set var="attrCode" value="${param.attrCode }" />
<c:set var="commCodeFlow" value="${param.commCodeFlow }" />
<c:set var="attrUnit" value="${param.attrUnit }" />
<c:set var="attrNote" value="${param.attrNote }" />

<div class="vote_meta_detail" style="padding-top: 10px;">
	<div class="frm_control_group">
		<label for="" class="frm_label"
			style="margin-top: -.3em; width: 8em"> <c:if
				test="${showEleName}">
${elementName }.
</c:if> ${attrName }
		</label>
		<div class="frm_controls">
			<div class="dropdown_menu time" style="width: 300px;">
				<a href="javascript:;" class="btn dropdown_switch jsDropdownBt">
					<label class="jsBtLabel jsBtLabelSel ${attrCode}_label">${value}</label> <i
					class="arrow"></i>
				</a>
				<div class="dropdown_data_container jsDropdownList"
					style="display: none;">
					<ul class="dropdown_data_list">
						<li class="dropdown_data_item "><a onclick="return false;"
							href="javascript:;" class="jsDropdownItem" data-value=""
							data-index="0" data-name="00">&#12288;</a></li>
						<c:forEach
							items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}"
							var="code">
							<c:set var="edcAttrCode"
								value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />
							<li class="dropdown_data_item "><a onclick="return false;"
								href="javascript:;"
								class="jsDropdownItem <c:if test="${value==edcAttrCode.codeValue }">selected</c:if>"
								data-value="${edcAttrCode.codeValue }" data-index=""
								data-name="${edcAttrCode.codeName }">${edcAttrCode.codeName}</a>
							</li>
						</c:forEach>

					</ul>
				</div>
				<input type="hidden" class="jsDropdownHidden"
					name="${attrCode }" value="${value }" elementSerialSeq="1" />
			</div>
			<c:if test="${edcPatientVisit.inputOperStatusId == edcInputStatusEnumSubmit.id}">
			<i class="icon_msg_mini ask" attrCode='${attrCode }' moduleCode='${ moduleCode}' style="margin-left: 5px;cursor: pointer;" id="js_ask_trend"></i>
			</c:if>
			<span class="frm_tips">${attrNote}</span>
			<p class="frm_msg fail" style="display: none">
				<span for="${attrCode}_1" class="frm_msg_content"
					style="display: inline;">错误描述</span>
			</p>
			

		</div>
	</div>
</div>
