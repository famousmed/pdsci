<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>多文件上传</title>
</head>
<body>
<h2>上传多个文件 实例</h2>  
  
  
    <form action="<s:url value='/ueditor/jsp/fileUp.jsp'/>" method="post"  
        enctype="multipart/form-data">  
        <p>  
            选择文件:<input type="file" name="file">  
        <p>  
            <input type="submit" value="提交">  
    </form> 
</body>
</html>