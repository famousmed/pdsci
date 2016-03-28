package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchAppraisalAuthor;

public interface IAppraisalAuthorBiz {
	
	/**
	 * 删除鉴定作者
	 * @param achAppraisalAuthor
	 */
	void editAppraisalAuthor(SrmAchAppraisalAuthor achAppraisalAuthor);
	
	/**
	 * 查询作者
	 * @param srmAchAppraisalAuthor
	 * @return
	 */
	List<SrmAchAppraisalAuthor> searchAuthorList(SrmAchAppraisalAuthor author);
}
