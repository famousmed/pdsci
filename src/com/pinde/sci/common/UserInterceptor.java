package com.pinde.sci.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.util.StringUtil;

public class UserInterceptor implements HandlerInterceptor {

	private static Logger logger = LoggerFactory.getLogger(UserInterceptor.class);

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object obj, Exception err)
			throws Exception {
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object obj, ModelAndView mav)
			throws Exception {
	}

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object obj) throws Exception {
		String getPath = request.getRequestURL().toString();
		if(StringUtil.isNotBlank(request.getQueryString()) ){
			getPath = getPath+"?"+request.getQueryString();
		}
		logger.debug("UserInterceptor handler......{}",getPath);
		if("get".equalsIgnoreCase(request.getMethod())){
			request.getSession().setAttribute("goPath", getPath);
		}	
		Object sysUser = request.getSession().getAttribute(GlobalConstant.CURRENT_USER);
		if (sysUser == null) {
			request.getRequestDispatcher("/timeout").forward(request, response);
			return false;
		}
		return true;
	}

}
