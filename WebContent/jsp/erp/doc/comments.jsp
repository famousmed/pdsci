<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="saveForm">
			<table style="width: 100%;">
				<tbody>
				<tr>
					<td style="text-align:left;">
				     	<textarea name="comment" rows="2" placeholder="评论..." style="width: 100%;"></textarea>
				     </td>
				</tr>
				</tbody>
			</table> 
			</form>
			<div style="text-align: right;padding-top: 5px;">
				<input type="button" style="width: 45px;" value="提交" onclick="" />
			</div>
			<table class="comments">
				<tbody>
					<tr>
						<td>
							<span class="cm_name">李丽</span><br>
							外网邮箱<br>
							<span class="cm_date">2015-01-15 09:02:01</span>
						</td>
					</tr>
					<tr>
						<td>
							<span class="cm_name">胡一菲</span><br>
							外网邮箱设置方法<br>
							<span class="cm_date">2015-01-15 08:16:01</span>
						</td>
					</tr>
				</tbody>
			</table> 
		</div>
	</div>
</div>
</body>
</html>