package com.pinde.sci.dao.srm;

import java.util.HashMap;
import java.util.List;

import com.pinde.sci.model.srm.SrmAchCountExt;

public interface SrmAchCountExtMapper {
  
	public List<SrmAchCountExt> selectSrmAch(HashMap<String,String> map);
}
