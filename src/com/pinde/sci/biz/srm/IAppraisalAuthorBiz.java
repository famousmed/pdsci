package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchAppraisalAuthor;

public interface IAppraisalAuthorBiz {
	
	/**
	 * ɾ����������
	 * @param achAppraisalAuthor
	 */
	void editAppraisalAuthor(SrmAchAppraisalAuthor achAppraisalAuthor);
	
	/**
	 * ��ѯ����
	 * @param srmAchAppraisalAuthor
	 * @return
	 */
	List<SrmAchAppraisalAuthor> searchAuthorList(SrmAchAppraisalAuthor author);
}
