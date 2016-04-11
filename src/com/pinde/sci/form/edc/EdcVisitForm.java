package com.pinde.sci.form.edc;

import java.io.Serializable;

public class EdcVisitForm implements Serializable{
	
	private static final long serialVersionUID = -6680550538704597538L;
	
	private String visitFlow ;
	private String moduleCode ;
	private String projFlow ;
	private String visitName ;
	private String projNo ;
	private String projName ;
	private String projShortName ;
	
	public String getVisitFlow() {
		return visitFlow;
	}
	public void setVisitFlow(String visitFlow) {
		this.visitFlow = visitFlow;
	}
	public String getModuleCode() {
		return moduleCode;
	}
	public void setModuleCode(String moduleCode) {
		this.moduleCode = moduleCode;
	}
	public String getProjFlow() {
		return projFlow;
	}
	public void setProjFlow(String projFlow) {
		this.projFlow = projFlow;
	}
	public String getVisitName() {
		return visitName;
	}
	public void setVisitName(String visitName) {
		this.visitName = visitName;
	}
	public String getProjNo() {
		return projNo;
	}
	public void setProjNo(String projNo) {
		this.projNo = projNo;
	}
	public String getProjName() {
		return projName;
	}
	public void setProjName(String projName) {
		this.projName = projName;
	}
	public String getProjShortName() {
		return projShortName;
	}
	public void setProjShortName(String projShortName) {
		this.projShortName = projShortName;
	}
}
