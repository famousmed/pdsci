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
</jsp:include>
<script type="text/javascript">
function saveDiary() {
	if(false==$("#diaryForm").validationEngine("validate")){
		return ;
	}
	var url = "<s:url value='/gcp/workFile/saveDiary'/>";
	requestData = $('#diaryForm').serialize();
	jboxPost(
		url, 
		requestData, 
		function(){
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		},
		null , true
	);
}

function delDiary(diaryFlow){
	var url = '<s:url value="/gcp/workFile/delDiary"/>?diaryFlow='+diaryFlow;
	jboxConfirm("删除工作日志？" , function(){
		jboxGet(url , null , 
				function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						window.parent.frames['mainIframe'].location.reload(true);
						jboxClose();
					}
				},
				null , true);
	});
	
}
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		<form id="diaryForm">
		<input type="hidden" name="diaryFlow" value="${diary.diaryFlow}"/>
		<table class="basic" style="width: 100%;">
		<tr>
			<th width="17%">工作日期：</th>
			<td style="text-align: left">
				<c:if test="${empty diary.diaryDate}">
					<c:if test="${!empty param.date}">
						${param.date}
						<input type="hidden" name="diaryDate" value="${param.date}"/>
					</c:if>
					<c:if test="${empty param.date}">
						<input name="diaryDate" value="${pdfn:getCurrDate() }" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime"  type="text"/>
					</c:if>
				</c:if>
				<c:if test="${!empty diary.diaryDate}">
					<input name="diaryDate" value="${diary.diaryDate}" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  class="ctime"  type="text"/>
				</c:if>
			</td>
		</tr>
		<tr>
			<th>日志标题：</th>
			<td style="text-align: left">
				<input type="text" name="diaryTitle" value="${diary.diaryTitle}" class="validate[required] xltext" style="width: 97%"/>
			</td>
		</tr>
		<tr>
			<th>起止时间：</th>
			<td style="text-align: left">
				<input type="text" name="startTime" value="${diary.startTime}" onClick="WdatePicker({dateFmt:'HH:mm'})" class="validate[required] xltext" style="width: 50px;margin-right: 0px;" />
				~
				<input type="text" name="endTime" value="${diary.endTime}" onClick="WdatePicker({dateFmt:'HH:mm'})" class="validate[required] xltext" style="width: 50px"/>
			</td>
		</tr>
		<tr>
			<th>日志内容：</th>
			<td style="text-align:left;">
	     		<textarea name="diaryContent" placeholder="请输入工作日志内容" class="validate[maxSize[500]] xltxtarea" style="margin-left: 0px;">${diary.diaryContent}</textarea>
	     	</td>
		</tr>
		<c:if test="${not empty diary}">
		<tr>
			<th>操作人：</th>
			<td style="text-align: left">${diary.operUserName}</td>
		</tr>
		</c:if>
		</table>
		</form>
		
		<p style="text-align: center;">
			<input type="button" class="search" value="保&#12288;存" onclick="saveDiary();"/>
			<input type="button" class="search" value="删&#12288;除" onclick="delDiary('${diary.diaryFlow}');"/>
			<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();">
		</p>
	</div>
</div>
</div>
</body>
</html>