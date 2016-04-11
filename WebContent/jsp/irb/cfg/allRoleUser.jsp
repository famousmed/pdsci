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
	function saveInfo(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/irb/cfg/editInfo'/>";
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.reload();
				jboxClose();
			}
		},null,true);
	}
	function deleteUser(recordStatus){
		var url = '<s:url value="/irb/cfg/editUser" />';
		var recordFlow = $("input[name='chooseUser']:checked").val();
		if(!recordFlow){
			jboxTip("请选择要删除的记录！");
			return false;
		}
		var requestData = {"recordFlow":recordFlow,"recordStatus":recordStatus}
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.reload();
				jboxClose();
			}
		},null,true);
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
   				<tr><td><input type="radio" name="chooseUser" value="${user.recordFlow}"/></td><td>${user.roleName}</td></tr>
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