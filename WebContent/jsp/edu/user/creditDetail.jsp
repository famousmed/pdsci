<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
    <jsp:param name="jbox" value="true"/>
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<script>
   
    function doClose(){
    	jboxClose();
    }
</script>
<body style="margin:0 10px;">
		<p  class="courseP">所学课程</p>
		<div class="part">
				<table style="width:100%;border:1px solid #d4e7f0""  class="course-table">
				    <col width="30%">
				    <col width="20%">
				    <col width="25%">
				    <col width="25%">
				    <tr>
				      <th style="border-bottom:1px solid #d4e7f0">课程名称</th>
				      <th style="border-bottom:1px solid #d4e7f0">课程类型</th>
				      <th style="border-bottom:1px solid #d4e7f0">课程学分</th>
				      <th  style="border-bottom:1px solid #d4e7f0">获得学分</th>
				    </tr>
				    <c:forEach items="${searchStudentChooseCourseMap['required'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
		       	     <tr>
					    <td style="text-align:left; padding-left: 80px;">
						      <c:choose>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumFinish.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/wc.png'/>"/>     
						      </c:when>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumUnderway.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/xjz.png'/>"/>     
						      </c:when>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumNotStarted.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/wks.png'/>"/>     
						      </c:when>
						      </c:choose>   
					          ${studentCourseExt.course.courseName}
					     </td>
					    <td>${studentCourseExt.course.courseTypeName}</td>
					    <td>${studentCourseExt.course.courseCredit}</td>
					    <td>
					    <c:choose>
					     <c:when test="${eduStudyStatusEnumFinish.id eq studentCourseExt.studyStatusId and studentCourseExt.achieveCredit eq GlobalConstant.RECORD_STATUS_Y }">
					       ${studentCourseExt.course.courseCredit}
					     </c:when>
					     <c:otherwise>
					       0
					     </c:otherwise>
					    </c:choose>   
					     </td>
				     </tr>
		    	    </c:forEach>
					<c:forEach items="${searchStudentChooseCourseMap['optional'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
			       	  <tr>
					    <td style="text-align:left; padding-left: 80px;">
						      <c:choose>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumFinish.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/wc.png'/>"/>     
						      </c:when>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumUnderway.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/xjz.png'/>"/>     
						      </c:when>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumNotStarted.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/wks.png'/>"/>     
						      </c:when>
						      </c:choose>   
					          ${studentCourseExt.course.courseName}
					     </td>
					    <td>${studentCourseExt.course.courseTypeName}</td>
					    <td>${studentCourseExt.course.courseCredit}</td>
					    <td>
					    <c:choose>
					     <c:when test="${eduStudyStatusEnumFinish.id eq studentCourseExt.studyStatusId and studentCourseExt.achieveCredit eq GlobalConstant.RECORD_STATUS_Y }">
					       ${studentCourseExt.course.courseCredit}
					     </c:when>
					     <c:otherwise>
					       0
					     </c:otherwise>
					    </c:choose>   
					     </td>
				     </tr>
    	            </c:forEach>
					<c:forEach items="${searchStudentChooseCourseMap['public'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
			       	  <tr>
					    <td style="text-align:left; padding-left: 80px;">
						      <c:choose>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumFinish.id and studentCourseExt.achieveCredit eq GlobalConstant.RECORD_STATUS_Y }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/wc.png'/>"/>     
						      </c:when>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumUnderway.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/xjz.png'/>"/>     
						      </c:when>
						      <c:when test="${studentCourseExt.studyStatusId eq eduStudyStatusEnumNotStarted.id }">
						          <img  style="vertical-align:middle; margin-right:10px;" src="<s:url value='/jsp/edu/css/images/wks.png'/>"/>     
						      </c:when>
						      </c:choose>   
					          ${studentCourseExt.course.courseName}
					     </td>
					    <td>${studentCourseExt.course.courseTypeName}</td>
					    <td>${studentCourseExt.course.courseCredit}</td>
					    <td>
					    <c:choose>
					     <c:when test="${eduStudyStatusEnumFinish.id eq studentCourseExt.studyStatusId and studentCourseExt.achieveCredit eq GlobalConstant.RECORD_STATUS_Y }">
					       ${studentCourseExt.course.courseCredit}
					     </c:when>
					     <c:otherwise>
					       0
					     </c:otherwise>
					    </c:choose>   
					     </td>
				     </tr>
			    	</c:forEach>
				</table>
				</div>
	                <div style="width: 180px;" class="editBtn">
					   <input type="button" class="search2"  style='border:none;' value="关闭" onclick='doClose();'/>
					</div>
</body>