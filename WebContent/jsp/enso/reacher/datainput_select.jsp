<c:set var="showEleName" value="${param.showEleName }" />
<c:set var="elementName" value="${param.elementName }" />
<c:set var="attrName" value="${param.attrName}" />
<c:set var="value" value="${param.value }" />
<c:set var="attrCode" value="${param.attrCode }" />
<c:set var="commCodeFlow" value="${param.commCodeFlow }" />

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
					<label class="jsBtLabel jsBtLabelSel">${value}</label> <i
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
			<p class="frm_msg fail" style="display: none">
				<span for="${attrCode}_1" class="frm_msg_content"
					style="display: inline;">错误描述</span>
			</p>
			<span class="frm_tips"></span>

		</div>
	</div>
</div>
