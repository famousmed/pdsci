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
	<c:forEach items="${sysUserList}" var="sysUser">
		var json${sysUser.userFlow} = {
				"userFlow":"${sysUser.userFlow}",
				"userName":"${sysUser.userName}",
				"sexName":"${sysUser.sexName}",
				"deptName":"${sysUser.deptName}",
				"postName":"${sysUser.postName}",
				"titleName":"${sysUser.titleName}",
				"userPhone":"${sysUser.userPhone}",
				"userEmail":"${sysUser.userEmail}"
		};
	</c:forEach>
	
	function searchUser(){
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function selMeetingUser(user){
		$("#"+user.userFlow).attr("checked",!$("#"+user.userFlow).attr("checked"));
		window.parent.frames["jbox-iframe"].addUserTr(user);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="padding-bottom: 10px;">
			<form id="searchForm" action="<s:url value="/pub/meeting/userMain" />" method="post">
				&#12288;所属部门：
			    <select id="deptFlow" name="deptFlow" class="xlselect" onchange="searchUser();">
			        <option value="">请选择</option>
			        <c:forEach items="${deptList}" var="dept">
			           <option value="${dept.deptFlow}"  ${dept.deptFlow eq param.deptFlow?'selected="selected"':''}>${dept.deptName}</option>
			         </c:forEach>
			    </select>
				 姓名：<input type="text" name="userName" value="${param.userName}"  class="xltext"/>	
				     <input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
			</form>
			</div>
		<table class="xllist" > 
			<tr>
				<th width="60px"></th>
				<th width="100px">姓名</th>
				<th width="140px">机构名称</th>
				<th width="80px">性别</th>
				<th width="120px">手机</th>
				<th width="120px">邮件</th>
			</tr>
			<tbody>
			<c:forEach items="${sysUserList}" var="sysUser">
			<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
			<tr style="height:20px;cursor: pointer;" onclick="selMeetingUser(json${sysUser.userFlow});">	
				<td width="60px">
					<input ${!empty selMeetingUserMap[sysUser.userFlow]?'checked="true"':''} type="checkbox" id="${sysUser.userFlow}" onclick="this.checked=!this.checked;" style="cursor: pointer;"/>
				</td>	
				<td width="100px">${sysUser.userName}</td>
				<td width="140px">${sysUser.orgName}</td>
				<td width="80px">${sysUser.sexName}</td>
				<td width="120px">${sysUser.userPhone}</td>
				<td width="120px">${sysUser.userEmail}</td>
			</tr>
			</c:if>
		   </c:forEach>
		   </tbody>
		   <c:if test="${empty sysUserList}"> 
				<tr> 
					<td colspan="6">无记录</td>
				</tr>
			</c:if>
	</table>
	</div>
	</div>
</div>
</body>
</html>