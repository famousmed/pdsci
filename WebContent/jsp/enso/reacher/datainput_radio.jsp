<c:set var="showEleName" value="${param.showEleName }" />
<c:set var="elementName" value="${param.elementName }" />
<c:set var="attrName" value="${param.attrName}" />
<c:set var="value" value="${param.value }" />
<c:set var="attrCode" value="${param.attrCode }" />
<c:set var="commCodeFlow" value="${param.commCodeFlow }" />
<c:set var="inputTypeId" value="${param.inputTypeId }" />

<div class="vote_meta_detail js_vote_type vote_meta_radio">
	<div class="frm_control_group">
		<label for="" class="frm_label" style="margin-top: -.1em; width: 8em">
			<c:if test="${showEleName}">
						${elementName}.
						</c:if> ${attrName }
		</label>
		<div class="frm_controls vote_meta_radio">
			<c:forEach
				items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}"
				var="code">
				<c:set var="edcAttrCode"
					value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />

				<label class="vote_${inputTypeId }_label frm_${inputTypeId }_label" onclick="radioCheckboxClick(this);" 
					for="" inputTypeId="${inputTypeId}"> <i class="icon_${inputTypeId }"></i> <span
					type="label_content">${edcAttrCode.codeName}</span> <input
					name="${attrCode }" elementSerialSeq="1"
					type="${inputTypeId }"
					<c:if test="${fn:indexOf(value,edcAttrCode.codeValue)>-1 }">checked="checked"</c:if>
					value="${edcAttrCode.codeValue }" class="frm_${inputTypeId }">
				</label>
				<!-- 
							<label class="frm_checkbox_label" for="">
								<i class="icon_checkbox"></i>
								<span type="label_content">${edcAttrCode.codeName}</span>
								<input type="checkbox"  class="frm_checkbox" value="${edcAttrCode.codeValue }" >
							</label>
							 -->
			</c:forEach>
			<p class="frm_msg fail" style="display: none">
				<span for="${attrCode}_1" class="frm_msg_content"
					style="display: inline;">错误描述</span>
			</p>
			<span class="frm_tips"></span>
		</div>
			
	</div>
</div>
