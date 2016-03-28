<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_placeholder" value="false"/>
</jsp:include>
<script>

$(document).ready(function(){
	$("#loginBtn").bind("click",function(){
		if($("#sessionid").val()==""){
			alert("sessionid not null");
			return ;	
		}
		window.location.href="http://www.enso.net.cn/edc/enso/oauth/"+$("#sessionid").val();
	});
	$("#sessionid").keyup(function(){
		  $("#sessionidSpan").html($("#sessionid").val());
		  if( $("#sessionidSpan").html()==""){
			  $("#sessionidSpan").html("sessionid");
		  }
	});
});
</script>
</head>
<body>
	<div style="margin-top: 50px;font-size: 20px;margin-left: 30px;">
	CheckLoginUrl: "http://www.enso.net.cn/checklogin/<span id="sessionidSpan">sessionid</span>/c6289c8201b745df94436abdee";
	<br/><br/><br/>
	LonginURL:http://www.enso.net.cn/edc/enso/oauth/<input type="text" id="sessionid" value=""  placeholder="sessionid"/>
	<input type="button" value="login" id="loginBtn"/>
	</div>
</body>
</html>