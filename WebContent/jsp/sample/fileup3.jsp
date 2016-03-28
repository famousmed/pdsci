<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.FilePart"%>
<%@ page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@ page import="com.oreilly.servlet.multipart.ParamPart"%>
<%@ page import="com.oreilly.servlet.multipart.Part"%>
<%@ page import="java.io.*" %>
<%@ page import="com.pinde.lic.util.DateUtil"%>
<%@ page import="com.pinde.lic.util.PkUtil"%>
<%@ page import="com.pinde.lic.util.StringUtil"%>
<%@ page import="com.pinde.sci.common.InitConfig" %>
 <%
 int maxPostSize = 2 * 100 * 1024 * 1024;  
 MultipartParser mp = new MultipartParser(request, maxPostSize, false, false, "UTF-8");
 Part part;
 while ((part = mp.readNextPart()) != null) {        
	  String paramName = part.getName();
	  if (part.isParam()) { 
		  
	  }else if(part.isFile()){
		  FilePart filePart = (FilePart) part;
      	  String fileName = filePart.getFileName();
      	  String dateString = DateUtil.getCurrDate2();
		  String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+"//annex//" + dateString ;
		  File fileDir = new File(newDir);
		  if(!fileDir.exists()){
		    fileDir.mkdirs();
		  }
		  /*文件名*/
		  fileName = PkUtil.getUUID()+fileName.substring(fileName.lastIndexOf("."));
		  File newFile = new File(fileDir, fileName); 
		  try {
			  filePart.writeTo(newFile);
			  out.println(fileName);
		  } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		  }
	  }
 }
 %>
