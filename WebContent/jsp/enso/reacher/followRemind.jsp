
<h3>
	随访提醒&#12288;
	<!-- 
           <span style="float: right">
          <label><input type="checkbox" checked="checked">7天</input></label>
          &#12288;<label><input type="checkbox">10天</input></label>
         	&#12288;<label> <input type="checkbox">15天</input></label>
          </span>
           -->

</h3>
<table border="0" cellpadding="0" cellspacing="0" class="grid"
	style="border-top: 0px;">
	<c:set var="count" value="0"/>
	<c:forEach items="${patientVisitMap}" var="map">
	
		<c:if test="${pdfn:signDaysBetweenTowDate(map.value.windowVisitLeft,pdfn:getCurrDate())<=3
			or pdfn:getCurrDate()>map.value.windowVisitLeft
		}">
			<tr>
				<td style="padding-left: 10px; text-align: left;">
				姓名：${map.value.patientName }</td>
				<td style="padding-left: 10px; text-align: left;">
					联系方式：${patientMap[map.key].patientPhone }</td>
				<td style="padding-left: 10px; text-align: left;">上次访视：${map.value.visitDate }</td>
				<td style="padding-left: 10px; text-align: left;">访视窗：
				${map.value.windowVisitLeft }~${map.value.windowVisitRight}
				&#12288;&#12288;
					<c:choose>
						<c:when test="${pdfn:getCurrDate()>map.value.windowVisitLeft }">访视中...</c:when>
						<c:otherwise>距离${pdfn:signDaysBetweenTowDate(map.value.windowVisitLeft,pdfn:getCurrDate()) }天</c:otherwise>
					</c:choose>
				</td>
				<td><a href="javascript:visit('${map.key }');" title="访视">>></a></td>
			</tr>
			<c:set var="count" value="${count+1 }"/>
		</c:if>
	</c:forEach>
	<c:if test="${count==0 }">
		<tr><td style="text-align: left;padding-left:  40px;">暂无提醒</td></tr>
	</c:if>
</table>
