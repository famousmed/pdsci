package com.pinde.sci.model.srm;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

import com.pinde.sci.model.mo.SrmExpert;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysUser;

public class UserRegForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7327853952201858716L;

	private String roleFlow;
	
	private SysUser user;
	
	private SrmExpert expert;
	
	private SysOrg org;
	
	private MultipartFile orgFile;//��֯�����ļ�
 
	private MultipartFile licenseFile;//Ӫҵִ���ļ�
	
	
	public SysOrg getOrg() {
		return org;
	}

	public void setOrg(SysOrg org) {
		this.org = org;
	}

	

	public String getRoleFlow() {
		return roleFlow;
	}

	public void setRoleFlow(String roleFlow) {
		this.roleFlow = roleFlow;
	}

	public SysUser getUser() {
		return user;
	}

	public void setUser(SysUser user) {
		this.user = user;
	}

	public SrmExpert getExpert() {
		return expert;
	}

	public void setExpert(SrmExpert expert) {
		this.expert = expert;
	}

	public MultipartFile getOrgFile() {
		return orgFile;
	}

	public void setOrgFile(MultipartFile orgFile) {
		this.orgFile = orgFile;
	}

	public MultipartFile getLicenseFile() {
		return licenseFile;
	}

	public void setLicenseFile(MultipartFile licenseFile) {
		this.licenseFile = licenseFile;
	}
	
	
	
	
}
