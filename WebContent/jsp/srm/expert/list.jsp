<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
function searchExpert(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function edit(userFlow){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/expert/edit'/>?userFlow="+userFlow, "修改专家信息", 800, 600);
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
			<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/expert/list"/>" method="post" > 
			<p>
			单&#12288;位：
	     	<select class="xlselect" name="orgFlow" onchange="searchExpert();">
				<option value="">请选择</option>
				<c:forEach var="org" items="${applicationScope.sysOrgList}">
					<option value="${org.orgFlow}" <c:if test="${org.orgFlow==param.orgFlow }">selected</c:if>>${org.orgName}</option>
				</c:forEach>
			</select> 
	     	姓&#12288;名：<input type="text" name="userName" value="${param.userName}"  class="xltext"/>     	
	     	<input type="button" class="search" onclick="searchExpert();" value="查&#12288;询">
	     	</p><br/>
			<table class="xllist" > 
				<tr>
					<th style="width:100px;">登录名</th>
					<th style="width: 85px;">姓名</th>
					<th style="width: 45px;">性别</th>
					<th style="width: 145px;">手机</th>
					<th style="width: 210px;">邮箱</th>
					<th style="width: 106px;">学历</th>
					<th>专业</th>
					<th>操作</th>
				</tr>	
				<c:if test="${!empty expertList}">			
				<c:forEach items="${expertList}" var="expert">
					<tr>
						<td>${userMap[expert.userFlow].userCode}</td>
						<td>${userMap[expert.userFlow].userName}</td>
						<td>${userMap[expert.userFlow].sexName}</td>
						<td>${userMap[expert.userFlow].userPhone}</td>
						<td>${userMap[expert.userFlow].userEmail}</td>
						<td>${userMap[expert.userFlow].educationName}</td>
						<td>${expert.majorName}</td>
						<td>
							[<a href="javascript:edit('${expert.userFlow}');" >修改</a>] 
						</td>
					</tr>
			   </c:forEach>
			   </c:if>
			</table>
			<p>
				<input type="hidden" id="currentPage" name="currentPage">
			    <c:set var="pageView" value="${pdfn:getPageView2(expertList, 10)}" scope="request"></c:set>
				<pd:pagination toPage="toPage"/>
			</p>
		
		</form>
		</div>
		</div>
	</div>
</body>
</html>