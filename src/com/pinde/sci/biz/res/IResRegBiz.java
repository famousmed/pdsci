package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResReg;

public interface IResRegBiz {

	List<ResReg> searchResReg();

	ResReg searchResReg(String userFlow, String regYear);

	int editResReg(ResReg reg);
	
	/**
	 * ��ѯѧԱ���µ�ע���¼
	 * @param userFlow
	 * @return
	 */
	ResReg searchRecentYearResReg(String userFlow);
	
}
