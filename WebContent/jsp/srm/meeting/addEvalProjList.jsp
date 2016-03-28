<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	function addEvalProj(evalSetFlow){
		var url = "<s:url value='/srm/meeting/addEvalProj'/>?groupFlow="+$('#groupFlow').val()+"&evalSetFlow="+evalSetFlow;
		jboxStartLoading();
		jboxGet(url , null , function(){
			window.parent.frames['mainIframe'].window.xmlb();
			window.location.reload(true);
		} , null , true);
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<input id="groupFlow" name="groupFlow" type="hidden" value="${param.groupFlow}"/>
			</div>
			<table class="xllist" > 
				<tr>
					<th>序号</th>
					<th>项目编号</th>
					<th>项目名称</th>
					<th>项目负责人</th>
					<th>申报单位</th>
					<th>评审类型</th>
					<th>操作</th>
				</tr>				
				<c:forEach items="${groupProjList}" var="groupProj" varStatus="sta">
					<tr>
						<td width="6%">${sta.count}</td>
						<td width="10%">${groupProj.pubProj.projNo}</td>
						<td width="30%">${groupProj.pubProj.projName}</td>
						<td width="11%">${groupProj.pubProj.applyUserName}</td>
						<td width="20%">${groupProj.pubProj.applyOrgName}</td>
						<td width="12%">${groupProj.evaluationName}</td>
						<td><input type="button" class="search" value="上&#12288;会" onclick="addEvalProj('${groupProj.evalSetFlow}');"/>
						</td>
					</tr>
				   </c:forEach>
			</table>
	</div>
</div>
</body>
</html>