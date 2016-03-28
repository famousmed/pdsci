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
<script type="text/javascript">
$().ready(function(){
	newEmail();
});

function newEmail(){
	$("#step1").removeClass("current");
	$("#step1").addClass("done");
	$("#step2").addClass("current");
	reloadContent('<s:url value='/sys/user/edit/newEmail'/>?userFlow=${param.userFlow}');
}

function reloadContent(url){
	jboxStartLoading();
	jboxLoad("mainContent",url,true);
	jboxEndLoading();
}
</script>
<body>
<div id="main">
		<div class="mobile-head" style="border-bottom: 0;">
			<div class="logo-title">修改邮箱</div>
		</div>
		<div class="flowsteps" id="icn">
	  <ol class="num4">
        <li class="first current" id="step1">
          <span><i>1</i><em>验证身份</em></span>
        </li>
        <li id="step2">
          <span><i>2</i><em>输入新邮箱地址</em></span>
        </li>
        <li id="step3">
          <span><i>3</i><em>发送邮箱验证码</em></span>
        </li>
        <li class="last" id="step4">
          <span><i>4</i><em>完成</em></span>
        </li>
      </ol>
	</div>
	<div id="mainContent" style="padding-top: 10px">

	</div>
</div>
</body>
</html>