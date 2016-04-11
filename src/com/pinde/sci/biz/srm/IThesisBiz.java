package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchAppraisal;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchThesis;
import com.pinde.sci.model.mo.SrmAchThesisAuthor;
import com.pinde.sci.model.mo.SysOrg;

public interface IThesisBiz 
{
	/**
	 * ����
	 * @param achThesis
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 * @return
	 */
    int save(SrmAchThesis thesis,List<SrmAchThesisAuthor> authorList, SrmAchFile file, SrmAchProcess process);
    int save(SrmAchThesis thesis);
	
	/**
	 * �����б�
	 * @param achThesis
	 * @param childOrgList  ����б�ҳ������ӻ���
	 * @return
	 */
	List<SrmAchThesis> search(SrmAchThesis achThesis, List<SysOrg> childOrgList);
	
	/**
	 * ��ѯһ������
	 * @param thesisFlow
	 * @return
	 */
	SrmAchThesis readThesis(String thesisFlow);	
	
	/**
	 * �޸�����״̬
	 * @return
	 */
    void updateThesisStatus(SrmAchThesis thesis,SrmAchProcess process);
    
    /**
     * ���ļ�����
     * @param existThesis
     * @param authorList
     * @return
     */
	int edit(SrmAchThesis thesis, List<SrmAchThesisAuthor> authorList, SrmAchFile file);
}
