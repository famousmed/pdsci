       <c:forEach items="${testPaperList }" var="paper">
               <tr >
                 <td><input type="checkbox" name="courseTestCount" id="check_${paper.paperFlow }" 
                 <c:if test="${pdfn:contain(paper.paperFlow,courseTestPaperFlowList) }">checked</c:if>
                 onclick="bindTest('${paper.paperFlow }','${param.chapterFlow }');" value="N"/>
                 <input type="hidden" id="testCount" value="${fn:length(testPaperList) }"/>
                 </td>
                 <td>${paper.paperName }</td>
                 <td>${paper.testTime }</td>
                 <td>${paper.paperTypeName }</td>
                 <td>${paper.paperUserName }</td>
                 <td>${paper.totleScore }</td>
                 <td>${paper.passScore}</td>
                 <td>
                    <a href="javascript:void(0)" onclick="testResultInfo('${paper.paperFlow}');">[考试情况]</a>
                 </td>
               </tr>
               </c:forEach>
               <c:if test="${empty testPaperList }">
                  <tr>
                    <td colspan="8">无记录</td>
                  </tr>
               </c:if>