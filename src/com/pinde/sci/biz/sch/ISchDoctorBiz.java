package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.form.sch.DoctorSearchForm;
import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.res.ResDoctorExt;


public interface ISchDoctorBiz {
	
	List<ResDoctor> searchResDoctor(String orgFlow);
	
	ResDoctor readResDoctor(String doctorFlow);
	
	int saveResDoctor(ResDoctor doctor);

	List<ResDoctor> searchResDoctor(String orgFlow,
			DoctorSearchForm doctorSearchForm);

	List<ResDoctor> searchTerminatResDoctor(String orgFlow,
			DoctorSearchForm doctorSearchForm);

	List<ResDoctor> searchNotTerminatResDoctor(String orgFlow);

	List<ResDoctor> searchResDoctorByFlows(String orgFlow,
			List<String> doctorFlowList);

	List<ResDoctor> searchResDoctorAll(String orgFlow,
			DoctorSearchForm doctorSearchForm);
	
    List<ResDoctorExt> searchResDoctor(ResDoctorExt doctor);
}
