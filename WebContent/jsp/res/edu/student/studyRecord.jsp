<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
function testDetail(courseFlow){
	var url = "<s:url value='/resedu/student/reasonTestreRultChaTestPaper?courseFlow='/>"+courseFlow;
	jboxOpen(url, "考试情况", 1000, 500);
}
function studyDetail(courseFlow){
	var url = "<s:url value='/resedu/student/studyDetail?courseFlow='/>"+courseFlow;
	jboxOpen(url, "学习情况", 1000, 500);
}
</script>
<div class="i-trend-main-div" style="padding: 15px 10px;">
	<div style="margin-bottom: 10px;margin-right: 10px;">
	<form id="studyRecordForm">
	   <div>
		课程名称：<input type="text" class="xltext" name="courseName" value="${param.courseName }"/>
		课程类别：<select class="xlselect" name="courseCategoryId" style="width: 100px;">
					<option value="">请选择</option>
					<c:forEach items="${eduCourseCategoryEnumList }" var="category">
					<option value="${category.id }" <c:if test="${param.courseCategoryId eq category.id }">selected</c:if>>${category.name }</option>
					</c:forEach>
				</select>
		课程要求：<select class="xlselect" name="courseTypeId" style="width: 100px;">
					<option value="">请选择</option>
					<c:forEach items="${eduCourseTypeEnumList }" var="type">
					 <c:if test="${type.id !=eduCourseTypeEnumPublic.id }">
					<option value="${type.id }" <c:if test="${param.courseTypeId eq type.id }">selected</c:if>>${pdfn:cutString(type.name,2,false,1) }</option>
					 </c:if>
					</c:forEach>
				</select>
		</div>
		<div style="margin-top: 10px;margin-bottom: 10px;">
		 发布科室：<select class="xlselect" name="deptFlow" style="width: 168px;">
					<option value="">请选择</option>
					<c:forEach items="${deptList }" var="dept">
					<option value="${dept.deptFlow }" <c:if test="${param.deptFlow eq dept.deptFlow }">selected</c:if>>${dept.deptName }</option>
					</c:forEach>
				</select>
		 课程状态：<select class="xlselect" name="studyStatusId" style="width: 100px;">
					<option value="">请选择</option>
					<c:forEach items="${eduStudyStatusEnumList }" var="studyStatus">
					<option value="${studyStatus.id }" <c:if test="${param.studyStatusId eq studyStatus.id }">selected</c:if>>${studyStatus.name }</option>
					</c:forEach>
				</select>
			 <input type="button" class="search" value="查&#12288;询" onclick="loadStudyRecord();">
		</div>
	 </form>
	</div>
	 <table class="xllist">
		<tr>
			<th width="15%">课程名称</th>
			<th width="10%">课程类别</th>
			<th width="10%">课程状态</th>
			<th width="10%">发布科室</th>
			<th width="10%">是否必修</th>
			<th width="10%">开始学习时间</th>
			<th width="10%">完成学习时间</th>
			<th width="8%">学分</th>
			<th width="17%">操作</th>
		</tr>
		<c:forEach items="${eduStudentCourseExtList }" var="studentCourseExt">
		<tr>
			<td><a href="<s:url value='/resedu/course/courseMain?courseFlow=${studentCourseExt.courseFlow }' />" target="_blank">${studentCourseExt.course.courseName }</a></td>
			<td>${studentCourseExt.course.courseCategoryName }</td>
			<td>${studentCourseExt.studyStatusName}</td>
			<td>${studentCourseExt.course.deptName }</td>
			<td>
			  <c:if test="${studentCourseExt.courseTypeId eq eduCourseTypeEnumRequired.id }">是</c:if>
			  <c:if test="${studentCourseExt.courseTypeId != eduCourseTypeEnumRequired.id }">否</c:if>
			</td>
			<td>${pdfn:transDateTimeForPattern(studentCourseExt.startStudyTime,"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd") }</td>
			<td>${pdfn:transDateTimeForPattern(studentCourseExt.completeStudyTime,"yyyy-MM-dd HH:mm:ss","yyyy-MM-dd") }</td>
			<td><c:if test="${studentCourseExt.achieveCredit eq 'Y' }">${studentCourseExt.courseCredit }</c:if></td>
			<td>
				[<a href="javascript:testDetail('${studentCourseExt.courseFlow} ');">考试情况</a>]
				[<a href="javascript:studyDetail('${studentCourseExt.courseFlow} ');">学习情况</a>]
			</td>
		</tr>
		</c:forEach>
		<c:if test="${empty eduStudentCourseExtList }">
		    <tr><td colspan="10">无记录</td></tr>
		</c:if>
	</table>
</div>
