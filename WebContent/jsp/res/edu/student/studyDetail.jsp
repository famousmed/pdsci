<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>

<script type="text/javascript">
	function TJ(){
		jboxStartLoading();
		$("#form").submit();
	}
	function toPage(page){
		var form = $("#searchForm");
		$("#currentPage").val(page);
		jboxStartLoading();
		form.submit();
	}
</script>
</head>
<body>

<div class="mainright">
	<div class="content">
		<table class="xllist">
			<tr>
				<th>课程名称</th>
				<th>学分</th>
				<th>学习情况</th>
				<th>成绩</th>
			</tr>
			<c:set var="finishChapterCredit" value="0"/>
			<c:set var="notFinishChapterCredit" value="0"/>
			<c:forEach items="${chapterList}" var="chapter">
				<c:set var="schedule" value="${chapterScheduleMap[chapter.chapterFlow]}"/>
				<tr>
					<td>
						<a href="<s:url value='/resedu/course/chapterDetail?chapterFlow=${chapter.chapterFlow}'/>" target="_blank">${chapter.chapterName}</a>
					</td>
					<td>${chapter.chapterCredit}</td>
					<td>
						<c:if test="${eduStudyStatusEnumFinish.id eq schedule.studyStatusId}">${schedule.studyStatusName}
							<c:set var="finishChapterCredit" value="${finishChapterCredit + chapter.chapterCredit}"/>
						</c:if>
						<c:if test="${(empty schedule.studyStatusId) or (eduStudyStatusEnumUnderway.id eq schedule.studyStatusId) }">未开始
							<c:set var="notFinishChapterCredit" value="${notFinishChapterCredit + chapter.chapterCredit}"/>
						</c:if>
					</td>
					<td>${schedule.examResults}</td>
				</tr>
			</c:forEach>
			<c:if test="${not empty chapterList}">
				<tr>
					<th style="text-align: right;">累计完成学分：</th>
					<th>${finishChapterCredit}</th>
					<th style="text-align: right;">待修学分：</th>
					<th>${notFinishChapterCredit}</th>
				</tr>
			</c:if>
			<c:if test="${empty chapterList}">
				<tr>
					<td colspan="5">无记录</td>
				</tr>
			</c:if>
		</table>
 		<p align="center" style="width:100%;margin-top: 20px;">
			  <input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();" />
	    </p>
	</div>
</div>
	   
</body>
</html>