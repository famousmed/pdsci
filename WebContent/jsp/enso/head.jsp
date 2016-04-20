<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="head">
	<div class="head_inner">
		<h1 class="logo">
			<a href="<s:url value='${param.indexUrl}'/>">${applicationScope.sysCfgMap['sys_title_name']}</a>
		</h1>
		<c:if test="${not param.notShowAccount}">
		<div class="account">
			<h2 style="text-align: right">${sessionScope.currUser.userName }&#12288;-&#12288;${sessionScope.currUser.orgName }</h2>
			<div class="head_right">
				<a href="<s:url value='${param.indexUrl}'/>">首页</a>&#12288;
				<a href="javascript:changeProj();">${proj.projShortName}&#12288;(${role.roleName})</a>&#12288;
				<a href="<s:url value='/logout'/>">退出</a>
			</div>
		</div>
		</c:if>
		
	</div> 
</div>