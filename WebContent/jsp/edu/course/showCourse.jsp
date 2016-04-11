<%@ include file="/jsp/jspf/prelude.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="findCourse" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>

</head>
<body>
<!--content-->

              <div class="title clearfix">
              	<h3 class="fl">全部课程</h3>
                <div class="title-r fr">
                  
                	 
                	<div class="searchBox fl">
                	   <input type="text"  value="${param.courseName }" placeholder="课程搜索" onchange="changeCourseName(this);"/>
                	   <img onclick="loadCourse();" src="<s:url value='/jsp/edu/css/images/search1.png'/>" style="cursor: pointer;" title="搜索"/> 
                	</div>
                	
                    <div class="tabs-title  module-tabs fl">
                    	<ul>
                        	<li <c:if test="${(param.sort=='create_time') or (empty param.sort) }">class="on"</c:if> id="create_time" onclick="changeSort('create_time');"><a href="javascript:void(0)" >最新</a></li>
                            <li <c:if test="${param.sort=='course_order' }">class="on"</c:if>id="course_order" onclick="changeSort('course_order');"><a href="javascript:void(0)" >最热</a></li>
                        </ul>
                    </div>
                </div>
              </div>
              
              <div class="module-content courseList-content allCourse">
                	<ul style="display:block;" id="content">
                	   <c:if test="${empty stuCourseList }">
                	        <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂无课程！</p>
							</div>
                	   </c:if>
                       <c:forEach items="${stuCourseList }" var="course">
                    	<li class="course">
                   	    	<a href="javascript:void(0);" onclick="checkRole('${course.courseFlow }');">
                   	    	    <img src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/edu/css/images/loginbar.jpg"/>'" width="218" height="141" /> 
                            </a>
                            <dl>
                            	<dt><a href="javascript:void(0);" onclick="checkRole('${course.courseFlow }');">${course.courseName }</a></dt>
                            	<dd class="countC">共${noParentMap[course.courseFlow] }章${parentMap[course.courseFlow] }节</dd>
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
                                <dd><span class="fr"><img src="<s:url value='/jsp/edu/css/images/head-icon1.jpg'/>" width="18" height="14" />${countOneCourseMap[course.courseFlow] }</span>学分：<c:out value="${course.courseCredit }" default="0"/>分</dd>
                            </dl>
                        </li>
                       </c:forEach>
                   </ul>
              </div>
            
              
   
  

<!--/content-->
</body>
</html>