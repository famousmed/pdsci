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
		if($("#teachRecordForm").validationEngine("validate")){
			jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#teachRecordForm').serialize(),function(resp){
				if(resp="${GlobalConstant.SAVE_SUCCESSED}"){
					parentRefresh();
					jboxClose();
				}
			},null,true);
		}
	}
	
	$(function(){
		<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
			$("#teachRecordForm").find(":text,textarea").each(function(){
				$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
			});
			$("#teachRecordForm select").each(function(){
				var text = $(this).find(":selected").text();
				$(this).replaceWith($('<label>'+text+'</label>'));
			});
			$("#teachRecordForm").find(":checkbox,:radio").attr("disabled",true);
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
		<form id="teachRecordForm">
		<input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;登记信息</th>
            </tr>
      		<tr>
             	<td style="width: 100px;"><font color="red">*</font>教学日期：</td>
                <td>
                   <input class="validate[required] " name="teachDate" type="text" value="${formDataMap['teachDate']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
             	<td style="width: 100px;"><font color="red">*</font>教师：</td>
                <td >
                    <input class="validate[required] " name="teacher" type="text" value="${formDataMap['teacher']}" />
				</td>
             </tr>
             <tr>
             	<td style="width: 100px;"><font color="red">*</font>活动形式：</td>
                <td colspan="3">
                    <select class="validate[required]" style="width: 155px;" name="teachType">
                    	<c:forEach items="${dictTypeEnumTeachTypeList}" var="dict">
                    		<option value="${dict.dictName}" ${formDataMap['teachType'] eq dict.dictName?'selected':''}>${dict.dictName}</option>
                    	</c:forEach>
                   	</select>
				</td>
             </tr>
              <tr>
             </tr>
             	<tr>
             	<td style="width: 100px;">活动内容：</td>
                <td colspan="3">
                    	<textarea style="width:487px;	border:1px solid #bdbebe;	height:100px;	margin:5px 5px 5px 0px" name="teachDetail">${formDataMap['teachDetail']}</textarea>
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