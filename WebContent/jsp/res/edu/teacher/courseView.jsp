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
function search(){
	$("#searchForm").submit();
}

function courseInfo(courseFlow){
	var page=$("#currentPage").val();
	var url = "<s:url value='/resedu/manage/course/courseInfo'/>?courseFlow="+courseFlow+"&page="+page;
	window.location.href=url;
}
function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}
function searchTestList(courseFlow){
	var url="<s:url value='/resedu/manage/course/testList'/>?courseFlow="+courseFlow;
    window.location.href=url;
}

function assignList(courseFlow){
	var $div = $("#div_"+courseFlow);
	var $content = $("#content_"+courseFlow);
	$div.slideToggle("slow", function(){
		var url = "<s:url value='/resedu/manage/course/loadChapterList'/>?courseFlow=" + courseFlow;
		jboxLoad("content_"+courseFlow, url, false);
 	});
}
function addTestPaper(){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url="<s:url value='/resedu/manage/course/addTestPaper'/>?closeFlag=Y";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'出题',w,h,null,false);
    
}

function courseInfo(courseFlow){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/resedu/manage/course/courseInfo'/>?courseFlow="+courseFlow+"&closeFlag=Y";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'查看课程信息',w,h,null,false);
}

function chapterInfo(chapterFlow){
	var w = $('.mainright').width();
	var h = $('.mainright').height();
	var url = "<s:url value='/resedu/manage/course/chapterInfo'/>?chapterFlow="+chapterFlow;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='"+h+"' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'查看章节信息',w,h,null,false);
}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<form id="searchForm" action="<s:url value='/resedu/manage/course/courseView'/>" method="post">
	<div style="margin-bottom: 10px;margin-right: 10px;">
		课程名称：<input type="text" name="courseName" class="xltext" value="${param.courseName }"/>
		课程类别：<select class="xlselect" name="courseCategoryId" style="width: 100px;">
					<option value="">请选择</option>
					<c:forEach items="${eduCourseCategoryEnumList }" var="category">
					  <option value="${category.id }"<c:if test="${param.courseCategoryId eq category.id }">selected</c:if>>${category.name }</option>
					</c:forEach>
				</select>
		<input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage }"/>
		<input type="button" class="search" onclick="search();" value="查&#12288;询">
		<input class="search" type="button" value="出&#12288;题"  onclick="addTestPaper();" />
	</div>
	</form>
	 <c:forEach items="${courseList}" var="course">
			<div style="cursor: pointer; border: 1px solid #E2E2E2; margin-top:8px;" class="ith" onclick="assignList('${course.courseFlow}');">
				<table style="width: 100%;border: 0;line-height: 30px;">
					<colgroup>
						<col width="30%"/>
						<col width="30%"/>
						<col width="30%"/>
						<col width="10%"/>
					</colgroup>
					<tr>
					    <td>课程名称：<label title="${course.courseName }">${pdfn:cutString(course.courseName,12,true,3 )}</label></td>
						<td>课程类别：${course.courseCategoryName }</td>
						<td>主&nbsp;讲&nbsp;人：${course.courseSpeaker }</td>
						<td rowspan="2" style="text-align:left;">
							<input type="button" class="search" onclick="event.cancelBubble=true;courseInfo('${course.courseFlow }');" value="查&#12288;看"/>
						</td>
					</tr>
					<tr>
						<td>发布科室：${course.deptName }</td>
						<td>学&#12288;&#12288;时：${course.coursePeriod }</td>
						<td>学&#12288;&#12288;分：${course.courseCredit }</td>
					</tr>
				</table>
			</div>
			
			<div id="div_${course.courseFlow}" style="display: none;">
				<div style="border: 1px solid #E2E2E2; border-top: none; border-bottom: none;">
				<table cellpadding="0" class="i-trend-main-div-table" cellspacing="0" border="0" style="width: 100%;">
					<colgroup>
					    <col width="25%" />
						<col width="25%" />
						<col width="25%" />
						<col width="25%" />
					</colgroup>
					<tr style="height: 40px;">
					    <th>章节名称</th>
					    <th>章节学分</th>
						<th>关联试卷</th>
						<th>操作</th>
					</tr>
					<tbody>
				        <tr>
				          <td colspan="5">
				             <div id="content_${course.courseFlow}">
				             </div>
				          </td>
				        </tr>
			      </tbody>
				</table>
				</div>
			</div>
			</c:forEach>
			
			<c:if test="${empty courseList}">
			<div style="cursor: pointer; border: 1px solid #ccc; margin-top: 10px;" class="ith" onclick="assignList('${course.courseFlow}');">
				<table style="width: 100%;border: 0;line-height: 30px;">
					<tr>
						<td align="center">无记录</td>
					</tr>
				</table>
			</div>
			</c:if>
</div>
</div>
</div>
</body>
</html>