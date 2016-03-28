package com.pinde.sci.dao.gcp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.gcp.GcpDrugInExt;
import com.pinde.sci.model.mo.GcpDrugIn;

public interface GcpDrugInExtMapper {
    
	public List<GcpDrugInExt> searchDrugInList(Map<String,Object> paramMap);
	
	public List<GcpDrugIn> searchDrugIns(Map<String,Object> paramMap);
}
