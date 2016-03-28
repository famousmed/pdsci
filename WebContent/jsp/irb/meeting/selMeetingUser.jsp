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
		if($("input[name='userFlows']:checked").length==0){
			jboxTip("请勾选记录！");
			return false;
		}
		var url = "<s:url value='/irb/meeting/saveMeetingUser'/>";
		var requestData = $("#editForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.reload();
				jboxClose();
			}
		},null,true);
	}
	
	function doChecked(userFlow) {
		var user = $("#"+userFlow);
		if (user.attr("checked")) {
			user.attr("checked",false);
		} else {
			user.attr("checked",true);
		}
	}
	
	function doClose() {
		jboxClose();
	}
	
</script>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <div style="margin-bottom: 5px;">
				&#12288;伦理委员会：${irbName }
		</div>
		<form id="editForm">
		<input type="hidden" name="meetingFlow" value="${meetingFlow }" >
		<input type="hidden" name="irbInfoFlow" value="${irbInfoFlow }" >
			<table class="xllist" width="100%" style="margin: 0 auto;">
		            <thead>
		            	<tr>
		            		<th width="5%"></th>
		            		<th>IRB岗位</th>
		            		<th width="15%">部门</th>
		            		<th width="7%">姓名</th>
		            		<th width="5%">性别</th>
		            		<th width="7%">学历</th>
		            		<th width="7%">学位</th>
		            		<th width="7%">职称</th>
		            		<th width="7%">职务</th>
		            		<th width="12%">手机</th>
		            		<th width="15%">邮件</th>
		            	</tr>
		            </thead>
		            <tbody>
		            <c:forEach items="${userList}" var="user">
		            	<tr  onclick="doChecked('${user.userFlow}');" style="cursor: pointer;">
			            	<td style="width:5%;"><input type="checkbox" onclick="doChecked('${user.userFlow}');" <c:if test="${!empty existUserMap[user.userFlow] }">checked="checked" </c:if> id="${user.userFlow}" name="userFlows" value="${user.userFlow}" /></td>
			            	<td>${user.roleName}
			            	</td>
			            	<td style="width:15%;">${sysUserMap[user.userFlow].orgName}</td>
			            	<td style="width:7%;">${sysUserMap[user.userFlow].userName}</td>
			            	<td style="width:5%;">${sysUserMap[user.userFlow].sexName}</td>
			            	<td style="width:7%;">${sysUserMap[user.userFlow].educationName}</td>
			            	<td style="width:7%;">${sysUserMap[user.userFlow].degreeName}</td>
			            	<td style="width:7%;">${sysUserMap[user.userFlow].titleName}</td>
			            	<td style="width:7%;">${sysUserMap[user.userFlow].postName}</td>
			            	<td style="width:12%;">${sysUserMap[user.userFlow].userPhone}</td>
			            	<td style="width:15%;">${sysUserMap[user.userFlow].userEmail}</td>
		            	</tr>
		            </c:forEach>
		            </tbody>
		            </table>
		</form>
		<div align="center" style="margin-top: 20px">
				<input type="button" class="search" value="保&#12288;存" onclick="saveUsers();" />
				<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" />
		</div>
         </div>
        
     </div> 	
   </div>
</body>
</html>