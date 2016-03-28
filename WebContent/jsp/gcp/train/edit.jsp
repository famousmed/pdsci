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
	
	function saveTrainSummary(){
		if(false==$("#editForm").validationEngine("validate")){
			return false;
		}
		var recordFlow = $("input[name=recordFlow]").val();
		var summaryTitle = $("input[name=summaryTitle]").val();
		var summaryTypeId = $("input[name=summaryTypeId]").val();
		var summaryContent = UE.getEditor('ueditor').getContent();
		var requestData ={
				"recordFlow":recordFlow,
				"summaryTitle":summaryTitle,
				"summaryTypeId":summaryTypeId,
				"summaryContent":summaryContent
		}
		var url = "<s:url value='/pub/train/saveTrainSummary'/>";
		jboxPost(
				url,
				requestData,
				function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						//window.parent.frames['mainIframe'].window.search();
						//jboxClose();
						window.location.href="<s:url value='/pub/train/summaryList'/>";
					}
				},
				null,true
		);
	}
	function doBack(){
		window.location.href="<s:url value='/pub/train/summaryList'/>";
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="editForm" style="position: relative;" action="<s:url value='/pub/train/saveTrainSummary'/>" method="post">
			<input type="hidden" name="recordFlow" value="${summary.recordFlow}">
			<table class="basic" width="100%">
				<tr>
					<th style="text-align: right;" width="100px;">标题：</th>
					<td>
						<input type="text" name="summaryTitle" value="${summary.summaryTitle}" class="validate[required] xltext" style="width:98%;"/>
					</td>
				</tr>
				<tr>
					<th style="text-align: right;">类别：</th>
					<td>
						<c:forEach var="summaryType" items="${trainSummaryTypeEnumList}">
						 	<input type="radio" name="summaryTypeId" value="${summaryType.id}" class="validate[required]"  id="summaryType_${summaryType.id}" <c:if test="${summary.summaryTypeId eq summaryType.id}">checked="checked"</c:if>/><label for="summaryType_${summaryType.id}">&nbsp;${summaryType.name}</label>&#12288;
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th style="text-align: right;">内容：</th>
					<td>
						<script id="ueditor" style="height:420px;" type="text/plain" >${summary.summaryContent}</script> 
					</td>
				</tr>
			</table>
			
			<c:if test="${param.view != GlobalConstant.FLAG_Y}">
			<p align="center" style="width:100%">
				<input class="search" type="button" value="保&#12288;存"  onclick="saveTrainSummary();" />
				<input class="search" type="button" value="返&#12288;回"  onclick="doBack();" />
			</p>
			</c:if>
		</form>
		</div>
	</div>
</div>
</body>
</html>