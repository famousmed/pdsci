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
function addProjUser() {
	var orgFlow = $("#orgFlow").val();
	jboxOpen("<s:url value='/edc/projUser/add?orgFlow='/>"+orgFlow,"新增用户信息", 900, 300);
}
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit/${sessionScope.userListScope}?userFlow='/>"+ userFlow,"编辑用户信息", 900, 400);
}
function allotRole(userFlow){
	jboxOpen("<s:url value='/edc/projUser/allotRole?userFlow='/>"+ userFlow,"分配用户角色", 900, 500);
}
function resetPasswd(userFlow){
	jboxConfirm("确认将该用户的密码重置为:${GlobalConstant.INIT_PASSWORD} 吗？",function () {
		var url = "<s:url value='/sys/user/resetPasswd?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
			//searchUser();			
		});		
	});
}
function activate(userFlow){
	jboxConfirm("确认解锁该用户吗？",function () {
		var url = "<s:url value='/sys/user/activate?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
			searchUser();			
		});
	});
}
function lock(userFlow){
	jboxConfirm("确认锁定该用户吗？锁定后该用户将不能登录系统！",function () {
		var url = "<s:url value='/sys/user/lock?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
			searchUser();			
		});		
	});
}
function inviteEmail(userFlow){
	jboxConfirm("确认重新发送该用户的邀请邮件吗？",function () {
		var url = "<s:url value='/edc/projUser/inviteEmail?userFlow='/>"+userFlow;
		jboxGet(url,null,function(){
	
		});
	});
}
function searchUser(){
	jboxStartLoading();
	$("#searchForm").submit();
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/edc/projUser/list/${sessionScope.userListScope}" />" method="post" >
				<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL }">
					参与机构：
					<select id="orgFlow" class="xlselect" name="orgFlow" style="80px;" onchange="searchUser();">
						<option value="">请选择</option>
						<c:forEach items="${pubProjOrgList}" var="projOrg">
							<option value="${projOrg.orgFlow}" <c:if test="${projOrg.orgFlow==param.orgFlow }">selected</c:if>>${projOrg.centerNo }&#12288;${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</option>
						</c:forEach>
					</select>
				</c:if>
				<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_LOCAL }">
					<input id="orgFlow" type="hidden" name="orgFlow" value="${sessionScope.currUser.orgFlow }"/>
				</c:if>
				身份证：<input type="text" id="idNo" name="idNo" value="${param.idNo}"  class="xltext "/>
		     	手机号：<input type="text" id="userPhone" name="userPhone" value="${param.userPhone}"  class="xltext "/>
		     	&#12288;Email：<input type="text" id="userEmail" name="userEmail" value="${param.userEmail}"  class="xltext "/>
				<br>  <br>  
				姓&#12288;<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL }">&#12288;</c:if>名：<input type="text" id="userName" name="userName" value="${param.userName}"  class="xltext"/>		
				用户状态：
				<input id="all" name="statusId" type="radio" value="" onclick="searchUser();" 
					<c:if test='${empty param.statusId}'>checked="checked"</c:if>>
				<label for="all">全部</label>&#12288;
				<c:if test="${sessionScope.currWsId==GlobalConstant.EDC_WS_ID}">
					<input id="${userStatusEnumAdded.id}" name="statusId" type="radio" value="${userStatusEnumAdded.id}" onclick="searchUser();" 
						<c:if test='${param.statusId==userStatusEnumAdded.id}'>checked="checked"</c:if>>
					<label for="${userStatusEnumAdded.id }">${userStatusEnumAdded.name}</label>&#12288;
				</c:if>
				<input id="${userStatusEnumActivated.id}" name="statusId" type="radio" value="${userStatusEnumActivated.id}" onclick="searchUser();" 
					<c:if test='${param.statusId==userStatusEnumActivated.id}'>checked="checked"</c:if>>
				<label for="${userStatusEnumActivated.id }">${userStatusEnumActivated.name}</label>&#12288;
				<input id="${userStatusEnumLocked.id}" name="statusId" type="radio" value="${userStatusEnumLocked.id}" onclick="searchUser();" 
					<c:if test='${param.statusId==userStatusEnumLocked.id}'>checked="checked"</c:if>>
				<label for="${userStatusEnumLocked.id }">${userStatusEnumLocked.name}</label>&#12288;
			    	<input type="button" class="search" onclick="searchUser();" value="查&#12288;询">
			    	<input type="button" class="search" onclick="addProjUser();" value="新&#12288;增">
			    	<input id="onlyShowAlloted" type="checkbox" name="onlyShowAlloted" onchange="searchUser();" value="Y" <c:if test="${param.onlyShowAlloted=='Y'}">checked</c:if>>
			    	<label for="onlyShowAlloted">只显示本研究有权限的用户</label>
			</form>
		</div>
		<table class="xllist" > 
			<tr>
				<th width="80px">状态</th>
				<th width="80px">姓名</th>
				<th width="30px">性别</th>
				<th width="100px">身份证</th>
				<th width="120px">手机</th>
				<th width="180px">邮件</th>
				<th width="180px">权限</th>
				<c:if test="${applicationScope.sysCfgMap['sys_weixin_qiye_flag']==GlobalConstant.FLAG_Y}">
				<th width="60px">微信状态</th>
				</c:if>
				<th width="180px" >操作</th>
			</tr>
		<c:set var="userNum" value="0"></c:set>
		<c:forEach items="${sysUserList}" var="sysUser">
			<c:if test="${sysUser.userCode!=GlobalConstant.ROOT_USER_CODE or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE }">
			<c:set var="userNum" value="${userNum+1 }"></c:set>
			<tr style="height:20px;display:<c:if test="${param.onlyShowAlloted=='Y' and empty pubProjUserMap[sysUser.userFlow]}">none</c:if> ; ">
				<td>${sysUser.statusDesc}</td>	
				<td>${sysUser.userName}</td>
				<td>${sysUser.sexName}</td>
				<td>${sysUser.idNo}</td>
				<td>${sysUser.userPhone}</td>
				<td>${sysUser.userEmail}</td>
				<td style="text-align: left;">
					<c:forEach items="${pubProjUserMap[sysUser.userFlow]}" var="sysUserRole" varStatus="status">
						${status.index+1}&nbsp;${applicationScope.sysRoleMap[sysUserRole.roleFlow].roleName }
						<c:if test="${not status.last }">,</c:if>						
					</c:forEach>
				</td>
				<c:if test="${applicationScope.sysCfgMap['sys_weixin_qiye_flag']==GlobalConstant.FLAG_Y}">
				<td width="60px" title="${sysUser.weiXinId}">${sysUser.weiXinStatusDesc}</td>
				</c:if>
				<td style="text-align: left;padding-left: 5px;">				
					<c:if test="${sysUser.statusId==userStatusEnumAdded.id}">
						[<a href="javascript:edit('${sysUser.userFlow}');" >编辑</a>] |
						[<a href="javascript:inviteEmail('${sysUser.userFlow}');" >重发邀请邮件</a>] 
					</c:if>	
					<c:if test="${sysUser.statusId==userStatusEnumReged.id}">
					[<a href="javascript:activate('${sysUser.userFlow}');" >审核</a>]
					</c:if>						
					<c:if test="${sysUser.statusId==userStatusEnumActivated.id}">
					[<a href="javascript:edit('${sysUser.userFlow}');" >编辑</a>] | 
					[<a href="javascript:resetPasswd('${sysUser.userFlow}');" >重置密码</a>] | 
					[<a href="javascript:lock('${sysUser.userFlow}');" >锁定</a>]
					</c:if>
					| [<a href="javascript:allotRole('${sysUser.userFlow}');" >分配角色</a>] | 
					<c:if test="${sysUser.statusId==userStatusEnumLocked.id}">
					[<a href="javascript:activate('${sysUser.userFlow}');" >解锁</a>]
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