package com.pinde.sci.common;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.commons.CommonsMultipartResolver;

public class PdsciMultipartResolver extends CommonsMultipartResolver{

	@Override
    public boolean isMultipart(HttpServletRequest request) {
		String getPath = request.getRequestURL().toString();
        if (getPath.contains("ueditor")) {
            return false;
        } else if (getPath.contains("saveProjInfo")) {
            return false;
        } else if(getPath.contains("savePageGroupStep")){
        	return false;
        }else if(getPath.contains("saveStep")){
        	return false;
        }else if(getPath.contains("saveApplyFile")){
        	return false;
        }else {
            return super.isMultipart(request);
        }
        
    }

}
