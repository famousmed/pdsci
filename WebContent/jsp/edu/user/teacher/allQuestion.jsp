<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="userCenter" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
  <!--registerMsg-m-->
     <div class="registerMsg-m2 fl">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs">
            
            	<div class="module-tabs">
                	<ul class="fl type">
                        <li <c:if test="${(param.questionStatusId eq eduQuestionStatusEnumUnanswered.id) or (empty param.questionStatusId) }">class="on"</c:if>onclick="changeQuestionStatus('${eduQuestionStatusEnumUnanswered.id}')">等待回复</li>
                        <li <c:if test="${param.questionStatusId eq eduQuestionStatusEnumAnswered.id}">class="on"</c:if> onclick="changeQuestionStatus('${eduQuestionStatusEnumAnswered.id}')">已回复</li>
                     </ul>
                    
                </div>
                <div class="module-content">
                	<ul>
                    	<li style="display:block" class="return">
   
                   	   		 <div class="video-info">
                   	   		   <c:if test="${empty questionList }">
                   	   		      <ul>
                   	   		         <li class="nomessage" style="display:block;background:none;border-bottom:none;" >
                	                  <img src="<s:url value='/jsp/edu/css/images/tanhao.png'/>"/> 
                	                  <p>暂无问题！</p>
                	                 </li>
                   	   		      </ul>
                   	   		   </c:if>
                               <c:forEach items="${questionList }" var="question">
                                <dl id="dl_${question.questionFlow }">
                                    <dt>
                                        <div class="fl infoT-l">
			  			                    <img class="t-face" src="${sysCfgMap['upload_base_url']}${eduMap[question.userFlow].userImg}" title="${stuMap[question.userFlow].orgName}&#10;${eduMap[question.userFlow].majorName}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'" />
                                        <br/>${stuMap[question.userFlow].userName }
                                        </div> 
                                        <div class="fr infoT-r">
                                            <p class="p1"><img src="<s:url value='/jsp/edu/css/images/aicon.png'/>" width="16" height="16" />${question.questionContent }</p>
                                            <p class="p2">
                                            <span class="fr blue">
                                              <a href="javascript:void(0);" id="a_${question.questionFlow }" onclick="showReturn('${question.questionFlow }',this);">展开回复</a>&nbsp;|
                                              <c:choose>
                                              <c:when test="${question.quintessence eq GlobalConstant.FLAG_Y }">
                                                 <a href="javascript:void(0);"  onclick="setNQuintessence('${question.questionFlow }',this);">取消推荐</a>
                                                 <a href="javascript:void(0);" style="display: none;" onclick="setYQuintessence('${question.questionFlow }',this);">设为推荐</a>
                                              </c:when>
                                              <c:otherwise>
                                                 <a href="javascript:void(0);" style="display: none;" onclick="setNQuintessence('${question.questionFlow }',this);">取消推荐</a>
                                                 <a href="javascript:void(0);" onclick="setYQuintessence('${question.questionFlow }',this);">设为推荐</a>
                                              </c:otherwise>
                                              </c:choose>
                                              
                                            </span>
                                            ${pdfn:signBetweenTowDate(pdfn:getCurrDateTime("yyyyMMddHHmmss"),question.questionTime) }
                                            <a href="<s:url value='/edu/course/chapter/${courseChapterMap[question.courseFlow][question.chapterFlow].chapterFlow }'/>" target="_blank">
                                                                                                                                          源自：${courseMap[question.courseFlow].courseName }&nbsp;
                                              ${courseChapterMap[question.courseFlow][courseChapterMap[question.courseFlow][question.chapterFlow].parentChapterFlow].chapterName }&nbsp;
                                              ${courseChapterMap[question.courseFlow][question.chapterFlow].chapterName }
                                              </a></p>
                                        </div>
                                        
                                        <div class="best" id="img_${question.questionFlow }" <c:if test="${question.quintessence != GlobalConstant.FLAG_Y }">style="display:none;"</c:if>></div>
                                    </dt>
                                    <dd>
                                        
                                        <div id="answer_${question.questionFlow }" style="display: none;">
                                        <ul>
                                            <c:forEach items="${answerMap[question.questionFlow] }" var="answer">
                                            <c:if test="${answer.answerUserFlow eq sessionScope.currUser.userFlow }">
                                            <li>
                                              <div class="fl infoT-l">
			  			                          <img class="t-face" src="${sysCfgMap['upload_base_url']}${sessionScope[GlobalConstant.CURR_EDU_USER].userImg}" onerror="this.src='<s:url value="/jsp/edu/css/images/head-icon.png"/>'" />
                                              <br/>${sessionScope.currUser.userName}
                                              </div>
                                               <div class="infoT2"> 
                                              <p class="p4"><img src="<s:url value='/jsp/edu/css/images/acion-off.png'/>" width="16" height="16" />${answer.answerContent }</p>
                                              <p class="p3"><span class="fr">${pdfn:signBetweenTowDate(pdfn:getCurrDateTime("yyyyMMddHHmmss"),answer.answerTime) }</span></p>                                  
                                              </div>
                                             </li>
                                             </c:if>
                                             </c:forEach>
                                        </ul>
                                         <form id="aForm_${question.questionFlow }" style="position: relative;">
                                        
                                        <div class="huif clearfix">
                                            <textarea name="answerContent" class="validate[required]" placeholder="请输入您的回复"></textarea>
                                            <input type="button" class="fb-btn fr" value="提交回复" onclick="submitAnswer('${question.questionFlow }');"/>
                                        </div>
                                        </form>
                                        </div>
                                        
                                    </dd>
                                    
                                </dl>
                               </c:forEach>
        
                            </div>
                        </li>
                      
                      
                  </ul>
                </div>
          </div>
        </div>
    </div> 
     <script>
</script> 
