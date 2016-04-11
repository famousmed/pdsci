package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.model.mo.SchArrangeDoctor;


public interface ISchArrangeDoctorBiz {
	List<SchArrangeDoctor> searchSchArrangeDoctor();
	
	SchArrangeDoctor readSchArrangeDoctor(String arrDocFlow);
	
	int saveSchArrangeDoctor(SchArrangeDoctor arrangeDoctor);
}
