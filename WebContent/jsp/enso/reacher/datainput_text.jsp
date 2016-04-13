<c:set var="showEleName" value="${param.showEleName }" />
<c:set var="elementName" value="${param.elementName }" />
<c:set var="attrName" value="${param.attrName}" />
<c:set var="value" value="${param.value }" />
<c:set var="attrCode" value="${param.attrCode }" />

<div class="vote_meta_detail" style="padding-top: 10px;">
	<div class="frm_control_group">
		<label for="" class="frm_label"
			style="margin-top: -.3em; width: 8em"> <c:if
				test="${showEleName}">
${elementName }.
</c:if> ${attrName }
		</label>
		<div class="frm_controls">
			<span
				class="frm_input_box with_counter counter_in append vote_title js_question_title count" style="width: 300px;">
				<input autofocus="" type="text" placeholder=""
				class="frm_input js_option_input frm_msg_content"
				name="${attrCode}" elementSerialSeq="1" value="${value }"
				autocomplete="off"> <em
				class="frm_input_append frm_counter"></em>
			</span>
			<p class="frm_msg fail" style="display: none;">
				<span for="${attrCode}" class="frm_msg_content"
					style="display: inline;">错误描述</span>
			</p>
			<span class="frm_tips"></span>
		</div>
	</div>
</div>
