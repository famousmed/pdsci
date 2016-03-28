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
	function search(){
		if($("#projNo").val()=="" && $("#projShortName").val()=="" && $("#deptFlow").val()=="" && $("#applyUserName").val()=="" && $("#irbTypeId").val()==""){
			jboxTip("请至少选择一个查询条件");
			return ;
		}
		$("#searchForm").submit();
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="searchForm" action="<s:url value="/irb/projIrbList"/>?conditionFlag=Y" method="post">
			<input type="hidden" name="orgFlow" value="${sessionScope.currUser.orgFlow}">
			<p style="text-align: left;">
				项目编号：<input type="text" id="projNo" name="projNo" value="${param.projNo}" style="width: 80px;"/>&#12288; 
				项目名称：<input type="text" id="projShortName" name="projShortName" value="${param.projShortName}" style="width:150px"/>&#12288;
				承担科室：
					<select id="deptFlow" name="deptFlow" style="width: 120px;">
						<option value="">请选择</option>
						<c:forEach items="${sysDeptList }" var="dept">
							<option value="${dept.deptFlow}" <c:if test="${dept.deptFlow==param.deptFlow }">selected="selected"</c:if> >${dept.deptName }</option>
						</c:forEach>
					</select>&#12288;
				主要研究者：<input type="text" id="applyUserName" name="applyUserName" value="${param.applyUserName}" style="width: 80px;" />&#12288;
				审查类别：
					<select id="irbTypeId" name="irbTypeId" style="width: 120px;">
						<option value="">请选择</option>
						<c:forEach items="${irbTypeEnumList }" var="irbType">
							<option value="${irbType.id}" <c:if test="${irbType.id==param.irbTypeId }">selected="selected"</c:if> >${irbType.scName }</option>
						</c:forEach>
					</select>&#12288;
				<input type="button" value="查 &#12288;询" class="search" onclick="search();"/>
			</p>
		</form>
		</div>
		<table class="xllist">
			<thead>
				<tr>
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<th width="10%" >项目编号</th>
					</c:if>
					<th width="25%" >项目名称</th>
					<th width="15%" >伦理审查类别</th>
					<!-- 
					<th width="10%" >承担科室</th>
					<th width="10%" >主要研究者</th>
					 -->
					<th width="10%" >受理号</th>
					<th width="10%" >审查方式</th>
					<th width="10%" >审查决定</th>
					<th width="10%" >决定文件日期</th>
					<th width="10%" >跟踪审查日期</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${!empty irbList}">
			<c:forEach items="${irbList}" var="irb">
				<tr >
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<td>${irb.projNo}</td>
					</c:if>
					<td style="text-align: left;">&#12288;${irb.projShortName}&#12288;${irb.projSubTypeName}&#12288;${irb.projShortDeclarer}</td>
					<td>
					${irb.irbTypeName}
					<!-- <a href="<s:url value='/irb/researcher/showMain'/>?projFlow=${irb.projFlow}&irbFlow=${irb.irbFlow}&vtype=view" target="_blank" style="color: red">
					</a> -->
					</td>
					<!-- 
					<td>${projMap[irb.projFlow].applyDeptName}</td>
					<td>${projMap[irb.projFlow].applyUserName}</td>
					 -->
					<td>${irb.irbNo}</td>
					<td>${irb.reviewWayName}</td>
					<td>${irb.irbDecisionName}</td>
					<td>${irb.irbDecisionDate}</td>
					<td>${irb.trackDate}</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${empty irbList }">
				<tr><td colspan="8">无记录</td></tr> 
			</c:if>
			</tbody>
		</table>
	</div>
</div>
</body>
</html>