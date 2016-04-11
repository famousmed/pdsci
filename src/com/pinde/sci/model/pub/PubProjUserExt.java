package com.pinde.sci.model.pub;

import com.pinde.sci.model.mo.PubProjUser;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

public class PubProjUserExt extends PubProjUser {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2905795757139055689L;
	private SysUser user;
	private SysRole role;
	private String allRoleName;
	
	public SysUser getUser() {
		return user;
	}
	public void setUser(SysUser user) {
		this.user = user;
	}
	public SysRole getRole() {
		return role;
	}
	public void setRole(SysRole role) {
		this.role = role;
	}
	public String getAllRoleName() {
		return allRoleName;
	}
	public void setAllRoleName(String allRoleName) {
		this.allRoleName = allRoleName;
	}
	
}
