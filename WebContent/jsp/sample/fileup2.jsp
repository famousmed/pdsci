<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.springframework.web.multipart.MultipartFile"%>
<%@ page import="org.springframework.web.multipart.MultipartHttpServletRequest"%>
<%@ page import="com.pinde.lic.util.DateUtil"%>
<%@ page import="com.pinde.lic.util.PkUtil"%>
<%@ page import="com.pinde.lic.util.StringUtil"%>
<%@ page import="com.pinde.sci.common.InitConfig" %>
<%@ page import="com.pinde.sci.common.GlobalConstant" %>
<%@ page import="com.pinde.lic.util.SpringUtil" %>
<%@ page import="com.pinde.sci.biz.pub.IFileBiz" %>
<%@ page import="java.io.File" %>
 <%
    MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	MultipartFile file = multipartRequest.getFile("file");
	String fileName = "";
	try {
		IFileBiz fileBiz = (IFileBiz) SpringUtil.getBean(IFileBiz.class);
		String fileFlow = fileBiz.addFile(file, "123456");
		
		out.println(fileFlow);
	} catch (Exception e) {
		e.printStackTrace();
		String resultMsg = GlobalConstant.UPLOAD_FAIL;
		out.println(resultMsg);
	}
 %>
