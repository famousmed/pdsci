<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="teacherMien" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function checkRole(courseFlow){
	var url="<s:url value ='/njmuedu/user/checkRole'/>";
	jboxPost(url,null,function(resp){
		if(resp=='${GlobalConstant.STUDENT_ROLE}'){
			url="<s:url value ='/njmuedu/course/stuCourseDetail'/>"+"/"+courseFlow;
			window.location.href=url;
		}else if(resp!=''){
			url="<s:url value ='/njmuedu/course/courseDetail'/>"+"/"+courseFlow;
			window.location.href=url;
		}else{
			jboxInfo("非授权登录，请联系管理员！");
		}
	},null,false);
}
</script>
</head>
<body style="background:#f4f4f4;">
<jsp:include page="/jsp/njmuedu/include/top.jsp"/>
  <div class="teacher-detail-pic-bg">
  <!-- <div class="mask" ></div> -->
      <div class="teacher-detail-breadcrumb-bg">
        <%-- <div class="cbody">
          <ul class="breadcrumb">
            <li><a href="/">医学教育知识平台&nbsp;&gt;&nbsp;</a></li>
            <li><a href="/instructors">教师风采&nbsp;&gt;&nbsp;</a></li>
            <li><a href="/instructors/14">${eduUserExt.sysUser.userName }</a></li>
          </ul>
        </div> --%>
      </div>
      <div class="main clearfix">
        <div class="fl">
                     <img class="pic" src="${sysCfgMap['upload_base_url']}${eduUserExt.sysUser.userHeadImg}" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/head-icon.png"/>'" height="141" width="141"/>
        </div>
        <div class="info fr">
          <div class="name">
            <strong>${eduUserExt.sysUser.userName }</strong>
            <span></span>
          </div>
          <div class="chen">
              ${eduUserExt.sysOrg.orgName }${eduUserExt.sysUser.postName }
          </div>
          <div class="mess">
             <c:if test="${empty eduUserExt.intro}">
                                                暂无个人介绍
             </c:if>
             <c:out value="${pdfn:cutString(eduUserExt.intro,200,true,3)}" default="暂无个人介绍"/>
          </div>
         <!--  <div class="tag">
             <a href="">创业创新领导力</a>
          </div> -->
        </div>
      </div>
  <!-- <a class="lang" href="#" target="_blank"></a> -->
   </div>
   
	<div class="teacher-detail-content-bg cbody">
    	<div class="teacher-detail-title">${eduUserExt.sysUser.userName }任教的课程</div>
            <c:if test='${empty courseList}'>
             <dd style="text-align:center; margin-top:60px;"> 
               <img src="${ctxPath }/jsp/njmuedu/css/images/tanhao.png">
               <p style="margin-top:20px; text-align:center">暂无课程</p>
             </dd> 
            </c:if>
            <c:forEach items="${courseList }" var="course">
            <ul>
                <li>
                    <a href="javascript:void(0)" onclick="checkRole('${course.courseFlow}');">
                   	   		        <img class="" src="<s:url value='${sysCfgMap["upload_base_url"]}${course.courseImg }'/>" onerror="this.src='<s:url value="/jsp/njmuedu/css/images/loginbar.jpg"/>'" width="218" height="141" /> 
                     </a>
                    <dl>
                        <dt><a href="javascript:void(0)" onclick="checkRole('${course.courseFlow}');">${course.courseName }</a></dt>
                        <dd class="countC">
                                                                                共<c:out value="${noParentMap[course.courseFlow] }" default="0"/>章<c:out value="${parentMap[course.courseFlow] }" default="0"/>节
                        </dd>
                        <dd>
                           <c:choose>
                                <c:when test="${course.courseTypeId eq njmuEduCourseTypeEnumRequired.id }">
                                   <input class="r-bnt" type="button" value="${course.courseTypeName }" />
                                </c:when>
                                <c:when test="${course.courseTypeId eq njmuEduCourseTypeEnumOptional.id }">
                                   <input class="i-bnt" type="button" value="${course.courseTypeName }" />
                                </c:when>
                                <c:when test="${course.courseTypeId eq njmuEduCourseTypeEnumPublic.id }">
                                   <input class="b-bnt" type="button" value="${course.courseTypeName }" />
                                </c:when>
                          </c:choose>
                        </dd>
                       
                        <dd><span class="fr"><img src="<s:url value='/jsp/njmuedu/css/images/head-icon1.jpg'/>" width="18" height="14" />${countOneCourseMap[course.courseFlow] }</span>总学分：${course.courseCredit }分</dd>
                    </dl>
                </li>
                
             </ul>
             </c:forEach>
    </div>
    
    <div class="container">
     <%--  <div class="cbody">
          <div class="teacher-detail-article">
            <dl>
              <dt>${eduUserExt.sysUser.userName }的文章</dt>
               <dd style="text-align:center; margin-top:60px;"> 
               <img src="${ctxPath }/jsp/njmuedu/css/images/tanhao.png">
               <p style="margin-top:20px; text-align:center">暂无文章</p>
               </dd>                                
            </dl>
          </div>
      </div> --%>

</div>
</body>
</html>