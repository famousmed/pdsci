<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
</jsp:include>
</head>
<body>
<div class="mainright">
<div class="content">
<div class="title1 clearfix">
	<table  class="xllist">
	    <thead>
	        <tr>
	            <th>医院</th>
	            <c:forEach var="projType" items="${dictTypeEnumProjTypeList}">
	                <th style="text-align: center;">${projType.dictName}</th>
	            </c:forEach>
	        </tr>
	    </thead>
	    <tbody>
	        <c:forEach items="${orgs}" var="org">
	            <tr>
	                <td>${org.value}</td>
	                <c:forEach var="projType" items="${dictTypeEnumProjTypeList}">
	                    <td>${applyLimitInfoMap[org.key][projType.dictId]}</td>
	                </c:forEach>
	            </tr>    
	        </c:forEach>
	    </tbody>
	</table>
</div>
</div>
</div>
</body>
</html>