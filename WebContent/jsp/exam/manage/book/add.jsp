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
	function saveBook() {
		if(false==$("#bookForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/exam/manage/book/save'/>";
		var data = $('#bookForm').serialize();
		jboxPost(url, data, function() {
			window.parent.frames['mainIframe'].window.refreshParent();
			jboxClose();
		});
	}
</script>
</head>
<body>
<form id="bookForm" style="height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr style="">
						<th>父节点名称：</th>
						<td colspan="3">
							<input type="hidden" name="bookParentFlow" value="${bookParent.bookFlow}">
							${bookParent.memo }
						</td>
					</tr>
					<tr>
						<th>书目名称：</th>
						<td colspan="3">
							<input type="text" name="bookName" class="validate[required] xltext">
						</td>
					</tr>
					<tr>
						<th>书号：</th>
						<td colspan="3">
						    <c:if test='${bookParent.bookFlow eq "0"}'>
						        <input type="text" name="bookNum" class="validate[required] xltext">
						    </c:if>
						    <c:if test='${bookParent.bookFlow != "0"}'>
						        <span>${topBook.bookNum}</span>
						        <input type="hidden" name="bookNum" value="${topBook.bookNum}">
						    </c:if>
						</td>
					</tr>
					<tr>
						<th>出版社：</th>
						<td colspan="3">
						    <c:if test='${bookParent.bookFlow eq "0"}'>
						        <input type="text" name="bookPress" class="validate[required] xltext">
						    </c:if>
						    <c:if test='${bookParent.bookFlow != "0"}'>
						        <span>${topBook.bookPress}</span>
						        <input type="hidden" name="bookPress" value="${topBook.bookPress}">
						    </c:if>
						</td>
					</tr>
					<tr>
						<th>出版年份：</th>
						<td colspan="3">
						    <c:if test='${bookParent.bookFlow eq "0"}'>
						        <input type="text" name="publishYear" class="validate[required] xltext">
						    </c:if>
						    <c:if test='${bookParent.bookFlow != "0"}'>
						        <span>${topBook.publishYear}</span>
						         <input type="hidden" name="publishYear" value="${topBook.publishYear}">
						    </c:if>
						</td>
					</tr>
					<tr>
						<th>书目页数：</th>
						<td colspan="3">
						    <c:if test='${bookParent.bookFlow eq "0"}'>
						        <input type="text" name="bookPageNum" class="validate[required] xltext">
						    </c:if>
						    <c:if test='${bookParent.bookFlow != "0"}'>
						        <span>${topBook.bookPageNum}</span>
						        <input type="hidden" name="bookPageNum" value="${topBook.bookPageNum}">
						    </c:if>
						</td>
					</tr>
					<tr>
						<th>书目来源：</th>
						<td colspan="3">
						    <c:if test='${bookParent.bookFlow eq "0"}'>
						        <input type="text" name="bookSource" class="validate[required] xltext">
						    </c:if>
						    <c:if test='${bookParent.bookFlow != "0"}'>
						        <span>${topBook.bookSource}</span>
						        <input type="hidden" name="bookSource" value="${topBook.bookSource}">
						    </c:if>
						</td>
					</tr>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveBook();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>