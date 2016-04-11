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
function add(){
	var url = "<s:url value='/srm/fund/item/edit'/>";
	jboxStartLoading();
	jboxOpen(url , "经费项目信息" , 500 , 260);
}
function editFundItem(itemFlow){
	var url = "<s:url value='/srm/fund/item/edit'/>?itemFlow="+itemFlow;
	jboxStartLoading();
	jboxOpen(url , "经费项目信息" , 500 , 260);
}
function delFundItem(itemFlow){
	var url = '<s:url value="/srm/fund/item/delete"/>?itemFlow='+itemFlow;
	jboxConfirm("确认删除？" , function(){
		jboxStartLoading();
		jboxGet(url , null , function(){
			search();
		} , null , true);
	});
	
}
function search(){
	jboxStartLoading();
	$("#searchFundItem").submit();	
}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchFundItem" action="<s:url value="/srm/fund/item/list"/>" method="post">
			经费项目：	
			<input style="width: 120px" class="xlname" name="itemName" type="text" value="${param.itemName}"/>
			<input class="search" type="button" value="查询" onclick="search()"/>
			<input class="search" type="button" value="新增" onclick="add()"/>
			</form>
		</div>
		<table class="xllist">
				<tr>
					<th width="10%">经费项目</th>
					<th width="10%">创建时间</th>
					<th width="10%">修改时间</th>
					<th width="10%">操作</th>
				</tr>
				<c:forEach items="${fundItemList}" var="fundItem">
					<tr>
						<td>${fundItem.itemName}</td>
						<td>${pdfn:transDateTime(fundItem.createTime)}</td>
						<td>${pdfn:transDateTime(fundItem.modifyTime)}</td>
						<td>[<a href="javascript:editFundItem('${fundItem.itemFlow}');" >编辑</a>] | 
							[<a href="javascript:delFundItem('${fundItem.itemFlow}');" >删除</a>] 
						</td>
					</tr>
				</c:forEach>
		</table>
	</div>
</div>
</body>
</html>