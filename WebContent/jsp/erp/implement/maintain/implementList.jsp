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
	<jsp:param name="jquery_cxselect" value="true"/>
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

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	form.submit();
}

function sendWorkOrder() {
	jboxOpen("<s:url value='/erp/implement/sendWorkOrder'/>","派工单", 800, 480);
}

function finishImplement() {
	jboxOpen("<s:url value='/erp/implement/finishImplement'/>","完成维护", 800, 400);
}

function doBack(){
	window.location.href="<s:url value='/erp/implement/maintainList'/>";
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value="/erp/implement/maintianImplement" />"	method="post">
				<div style="margin-bottom: 10px">
					<b>客户名称：</b><font color="red">苏州卫生局</font>&#12288;
					<b>产品名称：</b><font color="red">住院医师系统</font>&#12288;
					<b>开始日期：</b><font color="red">2014-01-18</font>
				</div>
				<div>
					维护类别：<select class="xlselect" style="width: 100px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="maintainCategory" items="${maintainCategoryEnumList}">
						            <option value="${maintainCategory.id}" >${maintainCategory.name}</option>
						        </c:forEach>
							</select>
					需求时间：<input type="text" class="xltext ctime" value="" style="width: 100px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
					需求状态：<select class="xlselect" style="width: 100px;">
				            	<option value="">请选择</option>
				             	<c:forEach var="demandState" items="${demandStateEnumList}">
						            <option value="${demandState.id}" >${demandState.name}</option>
						        </c:forEach>
							</select>
					<input id="currentPage" type="hidden" name="currentPage" value=""/> 
					<input type="button" class="search" onclick="search();" value="查&#12288;询" >
					<input type="button" class="search" onclick="doBack();" value="返&#12288;回" >
				</div>
				</form>
			</div>			
			<table class="xllist">
				<colgroup>
					<col width="4%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="8%"/>
					<col width="10%"/>
					<col width="8%"/>
					<col width="6%"/>
				</colgroup>
				<thead>
				<tr>
					<th>序号</th>
					<th>维护种类</th>
					<th>批准</th>
					<th>发起人</th>
					<th>批准人</th>
					<th>类别</th>
					<th>需求时间</th>
					<th>需求状态</th>
					<th>完成日期</th>
					<th>工单号</th>
					<th>满意度</th>
					<th>操作</th>
				</tr>
				</thead>						
				<tbody>
				<tr>
					<td>1</td>
					<td>应维</td>
					<td>常规</td>
					<td>李丽</td>
					<td>章章</td>
					<td>安装</td>
					<td>2014-06-02</td>
					<td>正常</td>
					<td>2014-06-05</td>
					<td>GDH-002</td>
					<td>满意</td>
					<td><img title="已完成" src="<s:url value="/css/skin/${skinPath}/images/gou.gif" />"/></td>
				</tr>
				<tr>
					<td>2</td>
					<td>应维</td>
					<td>常规</td>
					<td>李丽</td>
					<td>章章</td>
					<td>培训</td>
					<td>2014-06-15</td>
					<td>正常</td>
					<td>2014-06-16</td>
					<td>GDH-0009</td>
					<td>满意</td>
					<td><img title="已完成" src="<s:url value="/css/skin/${skinPath}/images/gou.gif" />"/></td>
				</tr>
				<tr>
					<td>3</td>
					<td>应维</td>
					<td>常规</td>
					<td>李丽</td>
					<td>章章</td>
					<td>安装</td>
					<td>2014-06-18</td>
					<td>正常</td>
					<td></td>
					<td>GDH-0011</td>
					<td></td>
					<td>[<a href="javascript:finishImplement();">完成</a>]</td>
				</tr>
				<tr>
					<td>4</td>
					<td>需维</td>
					<td>常规</td>
					<td>李丽</td>
					<td>章章</td>
					<td>培训</td>
					<td>2014-07-15</td>
					<td>加急</td>
					<td></td>
					<td></td>
					<td></td>
					<td>[<a href="javascript:sendWorkOrder();">派工单</a>]</td>
				</tr>
				</tbody>
			</table>
			<c:set var="pageView" value="${pdfn:getPageView(clientList)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>			
	</div>
</div>
</body>
</html>