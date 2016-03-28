package com.pinde.sci.model.pub;

import com.pinde.sci.model.mo.PubPatientRecipe;

public class PubPatientRecipeExt extends PubPatientRecipe{
	private static final long serialVersionUID = -6799437852592056195L;
	
	private String patientName;
	private String sexName;
	private String patientAge;
	private String projName;
	private String applyDeptName;
	
	public String getSexName() {
		return sexName;
	}
	public void setSexName(String sexName) {
		this.sexName = sexName;
	}
	public String getPatientAge() {
		return patientAge;
	}
	public void setPatientAge(String patientAge) {
		this.patientAge = patientAge;
	}
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public String getProjName() {
		return projName;
	}
	public void setProjName(String projName) {
		this.projName = projName;
	}
	public String getApplyDeptName() {
		return applyDeptName;
	}
	public void setApplyDeptName(String applyDeptName) {
		this.applyDeptName = applyDeptName;
	}
	
}
