<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <div class="registerMsg-r-bottom-inner">
      <div class="module-tabs-right">
         <h3 class="fl">课程推荐</h3>
         <ul class="fr">
           <li><a <c:if test="${(empty param.sortType) or (param.sortType eq 'score')}">class="hove1"</c:if> href="javascript:void(0);" onclick="changeRecommendSort('score');">评分</a></li>
           <li><a <c:if test="${param.sortType eq 'choose'}">class="hove1"</c:if> href="javascript:void(0);" onclick="changeRecommendSort('choose');">选课人数</a></li>
         </ul>
       </div>
                	<ul class="asd">
                	<c:if test="${empty recommendCourse }">
                	      <div class="nomessage wz" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂无课程！</p>
							</div>
                	   </c:if>  
           
                 <c:forEach items="${recommendCourse }" var="course">
               	  <li >
               	     <a href="<s:url value='/edu/course/stuCourseDetail/${course.courseFlow }'/>">
                   	   		<img class="fl" src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/edu/css/images/loginbar.jpg"/>'"  width="93" height="65" /> 
               	     </a>
                     <p><a href="<s:url value='/edu/course/stuCourseDetail/${course.courseFlow }'/>">${course.courseName } </a></p>
                     <p>
                     <c:if test="${(empty param.sortType) or (param.sortType eq 'score')}">
                                                                  评分：${course.avgScore }
                     </c:if>
                     <c:if test="${param.sortType eq 'choose'}">
                                                                  人数：${course.chooseCount }                                        
                     </c:if>
                     </p>
                      <c:choose>
                         <c:when test="${course.courseTypeId eq eduCourseTypeEnumRequired.id }">
                            <input class="r-bnt" type="button" value="${course.courseTypeName }" />
                         </c:when>
                         <c:when test="${course.courseTypeId eq eduCourseTypeEnumOptional.id }">
                            <input class="i-bnt" type="button" value="${course.courseTypeName }" />
                         </c:when>
                         <c:when test="${course.courseTypeId eq eduCourseTypeEnumPublic.id }">
                            <input class="b-bnt" type="button" value="${course.courseTypeName }" />
                         </c:when>
                      </c:choose>
                  </li>
                  </c:forEach>
              </ul> 
                    
      </div>
              





	