<table width="100%" cellpadding="0" cellspacing="0" class="basic">
<c:if test="${not empty trackFormList }">
                            <tr>
								<th colspan="3" style="text-align: left; padding-left: 10px">跟踪记录</th>
							</tr>
							<c:forEach items="${trackFormList }" var="form" varStatus="num">
							<tr>
					         <td colspan="3">
					       ${num.count }、记录日期：${form.recordDate }&#12288;&#12288;
					                    记录人：${form.recordUserName }&#12288;&#12288;
					       </tr>
					        <tr> 
						       <td>记录内容：${form.trackDate }&#12288;${form.trackContent }</td>
					        </tr>
					        </c:forEach>
					        </c:if>
</table>