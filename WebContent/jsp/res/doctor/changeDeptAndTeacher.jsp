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
	function save(){
		var $form = $("#saveForm");
		if($form.validationEngine("validate")){
			var url = "<s:url value='/res/doc/modifySchDate'/>";
			var requestData = $form.serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
					var mainWindow = window.parent.mainIframe;
					mainWindow.$("#headUserNameSpan").text($("#headUserName").val());
					mainWindow.$("#teacherUserNameSpan").text($("#teacherUserName").val());
					jboxClose();
				}
			},null,true);
		}
	}
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="saveForm">
		<input type="hidden" name="processFlow" value="${process.processFlow}">
   		<table class="basic" width="100%">
      		<tr>
             	<td width="100px;">科主任：</td>
                <td>
                	<select name="headUserFlow" style="width: 80%;height: 27px;" onchange="$('#headUserName').val($(this).find(':selected').text());">
                		<option>
                		<c:forEach items="${headList}" var="user">
                			<option value="${user.userFlow}" <c:if test="${process.headUserFlow eq user.userFlow}">selected</c:if>>${user.userName}</option>
                		</c:forEach>
                	</select>
                	<input id="headUserName" type="hidden" name="headUserName" value="${process.headUserName}"/>
				</td>
             </tr>
      		<tr>
             	<td width="100px;">带教老师：</td>
                <td>
                	<select name="teacherUserFlow" class="validate[required]" style="width: 80%;height: 27px;" onchange="$('#teacherUserName').val($(this).find(':selected').text());">
                		<option>
                		<c:forEach items="${teacherList}" var="user">
                			<option value="${user.userFlow}" <c:if test="${process.teacherUserFlow eq user.userFlow}">selected</c:if>>${user.userName}</option>
                		</c:forEach>
                	</select>
                	<input id="teacherUserName" type="hidden" name="teacherUserName" value="${process.teacherUserName}"/>
				</td>
             </tr>
         </table>
			<p align="center">
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>