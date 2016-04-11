package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.model.mo.SchArrangeDoctorDept;



public interface ISchArrangeDoctorDeptBiz {
	List<SchArrangeDoctorDept> searchSchArrangeDoctorDept();
	
	SchArrangeDoctorDept readySchArrangeDoctorDept(String arrDocDeptFlow);
	
	int saveSchArrangeDoctorDept(SchArrangeDoctorDept arrangeDoctorDept);
}
