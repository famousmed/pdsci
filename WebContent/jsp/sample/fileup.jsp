<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.springframework.web.multipart.MultipartFile"%>
<%@ page import="org.springframework.web.multipart.MultipartHttpServletRequest"%>
<%@ page import="com.pinde.lic.util.DateUtil"%>
<%@ page import="com.pinde.lic.util.PkUtil"%>
<%@ page import="com.pinde.lic.util.StringUtil"%>
<%@ page import="com.pinde.sci.common.InitConfig" %>
<%@ page import="com.pinde.sci.common.GlobalConstant" %>
<%@ page import="java.io.File" %>
 <%
    MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	MultipartFile file = multipartRequest.getFile("file");
	String fileName = "";
	try {
		/*创建目录*/
		String dateString = DateUtil.getCurrDate2();
		String newDir = StringUtil.defaultString(InitConfig.getSysCfg("upload_base_dir"))+"//annex//" + dateString ;
		File fileDir = new File(newDir);
		if(!fileDir.exists()){
			fileDir.mkdirs();
		}
		/*文件名*/
		fileName = file.getOriginalFilename();
		fileName = PkUtil.getUUID()+fileName.substring(fileName.lastIndexOf("."));
		File newFile = new File(fileDir, fileName); 
		file.transferTo(newFile);
		String resultPaht =  "success:"+dateString+"/"+fileName;
		out.println(resultPaht);
	} catch (Exception e) {
		e.printStackTrace();
		String resultMsg = GlobalConstant.UPLOAD_FAIL;
		out.println(resultMsg);
	}
 %>
