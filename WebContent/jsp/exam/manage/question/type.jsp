<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="false"/>
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
		 <c:if test='${param.questionTypeId == "15"}'>
             <jsp:include page="/jsp/exam/manage/question/type_15.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "18"}'>
             <jsp:include page="/jsp/exam/manage/question/type_18.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "25"}'>
             <jsp:include page="/jsp/exam/manage/question/type_25.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "26"}'>
             <jsp:include page="/jsp/exam/manage/question/type_26.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "27"}'>
             <jsp:include page="/jsp/exam/manage/question/type_27.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "28"}'>
             <jsp:include page="/jsp/exam/manage/question/type_28.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "29"}'>
             <jsp:include page="/jsp/exam/manage/question/type_29.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "30"}'>
             <jsp:include page="/jsp/exam/manage/question/type_30.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "31"}'>
             <jsp:include page="/jsp/exam/manage/question/type_31.jsp"></jsp:include>
         </c:if>
         <!-- K型题 暂时没有 -->
         <c:if test='${param.questionTypeId == "33"}'>
             <jsp:include page="/jsp/exam/manage/question/type_33.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "34"}'>
             <jsp:include page="/jsp/exam/manage/question/type_34.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "35"}'>
             <jsp:include page="/jsp/exam/manage/question/type_35.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "36"}'>
             <jsp:include page="/jsp/exam/manage/question/type_36.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "37"}'>
             <jsp:include page="/jsp/exam/manage/question/type_37.jsp"></jsp:include>
         </c:if>
         <c:if test='${param.questionTypeId == "38"}'>
             <jsp:include page="/jsp/exam/manage/question/type_38.jsp"></jsp:include>
         </c:if>
         <!-- 多媒体暂时没有 -->
         <c:if test='${param.questionTypeId == "48"}'>
             <jsp:include page="/jsp/exam/manage/question/type_48.jsp"></jsp:include>
         </c:if>
    </div>
</div>
    
</body>
</html>