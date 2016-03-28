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
function searchUser(){
	jboxStartLoading();
	$("#searchForm").submit();
}

function saveAssign(userFlow,orgFlow){
	jboxGet("<s:url value='/edc/proj/saveAssign?projFlow=${param.projFlow}&userFlow='/>"+userFlow+"&orgFlow="+orgFlow,null,function(){
		searchUser();					
	});	
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/edc/proj/assignPM?projFlow=${param.projFlow }" />" method="post" >
					机&#12288;&#12288;构：<select class="xlselect" name="orgFlow" onchange="searchUser();">
						<option value="">请选择</option>
						<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
							<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==param.orgFlow }">selected</c:if>>${sysOrg.orgName}</option>
						</c:forEach>
					</select>	
			 		姓&#12288;&#12288;名：<input type="text" name="userName" value="${param.userName}"  class="xltext"/>	
			 		<br>
			 		<p></p>
			 		身份证号：<input type="text" name="idNo" value="${param.idNo}"  class="xltext"/>	
			 		手&#12288;&#12288;机：<input type="text" name="userPhone" value="${param.userPhone}"  class="xltext"/>	
			 		&#12288;E-Mail：<input type="text" name="userEmail" value="${param.userEmail}"  class="xltext"/>
			 		
			     	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
			</form>
		</div>
		<table class="xllist" > 
			<tr>
				<th width="80px">状态</th>
				<th width="80px">姓名</th>
				<th width="120px">机构名称</th>
				<th width="30px">性别</th>
				<th width="80px">身份证号</th>
				<th width="120px">手机</th>
				<th width="120px">邮件</th>
				<th width="30px" >操作</th>
			</tr>
			<c:set var="userNum" value="0"></c:set>
			<c:forEach items="${sysUserList}" var="sysUser">
			<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
			<c:set var="userNum" value="${userNum+1 }"></c:set>
			<tr style="height:20px ">	
				<td>${sysUser.statusDesc}</td>	
				<td>${sysUser.userName}</td>
				<td>${sysUser.orgName}</td>
				<td>${sysUser.sexName}</td>
				<td>${sysUser.idNo}</td>
				<td>${sysUser.userPhone}</td>
				<td>${sysUser.userEmail}</td>
				<td>
					<c:if test="${empty pubProjUserMap[sysUser.userFlow]}">
					[<a href="javascript:saveAssign('${sysUser.userFlow}','${sysUser.orgFlow}');" >添加</a>] 
					</c:if>
					<c:if test="${not empty pubProjUserMap[sysUser.userFlow]}">
					<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>" />
					</c:if>
				</td>
			</tr>
			</c:if>
		   </c:forEach>
		   <c:if test="${userNum == 0 }"> 
				<tr> 
					<td align="center" colspan="8">无记录</td>
				</tr>
			</c:if>
	</table>
	</div>
</div>
</body>
</html>