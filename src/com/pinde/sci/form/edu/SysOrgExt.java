package com.pinde.sci.form.edu;

import java.util.List;

import com.pinde.sci.model.mo.SysOrg;

public class SysOrgExt extends SysOrg{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8032164434943496229L;
	private List<MajorForm> majorFormList;

	public List<MajorForm> getMajorFormList() {
		return majorFormList;
	}

	public void setMajorFormList(List<MajorForm> majorFormList) {
		this.majorFormList = majorFormList;
	}
	
	
}
