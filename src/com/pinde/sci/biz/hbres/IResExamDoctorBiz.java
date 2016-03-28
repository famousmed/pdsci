package com.pinde.sci.biz.hbres;

import java.util.List;

import com.pinde.sci.model.mo.ResExamDoctor;


public interface IResExamDoctorBiz {

	ResExamDoctor readResExamDoctor(String recordFlow);

	List<ResExamDoctor> searchExamDoctorList(ResExamDoctor examDoctor);
	
}
