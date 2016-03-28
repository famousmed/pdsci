package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchReseachrep;
import com.pinde.sci.model.mo.SrmAchReseachrepAuthor;
import com.pinde.sci.model.mo.SysOrg;

public interface IReseachrepBiz {
    /**
     * �����о�����
     * @param reseachrep
     * @param authorList
     * @param srmAchFile
     * @param srmAchProcess
     * @return
     */
    int save(SrmAchReseachrep reseachrep, List<SrmAchReseachrepAuthor> authorList, SrmAchFile file, SrmAchProcess process);

    /**
     * ��ȡ�о������б�
     * @param reseachrep
     * @param reseachrepFlowList
     * @param childOrgList
     * @return
     */
	List<SrmAchReseachrep> search(SrmAchReseachrep reseachrep, List<SysOrg> childOrgList);
	/**
	 * ��ȡ�о�����
	 * @param reseachrepFlow
	 * @return
	 */
	SrmAchReseachrep readReseachrep(String reseachrepFlow);
	
	/**
	 * �޸��о����漰����
	 * @param reseachrep
	 * @return
	 */
	int edit(SrmAchReseachrep reseachrep, List<SrmAchReseachrepAuthor> authorList, SrmAchFile file);
	
    /**
     * ����״̬
     * @param reseachrep
     * @param process
     * @return
     */
    int updateReseachrepStatus(SrmAchReseachrep reseachrep,SrmAchProcess process);
 
}
