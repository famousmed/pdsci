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
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		searchProj();
	}
	function edit(flow){
	   jboxOpen("<s:url value='/fstu/dec/editCredit'/>?userFlow="+flow, "新增学分",850,400);
	   
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
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/fstu/dec/creditList/${roleFlag}"/>"
				method="post">
				<input id="currentPage" type="hidden" name="currentPage" value=""/>
				<table class="basic" style="width: 100%;">
					<tr>
						<td>
							姓名：
							<input type="text" class=" " onchange="searchProj();" name="userName" value="${param.userName }"/>
							&#12288;
							<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
							单位名称： <input type="text" onchange="searchProj();" name="orgName" value="${param.orgName}" class="" />&#12288;
							</c:if>
							身份证号码：
							<input type="text" name="idNo" onchange="searchProj();" value="${param.idNo}" class="" />&#12288;
							<input id="currentPage" type="hidden" name="currentPage" value=""/>
							<input type="hidden" class="search" onchange="searchProj();" value="查&#12288;询">
						</td>
					</tr>
				</table>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
					<th>单位</th>
					</c:if>
					<th style="width: 100px;">姓名</th>
					<th style="width: 80px;">性别</th>
					<th style="width: 200px;">身份证号码</th>
					<th style="width: 100px;">职称</th>
					<th style="width: 200px;">最后晋升时间</th>
					<th style="width: 80px;">学科</th>
					<th style="width: 80px;">学分</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${userList }" var="user">
					<tr>
						<c:if test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
						<td>${user.orgName }</td>
						</c:if>
						<td>${user.userName }</td>
						<td>${user.sexName }</td>
						<td>${user.idNo }</td>
						<td>${user.titleName}</td>
						<td></td>
						<td></td>
						<td><c:if test="${roleFlag==GlobalConstant.USER_LIST_LOCAL }"> 
							<a style="color: blue;cursor: pointer;" onclick="edit('${user.userFlow}');">详情</a>
							</c:if>
							<c:if  test="${roleFlag==GlobalConstant.USER_LIST_CHARGE }"> 
							<a style="color: blue;cursor: pointer;" onclick="edit('${user.userFlow}');">查看</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty userList } ">
					<tr><td colspan="99">无记录</td></tr>
				</c:if>
			</tbody>
		</table>
		<c:set var="pageView" value="${pdfn:getPageView(userList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>	
	</div>
</div>
</body>
</html>