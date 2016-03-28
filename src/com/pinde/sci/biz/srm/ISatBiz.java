package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchSatAuthor;
import com.pinde.sci.model.mo.SysOrg;

public interface ISatBiz {
	
	/**���Ƽ���Ϣ
	 * @param achSat
	 * @return
	 */
	SrmAchSat readSat(String satFlow);
	
	/**
	 * ������޸ĿƼ���Ϣ������
	 * @param sat
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 */
	int save(SrmAchSat sat, List<SrmAchSatAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	int save(SrmAchSat sat);
	
	/**
	 * �޸�״̬
	 * @param sat
	 * @param process
	 * @return
	 */
	int updateSatStatus(SrmAchSat sat, SrmAchProcess process);
	
	/**
	 * 
	 * @param sat
	 * @param satFlowList
	 * @param childOrgList
	 * @return
	 */
	List<SrmAchSat> search(SrmAchSat sat, List<SysOrg> childOrgList);
	
	/**
	 * �޸ĿƼ�������
	 * @param sat
	 * @param authorList
	 * @return
	 */
	int edit(SrmAchSat sat, List<SrmAchSatAuthor> authorList, SrmAchFile file);

}
