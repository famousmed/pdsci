package com.pinde.sci.biz.res;

import java.util.List;

import com.pinde.sci.model.mo.ResExamSite;

public interface IResExamSiteBiz {

	/**
	 * ���濼��
	 * @param examSiteList
	 * @return
	 */
	int saveExamSiteList(List<ResExamSite> examSiteList);
	
	/**
	 * ����ExamSite
	 * @param examSite
	 * @return
	 */
	int saveExamSite(ResExamSite examSite);

	/**
	 * ��ѯ
	 * @param examSite
	 * @return
	 */
	List<ResExamSite> searchExamSiteList(ResExamSite examSite);
	
	/**
	 * ��ѯ���Կ���
	 * @param examFlow
	 * @param siteCode
	 * @return
	 */
	ResExamSite getExamSite(String examFlow, String siteCode);

	ResExamSite readExamSite(String siteFlow);
}
