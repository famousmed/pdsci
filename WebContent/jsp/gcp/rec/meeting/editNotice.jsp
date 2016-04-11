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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<script type="text/javascript">
	function save(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/gcp/rec/saveMeeting'/>?saveType=notice";
		if ($("#projStageId").length >0 && $("#projStageId").val() != "${gcpProjStageEnumApply.id }") {
			jboxConfirm("项目状态改变后不可修改，确认保存？", function() {
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.parent.frames['mainIframe'].window.location.href = "<s:url value='/gcp/proj/projInfo'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&tagId=qdh";
						jboxClose();
					}
				},null,true);
			});
		} else {
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadStartMeeting();
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
		<form id="editForm">
   		<table class="basic" width="100%">
   			<tr>
				<th colspan="4" style="text-align: left;padding-left: 10px;">启动通知</th>
			</tr>
			<tr>
				<td style="text-align: right;">研究例数：</td>
				<td>
					<input type="text" name="researchCount" class="xltext" value="${meetingForm.researchCount }" />
				</td>
				<td style="text-align: right;">疗程/观察周期：</td>
				<td>
					<input type="text" name="period" class="xltext" value="${meetingForm.period }" />
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">药物编码范围：</td>
				<td colspan="3">
					<input type="text" name="scope" class="xltext" value="${meetingForm.scope }"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">机构管理员签字：</td>
				<td>
					<input type="text" name="goSign" class="xltext" value="${meetingForm.goSign }"/>
				</td>
				<td style="text-align: right;">启动通知日期：</td>
				<td>
					<input type="text" name="noticeDate" class="xltext ctime" readonly="readonly" value="${meetingForm.noticeDate }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				</td>
			</tr>
            <tr>
				<td style="text-align: right;">项目状态：</td>
				<td colspan="3">
					<c:if test="${gcpProjStageEnumApply.id eq proj.projStageId }">
						<select id="projStageId" name="projStageId" class="xlselect">
							<option value="${gcpProjStageEnumApply.id }">${gcpProjStageEnumApply.name }</option>
							<option value="${gcpProjStageEnumSchedule.id }">${gcpProjStageEnumSchedule.name }</option>
						</select>
					</c:if>
					<c:if test="${gcpProjStageEnumApply.id != proj.projStageId }">${proj.projStageName }</c:if>
				</td>
			</tr>
			</table>
			<p align="center">
			    <input name="projFlow" type="hidden" value="${param.projFlow }" />
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
				<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
			</p>
		</form>
         </div>
     </div> 	
   </div>
</body>
</html>