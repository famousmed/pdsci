package com.pinde.sci.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pinde.sci.model.mo.SysUser;

public class GlobalContext {

	private static ThreadLocal<HttpServletRequest> requestLocal = new ThreadLocal<HttpServletRequest>();
	private static ThreadLocal<HttpServletResponse> responseLocal = new ThreadLocal<HttpServletResponse>();

	public static HttpServletRequest getRequest() {
		return (HttpServletRequest) requestLocal.get();
	}

	public static void setRequest(HttpServletRequest request) {
		requestLocal.set(request);
	}

	public static HttpServletResponse getResponse() {
		return (HttpServletResponse) responseLocal.get();
	}

	public static void setResponse(HttpServletResponse response) {
		responseLocal.set(response);
	}

	public static HttpSession getSession() {
		if (null == getRequest()) {
			return null;
		}
		return (HttpSession) getRequest().getSession();
	}

	public static SysUser getCurrentUser() {
		if (null == getSession()) {
			return null;
		}
		SysUser user = (SysUser) getSession().getAttribute(GlobalConstant.CURRENT_USER);
		return user;
	}
	public static String getCurrentWsId() {
		if (null == getSession()) {
			return null;
		}
		String cuurentWsId = (String) getSession().getAttribute(GlobalConstant.CURRENT_WS_ID);
		return cuurentWsId;
	}
	
	public static void setSessionAttribute(String key,Object obj){
		getSession().setAttribute(key, obj);
	}
	
	public static Object getSessionAttribute(String key){
		return getSession().getAttribute(key);
	}

}
