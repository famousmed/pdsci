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
	function editFile(id){
		var url = "<s:url value='/gcp/cfg/editApplyFile'/>?id=" + id;
		var flag = "新增";
		if(id){
			flag = "修改";
		}
		jboxOpen(url, flag + "送审文件" ,600,250);
	}
	
	function delFile(id){
		var url = "<s:url value='/gcp/cfg/delFileById'/>?fileType=${GlobalConstant.GCP_APPLY_FILE_CFG_CODE}&id="+id;
		jboxConfirm("确认删除？" , function(){
			jboxGet(url , null , function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.search();
				}
			} , null , true);
		});
	}
	
	function search(){
		$("#searchForm").submit();	
	}
</script>
</head>
<body>
	<div class="mainright" id="mainright">
	<div class="content">
	<form id="searchForm" action="<s:url value="/gcp/cfg/applyFileList" />" method="post">
		<div class="title1 clearfix">
			<input type="button" class="search" onclick="editFile('')" value="新&#12288;增">
		</div>
		
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="50%">文件名</th>
				<th width="15%">版本号</th>
				<th width="15%">版本日期</th>
				<th width="15%">操作</th>
			</tr>
			</thead>
			<c:forEach items="${fileList}" var="file" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${file.fileName}</td>
				<td>
					<c:if test="${file.version eq GlobalConstant.FLAG_Y}">有</c:if>
					<c:if test="${empty file.version or file.version eq GlobalConstant.FLAG_N}">无</c:if>
				</td>
				<td>
					<c:if test="${file.versionDate==GlobalConstant.FLAG_Y}">有</c:if>
					<c:if test="${empty file.versionDate or file.versionDate==GlobalConstant.FLAG_N}">无</c:if>
				</td>
				<td>
					[<a href="javascript:void(0)" onclick="editFile('${file.id}')">修改</a>]&#12288;
					[<a href="javascript:void(0)" onclick="delFile('${file.id}')">删除</a>]
				</td>
			</tr>
		   </c:forEach>
		</table>
		</form>
	</div> 
</div>
</body>
</html>