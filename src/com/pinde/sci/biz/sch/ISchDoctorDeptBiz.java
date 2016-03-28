package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.model.mo.SchDoctorDept;


public interface ISchDoctorDeptBiz {
	List<SchDoctorDept> searchSchDoctorDept();
	
	List<SchDoctorDept> searchSchDoctorDept(String doctorFlow);
	
	SchDoctorDept readSchDoctorDept(String recordFlow);
	
	int saveSchDoctorDept(SchDoctorDept doctorDept);
	
	int save(SchDoctorDept doctorDept);

	int update(SchDoctorDept doctorDept);

	List<SchDoctorDept> searchDoctorDeptByDoctorFlows(List<String> doctorFlows);

	int editDoctorDept(SchDoctorDept doctorDept);

	SchDoctorDept readSchDoctorDeptByObj(String doctorFlow, String schDeptFlow,
			String groupFlow, String standardDeptId);

	int countRotationUse(String rotationFlow);
}
