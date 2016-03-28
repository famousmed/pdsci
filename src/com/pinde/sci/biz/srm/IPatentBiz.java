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
	 * 保存与修改专利   此时专利记录状态为Y
	 * @param srmA 专利实体类对象
	 * @return 
	 */
    public void save(SrmAchPatent patent, List<SrmAchPatentAuthor> authorList, SrmAchFile file, SrmAchProcess process);
    public int save(SrmAchPatent patent);
    
    /**
     * 根据各种条件查询专利记录状态为Y的记录
     * @param srmAchPatent 专利实体对象
     * @return
     */
    public List<SrmAchPatent> search(SrmAchPatent patent, List<SysOrg> childOrgList);
    
    /**
     * 根据专利ID获取该条专利的详细信息
     * @param srmAchPatent  专利实体对象
     * @return
     */
    public SrmAchPatent readPatent(String patentFlow);
    
    /**
     * 修改专利及作者
     * @param srmAchPatent
     * @return
     */
    int edit(SrmAchPatent patent, List<SrmAchPatentAuthor> authorList, SrmAchFile file);
   

    /**
     * 修改专利的操作状态
     * @param thesis
     * @param process
     * @return
     */
    public void updatePatentStatus(SrmAchPatent patent,SrmAchProcess process);
	
    

}
