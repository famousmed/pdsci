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
	function search(){
		$("#searchForm").submit();
	}
 	
	function toPage(page) {
 		if(page!=undefined){
 			$("#currentPage").val(page);			
 		}
 		searchProj();
 	}
 	
	 function edit(flow){
	  jboxOpen("<s:url value='/fstu/dec/add'/>?flow="+flow,"添加",850,500);
	} 
	 function delAidProj(flow){
		jboxConfirm("确认删除？", function() {
			url="<s:url value='/fstu/dec/delPro'/>?projFlow="+flow+"&recordStatus=${GlobalConstant.RECORD_STATUS_N}";
			jboxPost(url , null , function(obj){
				if(obj=="${GlobalConstant.DELETE_SUCCESSED}"){
					search();
				}
		});
		});
	} 
</script>

</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix" >
			<form id="searchForm" action="<s:url value='/fstu/dec/projList/${roleFlag}'/>" method="post">
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				<table class="basic" style="width: 100%;">
					<tr>
						<td>
							年&#12288;&#12288;份：
							<input type="text" style="width: 100px;" name="projYear" readonly="readonly" onchange="search();" onClick="WdatePicker({dateFmt:'yyyy'})" value="${param.projYear }"/>&#12288;
							项目级别： <input type="text" style="width: 100px;" name="projLevelName" value="${param.projLevelName}" class="" onchange="search();"/>&#12288;
							主办单位： <input type="text" style="width: 130px;" name="applyOrgName" value="${param.applyOrgName}" class="" onchange="search();"/>&#12288;
							项目名称：<input type="text" name="projName" style="width: 123px;" value="${param.projName}" class="" onchange="search();"/>&#12288;
							项目负责人：
							<input type="text" name="applyUserName" style="width: 100px;" value="${param.applyUserName}" class="" onchange="search();" />&#12288;
							<br>
							所属学科：
							<input type="text" name="projSubject" style="width: 100px;" value="${param.projSubject}" class="" onchange="search();" />&#12288;
							申报结果： <select class="" name="declarationResultId" style="width: 100px;" onchange="search();">
										<option></option>
										<option value="${declarationResultEnumPass.id}" <c:if test="${param.declarationResultId == declarationResultEnumPass.id}">selected</c:if>>${declarationResultEnumPass.name}</option>
										<option value="${declarationResultEnumNotPass.id}" <c:if test="${param.declarationResultId == declarationResultEnumNotPass.id}">selected</c:if>>${declarationResultEnumNotPass.name}</option>
									 </select>&#12288;	
							<input id="currentPage" type="hidden" name="currentPage" value=""/>&#12288;
							<c:if test="${roleFlag==GlobalConstant.USER_LIST_LOCAL }">
								<input type="button" class="search" onclick="edit('');" value="新&#12288;增"/>  
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<th>年份</th>
					<th >项目级别</th>
					<th>项目名称</th>
					<th>所属学科</th>
					<th>主办单位</th>
					<th>项目负责人</th>
					<th>电话</th>
					<th>起止时间</th>
					<th>举办地点</th>
					<th>申请学分</th>
					<th>教学对象</th>
					<th>招生人数</th>
					<th>申报结果</th>
					<th>项目编号</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="proj" items="${projList }">
					<tr>
						<td>${proj.projYear}</td>
						<td>${proj.projLevelName}</td>
						<td>${proj.projName}</td>
						<td>${proj.projSubject}</td>
						<td>${proj.applyOrgName}</td>
						<td>${proj.applyUserName}</td>
						<td>${proj.projPhone}</td>
						<td style="line-height: 18px;">${proj.projStartTime}<br>~<br>${proj.projEndTime}</td>
						<td>${proj.projHoldAddress}</td>
						<td>${proj.applyScore}</td>
						<td>${proj.teachingObject}</td>
						<td>${proj.recruitNum}</td>
						<td>${proj.declarationResultName}</td>
						<td>${proj.projNo}</td>
						<td><a style="cursor:pointer; color: blue;" onclick="edit('${proj.projFlow}')">编辑</a> |
						<a style="cursor:pointer; color: blue;" onclick="delAidProj('${proj.projFlow}')">删除</a></td>
					</tr>
				</c:forEach>
				<c:if test="${empty projList}">
	    			<tr><td colspan="99">无记录</td></tr>
	  		  	</c:if>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(projList)}" scope="request"></c:set> 
			<pd:pagination toPage="toPage"/>	 
	</div>
</div>
</body>
</html>