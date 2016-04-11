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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>

<script type="text/javascript">
	$(document).ready(function(){
		dataCount();
		var aeCount = $("input[name='aeCount']").val();
		$("#aeCount").text(aeCount);
	});
	
	function dataCount(){
		if($("#data tr").not(":hidden").length>0){
			$("#dataFoot").hide();
		}else{
			$("#dataFoot").show();
		}
	}
	
	function search(){
		$("#searchForm").submit();
	}
	
	function editCourse(courseFlow){
		var url = "<s:url value='/njmuedu/manage/course/editCourse'/>?courseFlow=" + courseFlow;
		window.location.href=url;
	}
	function delCourse(courseFlow){
		jboxConfirm("确认删除？", function(){
			var url = "<s:url value='/njmuedu/manage/course/delCourse'/>?courseFlow=" + courseFlow ; 
			jboxGet(url, null, function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.location.reload();
					jboxTip("删除成功！");
				}
			});
			
		});
	}
	function toPage(page){
		var form = $("#searchForm");
		$("#currentPage").val(page);
		jboxStartLoading();
		form.submit();
	}
	
	function lookChapter(courseFlow){
		var url = "<s:url value='/njmuedu/manage/course/chapterList'/>?courseFlow=" + courseFlow;
		window.location.href=url;
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">	
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value='/njmuedu/manage/course/courseList'/>" method="post">
			<div style="margin: 10px;">
				<input type="hidden" id="currentPage" name="currentPage"/>
				课程名称：<input type="text" name="courseName" value="${param.courseName}" class="xltext"/>
				课程类别：
				<select name="courseTypeId" class="xlselect" onchange="search();">
           			<option value="">全部</option>
           			<c:forEach var="courseType" items="${njmuEduCourseTypeEnumList}">
              				<option value="${courseType.id}" <c:if test="${param.courseTypeId eq courseType.id}">selected="selected"</c:if>>${courseType.name}</option>
                   	</c:forEach>
           		</select>
           		<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
           		<input type="button" value="新&#12288;增" class="search" onclick="editCourse('');"/>
			</div>
			</form>
			<table class="xllist">
				<thead>
				<tr id="top">
					<th width="5%">序号</th>
					<th width="40%">课程名称</th>
					<th width="20%">专业名称</th>
					<th width="10%">学分</th>
					<th width="10%">课程类别</th>
					<th width="10%">总学时</th>
					<th width="15%">操作</th>
				</tr>
				</thead>
				<tbody id="data">
				<c:set var="aeCount" value="0"/>
				<c:forEach items="${courseList}" var="course" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${course.courseName}</td>
					<td>${course.courseMajorName}</td>
					<td>${course.courseCredit}</td>
					<td>${course.courseTypeName}</td>
					<td>${course.coursePeriod}</td>
					<td>
						[<a href="javascript:void(0)" onclick="editCourse('${course.courseFlow}')">编辑</a>]
						[<a href="javascript:void(0)" onclick="delCourse('${course.courseFlow}')">删除</a>]
						[<a href="javascript:void(0)" onclick="lookChapter('${course.courseFlow}')">查看章节</a>]
					</td>
				</tr>
				</c:forEach>
				</tbody>
				<tr id="dataFoot"><td align="center" colspan="7">无记录</td></tr>
			</table>
			<p>
			    <c:set var="pageView" value="${pdfn:getPageView2(courseList, 10)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p>
</div></div></div>
</body>
</html>