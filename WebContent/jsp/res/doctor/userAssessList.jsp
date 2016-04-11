<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>

<style type="text/css">
	#tags li{cursor: pointer;}
</style>

<script type="text/javascript">
	function search(){
		jboxPost("<s:url value='/res/doc/userAssessList'/>?roleFlag=${param.roleFlag}",$("#searchUserAccess").serialize(),function(resp){
			$("#tagContent").html(resp);
		},null,false);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content" style="height: 100%;">
		<div class="title1 clearfix">
			<form id="searchUserAccess">
				<table class="basic" style="width: 100%;">
					<tr>
						<td>
							考试类型： 	
								<select name="testTypeId" style="width: 90px;" onchange="search();">
								<option/>
								<c:forEach items="${dictTypeEnumTestTypeList}" var="dict">
									<option value="${dict.dictId}" ${param.testTypeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
								</c:forEach>
							</select>
							&#12288;
							考卷名称： <input type="text" style="width: 100px;" name="paperName" value="${param.paperName}"  onchange="search();"/>&#12288;
							是否合格： 					 
							<select name="passFlag" onchange="search();">
								<option></option>
								<option value="${GlobalConstant.FLAG_Y}" ${param.passFlag eq GlobalConstant.FLAG_Y?'selected':''}>是</option>
								<option value="${GlobalConstant.FLAG_N}" ${param.passFlag eq GlobalConstant.FLAG_N?'selected':''}>否</option>
							</select>
							<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
								&#12288;
								姓名：
								<select name="userFlow" style="width: 90px;" onchange="search();">
									<option/>
									<c:forEach items="${userList}" var="user">
										<option value="${user.userFlow}" <c:if test="${param.userFlow eq user.userFlow}">selected</c:if>>${user.userName}</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
								<a style="float: right;margin-right: 10px;color: blue;" href="http://www.gfhpx.com" target="_blank">执业医师考试</a>
							</c:if>
						</td>
					</tr>
				</table>
			</form>
		</div>
		
		<table class="xllist" style="width: 100%;">
			<tr>
				<th style="width: 15%;">考试类型</th>
				<th style="width: 25%;">考卷名称</th>
				<th style="width: 10%;">准考证号</th>
				<th style="width: 15%;">考试时间</th>
				<th style="width: 10%;">考试成绩</th>
				<th style="width: 10%;">是否合格</th>
				<th style="width: 10%;">备注</th>
			</tr>
			<c:forEach items="${resultList}" var="result">
				<tr>
					<td>${result.testTypeName}</td>
					<td>${result.paperName}</td>
					<td>${result.ticketNumber}</td>
					<td>${pdfn:transDate(result.testTime)}</td>
					<td>${result.totleScore}</td>
					<td>
						<c:if test="${result.passFlag eq GlobalConstant.FLAG_Y}">是</c:if>
						<c:if test="${result.passFlag eq GlobalConstant.FLAG_N}">否</c:if>
					</td>
					<td>${result.remark}</td>
				</tr>
			</c:forEach>
			<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR)}">
				<c:if test="${empty param.userFlow}">
					<tr><td colspan="7">请选择学员！</td></tr>
				</c:if>
				<c:if test="${!empty param.userFlow && empty resultList}">
					<tr><td colspan="7">无记录</td></tr>
				</c:if>
			</c:if>
			<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
				<c:if test="${empty resultList}">
					<tr><td colspan="7">无记录</td></tr>
				</c:if>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>