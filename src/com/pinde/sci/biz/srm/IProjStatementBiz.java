package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysOrg;

public interface IProjStatementBiz {
	
	/**
	 * ���ҵ�ǰ�������������е�����Ŀ
	 * @param proj
	 * @param orgList 
	 * @return
	 */
	public List<PubProj> searchPuisneProj(PubProj proj);  

}
