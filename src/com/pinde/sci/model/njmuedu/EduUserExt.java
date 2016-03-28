package com.pinde.sci.model.njmuedu;

import java.util.List;

import com.pinde.sci.model.mo.EduCourse;
import com.pinde.sci.model.mo.EduUser;
import com.pinde.sci.model.mo.SysOrg;
import com.pinde.sci.model.mo.SysRole;
import com.pinde.sci.model.mo.SysUser;

public class EduUserExt extends EduUser {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3640853290854658719L;
	private SysUser sysUser;
	private SysOrg sysOrg;
	private SysRole sysRole;
	private List<EduCourse> courseList;
	
	public SysOrg getSysOrg() {
		return sysOrg;
	}
	public void setSysOrg(SysOrg sysOrg) {
		this.sysOrg = sysOrg;
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
	public List<EduCourse> getCourseList() {
		return courseList;
	}
	public void setCourseList(List<EduCourse> courseList) {
		this.courseList = courseList;
	}
	
}
