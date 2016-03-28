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
	function choose(roleFlow,id) {
		var url = "<s:url value='/res/doc/chooseTeacherOrHead'/>?roleFlow="+roleFlow+"&resultFlow=${param.resultFlow}&id="+id;
		jboxOpen(url,"选择用户",900,window.screen.height*0.7);
	}
	function save(){
		var $form = $("#saveForm");
		if($form.validationEngine("validate")){
			var url = "<s:url value='/res/doc/saveChoose'/>";
			var requestData = $form.serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
					<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_HEAD}">
						window.parent.frames["mainIframe"].changeDept('${param.schDeptFlow}');
						return top.jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					</c:if>
					window.parent.frames["mainIframe"].window.location.href="<s:url value='/res/doc/rotationDetail'/>?resultFlow=${param.resultFlow}&rotationFlow=${param.rotationFlow}&schDeptFlow=${param.schDeptFlow}&roleFlag=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}";
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
   		<table class="basic" width="100%">
      		<tr>
             	<td width="100px;">科主任：</td>
                <td>
                	<select name="headUserFlow" style="width: 80%;height: 27px;">
                		<option>
                		<c:forEach items="${headList}" var="user">
                			<option value="${user.userFlow}" <c:if test="${param.headUserFlow eq user.userFlow}">selected</c:if>>${user.userName}</option>
                		</c:forEach>
                	</select>
				</td>
             </tr>
      		<tr>
             	<td width="100px;">带教老师：</td>
                <td>
                	<select name="teacherUserFlow" class="validate[required]" style="width: 80%;height: 27px;">
                		<option>
                		<c:forEach items="${teacherList}" var="user">
                			<option value="${user.userFlow}">${user.userName}</option>
                		</c:forEach>
                	</select>
				</td>
             </tr>
         </table>
			<p align="center">
				<input type="hidden" name="resultFlow" value="${param.resultFlow}" /> 
				<input type="hidden" name="preResultFlow" value="${param.preResultFlow}" /> 
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>