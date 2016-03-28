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
    function audit(bookImpFlow){
    	var url = "<s:url value='/exam/manage/imp/audit'/>?bookImpFlow="+bookImpFlow;
    	jboxOpen(url,"题目审核", 900, 600);
    }
    
    function search() {
    	jboxStartLoading();
    	$("#searchForm").submit();
    }
    
    function changeColor(obj){
    	$(obj).parent("tr").css("background-color" , "pink").siblings().css("background-color" , "");
    }
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			    <form id="searchForm" action="<s:url value="/exam/manage/imp/auditList" />"	method="post">
					书号：<input name="examBook.bookNum" value="${bookImpExt.examBook.bookNum}"/>
					&nbsp;&nbsp;
					<input type="button" class="search" onclick="search();" value="查&#12288;询">
				</form>
			</div>			
			<table id="impTable" class="xllist">
				<thead>
				<tr>
				    <th width="50px;">书号</th>
					<th width="50%">导入书本</th>
					<th width="20%">导入科目</th>
					<th width="60px">导入人</th>
					<th width="100px">导入时间</th>
					<th width="60px">校验人</th>
					<th width="100px">校验时间</th>
					<th width="50px">状态</th>
					<th width="50px">操作</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${examImpList}" var="imp">
					<tr>
					    <td>${imp.examBook.bookNum}</td>
						<td>${imp.bookName }</td>
						<td>${imp.subjectMemo}</td>
						<td>${imp.impUserName }</td>
						<td>${pdfn:transDateTime(imp.impTime)}</td>
						<td>${imp.checkUserName}</td>
						<td>${pdfn:transDateTime(imp.checkTime)}</td>
						<td>${imp.statusDesc}</td>
						<td onclick="changeColor(this);">
							[<a href="javascript:audit('${imp.bookImpFlow}');">审核</a>]
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${examImpList == null || examImpList.size()==0 }"> 
					<tr> 
						<td align="center" colspan="9">无记录</td>
					</tr>
				</c:if>
			</table>
	</div>
</div>
</body>
</html>