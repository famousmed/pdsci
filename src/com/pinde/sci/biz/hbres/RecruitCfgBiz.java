package com.pinde.sci.biz.hbres;

import com.pinde.sci.model.mo.ResRecruitCfg;

/**
 * 招录配置业务接口
 * @author Administrator
 *
 */
public interface RecruitCfgBiz {
	
	/**
	 * 根据年份查询该年的招录配置
	 * @param year
	 * @return
	 */
	ResRecruitCfg findRecruitCfgByYear(String year);
	
	/**
	 * 保存招录设置
	 * @param recruitCfg
	 */
	void saveRecruitCfg(ResRecruitCfg recruitCfg);

}
