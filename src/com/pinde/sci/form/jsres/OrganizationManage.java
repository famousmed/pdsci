package com.pinde.sci.form.jsres;

import java.io.Serializable;
import java.util.List;

public class OrganizationManage implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3745342978759755677L;
	private String info;
	private List<OrganizationPerson> organizationPersonList;
	
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public List<OrganizationPerson> getOrganizationPersonList() {
		return organizationPersonList;
	}
	public void setOrganizationPersonList(
			List<OrganizationPerson> organizationPersonList) {
		this.organizationPersonList = organizationPersonList;
	}
	
	
	
}
