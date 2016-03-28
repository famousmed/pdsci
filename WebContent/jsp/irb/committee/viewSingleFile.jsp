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
	function view() {
		
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	<table style="width: 850px;height:470px	">
				<tr>
					<td>
						<embed src="<s:url value='/jsp/irb/meeting/123.swf'/>" width="850px" height="450px"
			                 play="true" 
			                 ALIGN="middle" 
			                 loop="true" 
			                 quality="high"
			                 type="application/x-shockwave-flash"
			                 flashvars="zoomtype=3"
			                 pluginspage="http://www.macromedia.com/go/getflashplayer">
			          </embed>
						</td>
				</tr>
				</table>
			<div class="button" style="width: 900px;">
				<input type="button" class="search" onclick="jboxClose();" value="关闭">
			</div>
		</div>
	</div>
	</div>
</body>
</html>