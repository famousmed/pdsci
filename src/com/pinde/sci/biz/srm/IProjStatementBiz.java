package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SysOrg;

public interface IProjStatementBiz {
	
	/**
	 * 查找当前机构下属机构承担的项目
	 * @param proj
	 * @param orgList 
	 * @return
	 */
	public List<PubProj> searchPuisneProj(PubProj proj);  

}
