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
第二步 流水号：${param.projFlow}
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm">
	<input type="hidden" name="pageName" value="step2"/>
	<input type="hidden" name="projRecFlow" value="${param.projRecFlow}"/>
	<input type="hidden" name="projFlow" value="${param.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	说明：
		<textarea rows="10" cols="20" name="info">${resultMap.info}</textarea>
		<br/>
	性别：
		<input type="radio" name="sex" value="1" <c:if test='${resultMap.sex=="1"}'>checked="checked"</c:if> />男
		<input type="radio" name="sex" value="2" <c:if test='${resultMap.sex=="2"}'>checked="checked"</c:if>/>女
		<br/>
	完成人：
	1.<input type="text" name="finish1" value="${resultMap.finish1}"/>2.<input type="text" name="finish2" value="${resultMap.finish2}"/>
	<br/>
</form>
<a href="javascript:void(0)" target="_self"  onclick="nextOpt('step1')">上一步</a>
<a href="javascript:void(0)" target="_self"  onclick="nextOpt('step3')">下一步</a>
</body>
</html>