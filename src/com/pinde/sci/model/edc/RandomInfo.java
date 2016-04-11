package com.pinde.sci.model.edc;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.EdcRandomRec;
import com.pinde.sci.model.mo.GcpDrugStoreRec;
import com.pinde.sci.model.mo.PubPatient;

public class RandomInfo implements Serializable{
	
	private static final long serialVersionUID = 42764623994519652L;
	
	private PubPatient patient; 
	private EdcRandomRec randomRec ;
	private List<GcpDrugStoreRec> drugRecList ;
	public PubPatient getPatient() {
		return patient;
	}
	public void setPatient(PubPatient patient) {
		this.patient = patient;
	}
	public EdcRandomRec getRandomRec() {
		return randomRec;
	}
	public void setRandomRec(EdcRandomRec randomRec) {
		this.randomRec = randomRec;
	}
	public List<GcpDrugStoreRec> getDrugRecList() {
		return drugRecList;
	}
	public void setDrugRecList(List<GcpDrugStoreRec> drugRecList) {
		this.drugRecList = drugRecList;
	}
}
