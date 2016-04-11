<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
	function searchProj() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	
	function delAidProj(projFlow) {
		url="<s:url value='/srm/aid/proj/delete?projFlow='/>" + projFlow;
		jboxConfirm("确认删除？", function() {
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.parent.frames['mainIframe'].location.reload(true);
			} , null , true);
			
		});
	}

	function add(typeId){
        var url="<s:url value='/srm/aid/proj/add?typeId='/>"+typeId;
        window.parent.frames['mainIframe'].location=url;
        jboxClose();
    }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/srm/aid/proj/list"/>"
				method="post">
				<p>
					学科名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 420px" />
					<input id="currentPage" type="hidden" name="currentPage" value=""/>
					<input type="button" class="search" onclick="searchProj();" value="查&#12288;询">
					<input type="button" class="search" onclick="add('${param.typeId}');" value="添&#12288;加">  
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%">年份</th>
					<th width="30%">学科名称</th>
					<th width="15%">学科分类</th>
					<th width="15%">学科类型</th>
					<th width="15%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${aidProjList}" var="aidProj">
					<tr>
						<td>${aidProj.projYear}</td>
						<td>${aidProj.projName}</td>
						<td>${aidProj.projCategoryName}</td>
						<td>${aidProj.projTypeName}</td>
						<td>
							<a href="<s:url value='/srm/aid/proj/view?projFlow=${aidProj.projFlow}&typeId=${aidProj.projSubCategoryId}'/>">[查看]</a>
							<c:if test="${aidProjStatusEnumPass.id != aidProj.statusId}">
								<a href="<s:url value='/srm/aid/proj/edit?projFlow=${aidProj.projFlow}&typeId=${aidProj.projSubCategoryId}'/>">[编辑]</a>
							  	<a href="javascript:void(0)" onclick="delAidProj('${aidProj.projFlow}');">[删除]</a> 
					  		</c:if>
						</td>
					</tr>
				</c:forEach>
				
			<c:if test="${empty aidProjList}">
				<tr>
					<td colspan="10">无记录</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(aidProjList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>	
	</div>
</div>

</body>
</html>