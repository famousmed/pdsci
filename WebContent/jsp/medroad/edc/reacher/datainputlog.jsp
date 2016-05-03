<div class="faqscene_tab_bd js_faqscene_content"
	style="display:block ;height: 173px;" id="233">
	<ul>
		<c:forEach items="${logList}" var="log">
			<li><a target="_blank"
				href="javascript:void(0);">${log.logDesc}&#12288;</a>
				<span style="float: right;padding-right: 20px;">${pdfn:transDateTime(log.logTime)}</span>
			</li>
		</c:forEach>
	</ul>
</div>
