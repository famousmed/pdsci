
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
	<c:forEach items="${patientList}" var="patient">
	<tr>
		<td style="padding-left: 10px; text-align: left;">受试者姓名：${patient.patientName }</td>
		<td style="padding-left: 10px; text-align: left;">
			联系方式：${patient.patientPhone }</td>
		<td style="padding-left: 10px; text-align: left;">访视次数：1/5&nbsp;(上次访视：${patientVisitMap[patient.patientFlow]['beforeVisit'].visitDate})</td>
		<td style="padding-left: 10px; text-align: left;">访视窗：
		<c:if test="${!empty patientVisitMap[patient.patientFlow]['nextWindow'] && !empty patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitLeft && !empty patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitRight}">
								${patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitLeft}<div  style="Line-height:8px;">~</div>${patientVisitMap[patient.patientFlow]['nextWindow'].windowVisitRight}
		</c:if>
		</td>
		<td><a href="javascript:visit('${patient.patientFlow }');" title="访视">>></a></td>
	</tr>
	</c:forEach>
</table>
