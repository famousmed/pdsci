<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	var courseTypeId=$("#courseTypeId").val();
	if(courseTypeId != ""){
		$(".cType").hide();
	}else{
		$(".cType").show();
	}
});
</script>
<!--content-->
<!--  <div class="register clearfix">-->
   <!--registerMsg-m-->
    <div class="registerMsg-m fl">
    	<div class="registerMsg-m-inner registerBgg">
        	<div class="registerMsg-tabs"> 
                <div class="module-tabs" style="display: block;">
                	<ul class="fl type">
                        <li <c:if test="${(param.studyStatus eq eduStudyStatusEnumUnderway.id) or (empty param.studyStatus) }">class="on"</c:if> onclick="checkStatus('${eduStudyStatusEnumUnderway.id}')">在学</li>
                        <li <c:if test="${param.studyStatus eq eduStudyStatusEnumFinish.id }">class="on"</c:if> onclick="checkStatus('${eduStudyStatusEnumFinish.id}')">学完</li>
                     </ul>
                     <ul class="fr">
                           <li  onclick="selectCourseTypeId('');"><a <c:if test="${(empty param.courseTypeId) or (param.courseTypeId=='')}">class="hove1"</c:if>>全部</a></li>
                        <c:forEach items="${eduCourseTypeEnumList }" var="type">
                           <li  onclick="selectCourseTypeId('${type.id}');"><a  <c:if test="${param.courseTypeId eq type.id }">class="hove1"</c:if>>${type.name }</a></li>
                     	</c:forEach>
                     </ul>
                </div>
                <div class="module-content">
                  
                	<ul>
                	<c:if test="${empty courseList }">
                	      <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂无课程！</p>
							</div>
                	   </c:if>
                	   <c:forEach items="${courseList }" var="course">
                    	<li style="display:block">
                   	   	   <a href="<s:url value='/edu/course/stuCourseDetail/${course.courseFlow }'/>">
                   	   		    <img class="fl" src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/edu/css/images/loginbar.jpg"/>'" width="218" height="141" /> 
                           </a>
                      	 
                      	 
                        	<dl class="fl">
                            	<dt>
                            	<a href="<s:url value='/edu/course/stuCourseDetail/${course.courseFlow }'/>">${course.courseName }</a>
                            	</dt>
                                <dd>
                                	<p>共${noParentMap[course.courseFlow] }章${parentMap[course.courseFlow] }节&#12288;&#12288;&#12288;&#12288;
                                	<c:choose>
                                <c:when test="${course.courseTypeId eq eduCourseTypeEnumRequired.id }">
                                <input class="r-bnt cType" type="button" value="${course.courseTypeName }" />
                                </c:when>
                                <c:when test="${course.courseTypeId eq eduCourseTypeEnumOptional.id }">
                                <input class="i-bnt cType" type="button" value="${course.courseTypeName }" />
                                </c:when>
                                <c:when test="${course.courseTypeId eq eduCourseTypeEnumPublic.id }">
                                <input class="b-bnt cType" type="button" value="${course.courseTypeName }" />
                                </c:when>
                                </c:choose>
                                	</p>
                                    <p>
                                     <c:choose>
                                       <c:when test="${(param.studyStatus eq eduStudyStatusEnumUnderway.id) or (empty param.studyStatus)}">
                                          <c:choose>
                                          <c:when test="${not empty underWayChapterMap[course.courseFlow] }">
                                                                                                                                     当前正在学习：${underWayChapterMap[course.courseFlow].chapterName }
                                          </c:when>
                                          <c:otherwise>
                                                                                                                                     尚未开始学习
                                          </c:otherwise>
                                          </c:choose> 
                                       </c:when>
                                       <c:when test="${param.studyStatus eq eduStudyStatusEnumFinish.id }">
                                                                                                                                    所有章节已学完
                                       </c:when>
                                     </c:choose>
                                    </p>
                                    <div>
                                      <img src="<s:url value='/jsp/edu/css/images/video-icon.jpg'/>" width="12" height="10" />
                                      <div class="graph"><strong id="bar" style="width:<c:out value="${scheduleMap[course.courseFlow] }" default="0"/>%;"></strong></div>&nbsp;<c:out value="${scheduleMap[course.courseFlow] }" default="0"/>%
                                  </div>
                                </dd>
                            </dl>
                            <a href="<s:url value='/edu/course/stuCourseDetail/${course.courseFlow }'/>"><input type="button" class="btn" value="进入课堂" /></a>
                        </li>
                       </c:forEach>  
                    </ul>
                </div>
            </div>
            </div>
            </div>
           <!--  </div>--> 
         
   <!--/registerMsg-m--> 

