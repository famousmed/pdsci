package com.pinde.sci.dao.gcp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.gcp.GcpDrugExt;

public interface GcpDrugExtMapper {

	public List<GcpDrugExt> searchGcpDrugList(Map<String,Object> paramMap);

	public List<String> searchDrugPacks(Map<String, Object> map);

}
