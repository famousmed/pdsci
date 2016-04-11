<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
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
<style type="text/css">
	#ueditor{
		width:88%;
		margin: 15px 10px 15px 0px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var ue = UE.getEditor('ueditor', {
		    autoHeight: false,
		    imagePath: '${sysCfgMap['upload_base_url']}/',
		    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
		    filePath: '${sysCfgMap['upload_base_url']}/',
		    videoPath: '${sysCfgMap['upload_base_url']}/',
		    wordImagePath: '${sysCfgMap['upload_base_url']}/',
		    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
		    catcherPath: '${sysCfgMap['upload_base_url']}/',
		    scrawlPath: '${sysCfgMap['upload_base_url']}/'
		});
	});
	
	function saveWorkpaper(){
		if(false==$("#editForm").validationEngine("validate")){
			return false;
		}
		var recordFlow = $("input[name=recordFlow]").val();
		var workpaperTypeId = $("input[name=workpaperTypeId]").val();
		var workpaperName = $("input[name=workpaperName]").val();
		var reportTime = $("input[name=reportTime]").val();
		var reportUserName = $("input[name=reportUserName]").val();
		var workpaperContent = UE.getEditor('ueditor').getContent();
		var requestData ={
				"recordFlow":recordFlow,
				"workpaperTypeId":workpaperTypeId,
				"workpaperName":workpaperName,
				"reportTime":reportTime,
				"reportUserName":reportUserName,
				"workpaperContent":workpaperContent
		}
		var url = "<s:url value='/gcp/workFile/saveWorkpaper'/>";
		jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.location.href="<s:url value='/gcp/workFile/workpaperList?workpaperTypeId=${param.workpaperTypeId}'/>";
					}
				},null,true);
	}
	function doBack(){
		window.location.href="<s:url value='/gcp/workFile/workpaperList?workpaperTypeId=${param.workpaperTypeId}'/>";
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="editForm" style="position: relative;"  method="post">
			<input type="hidden" name="recordFlow" value="${workpaper.recordFlow}"/>
			<input type="hidden" name="workpaperTypeId" value="${param.workpaperTypeId}"/>
			<table class="basic" width="100%" >
				<tr>
					<th style="text-align: right;" width="100px;">文件名称：</th>
					<td colspan="3">
						<input type="text" name="workpaperName" value="${workpaper.workpaperName}" class="validate[required] xltext" style="width:98%;"/>
					</td>
				</tr>
				<tr>
					<th style="text-align: right;" width="100px;">报告日期：</th>
					<td> 
						<input type="text" name="reportTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime xltext validate[required]"
							<c:if test="${not empty workpaper.reportTime}">value="${workpaper.reportTime}"</c:if>
							<c:if test="${empty workpaper.reportTime}">value="${pdfn:getCurrDate()}"</c:if>/>
					</td>
					<th style="text-align: right;" width="100px;">报告人：</th>
					<td>
						<input type="text" name="reportUserName"  class="xltext validate[required]"
							<c:if test="${not empty workpaper.reportUserName}">value="${workpaper.reportUserName}"</c:if>
							<c:if test="${empty workpaper.reportUserName}">value="${sessionScope.currUser.userName}"</c:if> />
					</td>
				</tr>
				<tr>
					<th style="text-align: right;">内容：</th>
					<td colspan="3">
						<script id="ueditor" style="height:420px;"  type="text/plain" >${workpaper.workpaperContent}</script> 
					</td>
				</tr>
			</table>
			
			<p align="center" style="width:100%">
				<input class="search" type="button" value="保&#12288;存"  onclick="saveWorkpaper();" />
				<input class="search" type="button" value="返&#12288;回"  onclick="doBack();" />
			</p>
		</form>
		</div>
	</div>
</div>
</body>
</html>