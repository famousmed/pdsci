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

</head>
<body>
<c:if test="${not empty registInfo }">
 <p>${registInfo}</p>
 <c:if test="${not empty action }">
 <a href="<s:url value='/exam/manage/imp/${action}'/>">返回</a>
 </c:if>
</c:if>
<c:if test="${verifyInfo.passFlag==false}">
操作失败<br/>
失败题型：
<c:forEach items="${questionTypeEnumList}" var="questionTypeEnum">
<c:if test="${questionTypeEnum.id eq verifyInfo.questionTypeId}">
${questionTypeEnum.name}
</c:if>
</c:forEach>
<br/>
第${verifyInfo.getQuestionNo()}题出错<br/>
出错行数：${verifyInfo.getLineNum()}<br/>
错误信息：${verifyInfo.msg}<br/>
请检查题目文件信息后重新上传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<c:if test="${not empty action }">
    <a href="<s:url value='/exam/manage/imp/${action}'/>">返回</a>
</c:if>
<br/>
<script type="text/javascript" defer="defer">
    $(document).ready(function(){
	$("#hidden_frame").show();
});
</script>
</c:if>
</body>
</html>