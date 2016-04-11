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
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			</div>			
			<table class="xllist">
				<thead>
				<tr>
				    <th width="50px;">书号</th>
					<th>导入书本</th>
					<th>文件名称</th>
					<th width="40%">题目类型</th>
					<th width="60px">操作人</th>
					<th width="80px">操作时间</th>
				</tr>
				</thead>						
				<tbody>
				<c:forEach items="${reloadRecs}" var="reloadRec">
					<tr>
					    <td>${reloadRec.bookNum}</td>
					    <td>${reloadRec.bookMemo}</td>
					    <td>${reloadRec.fileName}</td>
					    <td>${reloadRec.questionTypeName}</td>
					    <td>${reloadRec.operUserName}</td>
					    <td>${pdfn:transDateTime(reloadRec.createTime)}</td>
					</tr>
				</c:forEach>
				</tbody>
				<c:if test="${reloadRecs == null || reloadRecs.size()==0 }"> 
					<tr> 
						<td align="center" colspan="5">无记录</td>
					</tr>
				</c:if>
			</table>
	</div>
</div>
</body>
</html>