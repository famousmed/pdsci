<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	function saveAllot() {
		if(false==$("#allotForm").validationEngine("validate")){
			return ;
		}
		var url = '<s:url value="/edc/projUser/saveAllot"/>';
		jboxPost(url, $('#allotForm').serialize(), function() {
			window.parent.frames['mainIframe'].window.searchUser();
			jboxClose();
		});
	}
</script>
</head>
<body>
<form id="allotForm" action="<s:url value="/edc/projUser/saveAllot"/>" method="post">
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th style="width: 40%;">用户名称：
							<input name="userFlow" type="hidden" value="${sysUser.userFlow}">
							<input name="orgFlow" type="hidden" value="${sysUser.orgFlow}">
						</th>
						<td style="width: 60%;">
							${sysUser.userName}
						</td>
					</tr>
					<c:forEach items="${sysRoleList}" var="sysRole">
					<tr>
						<th></th>
						<td>
							<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_GLOBAL }">
								<input id="${sysRole.roleFlow}" name="roleFlow" type="checkbox" value="${sysRole.roleFlow}" <c:if test="${pdfn:contain(sysRole.roleFlow, roleFlows)}">checked</c:if>>
								&#12288;<label for="${sysRole.roleFlow}">${sysRole.roleName}</label>&#12288;
							</c:if>
							<c:if test="${sessionScope.userListScope==GlobalConstant.USER_LIST_LOCAL }">
								<%-- 如果循环的角色当前用户具有，显示 --%>
								<%--  如果循环的角色父角色当前用户具有，显示--%>
								<c:if test="${pdfn:contain(sysRole.roleFlow, sessionScope.currRoleList) or pdfn:contain(sysRole.parentRoleFlow, sessionScope.currRoleList) or sessionScope.currUser.userCode==GlobalConstant.ROOT_USER_CODE}">
								<input id="${sysRole.roleFlow}" name="roleFlow" type="checkbox" value="${sysRole.roleFlow}" <c:if test="${pdfn:contain(sysRole.roleFlow, roleFlows)}">checked</c:if>>
								&#12288;<label for="${sysRole.roleFlow}">${sysRole.roleName}</label>&#12288;
								</c:if>
								<%-- 如果循环的角色不能显示，但已经具有，隐藏起来 --%>
								<c:if test="${!pdfn:contain(sysRole.roleFlow, sessionScope.currRoleList) and !pdfn:contain(sysRole.parentRoleFlow, sessionScope.currRoleList) and sessionScope.currUser.userCode!=GlobalConstant.ROOT_USER_CODE}}">											
									<c:if test="${pdfn:contain(sysRole.roleFlow, roleFlows)}">
										<input name="roleFlow" type="hidden" value="${sysRole.roleFlow}"/>
									</c:if>
								</c:if>
							</c:if>
						</td>
					</tr>								
					</c:forEach>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveAllot();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>