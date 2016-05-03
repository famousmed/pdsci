<c:set var="showEleName" value="${param.showEleName }" />
<c:set var="elementName" value="${param.elementName }" />
<c:set var="moduleCode" value="${param.moduleCode }" />
<c:set var="attrName" value="${param.attrName}" />
<c:set var="value" value="${param.value }" />
<c:set var="attrCode" value="${param.attrCode }" />
<c:set var="commCodeFlow" value="${param.commCodeFlow }" />
<c:set var="inputTypeId" value="${param.inputTypeId }" />
<c:set var="attrUnit" value="${param.attrUnit }" />
<c:set var="attrNote" value="${param.attrNote }" />

<div class="vote_meta_detail js_vote_type vote_meta_radio">
	<div class="frm_control_group">
		<label for="" class="frm_label" style="margin-top: -.1em; width: 8em">
			<c:if test="${showEleName}">
						${elementName}.
						</c:if> ${attrName }
		</label>
		<div class="frm_controls ">
			<span style="width: 300px;display:inline-block;">
			<c:forEach
				items="${sessionScope.projDescForm.visitAttrCodeMap[commCodeFlow]}"
				var="code">
				<c:set var="edcAttrCode"
					value="${sessionScope.projDescForm.codeMap[code.codeFlow]}" />

				<label class="vote_${inputTypeId }_label frm_${inputTypeId }_label ${attrCode}_${edcAttrCode.codeValue}_label" 
					for="" inputTypeId="${inputTypeId}"> <i class="icon_${inputTypeId }"></i> <span
					type="label_content">${edcAttrCode.codeName}</span>
				<input
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
			</span>
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
