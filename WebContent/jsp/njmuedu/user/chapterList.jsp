<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<c:if test="${empty courseExt.chapterList }">
<div class="learnchapter learnchapter-active">
     <center><ul><li>该课程尚未添加章节！</li></ul></center>
</div>
</c:if>
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
                        <a href="<s:url value='/njmuedu/course/chapter/${chapter.chapterFlow }'/>">${chapter.chapterNo}&#12288;${chapter.chapterName } <c:if test="${! empty chapter.chapterTime }">（${chapter.chapterTime }）</c:if></a>
                       </li>
                      </ul>
                    </c:if>
                   
           </c:otherwise>
        </c:choose>
   
</div>
</c:forEach>
