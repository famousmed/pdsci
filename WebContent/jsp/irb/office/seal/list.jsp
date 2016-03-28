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
	function addSeal(){
		jboxOpen("<s:url value='/irb/office/editSeal'/>","新增盖章登记", 700,350);
	}
	function editSeal(stampFlow){
		jboxOpen("<s:url value='/irb/office/editSeal?stampFlow='/>" + stampFlow,"编辑盖章登记", 700,350);
	}
	function delSeal(stampFlow){
		jboxConfirm("确认删除？" ,function(){
			var url = "<s:url value='/irb/office/delSeal?stampFlow='/>"+ stampFlow;
			jboxGet(url,null,function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].location.reload(true);
					jboxClose();
				}
			},null,true);
		});
	}
	
	function search() {
		$("#searchForm").submit();
	}
	
	function toPage(page){
		var form = $("#searchForm");
		$("#currentPage").val(page);
		form.submit();
	}
</script>
</head>
<body>
<div class="mainright" id="mainright" style="width:100%;">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/office/seal"/>" method="post">
			<p>
				项目名称：<input type="text" class="xltext" name="projName" value="${param.projName}"/>&#12288; 
				盖章日期：
				<input type="text" name="stampDate" value="${param.stampDate}" class="ctime" readonly="readonly" style="margin-right: 0px;" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> ~ 
				<input type="text" name="stampEndDate" value="${param.stampEndDate}" class="ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/> 
				
				<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
				<input type="button" value="新&#12288;增" class="search" onclick="addSeal();"/>
			</p><br/>
			
		<table class="xllist">
			<thead>
				<tr>
					<th>盖章日期</th>
					<th>项目名称</th>
					<th>期类别</th>
					<th>项目来源</th>
					<th>盖章文件名称</th>
					<th>份数</th>
					<th>盖章人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${stampList}" var="stamp">
					<tr>
						<td width="10%">${stamp.stampDate}</td>
						<td width="30%">${stamp.projName}</td>
						<td width="5%">${projMap[stamp.stampFlow].projSubTypeName}</td>
						<td width="20%">${projMap[stamp.stampFlow].projDeclarer}</td>
						<td width="10%">${stamp.stampName}</td>
						<td width="5%">${stamp.stampNum}</td>
						<td width="10%">${stamp.stampUserName}</td>
						<td>
							[<a href="javascript:void(0)" onclick="editSeal('${stamp.stampFlow}')">编辑</a>]
							[<a href="javascript:void(0)" onclick="delSeal('${stamp.stampFlow}')">删除</a>]
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p>
			<input type="hidden" id="currentPage" name="currentPage">
		    <c:set var="pageView" value="${pdfn:getPageView2(stampList , 10)}" scope="request"></c:set>
			<pd:pagination toPage="toPage"/>
		</p>
		</form>
	</div>
	</div>
</div>
</body>
</html>