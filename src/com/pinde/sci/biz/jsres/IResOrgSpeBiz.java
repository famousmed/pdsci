package com.pinde.sci.biz.jsres;

import java.util.List;

import com.pinde.sci.model.mo.ResOrgSpe;

public interface IResOrgSpeBiz {
	/**
	 * 查询
	 * @param resOrgSpe
	 * @param trainCategoryType
	 * @return
	 */
	List<ResOrgSpe> searchResOrgSpeList(ResOrgSpe resOrgSpe,String trainCategoryType);
	
	/**
	 * 保存基地专业
	 * @param resBaseSpe
	 * @return
	 */
	int saveResOrgSpe(ResOrgSpe resOrgSpe);
	
	
}
