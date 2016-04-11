<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function testDetail(courseFlow,userFlow){
	var url = "<s:url value='/resedu/student/reasonTestreRultChaTestPaper'/>?courseFlow="+courseFlow+"&userFlow="+userFlow;
	jboxOpen(url, "考试详情", 1000, 500);
}
function CX(){
	jboxStartLoading();
	$("#form").submit();
}
 function toPage(page){
	var form = $("#form");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
} 
</script>
<style type="text/css">
	.table tr td{
		border-top: 0px;
		border-left: 0px;
		border-bottom: 0px;
	}
	
	.table tr th{
		border-left: 0px;
		border-bottom: 0px;
	}
	
</style>
</head>
<body>
	<div class="mainright">
	<div class="content">
	
	<div style="margin-top: 20px;margin-right: 10px;line-height: 35px;">
	<div style="margin-bottom: 10px;margin-right: 10px;line-height: 35px;">
	<form id="form" action="<s:url value='/resedu/report/studentStatistics/${sessionScope[GlobalConstant.USER_LIST_SCOPE]}'/>" method="post">
			<input type="hidden" id="currentPage" name="currentPage"/>
			学员姓名：<input type="text" name="userName" class="xltext " value="${param.userName}"/>
			工&#12288;&#12288;号：<input type="text" name="doctorCode" value="${param.doctorCode}" class="xltext "/>
			<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_ADMIN || sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
			 科&#12288;&#12288;室：<select class="xlselect" name="deptFlow">
						<option value="">请选择</option>
						<c:forEach items="${orgFlowdeptList}" var="deptFlowList">
							<option value="${deptFlowList.deptFlow}" <c:if test="${param.deptFlow==deptFlowList.deptFlow}">selected="selected"</c:if>>${deptFlowList.deptName}</option>
						</c:forEach>
					</select>
			</c:if> 
			<br/> 
			
			课程名称：<input type="text" name="courseName" value="${param.courseName}" class="xltext"/>
			课程类别：<select class="xlselect" name="courseCategoryName">
						<option value="">请选择</option>
						<option value="普通培训" <c:if test="${param.courseCategoryName=='普通培训'}">selected="selected"</c:if>>普通培训</option>
						<option value="岗前培训" <c:if test="${param.courseCategoryName=='岗前培训'}">selected="selected"</c:if>>岗前培训</option>
					</select>
			<input type="button" class="search" onclick="CX();" value="查&#12288;询">
		</form>
	</div>
		<table width="100%" class="bs_tb" style="border-top:1px solid #e3e3e3;">
			<tr>
				<th width="10%">课程名称</th>
				<td width="90%">
					<table width="100%" class="table">
					<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_TEACHER || sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						<colgroup>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="9%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="6%"/>
						</colgroup>
							<tr>
							<th>课程类别</th>
							<th>是否必修</th>
							<th>学习状态</th>
							<th>姓名</th>
							<th>工号</th>
							<th>职称</th>
							<th>专业</th>
							<th>当前科室</th>
							<th>人员类别</th>
							<th>开始学习时间</th>
							<th>完成学习时间</th>
							<th>考试详情</th>
							</tr>
						</c:if>
						<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_ADMIN || sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
							<colgroup>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="9%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="6%"/>
							</colgroup>
							<tr>
							<th>课程类别</th>
							<th>发布科室</th>
							<th>是否必修</th>
							<th>学习状态</th>
							<th>姓名</th>
							<th>工号</th>
							<th>职称</th>
							<th>专业</th>
							<th>当前科室</th>
							<th>人员类别</th>
							<th>开始学习时间</th>
							<th>完成学习时间</th>
							<th>考试详情</th>
							</tr>
						</c:if>
						
					</table>
				</td>
			</tr>
			<c:if test="${not empty eduCourseList}">
			<c:forEach items="${eduCourseList}" var="educourse">
			<tr>
				<td width="10%">${educourse.courseName} </td>
			
				<td width="90%">
					<table width="100%" class="table" style="border-bottom: 0px;">
					<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_TEACHER || sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						<colgroup>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="9%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="6%"/>
						</colgroup>
					</c:if>
					<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_ADMIN || sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
							<colgroup>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="7%"/>
							<col width="9%"/>
							<col width="10%"/>
							<col width="7%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="6%"/>
							</colgroup>
					</c:if>
						<c:forEach items="${educourse.eduStudentCourseList}" var="eduStudentCourse" varStatus="num">
						<tr>
						 <c:if test="${fn:length(educourse.eduStudentCourseList) eq num.count}">
							<c:set var="c" value="1" />
						</c:if>
						<c:if test="${fn:length(educourse.eduStudentCourseList) != num.count}">  
							<c:set var="c" value="0" />
						</c:if>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${educourse.courseCategoryName} </td>
							<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_ADMIN || sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.RES_ROLE_SCOPE_MANAGER}">
								<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
								<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${educourse.deptName}</td>
							</c:if>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>
							<c:if test="${eduStudentCourse.courseTypeId eq eduCourseTypeEnumRequired.id}">是</c:if><c:if test="${eduStudentCourse.courseTypeId != eduCourseTypeEnumRequired.id}">否</c:if>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${studentCourseMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].studyStatusName}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${sysUserMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].userName} </td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${resdoctorMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].doctorCode}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${sysUserMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].titleName}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${resdoctorMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].specialized}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${studentCourseMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].schDeptName}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${resdoctorMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].doctorTypeName}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${studentCourseMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].startStudyTime}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>>${studentCourseMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].completeStudyTime}</td>
							<td <c:if test="${c==1}">style="border-bottom: 0px "</c:if>
							<c:if test="${c==0}">style="border-bottom: 1px solid #e3e3e3;"</c:if>> <a href="javascript:testDetail('${educourse.courseFlow}','${sysUserMap[eduStudentCourse.courseFlow][eduStudentCourse.userFlow].userFlow}')">[详情]</a></td>
						</tr>
						</c:forEach>
					</table>
				</td>
				</tr>
				</c:forEach>
				</c:if>
				
		</table>
		<c:if test="${empty eduCourseList}">
			<center>
			<tr>
				<td width="100%" >无记录！</td>
			</tr>
			</center>
		</c:if>
		 <p>
			<c:set var="pageView" value="${pdfn:getPageView(eduCourseList)}" scope="request"/> 
			<pd:pagination toPage="toPage"/>
		</p>
		</div>
		</div>
		</div>
		
</body>
</html>