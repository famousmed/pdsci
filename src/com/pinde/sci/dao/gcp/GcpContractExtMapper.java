package com.pinde.sci.dao.gcp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.gcp.GcpContractExt;

public interface GcpContractExtMapper {

	public List<GcpContractExt> searchContractList(Map<String,Object> paramMap);
	
	
}
