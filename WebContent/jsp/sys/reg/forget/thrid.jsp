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
	function doForget(){
		if(false==$("#forgetForm").validationEngine("validate")){
			return ;
		}
		$('#forgetForm').submit();	
		
	}
</script>
</head>

<body>
<div id="register">
   <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
</div>
<div class="mainright">
  <div id="content">
	<h1 class="reg_title">忘记密码--第三步--重新设置密码</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <div class="quyu clearfix">
    	<dl>
			<form id="forgetForm" name="forgetForm" action="<s:url value='/reg/forget/checkThrid'/>" method="post" style="position:relative;">
	            <dt class="dt_l">输入新密码：</dt>
	            <dd class="dd_r clearfix"><input id="userPasswdNew" name="userPasswdNew" type="password" class="validate[required,custom[password]] input_kuang address"/>
	                  <span class="check_tips succ_tips"></span></dd>
	            <dt class="dt_l">再次输入新密码：</dt>
	            <dd class="dd_r clearfix"><input name="userPasswdNew2" type="password" class="validate[required,equals[userPasswdNew]] input_kuang address"/>
	                  <span class="check_tips"></span></dd>
	            <dt class="dt_l"></dt>
	  		   <dd class="dd_r clearfix">
	             <div class="sub_login">
					<input type="hidden" name="userFlow" value="${param.userFlow }"/>          
	             	<input class="no_bg" type="button" value="设置新密码" onclick="doForget();"/>
	             	<c:if test="${not empty forgetErrorMessage}">
				       	<span style="color:red;">
							设置新密码失败：${forgetErrorMessage}
						</span>
					</c:if>
	             </div></dd>
			</form>
        </dl>
    </div>
</div>

<div id="footer"></div>
</div>
</body>
</html>