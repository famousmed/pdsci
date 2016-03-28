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
	function search() {
		jboxStartLoading();
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/secretary/list?irbStageId=${param.irbStageId}" />"method="post">
				<p>
					项目编号：<input type="text" name="projNo" value="${param.projNo}" class="xltext" style="width: 150px"/>
					项目名称：
					<input type="text" name="projName" value="${param.projName}" class="xltext" style="width: 200px"/>
					审查类别：
					<select class="xlselect" name="irbTypeId">
						<option value="">全部</option>
						<c:forEach items="${irbTypeEnumList}" var="irbType">
							<option value="${irbType.id}" <c:if test="${param.irbTypeId eq irbType.id}">selected="selected"</c:if> >${irbType.name}</option>
						</c:forEach>
					</select>
					<input type="button" class="search" value="查&#12288;询" onclick="search();"/>
				</p>
			</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<th width="10%" >项目编号</th>
					</c:if>
					<th width="20%">项目名称</th>
					<th width="10%" >项目类别</th>
					<th width="15%" >项目来源</th>
					<th width="10%">伦理审查类别</th>
					<th width="10%">主要研究者</th>
					<th width="10%">审查决定</th>
					<th width="5%">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${irbFormList}" var="irbForm">
					<tr>
						<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
							<td>${irbForm.irb.projNo}</td>
						</c:if>
						<td>${irbForm.irb.projShortName}</td>
						<td>${irbForm.irb.projSubTypeName }</td>
						<td>${irbForm.irb.projShortDeclarer }</td>
						<td>${irbForm.irb.irbTypeName}</td>
						<td>${irbForm.proj.applyUserName}</td>
						<td>${irbForm.irb.irbDecisionName}</td>
						<td>[<a href="<s:url value='/irb/secretary/archive'/>?irbFlow=${irbForm.irb.irbFlow}">进入</a>]</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${irbFormList == null || irbFormList.size() == 0 }"> 
				<tr> 
					<td align="center" colspan="8">无记录</td>
				</tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>