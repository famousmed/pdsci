package com.pinde.sci.dao.jsres;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.jsres.ResBaseExt;


public interface ResBaseExtMapper {
	 List<ResBaseExt> searchResBaseExtList(Map<String, Object> paramMap);
}
