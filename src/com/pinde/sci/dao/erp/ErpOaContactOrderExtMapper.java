package com.pinde.sci.dao.erp;

import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.ErpOaContactOrder;

public interface ErpOaContactOrderExtMapper {

	public List<ErpOaContactOrder> searchContactOrderList(Map<String,Object> paramMap);
	
	public int countContactOrderList(Map<String,Object> paramMap);
}
