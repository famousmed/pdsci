<%@ include file="/jsp/jspf/prelude.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<div class="content cbody clearfix">
 <div class="right fr">
     <!--发现课程-->
 	<div class="wrap">
 	<%--  <form id="searchForm">
 	  <input type="hidden" id="sort" name="sort" />
 	  <input type="hidden" id="courseName" name="courseName"/>
 	  <input type="hidden" id="courseMajorId" name="courseMajorId" value="${param.courseMajorId }"/>
 	 </form> --%>
     	<div class="courseBg" >
        	<div class="title clearfix">
              	<h3 class="fl" style="border:none;"><img src="<s:url value='/jsp/edu/css/images/credit.png'/>" />已获学分课程</h3>
                <div class="title-r fr">
                	 
                <%-- 	<div class="searchBox fl">
                	   <input type="text"  value="${param.courseName }" placeholder="课程搜索" onchange="changeCourseName(this);"/>
                	   <img onclick="loadCourse();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
                	</div> --%>
                	
                    <%-- <div class="tabs-title  module-tabs fl">
                    	<ul>
                        	<li <c:if test="${(param.sort=='create_time') or (empty param.sort) }">class="on"</c:if> id="create_time" onclick="changeSort('create_time');"><a href="javascript:void(0)" >最新</a></li>
                            <li <c:if test="${param.sort=='course_order' }">class="on"</c:if>id="course_order" onclick="changeSort('course_order');"><a href="javascript:void(0)" >最热</a></li>
                        </ul>
                    </div> --%>
                </div>
              </div>
              <div class="courseList-content allCourse">
                    <%-- <ul style="display:block;" >
                	   <c:if test="${empty courseList }">
                	        <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂未获得学分！</p>
							</div>
                	   </c:if>
                       <c:forEach items="${courseList }" var="course">
                    	<li class="course">
                   	    	<a href="javascript:void(0);" onclick="checkRole('${course.courseFlow }');">
                   	    	<c:choose>
                   	    	  <c:when test="${not empty course.courseImg}">
                   	    	    <img src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" width="218" height="141" /> 
                              </c:when>
                              <c:otherwise>
                                <img src="<s:url value='/jsp/edu/css/images/loginbar.jpg'/>" width="218" height="141" /> 
                              </c:otherwise>
                            </c:choose>
                            </a>
                            <dl>
                            	<dt><a href="javascript:void(0);" onclick="checkRole('${course.courseFlow }');">${course.courseName }</a></dt>
                                <dd>
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
                                </dd>
                                <dd><span class="fr"><img src="<s:url value='/jsp/edu/css/images/head-icon1.jpg'/>" width="18" height="14" /><a href="">查看评分规则</a></span>学分：<c:out value="${course.courseCredit }" default="0"/>分</dd>
                            </dl>
                        </li>
                       </c:forEach>
                   </ul>--%>
                    <c:forEach items="${courseList }" var="course">
                   <div class="course_credit">
                      <dl class="fl credit_p">
                   	    	    <img src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/edu/css/images/loginbar.jpg"/>'" width="212" height="132" /> 
                      </dl>
                      <dl class="fl mycredit">
                         <dt>
                            <span>${course.courseName }</span>
                            <span class="fr">学分：<font class="red">5.0分</font></span> 
                         </dt>
                         <dd><em>课程简介：${pdfn:cutString(course.courseIntro,40,true,3) }</em></dd>
                         <dt>
                            <table width="100%">
                              <tr>
                                <td>视屏（35%）：1分</td>
                                <td>讨论（10%）：1分</td>
                                <td>作业（20%）：1分</td>
                              </tr> 
                              <tr>
                                <td>考试（30%）：1分</td>
                                <td>在线时长（5%）：1分</td>
                                <td>&nbsp;</td>
                              </tr>
                            </table>
                         </dt>
                      </dl>
                  </div>
                  </c:forEach>
                  <c:if test="${empty courseList }">
                	        <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂未获得学分！</p>
							</div>
                	   </c:if>
             </div>
         </div>
      </div>
 </div>
</div>
