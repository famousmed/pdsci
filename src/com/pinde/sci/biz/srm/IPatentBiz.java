package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmAchPatentAuthor;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;

public interface IPatentBiz 
{
	/**
	 * �������޸�ר��   ��ʱר����¼״̬ΪY
	 * @param srmA ר��ʵ�������
	 * @return 
	 */
    public void save(SrmAchPatent patent, List<SrmAchPatentAuthor> authorList, SrmAchFile file, SrmAchProcess process);
    public int save(SrmAchPatent patent);
    
    /**
     * ���ݸ���������ѯר����¼״̬ΪY�ļ�¼
     * @param srmAchPatent ר��ʵ�����
     * @return
     */
    public List<SrmAchPatent> search(SrmAchPatent patent, List<SysOrg> childOrgList);
    
    /**
     * ����ר��ID��ȡ����ר������ϸ��Ϣ
     * @param srmAchPatent  ר��ʵ�����
     * @return
     */
    public SrmAchPatent readPatent(String patentFlow);
    
    /**
     * �޸�ר��������
     * @param srmAchPatent
     * @return
     */
    int edit(SrmAchPatent patent, List<SrmAchPatentAuthor> authorList, SrmAchFile file);
   

    /**
     * �޸�ר���Ĳ���״̬
     * @param thesis
     * @param process
     * @return
     */
    public void updatePatentStatus(SrmAchPatent patent,SrmAchProcess process);
	
    

}
