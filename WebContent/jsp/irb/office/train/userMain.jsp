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

function selTrainUser(userFlow){
	var jboxIfram = window.parent.frames["jbox-iframe"];
	if ($("#"+userFlow).attr("checked") != "checked") {
		$("#"+userFlow).attr("checked",true);
		if (jboxIfram.$("#"+userFlow).val() == null) {	//防止重复添加
			var userInfo = $("#"+userFlow).attr("userInfo");
			var userName = userInfo.split("_")[0];
			var sexName = userInfo.split("_")[1];
			var deptName = userInfo.split("_")[2];
			var postName = userInfo.split("_")[3];
			var titleName = userInfo.split("_")[4];
			var userPhone = userInfo.split("_")[5];
			var userEmail = userInfo.split("_")[6];
			var tr = "<tr id='"+userFlow+"_Tr'><td><input type='hidden' id='"+userFlow+"' name='userFlows' value='"+userFlow+"'>"+userName +"</td><td>"+sexName+"</td><td>"+deptName
			+"</td><td>"+postName+"</td><td>"+titleName+"</td><td>"+userPhone+"</td><td>"+userEmail+"</td><td class='operTd'>[<label onclick='delTrainUser(\""+userFlow+"\",\"N\")' style='color:blue;cursor: pointer;' >删除</label>]</td></tr>"; 
			jboxIfram.$("#trainUsers").append(tr);
		}
	} else {
		$("#"+userFlow).attr("checked",false);
		jboxIfram.$("#"+userFlow+"_Tr").remove();
	} 
	
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="padding-bottom: 10px;">
			<form id="searchForm" action="<s:url value="/irb/office/userMain" />" method="post">
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
				<th width="60px"></th>
				<th width="100px">姓名</th>
				<th width="140px">机构名称</th>
				<th width="80px">性别</th>
				<th width="120px">手机</th>
				<th width="120px">邮件</th>
			</tr>
			<c:set var="userNum" value="0"></c:set>
			<c:forEach items="${sysUserList}" var="sysUser">
			<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
			<c:set var="userNum" value="${userNum+1 }"></c:set>
			<tr style="height:20px;cursor: pointer;" onclick="selTrainUser('${sysUser.userFlow}');">	
				<td width="60px">
					<input type="checkbox" id="${sysUser.userFlow}" value="${sysUser.userFlow}" onclick="selTrainUser('${sysUser.userFlow}');"
					userInfo="${sysUser.userName}_${sysUser.sexName}_${sysUser.deptName}_${sysUser.postName}_${sysUser.titleName}_${sysUser.userPhone}_${sysUser.userEmail}" />
				</td>	
				<td width="100px">${sysUser.userName}</td>
				<td width="140px">${sysUser.orgName}</td>
				<td width="80px">${sysUser.sexName}</td>
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
</div>
</body>
</html>