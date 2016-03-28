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
function doClose(){
	jboxClose();
}
function save(){
	var url = "<s:url value='/srm/expert/proj/saveExpertNotice'/>?projFlow=${param.projFlow}";
	jboxStartLoading();
	jboxPost(url , $('#expertForm').serialize() , function(){} , null , true);
}
</script>
</head>
<body>
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
             <h2>&#12288;&#12288;项目名称：<span id="pjname"></span></h2>
		     <h2>&#12288;&#12288;评审委员名单</h2>
        </div>
        <form id="expertForm" method="post">
			<table class="xllist">
				<thead>
	       			<tr>
	           			<th width="10%">姓名</th> 
	            		<th width="10%">状态</th> 
	           			<th width="30%">邮件通知</th>
	           			<th width="30%">电话通知</th>
	           			<th>专家反馈</th>
	       			</tr>
       			</thead>
       			<tbody>
	      			<c:set var="pjName" value=""/>
	      			<c:forEach items="${expertProjList}" var="expertProj" varStatus="status"> 
		   				<tr>
		       				<td>${expertProj.userName}
		       					<c:if test="${status.index==0 }"> <c:set var="pjName" value="${expertProj.projName}"/></c:if>
		       					<input type="hidden" name="recordFlows" value="${expertProj.expertProjFlow}"/>
		       				</td>
		         			<td>
		         				<c:choose>
		         					<c:when test="${ empty expertProj.agreeFlag }">
		         						拟参评
		         					</c:when>
		         					<c:when test="${expertProj.agreeFlag eq  GlobalConstant.FLAG_Y}">
		         						确认参评
		         					</c:when>
		         					<c:when test="${expertProj.agreeFlag eq  GlobalConstant.FLAG_N}">
		         						确认不参评
		         					</c:when>
		         				</c:choose>
		         			</td>
		       				<td><input type="checkbox" name="${expertProj.expertProjFlow}_emailNotifyFlag" value="${ GlobalConstant.FLAG_Y}" <c:if test="${expertProj.emailNotifyFlag== GlobalConstant.FLAG_Y}">checked</c:if>/></td>
		      				<td><input type="checkbox" name="${expertProj.expertProjFlow}_phoneNotifyFlag" value="${ GlobalConstant.FLAG_Y}" <c:if test="${expertProj.phoneNotifyFlag== GlobalConstant.FLAG_Y}">checked</c:if>/></td>
		       				<td><input type="text" name="${expertProj.expertProjFlow}_feedBackInfo"  value="${expertProj.feedbackInfo }" /></td>
		   				</tr>
	   				</c:forEach>
   				</tbody>
			</table>
   			<div style="text-align: center;margin-top: 20px">
   				<input class="search" type="button" onclick="save();" value="保存"/>
            	<input class="close" type="button" onclick="doClose();" value="关闭"/>
   			</div>
		</form>
     </div> 	
   </div>
</body>
<script defer="defer">
$(document).ready(function(){
	$("#pjname").html('${pjName}');
});
</script>
</html>
