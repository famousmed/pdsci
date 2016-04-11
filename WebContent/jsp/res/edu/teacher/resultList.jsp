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
function search() {
	$("#searchForm").submit();
}
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	search();
}
	function edit(flow){
		   jboxOpen("<s:url value='/resedu/edu/editTestResult'/>?userFlow="+flow, "新增成绩",850,400);
		}
</script>
</head>

<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/resedu/edu/resultList"/>"
					method="post">
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<table class="basic" style="width: 100%;">
						<tr>
							<td>
								姓名：
								<input type="text" class=" " onchange="search();" name="userName" value="${param.userName }"/>
								&#12288;
								身份证号码：
								<input type="text" name="idNo" onchange="search();" value="${param.idNo}" class="" />&#12288;
								<input id="currentPage" type="hidden" name="currentPage" value=""/>
								<input type="hidden" class="search" onchange="search();" value="查&#12288;询">
							</td>
						</tr>
					</table>
				</form>
			</div>
		      <table class="xllist" style="width: 100%;">
	  				<thead>
	      				<tr>
	      					<th style="width: 10%;">姓名</th>
							<th style="width: 10%;">性别</th>
							<th style="width: 20%;">身份证号码</th>
							<th style="width: 10%;">职称</th>
							<th style="width: 10%;">考試成績</th>
	      				</tr>
	      			</thead>
	      			<tbody>
				<c:forEach items="${userList }" var="user">
					<tr>
						<td>${user.userName }</td>
						<td>${user.sexName }</td>
						<td>${user.idNo }</td>
						<td>${user.titleName}</td>
						<td><a style="color: blue;cursor: pointer;" onclick="edit('${user.userFlow}');">编辑</a></td>
					</tr>
				</c:forEach>
				<c:if test="${empty userList } ">
					<tr><td colspan="99">无记录</td></tr>
				</c:if>
			</tbody>
      		   </table>
      		   <c:set var="pageView" value="${pdfn:getPageView(userList)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
	    </div>
    </div>
</body>
</html>