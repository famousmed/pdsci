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
	function nextOpt(step){
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}

</script>

</head>
<body>
<h3>延期申请</h3>
第一步 流水号：${param.projFlow}
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
	<input type="hidden" name="pageName" value="step1"/>
	<input type="hidden" name="projRecFlow" value="${param.projRecFlow}"/>
	<input type="hidden" name="projFlow" value="${param.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	中文名：<input name="zhcnName" value="${resultMap.zhcnName}"/>
	<br/>
	品种：
	<select name="pinzhong">
		<option value="1" <c:if test='${resultMap.pinzhong=="1"}'>selected="selected"</c:if> >优秀</option>
		<option value="2" <c:if test='${resultMap.pinzhong=="2"}'>selected="selected"</c:if>>良好</option>
		<option value="3" <c:if test='${resultMap.pinzhong=="3"}'>selected="selected"</c:if>>及格</option>
	</select>
</form>
--------------------------------------
<a href="javascript:void(0)" target="_self"  onclick="nextOpt('step2')" id="next">下一步</a>
</body>
</html>