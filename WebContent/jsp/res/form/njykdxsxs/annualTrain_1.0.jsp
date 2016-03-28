<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.noHead}">
	<jsp:include page="/jsp/common/htmlhead.jsp">
		<jsp:param name="basic" value="true"/>
		<jsp:param name="jbox" value="true"/>
		<jsp:param name="jquery_form" value="true"/>
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
		<jsp:param name="ueditor" value="true"/>
	</jsp:include>
</c:if>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function saveForm(){
	if($("#resRecForm").validationEngine("validate")){
		jboxSubmit($("#resRecForm"),"<s:url value='/res/rec/saveRegistryForm'/>",function(resp){
			if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
				parentRefresh();
				jboxClose();
			}				
		},function(resp){
			jboxTip("${GlobalConstant.SAVE_FAIL}");
		},true);
	}
}
function parentRefresh(){
	window.parent.frames['mainIframe'].window.loadProcess();
}

$(function(){
	<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
		$("#resRecForm").find(":text,textarea").each(function(){
			$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
		});
		$("#resRecForm select").each(function(){
			var text = $(this).find(":selected").text();
			$(this).replaceWith($('<label>'+text+'</label>'));
		});
		$("#resRecForm").find(":checkbox,:radio").attr("disabled",true);
		$(":file").remove();
	</c:if>
});
</script> 
</head>
<body>
<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="resRecForm" method="post">
          <input type="hidden" name="formFileName" value="${formFileName}"/>
		  <input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
	      <input type="hidden" name="recFlow" value="${rec.recFlow}"/>
	      <input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;登记信息</th>
            </tr>
             <tr>
				<td style="width: 100px;"><font color="red">*</font>学习类型：</td>
                <td >
                   <input class="validate[required] " name="studyType" type="text" value="${formDataMap['studyType']}" style="width: 150px;"/>
				</td>
				<td style="width: 100px;"><font color="red">*</font>培训内容：</td>
                <td >
                    <input class="validate[required] " name="trainContent" type="text" value="${formDataMap['trainContent']}" style="width: 150px;"/>
				</td>
			</tr>
			<tr>
             	<td style="width: 100px;">培训日期：</td>
                <td >
                	<input style="width: 150px;" name="trainDate" type="text" value="${formDataMap['trainDate']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
				<td style="width: 110px; line-height: 20px;">学分数/学时数：</td>
				<td>
					<input style="width: 150px;" name="academicScore" type="text" value="${formDataMap['academicScore']}"/>
				</td>
			</tr>
             <tr>
				<td style="width: 100px;"><font color="red">*</font>备注：</td>
				<td colspan="3">
					<textarea  name="remarks"  class="validate[required] xltxtarea" style="margin-left: 0px;" >${formDataMap['remarks']}</textarea>
				</td>
             </tr>
              </table>
			<p align="center">
					<input class="search" type="button" value="保&#12288;存"  onclick="saveForm();"/>
				<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();"/>
			</p>
			 </form>
         </div>
     </div> 	
   </div>
</body>
</html>