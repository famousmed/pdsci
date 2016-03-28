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
searchUser();

function selConsultant(userFlow,userName){
	var dlgwId = window.parent.frames['mainIframe'].$("#dlgwId");
	if (userFlow == $(dlgwId).val()) {
		return;
	}
	$(dlgwId).val(userFlow);
	var consultantSpan = window.parent.frames['mainIframe'].$("#consultantSpan");
	consultantSpan.html(userName);
	
	//调用父页面关闭窗口与Loading
	window.parent.frames['mainIframe'].window.doSelect();
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/secretary/userMain" />" method="post">
					&#12288;所属部门：
		            <select id="deptFlow" name="deptFlow" class="xlselect" onchange="searchUser();">
		            	<option value="">请选择</option>
		            	<c:forEach items="${deptList}" var="dept">
		            		<option value="${dept.deptFlow}" <c:if test="${dept.deptFlow == deptFlow}">selected="selected"</c:if> >${dept.deptName}</option>
		            	</c:forEach>
		            </select>
			 		姓名：<input type="text" name="userName" value="${userName}"  class="xltext"/>	
			     	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
			     	<input type="hidden" name="type" value="search"/>	
			</form>
		</div>
		
		<table class="xllist" > 
			<tr>
				<th width="80px">状态</th>
				<th width="80px">姓名</th>
				<th width="140px">机构名称</th>
				<th width="50px">性别</th>
				<th width="120px">手机</th>
				<th width="120px">邮件</th>
			</tr>
			<c:set var="userNum" value="0"></c:set>
			<c:forEach items="${sysUserList}" var="sysUser">
			<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
			<c:set var="userNum" value="${userNum+1 }"></c:set>
			<tr style="height:20px;cursor: pointer;" onclick="selConsultant('${sysUser.userFlow}','${sysUser.userName}');">	
				<td width="80px">${sysUser.statusDesc}</td>	
				<td width="80px">${sysUser.userName}</td>
				<td width="140px">${sysUser.orgName}</td>
				<td width="50px">${sysUser.sexName}</td>
				<td width="120px">${sysUser.userPhone}</td>
				<td width="120px">${sysUser.userEmail}</td>
			</tr>
			</c:if>
		   </c:forEach>
		   <c:if test="${userNum == 0 }"> 
				<tr> 
					<td align="center" colspan="6">无记录</td>
				</tr>
			</c:if>
	</table>
	</div>
</div>
</body>
</html>