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
		var url = "<s:url value='/srm/expert/groupUser/saveExpertGroupUser'/>";
		jboxStartLoading();
		jboxPost(url , $('#expertGroupUserForm').serialize() , function(){
			window.parent.frames['jbox-message-iframe'].window.location.reload(true);
		} , null , true);
	}
	function search(){
		var url = "<s:url value='/srm/expert/groupUser/search'/>";
		jboxStartLoading();
		jboxPost(url , $('#expertGroupUserForm').serialize() , function(resp){
			$("#tbody").empty();
			var techAreaName = "";
			$.each(resp , function(i , n){
				techAreaName = n.expert.techAreaName;
				if(techAreaName==null){
					techAreaName = "";
				}
				$("#tbody").append("<tr>"+"<td style='text-align: center;'>"+"<input type='checkBox' id='"+n.expert.userFlow+"' name='userFlow' value='"+n.expert.userFlow+"' class='validate[required]''>"+"</td>"+"<td style='text-align: center;'>"+n.user.userName+"</td>"+"<td style='text-align: center;'  >"+n.user.sexName+"/"+n.user.titleName+"</td>"+"<td style='text-align: center;'>"+n.user.degreeName+"</td>"+"<td style='text-align: center;'>"+n.user.orgName+"</td>"+"<td style='text-align: center;'>"+techAreaName+"</td>"+"</tr>");
			});
		} , null , false);
		   
	}
	function doClose() {
		jboxClose();
	}
	function c(obj){
		alert(obj.id);
	}
</script>
</head>
<body>
	
<div class="mainright">
    <div class="content">
        <div class="title1 clearfix">
			<form id="expertGroupUserForm" action="/srm/expert/groupUser/search" method="post">
				专家名称：<input type="text" name="userName" value="${param.userName}" class="xltext"/>
				机构名称 ：<input type="text" name="orgName" value="${param.orgName}" class="xltext"/>
						<input type="button" class="search" onclick="search();"  value="查询"/>
						<input type="hidden" name="groupFlow" value="${param.groupFlow}" /> 
				<p></p>
			<table class="xllist" style="width: 100%" >
			  <thead>
				<tr>
					<th>选择</th>
					<th>姓名</th>
					<th>性别/职称</th>
					<th>学位</th>
					<th>机构名称</th>
					<th>技术领域</th>
				<tr>
			   </thead>
			   <tbody id="tbody">
				<c:forEach items="${expertInfoList}" var="expertInfo">
					<tr>
						<td >
							<input id="${expertInfo.expert.userFlow}" name="userFlow" type="checkbox" value="${expertInfo.expert.userFlow}" class="validate[required]" >
						</td>
						<td>${expertInfo.user.userName}</td>
						<td>${expertInfo.user.sexName}/${expertInfo.user.titleName}</td>
						<td>${expertInfo.user.degreeName}</td>
						<td>${expertInfo.user.orgName}</td>
						<td>${expertInfo.expert.techAreaName}</td>	
					</tr>													
				</c:forEach>
				</tbody>
			</table>
			</form>
			<p align="center">
				<input type="button" value="保&#12288;存" class="search"  onclick="saveExpertGroupUser();"  />
				<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
			</p>
		</div>
	</div>
</div>
</body>
</html>