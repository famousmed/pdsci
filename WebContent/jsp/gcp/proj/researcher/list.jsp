<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function projInfo(stage, projFlow){
	window.location.href="<s:url value='/gcp/proj/projInfo'/>?flag="+stage+"&projFlow="+projFlow+"&roleScope=${GlobalConstant.ROLE_SCOPE_RESEARCHER}";
}

function add(){
	jboxOpen("<s:url value='/gcp/proj/edit?roleScope=${GlobalConstant.ROLE_SCOPE_RESEARCHER}'/>","新增项目",950,460);
}
function option(projFlow){
	jboxOpen("<s:url value='/gcp/proj/optionList'/>?projFlow="+projFlow,"审核记录列表",800,400);
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" method="post">
				${sessionScope.currUser.userName}，您目前承担项目&#12288;<span style="color: red">${empty projList.size()?0:projList.size()}</span>&#12288;个
				<input type="button" class="search"	onclick="add();" style="float: right;margin-right: 20px;" value="新&#12288;增"> 
			</form>
		</div> 
		<div>
			<table class="xllist">
				<tr>
					<th width="60px;">序号</th>
					<th>项目名称</th>		
					<th width="100px;">期类别</th>		
					<th width="220px;">项目来源</th>		
					<th width="100px;">项目阶段</th>
					<th width="130px;">项目状态</th>
					<th width="140px;">操作</th>
				</tr>
				<c:forEach items="${projList}" var="proj" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td>${proj.projName}</td>
						<td>${proj.projSubTypeName}</td>
						<td>${proj.projShortDeclarer}</td>
						<td>${proj.projStageName}</td>
						<td>${proj.projStatusName}</td>
						<td>
							[<a href="javascript:void(0)" onclick="option('${proj.projFlow}')">审核意见</a>]&#12288;
							[<a href="javascript:void(0)" onclick="projInfo('edit','${proj.projFlow}')">进入</a>]
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty projList}">
					<tr>
						<td colspan="7">无记录！</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div> 
</div>
</body>
</html>