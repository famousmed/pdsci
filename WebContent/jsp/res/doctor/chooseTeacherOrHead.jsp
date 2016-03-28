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
	<jsp:param name="jquery_cxselect" value="true"/>
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
	function doChoose(userFlow,userName) {
		var id = "${param.id}";
		window.parent.frames["jbox-message-iframe"].document.getElementById(id+"UserName").value=userName;
		window.parent.frames["jbox-message-iframe"].document.getElementById(id+"UserFlow").value=userFlow;
		jboxClose();
	}
</script>
<style type="text/css">
.basic tbody th{padding:0;text-align: center;background-color: #f3f3f3;}
.basic tbody td{padding:0;text-align: center;}
</style>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="sysOrgForm">
   		<table class="basic" width="100%">
   			<colgroup>
   				<col width="20%"/>
   				<col width="30%"/>
   				<col width="25%"/>
   				<col width="25%"/>
   			</colgroup>
   			<tr>
                <th>姓名</th>
                <th>科室</th>
                <th>职务</th>
                <th>职称</th>
            </tr>
            <c:forEach items="${userList }" var="user">
      		<tr onclick="doChoose('${user.userFlow}','${user.userName }');" title="点击选择" style="cursor: pointer;">
            	<td>${user.userName}</td> 	                    
            	<td>${user.deptName}</td> 	                    
            	<td>${user.postName}</td> 	                    
            	<td>${user.titleName}</td> 	                    
             </tr>
             </c:forEach>
             <c:if test="${empty userList }">
             <tr>
             	<td colspan="4">暂无相关记录！</td>
             </tr>	
             </c:if>
         </table>
		</form>
         </div>
     </div> 	
   </div>	
</body>
</html>