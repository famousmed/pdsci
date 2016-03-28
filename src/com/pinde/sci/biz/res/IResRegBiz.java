package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResReg;

public interface IResRegBiz {

	List<ResReg> searchResReg();

	ResReg searchResReg(String userFlow, String regYear);

	int editResReg(ResReg reg);
	
	/**
	 * 查询学员最新的注册记录
	 * @param userFlow
	 * @return
	 */
	ResReg searchRecentYearResReg(String userFlow);
	
}
