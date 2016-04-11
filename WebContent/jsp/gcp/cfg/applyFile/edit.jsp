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
	function save(){
		if(false==$("#fileForm").validationEngine("validate")){
			return false;
		}
		var url = "<s:url value='/gcp/cfg/saveApplyFile'/>";
		var requestData = $("#fileForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.search();
				jboxClose();
			}
		},null,true);
	}
</script>
</head>
<body>
	<div class="mainright" id="mainright">
	<div class="content">
	<form id="fileForm"  method="post" >
		<table class="basic" width="100%" style="margin-top: 5px;"> 
			<tr>
				<th>文 件 名：</th>
				<td>
			 		<input type="hidden" name="id" value="${file.id}">
					<input type="text" name="fileName" class="validate[required] xltext" value="${file.fileName}" style="width: 90%">
				</td>
			</tr>
			<tr>
				<th>版 本 号：</th>
				<td>
					<input type="radio" id="version_Y" name="version" <c:if test="${file.version==GlobalConstant.FLAG_Y}"> checked="checked" </c:if> value="${GlobalConstant.FLAG_Y}" /><label for="version_Y">有&#12288;</label>
					<input type="radio" id="version_N" name="version" <c:if test="${empty file.version or file.version==GlobalConstant.FLAG_N}"> checked="checked" </c:if> value="${GlobalConstant.FLAG_N}" /><label for="version_N">无</label>
				</td>
			</tr>
			<tr>
				<th>版本日期：</th>
				<td>
					<input type="radio" id="versionDate_Y" name="versionDate" <c:if test="${file.versionDate==GlobalConstant.FLAG_Y}"> checked="checked" </c:if>  value="${GlobalConstant.FLAG_Y}"/><label for="versionDate_Y">有&#12288;</label>
					<input type="radio" id="versionDate_N" name="versionDate" <c:if test="${empty file.versionDate or file.versionDate==GlobalConstant.FLAG_N}"> checked="checked" </c:if> value="${GlobalConstant.FLAG_N}" /><label for="versionDate_N">无</label>
				</td>
			</tr>
			<tr>
				<th>模版文件：</th>
				<td>
					<input type="text" name="temple" class="xltext" value="${file.temple}" style="width: 90%">
				</td>
			</tr>
		</table>
		
		 <p align="center" style="margin-top: 10px;">
	     	<input type="button" value="保&#12288;存" onclick="save();" class="search"/>
	     	<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	     </p>
		</form>
	</div> 
</div>
</body>
</html>