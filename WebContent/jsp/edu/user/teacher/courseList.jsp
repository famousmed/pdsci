<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="userCenter" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
</jsp:include>
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
</head>
<body>
<!--content-->
<!--  <div class="register clearfix">-->
  
 <div class="registerMsg-m fl">
    	<div class="registerMsg-m-inner registerBgg">  
        	<div class="registerMsg-tabs">
                <div class="module-tabs" style="display: block;">
                	<ul class="fl" >
                        <li class="statusLi on">我的授课</li>
                    </ul>
                     <ul class="fr">
                           <li  class="type" onclick="selectCourseTypeId('');"><a <c:if test="${(empty param.courseTypeId) or (param.courseTypeId=='')}">class="hove1"</c:if>>全部</a></li>
                        <c:forEach items="${eduCourseTypeEnumList }" var="type">
                           <li  class="type" onclick="selectCourseTypeId('${type.id}');"><a  <c:if test="${param.courseTypeId eq type.id }">class="hove1"</c:if>>${type.name }</a></li>
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
                   	   		 <a href="<s:url value='/edu/course/courseDetail/${course.courseFlow }'/>">
                   	   		        <img class="fl" src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/edu/css/images/loginbar.jpg"/>'" width="218" height="141" /> 
                        	 </a>
                       	    <dl class="fl">
                            	<dt><a href="<s:url value='/edu/course/courseDetail/${course.courseFlow }'/>">${course.courseName }</a></dt>
                                <dd>
                                	<p>共<c:out value="${noParentMap[course.courseFlow] }"/>章<c:out value="${parentMap[course.courseFlow] }"/>节&#12288;&#12288;&#12288;&#12288;
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
                                	<p>学习人数：${countOneCourseMap[course.courseFlow] }人</p>
                                    <div class="grapint">${course.courseIntro }</div>
                                </dd>
                                
                                
                                
                            </dl>
                            <a href="<s:url value='/edu/course/courseDetail/${course.courseFlow }'/>"><input type="button" class="btn" value="课程情况总览" /></a>
                        </li>
                       </c:forEach>  
                    </ul>
                </div>
           <!--  </div>--> 
   <!--/registerMsg-m--> 
</div>
  </div>
  </div>
 
</body>
</html>