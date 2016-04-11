<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/doctor/Style.css'/>"></link>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
</jsp:include>
<style type="text/css">
     body{overflow-x:hidden;}
     html{overflow-x:hidden;}
</style>
<script type="text/javascript">
   
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix" style="width: 100%;">
				${empty rotationDept.schStandard?'没有科室轮转信息规范!':rotationDept.schStandard}
			</div>
		</div>
	</div>
</body>
</html>