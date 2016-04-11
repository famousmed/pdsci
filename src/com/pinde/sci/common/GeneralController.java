package com.pinde.sci.common;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.pinde.core.util.AjaxUtil;
import com.pinde.sci.biz.sys.ICfgBiz;
public class GeneralController {
	
	@Autowired
	protected ICfgBiz cfgBiz;
	
	private static Logger logger = LoggerFactory.getLogger(GeneralController.class);
	
	@ExceptionHandler(Throwable.class)
    public String exception(Throwable e, HttpServletRequest request) {
		logger.error(this.getClass().getCanonicalName()+" some error happened",e);
		boolean isAjax = AjaxUtil.isAjaxRequest(request);
		if(isAjax){
			e.printStackTrace();
			return e.getMessage();
		}else{
	        e.printStackTrace();
	        request.setAttribute("exception", e);
	        return "error/500";			
		}
    }
	
	protected void setSessionAttribute(String key,Object obj){
		GlobalContext.getSession().setAttribute(key, obj);
	}
	
	protected Object getSessionAttribute(String key){
		return GlobalContext.getSession().getAttribute(key);
	}
	
	protected void removeSessionAttribute(String key){
		GlobalContext.getSession().removeAttribute(key);
	}
	
	protected int getPageSize(HttpServletRequest request){
		return Integer.parseInt(cfgBiz.getPageSize(request));
	}

}
