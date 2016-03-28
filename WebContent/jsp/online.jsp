<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="refresh" content="60">
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
<script>
function resetUserLogin(userFlow){
	jboxGet('<s:url value='/resetUserLogin'/>?userFlow='+userFlow,function(resp){
		jboxTip(resp);
		window.location.href="<s:url value='/online'/>?date="+new Date();
	},null,false);
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<table class="xllist" >  
				<tr>
   					<th colspan="10" align="center">当前服务器标识：${pdfn:split(pageContext.session.id,'.')[1] } ,系统共有${fn:length(sessionDataList)}个用户在线</th>
   				</tr>
				<tr>
   					<th height="18" width="60" align="center">序号</th>
   					<th height="18" width="100" align="center">服务器</th>
   					<th height="18" width="60" align="center">登录名</th>
   					<th height="18" width="60" align="center">用户</th>
   					<th align="center" width="150">机构</th>
   					<th align="center" width="150">登录IP</th>	            					
   					<th align="center" width="150">登录时间</th>
   					<th align="center" width="150">最后一次操作时间</th>
   					<th align="center" width="150">离线时间</th>
   					 <c:if test='${!empty sessionScope.currUser }'>
   					<th width="100">操作</th>
   					</c:if>
   				</tr>
				<c:forEach items="${sessionDataList}" var="sessionData" varStatus="status">
				<tr>
   					<td>${status.index+1 }</td>
   					<td>${pdfn:split(sessionMap[sessionData.sysUser.userFlow].id,'.')[1] }</td>
   					<td>${sessionData.sysUser.userCode }</td>
   					<td>${sessionData.sysUser.userName }</td>
   					<td>${sessionData.sysUser.orgName }</td>
   					<td>${sessionData.ip }</td>
   					<td>${sessionData.loginTime }</td>
   					<td>${sessionData.lastAccessTime }</td>
   					<td>${sessionData.gapTime }</td>
   					 <%-- <c:if test='${pageContext.request.remoteAddr eq applicationScope.sysCfgMap["super_ip"] }'>--%>
   					 <c:if test='${!empty sessionScope.currUser }'>
   						<td><a href="javascript:resetUserLogin('${sessionData.sysUser.userFlow }');">重置登录</a></td>
   					</c:if>
   				</tr>
		   		</c:forEach> 
			</table>
			</div>
		</div>
	</div>
</body>
</html>