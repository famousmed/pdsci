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
	if($("#dblForm").validationEngine("validate")){
		jboxSubmit($("#dblForm"),"<s:url value='/res/rec/saveRegistryForm'/>",function(resp){
			if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
				parentRefresh();
				jboxClose();
			}				
		},function(resp){
			jboxTip("${GlobalConstant.SAVE_FAIL}");
		},true);
	}
}

$(function(){
	<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
		$("#dblForm").find(":text,textarea").each(function(){
			$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
		});
		$("#dblForm select").each(function(){
			var text = $(this).find(":selected").text();
			$(this).replaceWith($('<label>'+text+'</label>'));
		});
		$("#dblForm").find(":checkbox,:radio").attr("disabled",true);
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
	//window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
	window.parent.frames['mainIframe'].window.loadProcess();
}
</script> 
</head>
<body>
<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <form id="dblForm" enctype="multipart/form-data" method="post">
        <input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
        <input type="hidden" name="recFlow" value="${rec.recFlow}"/>
        <input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;登记信息</th>
            </tr>
             <tr>
             	<td style="width: 100px;"><font color="red">*</font>病人姓名：</td>
                <td >
                    <input class="validate[required] " name="patientName" type="text" value="${formDataMap['patientName']}" style="width: 150px;"/>
				</td>
				<td style="width: 100px;"><font color="red">*</font>住院号：</td>
                <td >
                    <input class="validate[required] " name="hospitalNumbers" type="text" value="${formDataMap['hospitalNumbers']}" style="width: 150px;"/>
				</td>
			</tr>
			<tr>
				<td style="width: 100px;"><font color="red">*</font>疾病名称：</td>
				<td>
					<input class="validate[required] " name="diseaseName" type="text" value="${formDataMap['diseaseName']}" style="width: 150px;"/>
				</td>
				<td style="width: 100px;"><font color="red">*</font>操作时间：</td>
				<td>
					<input style="width: 150px;" name="operTime" type="text" value="${formDataMap['operTime']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
			</tr>
             <tr>
				<td style="width: 100px;"><font color="red">*</font>诊断类型：</td>
                <td >
                    <select name="diagnoseType" style="width: 154px;">
	                    <option value="主要诊断" <c:if test="${formDataMap['diagnoseType']=='主要诊断'}">selected="selected"</c:if> >主要诊断</option>
	                    <option value="次要诊断" <c:if test="${formDataMap['diagnoseType']=='次要诊断'}">selected="selected"</c:if>>次要诊断</option>
	                    <option value="并行诊断" <c:if test="${formDataMap['diagnoseType']=='并行诊断'}">selected="selected"</c:if>>并行诊断</option>
                    </select>
				</td>
				<td style="width: 100px;"><font color="red">*</font>诊断：</td>
				<td>
					<input class="validate[required] " name="diagnose" type="text" value="${formDataMap['diagnose']}" style="width: 150px;"/>
				</td>
             </tr>
             <tr>
             	<td style="width: 100px;">抢救措施：</td>
				<td colspan="3">
					<input name="saveStep" type="text" value="${formDataMap['saveStep']}" style="width: 493px;"/>
				</td>
             </tr>
             <tr>
             	<td style="width: 100px;">死亡原因分析：</td>
				<td colspan="3">
					<input name="dieReasonParse" type="text" value="${formDataMap['dieReasonParse']}" style="width: 493px;"/>
				</td>
             </tr>
             <tr>
             	<td style="width: 100px;">记录：</td>
				<td colspan="3">
					<textarea style="width:495px;	border:1px solid #bdbebe;	height:100px;	margin:5px 5px 5px 0px" name="caseRecord">${formDataMap['caseRecord']}</textarea>
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