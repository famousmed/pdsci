package com.pinde.sci.common;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.swing.Spring;

import org.springframework.beans.factory.annotation.Autowired;

import com.pinde.core.util.DateUtil;
import com.pinde.core.util.SpringUtil;
import com.pinde.sci.model.mo.SysUser;

public class SessionData implements Serializable,HttpSessionBindingListener{
	
	private static final long serialVersionUID = 4342045600030902787L;
	
	public static String SESSIONDATAID = "SESSIONDATA";
	//在线统计使用
	public static Map<String,SessionData> sessionDataMap = new HashMap<String,SessionData>();
	public static Map<String,HttpSession> sessionMap = new HashMap<String,HttpSession>();
	// 所有用户拥有
	private SysUser sysUser;
	private String ip;
	private String loginTime = null;
	private String lastAccessTime = null;
	private String gapTime = null;

	public String getIp() {
		return ip;
	}
	
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getLoginTime() {
		return loginTime;
	}
	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}
	public String getLastAccessTime() {
		return lastAccessTime;
	}
	public void setLastAccessTime(String lastAccessTime) {
		this.lastAccessTime = lastAccessTime;
	}
	public String getGapTime() {
		return gapTime;
	}
	public void setGapTime(String gapTime) {
		this.gapTime = gapTime;
	}
	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	
	//接口只用,负责统计在线时间，记录退出系统或项目的时间
	public void valueBound(HttpSessionBindingEvent event) {
		if(this.sysUser!=null){
			sessionDataMap.put(sysUser.getUserFlow(),this);
			sessionMap.put(sysUser.getUserFlow(),event.getSession());
		}		
	}
	public void valueUnbound(HttpSessionBindingEvent event) {
		if(this.sysUser!=null){
			sessionDataMap.remove(sysUser.getUserFlow());
			sessionMap.remove(sysUser.getUserFlow());
		}
	}
	//在线统计使用
	/**
	 * Returns the onlineUsers.
	 * @return List
	 */
	public static List<SessionData> getOnlineUsers() {
		List<SessionData> onlineUsers = new ArrayList<SessionData>();
		Set<String> set = sessionDataMap.keySet();
		Iterator<String> it = set.iterator();
		while(it.hasNext()){
			String userFlow = (String)it.next();
			SessionData sessionData = (SessionData)sessionDataMap.get(userFlow);
			onlineUsers.add(sessionData);
		}
		return onlineUsers;
	}
}
