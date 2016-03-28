package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.erp.ErpOaWorkOrderExt;
import com.pinde.sci.model.mo.ErpOaContactOrder;

public interface ErpOaWorkOrderExtMapper {

	List<ErpOaWorkOrderExt> searchWorkOrderList(Map<String,Object> paramMap);
	
	List<ErpOaWorkOrderExt> applyWorkOrderList(Map<String,Object> paramMap);
	
	public int countWorkOrderList(Map<String,Object> paramMap);
}
