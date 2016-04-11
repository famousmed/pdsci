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
</head>
<body>
<script type="text/javascript">
function fundSchemedetail(){
	jboxStartLoading();
	$("#searchFundSchemeDetailForm").submit();
}
function addFundItem(){
	jboxStartLoading();
	jboxOpen("<s:url value='/srm/fund/scheme/detail/addFundItem?schemeFlow=${param.schemeFlow}'/>" , "向经费方案添加经费项目信息", 500,400);
}
function delFundItemDetail(detailFlow){
	var url = '<s:url value="/srm/fund/scheme/detail/delete"/>?detailFlow='+detailFlow;
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
		jboxGet(url , null , function(){
			fundSchemedetail();
		} , null , true);
	});
}
</script>
 <div class="title1 clearfix">
 <form id="searchFundSchemeDetailForm" action="<s:url value="/srm/fund/scheme/detail/list2" />" method="post" > 
 		<input type="hidden" value="${scheme.schemeFlow }" name="schemeFlow"/>
 		经费方案名:
 		<input type="text" class="xlname"  value="${scheme.schemeName }" readonly="readonly"/>
 		<c:if test="${not empty param.schemeFlow}">
 		<input  class="search" onclick="addFundItem();" value="添加经费项目" >
 		</c:if>
</form>
	<table class="xllist" > 
		<tr>
			<th width="80px">经费项目名</th>
			<th width="60px">创建时间</th>
			<th width="60px">修改时间</th>
			<th width="80px">操作</th>
		</tr>
		<c:forEach items="${itemList}" var="item">
		<tr>
			<td>${item.itemName}</td>
			<td>${item.createTime}</td>
			<td>${item.modifyTime}</td>
			<td>
				[<a href="javascript:delFundItemDetail('${item.detailFlow}');" >删除</a>] 
			</td>
		</tr>
	   </c:forEach>
	</table>
</div>
</body>
</html>