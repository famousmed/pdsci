package com.pinde.sci.biz.hbres;

import com.pinde.sci.model.mo.ResRecruitCfg;

/**
 * ��¼����ҵ��ӿ�
 * @author Administrator
 *
 */
public interface RecruitCfgBiz {
	
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
