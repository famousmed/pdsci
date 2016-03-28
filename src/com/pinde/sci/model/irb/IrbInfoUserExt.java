package com.pinde.sci.model.irb;

import java.io.Serializable;

import com.pinde.sci.model.mo.IrbInfo;
import com.pinde.sci.model.mo.IrbInfoUser;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

public class IrbInfoUserExt extends IrbInfoUser implements Serializable{
	
	private static final long serialVersionUID = -5025428396907606864L;
	
	/**
	 * ����ίԱ��
	 */
	private IrbInfo irbInfo;
	/**
	 *��Ӧ�û�
	 */
	private SysUser sysUser;
	/**
	 * ����ְ��
	 */
	private SysRole sysRole;
	public IrbInfo getIrbInfo() {
		return irbInfo;
	}
	public void setIrbInfo(IrbInfo irbInfo) {
		this.irbInfo = irbInfo;
	}
	public SysUser getSysUser() {
		return sysUser;
	}
	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	public SysRole getSysRole() {
		return sysRole;
	}
	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}
	
}
