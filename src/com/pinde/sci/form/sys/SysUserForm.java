package com.pinde.sci.form.sys;

import com.pinde.sci.model.mo.SysUser;

public class SysUserForm {
	private SysUser user;
	/**
	 *����ίԱ����ˮ��
	 */
	private String irbInfoFlow;
	/**
	 * ��ɫ��ˮ��
	 */
	private String roleFlow;
	/**
	 * ��Ŀ��ˮ��
	 */
	private String projFlow;
	

	public String getProjFlow() {
		return projFlow;
	}
	public void setProjFlow(String projFlow) {
		this.projFlow = projFlow;
	}
	public SysUser getUser() {
		return user;
	}
	public void setUser(SysUser user) {
		this.user = user;
	}
	public String getIrbInfoFlow() {
		return irbInfoFlow;
	}
	public void setIrbInfoFlow(String irbInfoFlow) {
		this.irbInfoFlow = irbInfoFlow;
	}
	public String getRoleFlow() {
		return roleFlow;
	}
	public void setRoleFlow(String roleFlow) {
		this.roleFlow = roleFlow;
	}
}
