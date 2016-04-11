package com.pinde.sci.biz.sch;

import java.util.List;

import com.pinde.sci.model.mo.SchDeptExternalRel;



public interface ISchDeptExternalRelBiz {
	int editSchDeptExtRel(SchDeptExternalRel schDeptExtRel);
	
	SchDeptExternalRel readSchDeptExtRel(String recordFlow);
	
	SchDeptExternalRel readSchDeptExtRelBySchDept(String schDeptFlow);
	
	List<SchDeptExternalRel> searchSchDeptExtRel();

	List<SchDeptExternalRel> searchSchDeptExtRel(String orgFlow);

	int delSchDeptRel(String schDeptFlow);
}
