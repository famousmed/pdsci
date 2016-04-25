<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
function tieredMedical(){
	window.location.href = "<s:url value='/jsp/medroad/tms/index.jsp'/>";
}
function changeProj(){
	jboxConfirm("确认切换项目?",function(){
		jboxStartLoading();
		window.location.href = "<s:url value='/medroad/main'/>";
	});
}
</script>
<div class="head">
	<div class="head_inner">
		<h1 class="logo">
			<c:choose>
				<c:when test="${!empty  edcCurrProj && !empty role}">
					<a href="<s:url value='/medroad/index?projFlow=${edcCurrProj.projFlow}&roleFlow=${role.roleFlow}'/>">${applicationScope.sysCfgMap['sys_title_name']}</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:void();">${applicationScope.sysCfgMap['sys_title_name']}</a>
				</c:otherwise>
			</c:choose>
			
		</h1>
		<c:if test="${not param.notShowAccount}">
		<div class="account">
			<h2 style="text-align: right">欢迎您：${sessionScope.currUser.userName }&#12288;-&#12288;${sessionScope.currUser.orgName }</h2>
			<div class="head_right">
				<a href="<s:url value='/medroad/index?projFlow=${edcCurrProj.projFlow}&roleFlow=${role.roleFlow}'/>">首页</a>&#12288;
				<!-- 
				<a href="javascript:tieredMedical();">分级诊疗</a>&#12288;
				<a href="javascript:changeProj();">临床科研一体化</a>&#12288;
				 -->
				<a href="javascript:changeProj();">${proj.projShortName}&#12288;(${role.roleName})</a>&#12288;
<!-- 

				<a href="javascript:void();">教育培训</a>&#12288;
 -->
				<a href="<s:url value='/logout'/>">退出</a>
			</div>
		</div>
		</c:if>
		
	</div> 
</div>