package com.pinde.sci.model.res;

import com.pinde.sci.model.mo.ResDoctorSchProcess;
import com.pinde.sci.model.mo.ResRec;

public class ResRecExt extends ResRec {

	private static final long serialVersionUID = 5283259991088005661L;
	
	private ResDoctorExt doctorExt;
	private ResDoctorSchProcess process;
	public ResDoctorSchProcess getProcess() {
		return process;
	}
	public void setProcess(ResDoctorSchProcess process) {
		this.process = process;
	}
	public ResDoctorExt getDoctorExt() {
		return doctorExt;
	}
	public void setDoctorExt(ResDoctorExt doctorExt) {
		this.doctorExt = doctorExt;
	}

}
