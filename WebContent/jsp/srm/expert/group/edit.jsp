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
</head>
<body>
	<script type="text/javascript">
		function saveExpertGroup() {
			var datas = {
					groupFlow:"${srmExpertGroup.groupFlow}",
					groupName : $("#groupName").val(),
					groupTypeId:$("#groupType option:selected").val(),
					groupTypeName:$("#groupType option:selected").text(),
					groupNote:$("#groupNote").val()
			};
			var url = "<s:url value='/srm/expert/group/save'/>";
			jboxStartLoading();
			jboxPost(url , datas , function(){
				window.parent.frames['mainIframe'].window.location.reload(true); 
				doClose();
			} , null , true);
			
		}
		function doClose() {
			jboxClose();
		}
	</script>
<div class="mainright">
    <div class="content">
        <div class="title1 clearfix">
	
		<form id="expertGroupForm">
			<table class="basic" style="width:100%;" >
				<tr class="bs_name"><td colspan="2" align="left" >项目信息</td></tr>
				<tr>
					<th style="text-align: right;width: 20%;">专家组名称：</th>
					<td >
						<input class="validate[required] xltext" name="groupName" id="groupName" type="text" value="${srmExpertGroup.groupName }" /></td>
				</tr>
				<!-- <tr>
					<th style="text-align: right">领域：</th>
					<td>
						<select name="groupType" id="groupType" class="xlselect">
							<option value=""></option>
						</select>
					</td>
				</tr> -->
				<tr>
					<th style="text-align: right">描述：</th>
					<td style="text-align: left;">
						<textarea name="groupNote" id="groupNote" rows="3" style="width: 100%; resize:none;" >${srmExpertGroup.groupNote }</textarea>
					</td>
				</tr>
				
			</table>
			<p align="center">
				<input type="button" value="保&#12288;存" class="search"  onclick="saveExpertGroup();"  />
			    <input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
			</p>
		</form>

</div>
</div>
</div>
</body>
</html>