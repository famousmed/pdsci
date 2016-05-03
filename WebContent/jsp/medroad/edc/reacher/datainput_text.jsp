<c:set var="showEleName" value="${param.showEleName }" />
<c:set var="moduleCode" value="${param.moduleCode }" />
<c:set var="elementName" value="${param.elementName }" />
<c:set var="attrName" value="${param.attrName}" />
<c:set var="value" value="${param.value }" />
<c:set var="attrCode" value="${param.attrCode }" />
<c:set var="attrUnit" value="${param.attrUnit }" />
<c:set var="attrNote" value="${param.attrNote }" />
<div class="vote_meta_detail ${attrCode}_div" style="padding-top: 10px;">
	<div class="frm_control_group">
		<label for="" class="frm_label"
			style="margin-top: -.1em; width: 8em"> <c:if
				test="${showEleName}">
${elementName }.
</c:if> ${attrName }
		</label>
		<div class="frm_controls">
			<span 
				class="frm_input_box with_counter counter_in append vote_title js_question_title count" >
				<input autofocus="" type="text" placeholder=""
				class="frm_input js_option_input frm_msg_content" 
				<c:if test="${edcPatientVisit.inputOperStatusId == edcInputStatusEnumSubmit.id}">
					readonly="readonly" 
				</c:if>
				name="${attrCode}" elementSerialSeq="1" value="${value }"
				autocomplete="off"> <em
				class="frm_input_append frm_counter">${attrUnit }</em>
			</span>
			<c:if test="${edcPatientVisit.inputOperStatusId == edcInputStatusEnumSubmit.id}">
			<i class="icon_msg_mini ask" attrCode='${attrCode }' moduleCode='${ moduleCode}' style="margin-left: 5px;cursor: pointer;" id="js_ask_trend"></i>
			</c:if>
			<span class="frm_tips">${attrNote}</span>
			<p class="frm_msg fail" style="display: none;">
				<span for="${attrCode}" class="frm_msg_content"
					style="display: inline;">错误描述</span>
			</p>
			
		</div>
	</div>
</div>
