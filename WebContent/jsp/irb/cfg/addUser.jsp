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
		var url = "<s:url value='/irb/cfg/saveUsers'/>";
	 	jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.reload();
				jboxClose();
			}
		},null,true);
	}
	function changeUsers(){
		var deptFlow = $("#deptFlow").val();
		var url = "<s:url value='/irb/cfg/queryUserByDep'/>";
		var requestData = {"deptFlow":deptFlow}; 
		jboxPost(url,requestData,function(resp){
			if(resp){
				var html = "";
				$.each(resp, function(index,obj){
					html += '<tr><td><input type="checkbox" name="userFlows" value="'+obj.userFlow+'"/></td><td>'+replaceNull(obj.userName,"")+'</td><td>'+replaceNull(obj.sexName,"")+'</td><td>'+replaceNull(obj.orgName,"")+'</td><td>'+replaceNull(obj.deptName,"")+'</td><td>'+replaceNull(obj.titleName,"")+'</td></tr>'; 
				});
				$("#irbUsers").html(html);
			}
		},null,false);
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
</script>
<style type="text/css">
	table.xllist tr th, table.xllist tr td{text-align: center;padding: 0;margin: 0;}
</style>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="editForm" action="<s:url value='/irb/cfg/showAddUser'/>" method="post">
   		<table class="basic" width="100%" style="margin: 0 auto;">
            <tr>
                <th class="td_blue" width="100px">委员会名称：</th>
                <td >
                	${info.irbName }
                </td>
                 <th class="td_blue" width="100px">委员会简称：</th>
                <td>
                	${info.irbShortName }
                </td>
                 <th class="td_blue" width="90px">联系人：</th>
                <td>
                	${info.contactUser }
                </td>
            </tr>
             <tr>
                <th class="td_blue" width="80px">联系电话：</th>
                <td>
                	${info.contactMobile }&#12288;${info.contactPhone }
                </td>
                <th class="td_blue" width="80px">联系邮件：</th>
                <td>
                	${info.contactEmail }
                </td>
                <th class="td_blue" width="80px">会议地点：</th>
                <td>
                	${info.meetingAddress }
                </td>
            </tr>
			</table>
			
			<table class="basic" width="100%" style="margin-top: 10px;" >
				<tr>
	            	<th class="td_blue" width="100px">伦理职务：</th>
		            <td colspan="3">
		            	<c:forEach items="${roleList}" var="role" varStatus="statu">
		            		<input type="radio" id="${role.roleFlow}" name="roleFlow" value="${role.roleFlow}" <c:if test="${statu.first||role.roleFlow==param.roleFlow}">checked="checked"</c:if> onchange="submit()" /> <label for="${role.roleFlow}">${role.roleName}&#12288;</label>
		            	</c:forEach>
		            </td>
	            </tr>
				<tr>
				 	<th class="td_blue" width="80px">姓名：</th>
				 	<td><input type="text" name="userName" class="xltext" value="${param.userName }" onchange="submit()"></td>
		            <th class="td_blue" width="100px">所属部门：</th>
		            <td >
		            	<select id="deptFlow" name="deptFlow" class="xlselect" onchange="submit()">
		            		<option value="">全部</option>
		            		<c:forEach items="${depList }" var="dep">
		            			<option value="${dep.deptFlow}" <c:if test="${dep.deptFlow==param.deptFlow}">selected="selected"</c:if> >${dep.deptName}</option>
		            		</c:forEach>
		            	</select>
		            </td>
	            </tr>
			</table>
			     <table class="xllist" width="100%" id="irbUsers" style="border-top: none;">
		            <thead>
		            	<tr>
		            		<th width="6%">勾选</th>
		            		<th width="10%">姓名</th>
		            		<th width="7%">性别</th>
		            		<th width="15%">部门</th>
		            		<th width="15%">职务</th>
		            		<th width="12%">职称</th>
		            		<th width="14%">手机</th>
		            		<th width="21%">邮件</th>
		            	</tr>
		            </thead>
		            <c:forEach items="${userList}" var="user">
		            	<tr>
			            	<td width="6%"><input type="checkbox" name="userFlows" value="${user.userFlow}"/></td>
			            	<td width="10%">${user.userName}</td>
			            	<td width="7%">${user.sexName}</td>
			            	<td width="15%">${user.deptName}</td>
			            	<td width="15%">${user.postName}</td>
			            	<td width="12%">${user.titleName}</td>
			            	<td width="14%">${user.userPhone}</td>
			            	<td width="21%">${user.userEmail}</td>
		            	</tr>
		            </c:forEach>
		            </table>
			<p align="center" style="width:100%">
			    <input name="recordFlow" type="hidden" value="${info.recordFlow }" />
				<input class="search" type="button" value="保&#12288;存"  onclick="saveUsers();" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>
</body>
</html>