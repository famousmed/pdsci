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
	function sendEmail() {
		if(false==$("#testForm").validationEngine("validate")){
			return ;
		}
		var url = "<s:url value='/sys/cfg/sendEmail'/>";
		var data = $('#testForm').serialize();
		jboxPost(url, data, function() {
			jboxClose();
		});
	}
</script>
</head>
<body>

<form id="testForm" style="height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">
				<table width="800" cellpadding="0" cellspacing="0" class="basic">
					<tr>
						<th>收件人：</th>
						<td>
							<input class="validate[required,custom[email]] xltext" name="receiver" type="text" value="" >
						</td>
					</tr>
					<tr>
						<th>标题：</th>
						<td>
							<input class="validate[required] xltext" name="title" type="text" value="" placeholder="请填写email标题">
						</td>
					</tr>
					<tr>
						<th>内容：</th>
						<td>
							<textarea name="content" class="validate[required] xltxtarea" placeholder="请填写email内容" style="margin: 1px;"></textarea>
						</td>
					</tr>
					
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="发&#12288;送" onclick="sendEmail();" />
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>