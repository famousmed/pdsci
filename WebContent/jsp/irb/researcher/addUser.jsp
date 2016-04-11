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
	function saveUsers(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/irb/researcher/saveUsers'/>";
	 	jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.showProjUser();
				jboxClose();
			}
		},null,true);
	}
	function replaceNull(obj,str){
		if(obj==null){
			return str;
		}
		return obj;
	}
	function submit(){
		$("#editForm").submit();
	}
	function doChecked(userFlow) {
		var user = $("#"+userFlow);
		if (user.attr("checked")) {
			user.attr("checked",false);
		} else {
			user.attr("checked",true);
		}
	}
</script>
<style type="text/css">
	table.xllist tr th, table.xllist tr td{text-align: center;padding: 0;margin: 0;}
</style>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="editForm" action="<s:url value='/irb/researcher/showAddUser'/>" method="post">
        	<div class="title1 clearfix">
					&#12288;所属部门：
		             <select id="deptFlow" name="deptFlow" class="xlselect" onchange="submit()">
		            	<option value="" >全部</option>
		            	<c:forEach items="${depList }" var="dep">
		            		<option value="${dep.deptFlow}" <c:if test="${dep.deptFlow==param.deptFlow}">selected="selected"</c:if> >${dep.deptName}</option>
		            	</c:forEach>
		            </select>
			 		研究岗位：
			 		<select name="roleFlow" onchange="submit()" class="xlselect">
		            	<c:forEach items="${roleList}" var="role" varStatus="statu">
		            		<option value="${role.roleFlow}" <c:if test="${statu.first||role.roleFlow==param.roleFlow}">selected="selected"</c:if>>${role.roleName}</option>
		            	</c:forEach>
		            </select>
				</div>
		            <table class="xllist" width="100%" id="irbUsers">
		            <thead>
		            	<tr>
		            		<th width="5%"></th>
		            		<th width="10%">姓名</th>
		            		<th width="8%">性别</th>
		            		<th width="13%">部门</th>
		            		<th width="12%">职务</th>
		            		<th width="12%">职称</th>
		            		<th width="15%">手机</th>
		            		<th width="15%">邮件</th>
		            	</tr>
		            </thead>
		            <c:forEach items="${userList}" var="user">
		            	<tr onclick="doChecked('${user.userFlow}');" style="cursor: pointer;">
			            	<td width="5%"><input type="checkbox" onclick="doChecked('${user.userFlow}');"  id="${user.userFlow}" name="userFlows" value="${user.userFlow}"/></td>
			            	<td width="10%">${user.userName}</td>
			            	<td width="8%">${user.sexName}</td>
			            	<td width="13%">${user.deptName}</td>
			            	<td width="12%">${user.postName}</td>
			            	<td width="12%">${user.titleName}</td>
			            	<td width="15%">${user.userPhone}</td>
			            	<td width="15%">${user.userEmail}</td>
		            	</tr>
		            </c:forEach>
		            </table>
			<p align="center" style="width:100%;margin-top: 20px">
			    <input name="recordFlow" type="hidden" value="${info.recordFlow }" />
				<input class="search" type="button" value="保&#12288;存"  onclick="saveUsers();" />
				<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();" />
			</p>
			</form>
         </div>
     </div> 	
   </div>
</body>
</html>