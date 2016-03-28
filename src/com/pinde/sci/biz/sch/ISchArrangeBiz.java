package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.model.mo.ResDoctor;
import com.pinde.sci.model.mo.SchArrange;


public interface ISchArrangeBiz {

	List<SchArrange> searchSchArrange(String orgFLow);

	void rostering(String beginDate);

	List<ResDoctor> searchCouldSchDoctor(String orgFLow);

	SchArrange readArrange(String arrangeFlow);

	void modifyArrange(SchArrange arrange);

	int saveArrange(SchArrange arrange);

	List<ResDoctor> searchUnSchDoctor(String orgFLow);

}
