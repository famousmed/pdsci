package com.pinde.sci.biz.jsres;

import java.util.List;

import com.pinde.sci.model.mo.ResOrgSpe;

public interface IResOrgSpeBiz {
	/**
	 * ��ѯ
	 * @param resOrgSpe
	 * @param trainCategoryType
	 * @return
	 */
	List<ResOrgSpe> searchResOrgSpeList(ResOrgSpe resOrgSpe,String trainCategoryType);
	
	/**
	 * �������רҵ
	 * @param resBaseSpe
	 * @return
	 */
	int saveResOrgSpe(ResOrgSpe resOrgSpe);
	
	
}
