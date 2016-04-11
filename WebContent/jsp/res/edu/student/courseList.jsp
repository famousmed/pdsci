<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript" src="<s:url value='/js/echarts/echarts-all.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
	function scroll(){
		setTimeout(function(){
			$(".list li:first").animate({marginTop : "-25px"},500,function(){
				$(".list").append($(this).css({marginTop : "0px"}));
				scroll();
			});
		},3000);
	}
	$(function(){
		if($(".list li").length>1){
			scroll();
		}
	});
</script>
</head>
<body>
<div class="mainright" style="margin-bottom: 70px;">
  <div class="top-tab">
   <div class="module-tabs">
    <c:if test="${param.showSort!='N' }">
        <ul class="fl type">
           <li id="all_category" <c:if test="${empty param.courseCategoryId }">class="on"</c:if> onclick="checkCourseCategory('');">全部</li>
           <c:forEach items="${eduCourseCategoryEnumList }" var="courseCategory">
           <li id="courseCategory_${courseCategory.id }" <c:if test="${courseCategory.id eq param.courseCategoryId }">class="on"</c:if> onclick="checkCourseCategory('${courseCategory.id }');">${courseCategory.name }</li>
           </c:forEach>
        </ul>
     </c:if>
        <ul class="fr">
            <li  onclick="selectCourseTypeId('');"><a <c:if test="${(empty param.courseTypeId) or (param.courseTypeId=='')}">class="hove1"</c:if>>全部</a></li>
            <li  onclick="selectCourseTypeId('${eduCourseTypeEnumRequired.id}');"><a <c:if test="${param.courseTypeId eq 'Required' }">class="hove1"</c:if>>必修</a></li>
            <li  onclick="selectCourseTypeId('Other');"><a <c:if test="${param.courseTypeId eq 'Other' }">class="hove1"</c:if>>选修</a></li>
         </ul>
     </div>
     <div class="coursemodule-tabs" style="border-bottom:0;">
            <ul class="fr type">
              <li><a <c:if test="${(param.studyStatus eq eduStudyStatusEnumUnderway.id) or (empty param.studyStatus) }">class="coursetab_left_select"</c:if>
                     <c:if test="${(param.studyStatus != eduStudyStatusEnumUnderway.id) and (not empty param.studyStatus) }">class="coursetab_left"</c:if>
                   onclick="checkStatus('${eduStudyStatusEnumUnderway.id}')">在学</a></li>
              <li><a <c:if test="${param.studyStatus eq eduStudyStatusEnumFinish.id }">class="coursetab_right_select"</c:if> 
                     <c:if test="${param.studyStatus != eduStudyStatusEnumFinish.id }">class="coursetab_right"</c:if>
                   onclick="checkStatus('${eduStudyStatusEnumFinish.id}')" class="coursetab_right">学完</a></li>
            </ul>
     
       <%-- <ul class="fr type">
           <li <c:if test="${(param.studyStatus eq eduStudyStatusEnumUnderway.id) or (empty param.studyStatus) }">class="on"</c:if> onclick="checkStatus('${eduStudyStatusEnumUnderway.id}')">在学</li>
           <li <c:if test="${param.studyStatus eq eduStudyStatusEnumFinish.id }">class="on"</c:if> onclick="checkStatus('${eduStudyStatusEnumFinish.id}')">学完</li>
         </ul> --%>
     </div>
	<div class="content" id="courseContent" style="padding-left: 0; margin-top:15px;">
		<div class="module-content">
		            <c:if test="${empty studentCourseExtList }">
                	      <div class="nomessage" style="text-align: center;"> 
								<img src="${ctxPath }/jsp/edu/css/images/tanhao.png">           
								<p>暂无课程！</p>
							</div>
                	   </c:if>
                   <c:forEach items="${studentCourseExtList }" var="studentCourseExt" varStatus="num">
                	<ul>
                    	<li>
                        	<dl class="fl">
                            	<dt>
                            	<a href="<s:url value='/resedu/course/courseMain?courseFlow=${studentCourseExt.course.courseFlow}'/>" target="_blank">${studentCourseExt.course.courseName }</a>
                            	 <c:if test="${studentCourseExt.courseTypeId eq eduCourseTypeEnumRequired.id }">
                            	 <img src="<s:url value='/jsp/res/edu/image/bx.png'/>"  class="fr" />
                            	 </c:if>
                            	 <c:if test="${studentCourseExt.courseTypeId eq eduCourseTypeEnumOptional.id }">
                            	 <img src="<s:url value='/jsp/res/edu/image/xx.png'/>"  class="fr" />
                            	 </c:if>
                            	 <%-- <img src="<s:url value="${sysCfgMap['upload_base_url']}${course.courseImg }"/>"  class="fr" onerror="this.src='<s:url value="${sysCfgMap['res_edu_course_img']}"/>'" /> --%>
                            	</dt>
                                <dd>
                                	<p>学分：${studentCourseExt.course.courseCredit }&#12288;&#12288;&#12288;学时：${studentCourseExt.course.coursePeriod }</p>
                                    <p>
                                        <c:if test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumNotStarted.id }">
                                                                                                                              尚未开始学习
                                        </c:if>
                                        <c:if test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumUnderway.id }">
                                                                                                                              学习中
                                        </c:if>
                                        <c:if test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumFinish.id }">
                                                                                                                              已完成学习                                                                                    
                                        </c:if>
                                    </p>
                                    <div>
                                      <img src="<s:url value='/jsp/edu/css/images/video-icon.jpg'/>" width="12" height="10" />
                                      <div class="graph"><strong id="bar" style="width:<c:out value="${scheduleMap[studentCourseExt.course.courseFlow] }" default="0"/>%;"></strong></div>&nbsp;<c:out value="${scheduleMap[studentCourseExt.course.courseFlow] }" default="0"/>%
                                      <a href="<s:url value='/resedu/course/courseMain?courseFlow=${studentCourseExt.course.courseFlow}'/>" target="_blank"><input type="button" class="btn" value="进入课堂" /></a>
                                  </div>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                    </c:forEach>  
                </div>
	</div>
</div></div>
</body>
</html>