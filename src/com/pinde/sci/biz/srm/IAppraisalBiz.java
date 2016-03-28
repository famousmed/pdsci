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
	 * ҳ����ؼ�����Ϣ
	 * @param achAppraisal
	 * @param childOrgList ����б�ҳ������ӻ�����Ϣ
	 * @return
	 */
	List<SrmAchAppraisal> search(SrmAchAppraisal appraisal, List<SysOrg> childOrgList);
	
	/**
	 * ��ʾ����
	 * @param achAppraisalFlow
	 * @return
	 */
	SrmAchAppraisal readAppraisal(String appraisalFlow);
	
	/**
	 * ����
	 * @param appraisal
	 * @param authorList
	 * @param file
	 * @param process
	 */
	void save(SrmAchAppraisal appraisal,List<SrmAchAppraisalAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	
	/**
	 * �޸ļ���������
	 * @param appraisal
	 * @param authorList
	 * @return
	 */
	int edit(SrmAchAppraisal appraisal, List<SrmAchAppraisalAuthor> authorList, SrmAchFile file);
}
