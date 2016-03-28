<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.noHead}">
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
</c:if>
<script type="text/javascript">
	function saveForm(){
		if($("#campaignForm").validationEngine("validate")){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#campaignForm').serialize(),function(resp){
				if(resp="${GlobalConstant.SAVE_SUCCESSED}"){
					parentRefresh();
					jboxClose();
				}
			},null,true);
		}
	}
	
	$(function(){
		<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
			$("#campaignForm").find(":text,textarea").each(function(){
				$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
			});
			$("#campaignForm select").each(function(){
				var text = $(this).find(":selected").text();
				$(this).replaceWith($('<label>'+text+'</label>'));
			});
			$("#campaignForm").find(":checkbox,:radio").attr("disabled",true);
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
		<form id="campaignForm">
		<input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;登记信息</th>
            </tr>
      		<tr>
             <td style="width: 100px;"><font color="red">*</font>病例类型：</td>
             <td >
                    <select name="case" style="width: 154px;" class="validate[required] ">
                    	<option value="" selected="selected">请选择</option>
	                    <option value="一般病例" <c:if test="${formDataMap['case']=='一般病例'}">selected="selected"</c:if> >一般病例</option>
	                    <option value="抢救病例" <c:if test="${formDataMap['case']=='抢救病例'}">selected="selected"</c:if>>抢救病例</option>
                    </select>
			</td>
			<td style="width: 100px;"><font color="red">*</font>疾病名称：</td>
				<td>
					<input class="validate[required] " name="diseaseName" type="text" value="${formDataMap['diseaseName']}" style="width: 150px;"/>
				</td>
             </tr>
             <tr>
                <td style="width: 100px;">例次：</td>
				<td>
					<input  name="cases" type="text" value="${formDataMap['cases']}" style="width: 150px;"/>
				</td>
				<td style="width: 100px;">日期：</td>
				<td>
					<input style="width: 150px;" name="date" type="text" value="${formDataMap['date']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
            </tr>
             <tr>
                <td style="width: 100px;">指导教师签名：</td>
				<td colspan="5">
					<input  name="teacherSignature" type="text" value="${formDataMap['teacherSignature']}" style="width: 150px;"/>
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