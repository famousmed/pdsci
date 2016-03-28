<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; margin-top:0;border:0;">
	           <colgroup>
   		         <col width="33%"/>
   		         <col width="33%"/>
   		         <col width="33%"/>
   		       </colgroup>
	             <tbody>
	              <c:forEach items="${resultList }" var="result">
	               <tr>
	                <td>${pdfn:transDateTimeForPattern(result.createTime,"yyyyMMddHHmmss","yyyy-MM-dd") }</td>
	                <td>${result.totleScore }</td>
	                <td>
	                 <c:if test="${result.passFlag eq 'Y'}">是</c:if>
	                 <c:if test="${result.passFlag eq 'N'}">否</c:if>
	                </td>
	               </tr> 
	              </c:forEach>
	              <c:if test="${empty resultList }">
	                 <tr>
	                   <td colspan="4">无记录</td>
	                 </tr>
	              </c:if>
	             </tbody>
	          </table>