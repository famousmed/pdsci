package com.pinde.sci.biz.cnres;

import java.util.List;

import com.pinde.sci.model.mo.ResExamDoctor;


public interface ICnResExamDoctorBiz {

	ResExamDoctor readResExamDoctor(String recordFlow);

	List<ResExamDoctor> searchExamDoctorList(ResExamDoctor examDoctor);
	
}
