package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResExamSite;

public interface IResExamSiteBiz {

	/**
	 * 保存考点
	 * @param examSiteList
	 * @return
	 */
	int saveExamSiteList(List<ResExamSite> examSiteList);
	
	/**
	 * 保存ExamSite
	 * @param examSite
	 * @return
	 */
	int saveExamSite(ResExamSite examSite);

	/**
	 * 查询
	 * @param examSite
	 * @return
	 */
	List<ResExamSite> searchExamSiteList(ResExamSite examSite);
	
	/**
	 * 查询考试考点
	 * @param examFlow
	 * @param siteCode
	 * @return
	 */
	ResExamSite getExamSite(String examFlow, String siteCode);

	ResExamSite readExamSite(String siteFlow);
}
