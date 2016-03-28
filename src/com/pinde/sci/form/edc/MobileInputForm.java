package com.pinde.sci.form.edc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.pinde.sci.model.edc.InputData;
import com.pinde.sci.model.mo.EdcVisit;

public class MobileInputForm implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5838532345574530785L;
	private String projFlow;
	private String visitFlow;
	private String moduleCode;
	private String patientFlow;
	List<InputData> datas;
	public String getProjFlow() {
		return projFlow;
	}
	public void setProjFlow(String projFlow) {
		this.projFlow = projFlow;
	}
	public String getVisitFlow() {
		return visitFlow;
	}
	public List<InputData> getDatas() {
		return datas;
	}
	public void setDatas(List<InputData> datas) {
		this.datas = datas;
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
	public String getPatientFlow() {
		return patientFlow;
	}
	public void setPatientFlow(String patientFlow) {
		this.patientFlow = patientFlow;
	}
}
