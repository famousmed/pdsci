<c:if test="${empty courseExt.chapterList }">
<div class="learnchapter learnchapter-active">
     <center><ul><li>该课程尚未添加章节！</li></ul></center>
</div>
</c:if>
<c:choose>
<c:when test="${sysCfgMap['njmuedu_force_order_play']==GlobalConstant.FLAG_N }">
<c:forEach items="${courseExt.chapterList }" var="chapter">
 <div class="learnchapter">
        <c:choose>
           <c:when test="${empty chapter.parentChapterFlow }">
                <c:set var="parentNode" value="${chapter }"></c:set>
                <h3 onclick="showAndHide('${parentNode.chapterFlow}',this);"><i class="hasOpenOn"></i><span></span><strong>${chapter.chapterNo}.&nbsp; ${chapter.chapterName }</strong></h3>
           </c:when>
           <c:otherwise>
             
              <c:if test="${chapter.parentChapterFlow eq parentNode.chapterFlow}">
                <ul class="learnchapter-item clearfix sonNode_${parentNode.chapterFlow }" >
       	              <li>
       	                 <c:choose>
        	                 <c:when test="${scheduleMap[chapter.chapterFlow].studyStatusId == njmuEduStudyStatusEnumFinish.id }">
                             <i class="fr end"><c:out value="${scheduleMap[chapter.chapterFlow].studyStatusName }" default="${njmuEduStudyStatusEnumNotStarted.name }"/></i>
                           </c:when>
                            <c:when test="${scheduleMap[chapter.chapterFlow].studyStatusId == njmuEduStudyStatusEnumUnderway.id }">
                             <i class="fr in"><c:out value="${scheduleMap[chapter.chapterFlow].studyStatusName }" default="${njmuEduStudyStatusEnumNotStarted.name }"/></i>
                           </c:when>
                           <c:otherwise>
                             <i class="fr"><c:out value="${scheduleMap[chapter.chapterFlow].studyStatusName }" default="${njmuEduStudyStatusEnumNotStarted.name }"/></i>
                           </c:otherwise>
                         </c:choose>
                        <a href="<s:url value='/njmuedu/course/chapter/${chapter.chapterFlow }'/>">${chapter.chapterNo}&#12288;${chapter.chapterName } <c:if test="${! empty chapter.chapterTime }">（${chapter.chapterTime }）</c:if></a>
                       </li>
                      </ul>
                    </c:if>
                   
           </c:otherwise>
        </c:choose>
   
</div>
</c:forEach>
</c:when>
<c:otherwise>
<c:forEach items="${courseExt.chapterList }" var="chapter" varStatus="num">
  <div class="learnchapter">
         <c:choose>
            <c:when test="${empty chapter.parentChapterFlow }">
                 <c:set var="parentNode" value="${chapter }"></c:set>
                 <h3 onclick="showAndHide('${parentNode.chapterFlow}',this);" style="cursor: pointer;"><i class="hasOpenOn"></i><span></span><strong>${chapter.chapterNo}.&nbsp;${chapter.chapterName }</strong></h3>
            </c:when>
            <c:otherwise>
              
               <c:if test="${chapter.parentChapterFlow eq parentNode.chapterFlow}">
                 <ul class="learnchapter-item clearfix sonNode_${parentNode.chapterFlow }" >
        	              <li>
        	               <c:choose>
        	                 <c:when test="${scheduleMap[chapter.chapterFlow].studyStatusId == njmuEduStudyStatusEnumFinish.id }">
                             <i class="fr end"><c:out value="${scheduleMap[chapter.chapterFlow].studyStatusName }" default="${njmuEduStudyStatusEnumNotStarted.name }"/></i>
                           </c:when>
                            <c:when test="${scheduleMap[chapter.chapterFlow].studyStatusId == njmuEduStudyStatusEnumUnderway.id }">
                             <i class="fr in"><c:out value="${scheduleMap[chapter.chapterFlow].studyStatusName }" default="${njmuEduStudyStatusEnumNotStarted.name }"/></i>
                           </c:when>
                           <c:otherwise>
                             <i class="fr"><c:out value="${scheduleMap[chapter.chapterFlow].studyStatusName }" default="${njmuEduStudyStatusEnumNotStarted.name }"/></i>
                           </c:otherwise>
                         </c:choose>
                         <a <c:if test="${scheduleMap[chapter.chapterFlow].studyStatusId!=njmuEduStudyStatusEnumFinish.id }">onclick="checkChapter('${chapter.chapterFlow }','${courseExt.courseFlow }');" href="javascript:void(0);"</c:if>
                         	<c:if test="${scheduleMap[chapter.chapterFlow].studyStatusId==njmuEduStudyStatusEnumFinish.id }">href="<s:url value='/njmuedu/course/chapter/${chapter.chapterFlow }'/>"</c:if> >
			${chapter.chapterNo}&#12288;${chapter.chapterName}<c:if test="${! empty chapter.chapterTime }">（${chapter.chapterTime }）</c:if> 
                         </a>
                        </li>
                       </ul>
                     </c:if>
            </c:otherwise>
         </c:choose>
</div>
</c:forEach>
</c:otherwise>
</c:choose>

