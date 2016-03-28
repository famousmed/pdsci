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
	function opera(){
		var id = $("#id").val();
		if(id){
			var url="<s:url value='/irb/cfg/operaApplyFile'/>";
			var requestData = $("#editForm").serialize()+"&opera=edit";
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					window.parent.frames["mainIframe"].window.search();
					jboxClose();
				}
			},null,true);
		}else{
			var url = "<s:url value='/irb/cfg/editApplyFile'/>";
			var requestData = $("#editForm").serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
					window.parent.frames["mainIframe"].window.search();
					jboxClose();
				}
			},null,true);
		}
		
		
	}
</script>
</head>
<body>
	<div class="mainright" id="mainright">
	<div class="content">
	<form id="editForm"  method="post" >
		<table class="basic" width="100%" style="margin-top: 5px;"> 
			<tr>
				<th width="130px">文 件 名：</th>
				<td><input type="text" name="name" class="xltext"  value="${findApplyFile.name}"></td>
			</tr>
			<tr>
				<th>文件类型：</th>
				<td>
					<select name="fileType" class="xlselect">
						<option value="">请选择</option>
						<c:forEach items="${irbApplyFileTypeEnumList}" var="fileType"> 
							<option value="${fileType.id }" <c:if test="${fileType.id == findApplyFile.fileType}">selected</c:if>>${fileType.name }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>版 本 号：</th>
				<td>
					<input type="radio" id="version1" name="version" <c:if test="${ findApplyFile.version==GlobalConstant.FLAG_Y }"> checked="checked" </c:if> value="Y" /><label for="version1">有&#12288;</label>
					<input type="radio" id="version0" name="version" <c:if test="${empty findApplyFile.version || findApplyFile.version==GlobalConstant.FLAG_N }"> checked="checked" </c:if> value="N" /><label for="version0">无</label>
				</td>
			</tr>
			<tr>
				<th>版本日期：</th>
				<td>
					<input type="radio" id="versionDate1" name="versionDate" <c:if test="${ findApplyFile.versionDate==GlobalConstant.FLAG_Y }"> checked="checked" </c:if>  value="Y"/><label for="versionDate1">有&#12288;</label>
					<input type="radio" id="versionDate0" name="versionDate" <c:if test="${empty findApplyFile.versionDate || findApplyFile.versionDate==GlobalConstant.FLAG_N }"> checked="checked" </c:if> value="N" /><label for="versionDate0">无</label>
				</td>
			</tr>
			<tr>
				<th>受理通知->送审材料中是否显示：</th>
				<td>
					<input type="radio" id="showNotice1" name="showNotice" <c:if test="${empty findApplyFile.showNotice || findApplyFile.showNotice==GlobalConstant.FLAG_Y }"> checked="checked" </c:if>  value="Y"/><label for="showNotice1">是&#12288;</label>
					<input type="radio" id="showNotice0"name="showNotice" <c:if test="${findApplyFile.showNotice==GlobalConstant.FLAG_N }"> checked="checked" </c:if> value="N" /><label for="showNotice0">否</label>
				</td>
			</tr>
			
		</table>
		 <p align="center" style="margin-top: 10px;">
		 	<input type="hidden" id="irbType" name="irbType" value="${param.irbType }">
		 	<input type="hidden" id="pjType" name="pjType" value="${param.pjType }">
		 	<input type="hidden" id="id" name="id" value="${param.id}">
	     	<input type="button" value="保&#12288;存" onclick="opera();" class="search"/>
	     	<input type="button" value="关&#12288;闭" onclick="jboxClose();" class="search"/>
	     </p>
		</form>
	</div> 
</div>
</body>
</html>