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
             	<td style="width: 100px;"><font color="red">*</font>疾病名称：</td>
                <td >
                    <input class="validate[required] " name="diseaseName" type="text" value="${formDataMap['diseaseName']}" style="width: 150px;"/>
				</td>
				<td style="width: 100px;"><font color="red">*</font>住院号：</td>
                <td >
                    <input class="validate[required] " name="hospitalNumbers" type="text" value="${formDataMap['hospitalNumbers']}" style="width: 150px;"/>
				</td>
			</tr>
			<tr>
				<td style="width: 100px;"><font color="red">*</font>类型：</td>
				<td>
						
					 <select name="type" style="width: 154px;" class="validate[required] ">
					 	<option value="" >请选择</option>
	                    <option value="一般" <c:if test="${formDataMap['type']=='一般'}">selected="selected"</c:if> >一般</option>
	                    <option value="危重" <c:if test="${formDataMap['type']=='危重'}">selected="selected"</c:if>>危重</option>
	                    <option value="抢救" <c:if test="${formDataMap['type']=='抢救'}">selected="selected"</c:if>>抢救</option>
                    </select>
				</td>
				<td style="width: 100px;"><font color="red">*</font>结果：</td>
				<td>
					<select name="result" style="width: 154px;" class="validate[required] ">
						<option value="" >请选择</option>
	                    <option value="痊愈" <c:if test="${formDataMap['result']=='痊愈'}">selected="selected"</c:if> >痊愈</option>
	                    <option value="好转" <c:if test="${formDataMap['result']=='好转'}">selected="selected"</c:if>>好转</option>
	                    <option value="死亡" <c:if test="${formDataMap['result']=='死亡'}">selected="selected"</c:if>>死亡</option>
                    </select>
				</td>
			</tr>
             <tr>
				<td style="width: 100px;"><font color="red">*</font>治疗方法：</td>
                <td >
                    <select name="treatmentWay" style="width: 154px;" class="validate[required] ">
                    	<option value="" >请选择</option>
	                    <option value="中医" <c:if test="${formDataMap['treatmentWay']=='中医'}">selected="selected"</c:if> >中医</option>
	                    <option value="西医" <c:if test="${formDataMap['treatmentWay']=='西医'}">selected="selected"</c:if>>西医</option>
	                    <option value="中西医" <c:if test="${formDataMap['treatmentWay']=='中西医'}">selected="selected"</c:if>>中西医</option>
                    </select>
				</td>
				<td style="width: 100px;"><font color="red">*</font>综合方法：</td>
				<td>
					<select name="comprehensiveWay" style="width: 154px;" class="validate[required] ">
						<option value="" >请选择</option>
	                    <option value="针灸" <c:if test="${formDataMap['comprehensiveWay']=='针灸'}">selected="selected"</c:if> >针灸</option>
	                    <option value="推拿" <c:if test="${formDataMap['comprehensiveWay']=='推拿'}">selected="selected"</c:if>>推拿</option>
	                    <option value="火罐" <c:if test="${formDataMap['comprehensiveWay']=='火罐'}">selected="selected"</c:if>>火罐</option>
	                    <option value="刮痧" <c:if test="${formDataMap['comprehensiveWay']=='刮痧'}">selected="selected"</c:if>>刮痧</option>
	                    <option value="其他" <c:if test="${formDataMap['comprehensiveWay']=='其他'}">selected="selected"</c:if>>其他</option>
                    </select>
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