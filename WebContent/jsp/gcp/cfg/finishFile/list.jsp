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
		var stage = $("select[name='stage']").val();
		var url = "<s:url value='/gcp/cfg/editFinishFile'/>?stage=" + stage + "&id=" + id;
		var flag = "新增";
		if(id){
			flag = "修改";
		}
		jboxOpen(url, flag + "归档文件" ,600,150);
	}
	
	function delFileById(id){
		var url = "<s:url value='/gcp/cfg/delFileById'/>?fileType=${GlobalConstant.GCP_FINISH_FILE_CFG_CODE}&id="+id ;
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
	<form id="searchForm" action="<s:url value="/gcp/cfg/finishFileList" />" method="post">
		<div class="title1 clearfix">
			&#12288;阶段：
			<select name="stage" class="xlselect" onchange="search()">
                <c:forEach var="stageEnum" items="${gcpProjStageEnumList}">
                	<c:if test="${!(stageEnum.id eq gcpProjStageEnumTerminate)}">
               			<option value="${stageEnum.id}" <c:if test="${param.stage eq stageEnum.id}">selected="selected"</c:if>>${stageEnum.name}</option>
               		</c:if>
                </c:forEach>
            </select>
			<input type="button" class="search" onclick="editFile('')" value="新&#12288;增">
		</div>
		
		<table class="xllist" > 
			<thead>
			<tr>
				<th width="5%">序号</th>
				<th width="80%">文件名</th>
				<th width="15%" >操作</th>
			</tr>
			</thead>
			<c:forEach items="${fileList}" var="file" varStatus="status">
			<tr>
				<td>${status.count}</td>
				<td>${file.fileName}</td>
				<td>
					[<a href="javascript:void(0)" onclick="editFile('${file.id}')">修改</a>]&#12288;
					[<a href="javascript:void(0)" onclick="delFileById('${file.id}')">删除</a>]
				</td>
			</tr>
		   </c:forEach>
		</table>
		</form>
	</div> 
</div>
</body>
</html>