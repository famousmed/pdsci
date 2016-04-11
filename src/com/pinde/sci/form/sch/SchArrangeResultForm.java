package com.pinde.sci.form.sch;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SchArrangeDoctor;
import com.pinde.sci.model.mo.SchArrangeDoctorDept;
import com.pinde.sci.model.mo.SchArrangeResult;

public class SchArrangeResultForm implements Serializable{
	private static final long serialVersionUID = 8256273931760685022L;
	
	private SchArrangeDoctor arrDoc;
	private List<SchArrangeDoctorDept> arrDocDeptList;
	private List<SchArrangeResult> resultList;
	
	public SchArrangeDoctor getArrDoc() {
		return arrDoc;
	}
	public void setArrDoc(SchArrangeDoctor arrDoc) {
		this.arrDoc = arrDoc;
	}
	public List<SchArrangeResult> getResultList() {
		return resultList;
	}
	public void setResultList(List<SchArrangeResult> resultList) {
		this.resultList = resultList;
	}
	public List<SchArrangeDoctorDept> getArrDocDeptList() {
		return arrDocDeptList;
	}
	public void setArrDocDeptList(List<SchArrangeDoctorDept> arrDocDeptList) {
		this.arrDocDeptList = arrDocDeptList;
	}
	
}
