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
	<h1 class="reg_title">忘记密码--第二步--输入校验信息</h1>
    <p class="line">如已拥有帐户信息，则<a href="<s:url value='/index.jsp'/>" class="line_c">在此登录</a></p>
    <div class="quyu clearfix">
    	<dl>
			<form id="forgetForm" name="forgetForm" action="<s:url value='/reg/forget/checkSecond'/>" method="post" style="position:relative;">
	            <dt class="dt_l">姓名：</dt>
	            <dd class="dd_r clearfix"><input name="userName" type="text" placeholder="姓名" class="validate[required,custom[chinese]] input_kuang address" value="${param.userName }"/>
	                  </dd>
	            <c:if test="${param.forgetType != 'idNo'}">
	            <dt class="dt_l">身份证号：</dt>
	            <dd class="dd_r clearfix"><input name="idNo" type="text" placeholder="身份证号" class="validate[required,custom[chinaIdLoose]] input_kuang address" value="${param.idNo }"/>
	                 </dd>
	            </c:if>
	            <dt class="dt_l">所在机构：</dt>
	            <dd class="dd_r clearfix">
	            		<select class="validate[required] input_kuang address" name="orgFlow" style="80px;">
							<option value="">请选择</option>
							<c:forEach var="sysOrg" items="${applicationScope.sysOrgList}">
							<option value="${sysOrg.orgFlow}" <c:if test="${sysOrg.orgFlow==param.orgFlow }">selected</c:if>>${sysOrg.orgName}</option>
							</c:forEach>
						</select></dd>
						</dd>
	            <dt class="dt_l"></dt>
	  		   <dd class="dd_r clearfix">
	             <div class="sub_login">
					<input type="hidden" name="userFlow" value="${param.userFlow }"/>
					<input type="hidden" name="forgetType" value="${param.forgetType }"/>          
	             	<input class="no_bg" type="button" value="验证信息" onclick="doForget();"/>
	             	<c:if test="${not empty forgetErrorMessage}">
				       	<span style="color:red;">							
	             	&#12288;&#12288;验证信息失败：${forgetErrorMessage}
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