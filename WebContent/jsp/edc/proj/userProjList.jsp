<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
</jsp:include>
<script type="text/javascript">
	function setCurrProj(projFlow) {
		jboxGet("<s:url value='/edc/proj/setCurrProj?projFlow='/>"+projFlow,null,function(){
			jboxScript("<s:url value='/edc/proj/goCurrProj'/>",function (){
				doClose();
			});
		});	
	}
	function search() {
		$("#searchForm").submit();
	}

	function doClose() {
		jboxClose();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/edc/proj/userProjList" />"
				method="post">
				项目编号：<input type="text" name="projNo" value="${param.projNo}" class="xltext" />
				项目名称：<input type="text" name="projName" value="${param.projName}" class="xltext" /> 
				<input type="button" class="search"	onclick="search();" value="查&#12288;询"> 
			</form>
		</div>
		<div>
			<table class="xllist">
				<tr>
					<th width="200px">项目编号</th>
					<th width="60%">项目名称</th>
					<th width="200px">操作</th>
				</tr>
				<c:if test="${not empty sessionScope.edcCurrProj}">
				<tr style="height: 20px;background-color : pink;">
					<td>${sessionScope.edcCurrProj.projNo }</td>
					<td>${sessionScope.edcCurrProj.projShortName }</td>
					<td>
						[<a	href="javascript:setCurrProj('${sessionScope.edcCurrProj.projFlow}');">选择</a>] 
					</td>
				</tr>
				</c:if>
				<c:forEach items="${projList}" var="proj">
					<c:if test="${sessionScope.edcCurrProj.projFlow != proj.projFlow}">
					<tr style="height: 20px">
						<td>${proj.projNo }</td>
						<td>${proj.projShortName }</td>
						<td>
							[<a	href="javascript:setCurrProj('${proj.projFlow}');">选择</a>] 
						</td>
					</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
</div>
</body>
</html>