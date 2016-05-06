<div class="faqscene_tab_bd js_faqscene_content"
	style="display:block ;height: 173px;" id="233">
	<ul>
		<c:forEach items="${ eventList}" var="event">
			<li><a target="_blank"
				href="javascript:scrollToModule('${event.attrCode }_div');">${event.moduleName }.${event.elementName }.${event.attrName}</a>
				<span style="float: right;padding-right: 20px;text-align: left;">${empty event.attrValue?'未录入': pdfn:getAttrValue(sessionScope.projDescForm,event.attrCode,event.attrValue) }--->${pdfn:getAttrValue(sessionScope.projDescForm,event.attrCode,event.attrEventValue)}</span>
				</li>
				<li style="text-indent: 20px;color: #888;list-style-type: none;" title="${event.eventNote }">
					修改信息：${pdfn:transDate(event.eventTime)} &#12288;${event.eventUserName }&#12288;
					${event.eventNote}
				</li>
		</c:forEach>
		<c:if test="${empty eventList }">
			<li>暂无澄清数据 </li>
			<li>数据提交后修改自动留痕 </li>
		</c:if>
	</ul>
</div>
