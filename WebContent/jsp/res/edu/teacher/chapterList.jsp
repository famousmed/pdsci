<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%;">
	<colgroup>
	    <col width="25%" />
		<col width="25%" />
		<col width="25%" />
		<col width="25%" />
	</colgroup>
	<c:forEach items="${chapterList}" var="chapter">
		<tr style="height: 40px;">
		    <td>${chapter.chapterName}</td>
			<td>${chapter.chapterCredit}</td>
			<td>
			   <c:if test="${map[chapter.chapterFlow] eq GlobalConstant.FLAG_Y}">是</c:if>
			   <c:if test="${map[chapter.chapterFlow] eq GlobalConstant.FLAG_N}">否</c:if>
			</td>
			<td>
			    [<a href="javascript:void(0);" onclick="chapterInfo('${chapter.chapterFlow}')" style="cursor: pointer;">查看</a>]
				[<a href="javascript:void(0);" style="cursor: pointer;">选择试卷</a>]
			</td>
		</tr>
	</c:forEach>
	<c:if test="${empty chapterList}">
		<tr style="height: 40px;">
			<td colspan="5">无记录</td>
		</tr>
	</c:if>
</table>