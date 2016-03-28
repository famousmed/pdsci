package com.pinde.sci.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.pinde.core.license.PdLicense;
import com.pinde.core.util.StringUtil;

public class LicenseInterceptor implements HandlerInterceptor {

	private static Logger logger = LoggerFactory.getLogger(LicenseInterceptor.class);

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
		if(InitConfig.licenseed==false){
//			request.getRequestDispatcher("/license").forward(request, response);
//			return false;		
		}else{
			if(!PdLicense.checkValid()){
//				response.sendRedirect(request.getContextPath()+"/expired");
//				return false;
				//request.setAttribute("expired", true);
				//request.getRequestDispatcher("/license").forward(request, response);
				//return false;	
			}
		}
		return true;
	}

}
