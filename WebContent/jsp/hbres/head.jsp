<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="head">
	<div class="head_inner">
		<h1 class="logo">
			<a href="<s:url value='${param.indexUrl}'/>">湖北省住院医师规范化培训招录系统</a>
		</h1>
		<c:if test="${not param.notShowAccount}">
		<div class="account">
			<h2>${sessionScope.currUser.orgName }</h2>
			<div class="head_right">
				<a href="<s:url value='${param.indexUrl}'/>">首页</a>&#12288;
				<a href="<s:url value='/inx/hbres/logout'/>">退出</a>
			</div>
		</div>
		</c:if>
		
	</div>
</div>