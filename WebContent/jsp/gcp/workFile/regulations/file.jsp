<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</jsp:include>
<script type="text/javascript">
	function saveFile(){
		if(false == $("#fileForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/gcp/workFile/saveRegulationFile'/>";
		jboxSubmit(
			$("#fileForm"),
			url,
			function(resp){
				var url = "<s:url value='/gcp/workFile/regulationFiles?regulationCategoryId=${param.regulationCategoryId}&regulationTypeFlag=${param.regulationTypeId}'/>";
				window.parent.frames['mainIframe'].window.location.href = url;
				jboxClose();				
			},
			function(resp){
				jboxTip("${GlobalConstant.SAVE_FAIL}");
			}
		);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="fileForm" style="position: relative;" enctype="multipart/form-data" method="post">
			<input type="hidden" name="regulationCategoryId" value="${param.regulationCategoryId}"/>
			<input type="hidden" name="regulationTypeId" value="${param.regulationTypeId}"/>
			<input type="hidden" name="deptFlow" value="${param.deptFlow}"/>
			<table width="100%" cellpadding="0" cellspacing="0" class="basic">
				<tr>
					<th>文&#12288;&#12288;件：</th>
					<td>
						<input type="file" name="file" class="validate[required]">
					</td>
				</tr>
				<tr>
					<th>文件编码：</th>
					<td>
						<input name="regulationCode" class="xltext"/>
					</td>
				</tr>
				<tr>
					<th>文件年份：</th>
					<td>
						<input name="regulationYear" onClick="WdatePicker({dateFmt:'yyyy'})" class="ctime xltext" style="margin-right: 0px;"/>
					</td>
				</tr>
				<tr>
					<th>备&#12288;&#12288;注：</th>
					<td>
						<textarea name="regulationRemark" rows="2" placeholder="请输入备注" class="validate[maxSize[200]] text-input" style="width:90%;"></textarea>
					</td>
				</tr>
			</table>
			</form>
		</div>
		
		<p style="text-align: center;">
			<input class="search" type="button" value="保&#12288;存" onclick="saveFile();"  />
		</p>
		
	</div>
</div>
</body>
</html>