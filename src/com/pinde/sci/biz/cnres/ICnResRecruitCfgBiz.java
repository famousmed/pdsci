package com.pinde.sci.biz.cnres;

import com.pinde.sci.model.mo.ResRecruitCfg;

/**
 * ��¼����ҵ��ӿ�
 * @author Administrator
 *
 */
public interface ICnResRecruitCfgBiz {
	
	/**
	 * ������ݲ�ѯ�������¼����
	 * @param year
	 * @return
	 */
	ResRecruitCfg findRecruitCfgByYear(String year);
	
	/**
	 * ������¼����
	 * @param recruitCfg
	 */
	void saveRecruitCfg(ResRecruitCfg recruitCfg);

}
