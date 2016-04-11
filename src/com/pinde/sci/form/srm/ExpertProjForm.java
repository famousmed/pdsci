package com.pinde.sci.form.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmExpertProj;

public class ExpertProjForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8330395943180972191L;

	private String  evalOpinion;
	
	private List<SrmExpertProj> srmExpertProjList;


	public List<SrmExpertProj> getSrmExpertProjList() {
		return srmExpertProjList;
	}

	public void setSrmExpertProjList(List<SrmExpertProj> srmExpertProjList) {
		this.srmExpertProjList = srmExpertProjList;
	}

	public String getEvalOpinion() {
		return evalOpinion;
	}

	public void setEvalOpinion(String evalOpinion) {
		this.evalOpinion = evalOpinion;
	}
	
	
	
}
