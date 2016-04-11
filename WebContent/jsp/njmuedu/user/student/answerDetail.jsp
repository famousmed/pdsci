<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <html>
    <head>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="userCenter" value="true"/>
</jsp:include>
</head>
<body style="background: none;">
  <!--registerMsg-m-->
     <div class="registerMsg-m2 fl" style="margin-left:0; width:100%;">
    	<div class="registerMsg-m-inner registerBgw">
        	<div class="registerMsg-tabs" style="background: none;padding:0 10px 20px;">
                <div class="module-content">
                <div style="text-align: left; line-height:40px; background:#d8e7f0;padding-left: 30px;font-size: 14px;">问：${question.questionContent}</div>
                	<ul>
                    	<li style="display:block" class="return">
   
                   	   		 <div class="video-info">
                                <dl id="dl_${question.questionFlow }" style="margin-left:0; width:100%;">
                                    <dd style="padding-left: 0; width:100%;">
                                        <div>
                                        <ul>
                                            <c:forEach items="${answerList}" var="answer">
                                            <li>
                                              <div class="fl infoT-l">
                                              <c:choose>
		          	                            <c:when test="${empty answer.user.userHeadImg }">
		  				                          <img class="t-face" src="<s:url value='/jsp/njmuedu/css/images/head-icon.png'/>" />
			  		                            </c:when>
			  		                            <c:otherwise>
			  			                          <img class="t-face" src="${sysCfgMap['upload_base_url']}${answer.user.userHeadImg}" />
			  		                            </c:otherwise>
 				                              </c:choose>
 				                              <br/>${answer.user.userName}
                                              </div>
                                               <div class="infoT2"> 
                                              <p class="p4" style="text-align: left;"><img src="<s:url value='/jsp/njmuedu/css/images/acion-off.png'/>" width="16" height="16" /><c:if test="${answer.answerUserFlow==param.teacherFlow }"><font color="green">[老师回复]</font>&nbsp;</c:if>${answer.answerContent }</p>
                                              <p class="p3" style="text-align: left;"><span class="fr">${pdfn:signBetweenTowDate(pdfn:getCurrDateTime("yyyyMMddHHmmss"),answer.answerTime) }</span></p>                                  
                                              </div>
                                             </li>
                                             </c:forEach>
                                             <c:if test="${empty answerList }">
                                             <li>
                                             	 <img src="<s:url value='/jsp/njmuedu/css/images/tanhao.png'/>"/>           
                         						 <p>暂无回复！</p>
                                             </li>
                                             </c:if>
                                        </ul>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                        </li>
                  </ul>
                </div>
          </div>
        </div>
    </div> 
     <script>
</script> 
</body></html>