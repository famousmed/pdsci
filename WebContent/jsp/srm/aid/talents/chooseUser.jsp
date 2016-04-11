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
	function submit(){
		jboxStartLoading();
		$("#editForm").submit();
	}
	function choose(userFlow){
		window.parent.frames["jbox-iframe"].window.location.href='<s:url value="/srm/aid/talents/edit"/>?chooseUserFlow='+userFlow+'&talentsFlow=${param.talentsFlow }&role=${param.role}';
		jboxCloseMessager();
	}
	function toPage(page){
		var form = $("#editForm");
		$("#currentPage").val(page);
		jboxStartLoading();
		form.submit();
	}
</script>
</head>
<body>
<div class="title1 clearfix">
	<div class="content">
		<form id="editForm" action="<s:url value='/srm/aid/talents/chooseUser'/>" method="post">
		<table class="xllist" width="100%" id="userList">
			<thead>
				<tr>
					<th class="bs_name" colspan="8" style="text-align: left;background-color: #6cb4e7; color:#fff; height: 38px;">
						&#12288;所属单位：
		            	<select  name="orgFlow" class="xlselect" onchange="submit()">
		            		<c:choose>
				        	 	<c:when test="${param.role==GlobalConstant.PROJ_STATUS_SCOPE_LOCAL }">
				        	 		<option value="${sessionScope.currUser.orgFlow }">${sessionScope.currUser.orgName }</option>
				        	 	</c:when>
				        	 	<c:otherwise>
				        	 		<option value="">全部</option>
				            		<c:forEach items="${applicationScope.sysOrgList}" var="org">
				            			<option value="${org.orgFlow}" <c:if test="${org.orgFlow eq param.orgFlow}">selected="selected"</c:if> >${org.orgName}</option>
				            		</c:forEach>
				        	 	</c:otherwise>
			        	 	</c:choose>
		            	</select>
						&#12288;所属部门：
		            	<select  name="deptFlow" class="xlselect" onchange="submit()">
		            		<option value="">全部</option>
		            		<c:forEach items="${deptList}" var="dept">
		            			<option value="${dept.deptFlow}" <c:if test="${dept.deptFlow eq param.deptFlow}">selected="selected"</c:if> >${dept.deptName}</option>
		            		</c:forEach>
		            	</select>
		            	&#12288;姓名：
		            	<input type="text" name="userName" value="${param.userName }" class="xltext"/>
		            	&#12288;&#12288;
		            	<input type="button" class="search" value="查&#12288;找" onclick="submit();" >
					</th>
				</tr>
			</thead>
			<tr>
				<th>姓名</th>
				<th>性别</th>
				<th>单位</th>
				<th>部门</th>
				<th>职务</th>
				<th>职称</th>
				<th>手机</th>
				<th>邮箱</th>
			</tr>
			<tbody>
				<c:forEach items="${userList}" var="user">
					<tr style="cursor: pointer;" onclick="choose('${user.userFlow}')">
						<td>${user.userName}</td>
						<td>${user.sexName}</td>
						<td>${user.orgName}</td>
						<td>${user.deptName}</td>
						<td>${user.postName}</td>
						<td>${user.titleName}</td>
						<td>${user.userPhone}</td>
						<td>${user.userEmail}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p>
			<input type="hidden" id="currentPage" name="currentPage">
			<input type="hidden"  name="role" value="${param.role }">
			<input type="hidden"  name="talentsFlow" value="${param.talentsFlow }">
		    <c:set var="pageView" value="${pdfn:getPageView2(userList , 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
		</p>
		</form>
		<p align="center">
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxCloseMessager();" >
		</p>
	</div>
	</div>
</body>
</html>