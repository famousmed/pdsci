<div class="panel-head"><h3 style="font-weight: normal;">学习中心</h3></div>
<table width="99%">
		   <tr>
				<td style="width: 150px;">
					<a href="<s:url value ='/resedu/student/main?resultFlow=${param.resultFlow}&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}'/>">
	                   <img class="fl" src="<s:url value='/jsp/edu/css/images/film.png'/>" height="100" /> 
			        </a>
		         </td>
				<td style="border-right: 1px solid #ddd;line-height: 30px;width: 300px;">
					<p>必修课程：${countUserCourseMap[eduCourseTypeEnumRequired.id] }&#12288;&#12288;已学完：${countUserCourseFinishMap[eduCourseTypeEnumRequired.id] }</p>
					<p>选修课程：${countUserCourseMap[eduCourseTypeEnumOptional.id] }&#12288;&#12288;已学完：${countUserCourseFinishMap[eduCourseTypeEnumOptional.id] }</p>
					<p>获得学分：${sumUserCreditMap['achieveCredit'] }&#12288;&#12288;未获得学分：${sumUserCreditMap['notAchieveCredit'] }</p>
				</td>
				<td style="line-height: 30px;padding-left: 10px;">
					<p>最新学习：<c:if test="${empty studentCourseExtList }">无</c:if>
					         <c:if test="${not empty studentCourseExtList }"><a href="<s:url value='/resedu/course/courseMain?courseFlow=${studentCourseExtList.get(0).course.courseFlow }'/>&scope=student" target="_blank">${studentCourseExtList.get(0).course.courseName }</a></c:if></p>
					<p>最近学习：<c:if test="${empty studentCourseExtList }">无</c:if>
					  <c:forEach items="${studentCourseExtList }" var="studentCourseExt">
					     ${studentCourseExt.course.courseName }&#12288;
					  </c:forEach>
					</p>
				</td>
			</tr>
</table>