<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/njmuedu/htmlhead-edu.jsp">
	<jsp:param name="findCourse" value="true"/>
</jsp:include>
<body style="margin:0 10px;">
	<p class="courseP">基本信息</p>
<div class="part">
	<table  class="course-table course-table1">
		<colgroup>
		   <col width='20%'/>
		   <col width='30%'/>
		   <col width='20%'/>
		   <col width='30%'/>
		</colgroup>
		<tr>
			<th>姓名</th>
			<td>${eduUserExt.sysUser.userName}</td>
			<th>登录名</th>
			<td>${eduUserExt.sysUser.userCode}</td>
		</tr>
		<tr>
			<th>学校名称</th>
			<td>${eduUserExt.sysOrg.orgName}</td>
			<th>院系</th>
			<td>${eduUserExt.sysUser.deptName}</td>
		</tr>
		<tr>
		    <th>专业</th>
			<td>${eduUserExt.majorName}</td>
			<th>学号</th>
			<td>${eduUserExt.sid}</td>
		</tr>
		<tr>
			<th>手机</th>
			<td>${eduUserExt.sysUser.userPhone}</td>
			<th>身份证号</th>
			<td>${eduUserExt.sysUser.idNo}</td>
		</tr>
		<tr>
			<th style="border:none;">邮箱</th>
			<td>${eduUserExt.sysUser.userEmail}</td>
			<th style="border:none;">届别</th>
			<td>${eduUserExt.period}</td>
		</tr>
		<tr>
		    <th>学分</th>
			<td>${eduUserExt.credit}</td>
		</tr>
	</table>
</div>
		<p  class="courseP">所学课程</p>
		<div class="part part1" >
				<table  style="border-width:1px 1px 0 1px;border-color:#d4e7f0; border-style:solid;" class="course-table">
					<tr>
						<th style="border-right:1px solid #d4e7f0">必修课</th>
					</tr>
					<c:if test="${empty searchStudentChooseCourseMap['required'][eduUserExt.sysUser.userFlow]}">
					<tr>
						<td colspan="4" >暂无记录！</td>
					</tr>
				    </c:if>
				    <c:forEach items="${searchStudentChooseCourseMap['required'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
		       	    <tr>
					    <td colspan="4" >${studentCourseExt.course.courseName}</td>
				    </tr>
		    	    </c:forEach>
				</table>
		
				<table  class="course-table" style=" ;border-width:0 1px 0 1px;border-color:#d4e7f0; border-style:solid;">
					<tr>
						<th colspan="4" >选修课</th>
					</tr>
					<c:if test="${empty searchStudentChooseCourseMap['optional'][eduUserExt.sysUser.userFlow]}">
						<tr>
							<td colspan="4" >暂无记录！</td>
						</tr>
					</c:if>
					<c:forEach items="${searchStudentChooseCourseMap['optional'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
			       	<tr>
						<td colspan="4" >${studentCourseExt.course.courseName}</td>
					</tr>
    	            </c:forEach>
				</table>
				
				<table  class="course-table" style=" border-width:0 1px 1px 1px;border-color:#d4e7f0; border-style:solid;">
					<tr>
						<th colspan="4"  >公开课</th>
					</tr>
					<c:if test="${empty searchStudentChooseCourseMap['public'][eduUserExt.sysUser.userFlow]}">
						<tr>
							<td colspan="4">暂无记录！</td>
						</tr>
					</c:if>
					<c:forEach items="${searchStudentChooseCourseMap['public'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
			       	<tr>
						<td colspan="4" >${studentCourseExt.course.courseName}</td>
					</tr>
			    	</c:forEach>
				</table>
	</div>
	
		<!--<tr>
			<th colspan="4" class="part1">必修课</th>
		</tr>
		<c:if test="${empty searchStudentChooseCourseMap['required'][eduUserExt.sysUser.userFlow]}">
			<tr>
				<td colspan="4">暂无记录！</td>
			</tr>
		</c:if>
		<c:forEach items="${searchStudentChooseCourseMap['required'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
       	<tr>
			<td colspan="4">${studentCourseExt.course.courseName}</td>
		</tr>
    	</c:forEach>
    	
		<tr>
			<th colspan="4" class="part2">选修课</th>
		</tr>
		<c:if test="${empty searchStudentChooseCourseMap['optional'][eduUserExt.sysUser.userFlow]}">
			<tr>
				<td colspan="4">暂无记录！</td>
			</tr>
		</c:if>
		<c:forEach items="${searchStudentChooseCourseMap['optional'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
       	<tr>
			<td colspan="4">${studentCourseExt.course.courseName}</td>
		</tr>
    	</c:forEach>
		<tr>
			<th colspan="4" class="part3">公开课</th>
		</tr>
		<c:if test="${empty searchStudentChooseCourseMap['public'][eduUserExt.sysUser.userFlow]}">
			<tr>
				<td colspan="4">暂无记录！</td>
			</tr>
		</c:if>
		<c:forEach items="${searchStudentChooseCourseMap['public'][eduUserExt.sysUser.userFlow] }" var="studentCourseExt">
       	<tr>
			<td colspan="4">${studentCourseExt.course.courseName}</td>
		</tr>
    	</c:forEach>-->
	</table>
	<div class="part part2" style="margin-bottom:10px;">
	<table  class="course-table" style="border:1px solid #d4e7f0; " >
		<tr>
			<th>应得学分</th>
			<th >获得学分</th>
			<th>操作</th>
		</tr>
		<tr>
			<td>${searchStudentChooseCourseMap['allCreditMap'][eduUserExt.sysUser.userFlow]}</td>
			<td >${searchStudentChooseCourseMap['actualCreditMap'][eduUserExt.sysUser.userFlow]}</td>
			<td>[通知]</td>
		</tr>
	</table>
	</div>
	
</body>