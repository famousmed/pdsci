<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="false"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="false"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript" >
function reloadVerifyCode()
{
	$("#verifyImage").attr("src","<s:url value='/captcha'/>?random="+Math.random());
}
function checkForm(){
	if(false==$("#loginForm").validationEngine("validate")){
		return false;
	}
	return true;
}
</script>
<title>法默生临床研究数据采集与管理系统 | pharmasun-EDC</title>
<script Language=JavaScript> 
     function Click(){ 
     alert('南京迈拓医药科技有限公司版权所有'); 
     window.event.returnValue=false; 
     } 
     document.oncontextmenu=Click; 
</script>
<style>
.plogo{background: #EAEAEA url(<s:url value='/css/img/loginbg.jpg' />) no-repeat top center;}
</style>
</head>
<body class="plogo">
<div class="m">
<div style="margin-top:228px;margin-bottom:42px;width:800px">
<c:if test="${not empty loginErrorMessage}">
<div class="alert">登录失败：${loginErrorMessage}</div>
</c:if>
<table width="600" border="0" align="center" cellpadding="8" cellspacing="0">
  <tr>
    <td width="200" align="center"><a href="<s:url value='/inx/pharmasun/ctms'/>"><img src="<s:url value='/css/img/CTMS.png' />" alt="法默生临床试验管理系统" width="120" height="120"></a></td>
    <td width="200" align="center"><a href="<s:url value='/inx/pharmasun/edc'/>"><img src="<s:url value='/css/img/EDC.png' />" alt="法默生临床试验数据采集和管理系统" width="120" height="120"></a></td>
    <td width="200" align="center"><a href="<s:url value='/inx/pharmasun/irb'/>"><img src="<s:url value='/css/img/IRB.png' />" alt="法默生伦理审查管理系统" width="120" height="120"></a></td>
    </tr>
  <tr>
    <td width="200" align="center"><a href="<s:url value='/inx/pharmasun/ctms'/>">临床试验管理系统</a></td>
    <td width="200" align="center"><a href="<s:url value='/inx/pharmasun/edc'/>">临床试验数据和采集管理系统</a></td>
    <td width="200" align="center"><a href="<s:url value='/inx/pharmasun/irb'/>">伦理审查管理系统</a></td> 
    </tr>
</table>
</div>
<div class="footer">
Copyright © <a href="http://www.pharmasun.cn" target="_blank">法默生临床试验管理系统</a> <img src="<s:url value='/css/img/logos.png'/>" width="16" height="16"> 南京迈拓医药科技有限公司 All rights reserved. v2015.1  <a href="http://www.miibeian.gov.cn" target="_blank">苏ICP备14017851号-1</a></div>
</div>
</body>
</html>
