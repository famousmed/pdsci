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
	function deleteUser(recordStatus){
		var recordFlow = $("input[name='chooseUser']:checked").val();
		if(!recordFlow){
			jboxTip("请选择要删除的记录！");
			return false;
		}
		var roleFlow = $("input[name='chooseUser']:checked").attr("roleFlow");
		if (roleFlow == "${applicationScope.sysCfgMap['researcher_role_flow']}") {
			var userFlow = $("#userFlow").val();
			jboxGet("<s:url value='/irb/researcher/delResUserConfirm'/>?userFlow="+userFlow,null,function(resp){
				if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
					doDeleteUser(recordStatus);
				} else if(resp == "${GlobalConstant.OPRE_FAIL}"){
					jboxTip("该主要研究者不能删除!");
				}
			},null,false);
		} else {
			doDeleteUser(recordStatus);
		}
	}
	
	function doDeleteUser(recordStatus){
		var url = '<s:url value="/irb/researcher/delResUser" />';
		var recordFlow = $("input[name='chooseUser']:checked").val();
		var userName = $("#userName").val();
		var roleName = $("input[name='chooseUser']:checked").attr("roleName");
		
		jboxConfirm("确认删除 <b>"+userName+"</b> 的 <b>"+roleName+"</b> 角色?",function(){
			var requestData = {"recordFlow":recordFlow,"recordStatus":recordStatus};
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.showProjUser();
					jboxClose();
				}
			},null,true);
		},null);
	}
	
	function doChecked(recordFlow) {
		var user = $("#"+recordFlow);
		if (user.attr("checked")) {
			user.attr("checked",false);
		} else {
			user.attr("checked",true);
		}
	}
</script>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="editForm">
   		<table class="basic" width="100%" style="margin: 0 auto;">
   			<c:forEach items="${userList}" var="user">
   				<tr onclick="doChecked('${user.recordFlow}');" style="cursor: pointer;">
	   				<td style="text-align: center">
	   					<input type="radio" id="${user.recordFlow}" name="chooseUser" value="${user.recordFlow}" roleFlow="${user.role.roleFlow}" roleName="${user.role.roleName}" onclick="doChecked('${user.recordFlow}');"/>
	   				</td>
	   				<td>
	   					${user.role.roleName}
	   					<input type="hidden" id="userName" value="${user.user.userName }">
	   					<input type="hidden" id="userFlow" value="${user.user.userFlow }">
	   				</td>
   				</tr>
   			</c:forEach>
		</table>
			<p align="center" style="width:100%">
				<input class="search" type="button" value="确&#12288;定"  onclick="deleteUser('${GlobalConstant.RECORD_STATUS_N}');" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>
</body>
</html>