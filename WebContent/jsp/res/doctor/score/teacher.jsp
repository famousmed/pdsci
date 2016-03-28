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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	function openDetail(isRead,schDeptFlow,recFlow){
		jboxOpen("<s:url value='/res/rec/grade'/>?recTypeId=${resRecTypeEnumTeacherGrade.id}&schDeptFlow="+schDeptFlow+"&recFlow="+recFlow+"&isRead="+isRead,"${resRecTypeEnumTeacherGrade.name}",1200,500);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		</div>
		
		<table class="xllist">
			<thead>
				<tr>
					<th width="15%">科室</th>
					<th width="10%">带教老师</th>
					<th width="10%">得分</th>
					<th width="15%">考评时间</th>
					<th width="25%">轮转时间</th>
					<th width="10%">状态</th>
					<th width="15%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${arrResultList}" var="result">
					<c:if test="${!empty processMap[result.resultFlow]}">
						<tr>
							<td>${result.schDeptName}</td>
							<td>${processMap[result.resultFlow].teacherUserName}</td>
							<td>${recContentMap[recMap[result.schDeptFlow].recFlow]['totalScore']}</td>
							<td>${pdfn:transDate(recMap[result.schDeptFlow].operTime)}</td>
							<td>${processMap[result.resultFlow].startDate}&nbsp;~&nbsp;${processMap[result.resultFlow].endDate}</td>
							<td>
								<c:if test="${empty recMap[result.schDeptFlow]}">
									<font color="red">未考评</font>
								</c:if>
								<c:if test="${!empty recMap[result.schDeptFlow]}">
									<font>已考评</font>
								</c:if>
							</td>
							<td>
								<a href="#" onclick="openDetail(true,'${result.schDeptFlow}','${recMap[result.schDeptFlow].recFlow}');" style="color: blue;">详细</a>
								<c:if test="${!(recMap[result.schDeptFlow].statusId eq recStatusEnumSubmit.id)}">
								|
								<a href="#" onclick="openDetail(false,'${result.schDeptFlow}','${recMap[result.schDeptFlow].recFlow}');" style="color: blue;">考评</a>
								</c:if>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				<c:if test="${empty arrResultList}">
					<tr><td colspan="6">无记录</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>