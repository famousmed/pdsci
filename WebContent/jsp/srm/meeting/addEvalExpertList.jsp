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
	function saveExpertGroupUser() {
		var url = "<s:url value='/srm/meeting/addEvalExpert'/>";
		jboxStartLoading();
		jboxPost(url , $('#expertGroupUserForm').serialize() , function(){
			window.parent.frames['mainIframe'].window.search();
			window.location.reload(true);
		} , null , true);
	}
	function doClose() {
		jboxClose();
	}
</script>
<style type="text/css">
	.basic tbody th,.basic td {text-align: center; padding:0px;}
</style>
</head>
<body>
<div class="mainright">
    <div class="content">
        <div class="title1 clearfix">
		<form id="expertGroupUserForm">
			<table class="basic" style="width: 100%;">
				<tr>
					<th>选择</th>
					<th>姓名</th>
					<th>性别/职称</th>
					<th>学历</th>
					<th>机构名称</th>
					<th>技术领域</th>
				<tr>
				<c:forEach items="${expertInfoList}" var="expertInfo">
					<tr>
						<td width="6%">
							<input id="${expertInfo.expert.userFlow}" name="userFlow" type="checkbox" value="${expertInfo.expert.userFlow}" class="validate[required]" >
						</td>
						<td width="13%">${expertInfo.user.userName}</td>
						<td width="15%">${expertInfo.user.sexName}/${expertInfo.user.titleName}</td>
						<td width="10%">${expertInfo.user.educationName}</td>
						<td width="22%">${expertInfo.user.orgName}</td>
						<td >${expertInfo.expert.techAreaName}</td>	
					</tr>													
				</c:forEach>
			</table>
			<p align="center">
				<input type="button" value="保存" class="search"  onclick="saveExpertGroupUser();"  />
				<input type="hidden" name="groupFlow" value="${param.groupFlow}" /> 
				<input type="button" class="search" onclick="doClose();" value="关闭">
			</p>
		</form>
	</div>
	</div>
	</div>
</body>
</html>