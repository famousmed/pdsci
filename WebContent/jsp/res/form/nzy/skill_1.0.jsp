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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
</c:if>
<style type="text/css">
	#boxHome .item:HOVER{background-color: #eee;}
</style>
<script>
function saveForm(){
	if($("#skillForm").validationEngine("validate")){
		jboxSubmit($("#skillForm"),"<s:url value='/res/rec/saveRegistryForm'/>",function(resp){
			parentRefresh();
			jboxClose();				
		},function(resp){
			jboxTip("${GlobalConstant.SAVE_FAIL}");
		},true);
	}
}

$(function(){
	<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
		$("#skillForm").find(":text,textarea").each(function(){
			$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
		});
		$("#skillForm select").each(function(){
			var text = $(this).find(":selected").text();
			
			$(this).replaceWith($('<label>'+text+'</label>'));
		});
		$("#skillForm").find(":checkbox,:radio").attr("disabled",true);
		$(":file").remove();
	</c:if>
});

function recSubmit(rec){
	jboxConfirm("确认提交?",function(){
		jboxPost("<s:url value='/res/rec/opreResRec'/>",rec,function(resp){
			if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
				parentRefresh();
				jboxClose();
			}
		},null,true);
	},null);
}

function parentRefresh(){
	window.parent.frames['mainIframe'].window.loadProcess();
}
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="skillForm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;登记信息</th>
            </tr>
             <tr>
             	<td style="width: 150px;"><font color="red">*</font>技术操作及手术名称</td>
               <td colspan="1">
                	<input id="inputMain" type="text" class="validate[required]" name="skillName" style="width: 160px;" value="${formDataMap['skillName']}"/>
				</td>
					<td style="width: 100px;"><font color="red">*</font>日期：</td>
                <td colspan="1">
                	 <input style="width: 160px;" class="validate[required]" name="date" type="text" value="${formDataMap['date']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>

				</td>
             </tr>
             <tr>
             
				<%-- <td style="width: 100px;"><font color="red">*</font>例次(份)：</td>
                <td >
                    <input style="width: 160px;" class="validate[required]" name="cases" type="text" value="${formDataMap['cases']}" />
				</td> --%>
				
				<td style="width: 100px;">第一助手：</td>
                 <td colspan="1">
                    <input style="width: 160px;"  name="firstAssistant" type="text" value="${formDataMap['firstAssistant']}" />
				</td>
				<td style="width: 100px;">第二助手：</td>
                 <td colspan="1">
                    <input style="width: 160px;" name="secondAssistant" type="text" value="${formDataMap['secondAssistant']}" />
				</td>
             </tr>
              <tr>
             	<td style="width: 100px;"><font color="red">*</font>住院号：</td>
                 <td colspan="1">
                    <input style="width: 160px;" class="validate[required]" name="status" type="text" value="${formDataMap['status']}" />
				</td>
				<td style="width: 100px;"><font color="red">*</font>考核者：</td>
                 <td colspan="1">
                    <input style="width: 160px;" class="validate[required]" name=assessment type="text" value="${formDataMap['assessment']}" />
				</td>
             </tr>
             
             	
			
              </table>
			<p align="center">
				<c:if test="${!(rec.auditStatusId eq recStatusEnumTeacherAuditY.id) && !param.isRead}">
					<input class="search" type="button" value="保&#12288;存"  onclick="saveForm();"/>
				</c:if>
				<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();"/>
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>