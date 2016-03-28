package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchAppraisal;
import com.pinde.sci.model.mo.SrmAchAppraisalAuthor;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;

public interface IAppraisalBiz {

	
	void updateAppraisalStatus(SrmAchAppraisal appraisal,SrmAchProcess process);

	/**
	 * 页面加载鉴定信息
	 * @param achAppraisal
	 * @param childOrgList 审核列表页面加载子机构信息
	 * @return
	 */
	List<SrmAchAppraisal> search(SrmAchAppraisal appraisal, List<SysOrg> childOrgList);
	
	/**
	 * 显示数据
	 * @param achAppraisalFlow
	 * @return
	 */
	SrmAchAppraisal readAppraisal(String appraisalFlow);
	
	/**
	 * 保存
	 * @param appraisal
	 * @param authorList
	 * @param file
	 * @param process
	 */
	void save(SrmAchAppraisal appraisal,List<SrmAchAppraisalAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	
	/**
	 * 修改鉴定及作者
	 * @param appraisal
	 * @param authorList
	 * @return
	 */
	int edit(SrmAchAppraisal appraisal, List<SrmAchAppraisalAuthor> authorList, SrmAchFile file);
}
