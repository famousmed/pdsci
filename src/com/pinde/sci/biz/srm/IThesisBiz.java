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
	 * 保存
	 * @param achThesis
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 * @return
	 */
    int save(SrmAchThesis thesis,List<SrmAchThesisAuthor> authorList, SrmAchFile file, SrmAchProcess process);
    int save(SrmAchThesis thesis);
	
	/**
	 * 加载列表
	 * @param achThesis
	 * @param childOrgList  审核列表页面加载子机构
	 * @return
	 */
	List<SrmAchThesis> search(SrmAchThesis achThesis, List<SysOrg> childOrgList);
	
	/**
	 * 查询一条论文
	 * @param thesisFlow
	 * @return
	 */
	SrmAchThesis readThesis(String thesisFlow);	
	
	/**
	 * 修改论文状态
	 * @return
	 */
    void updateThesisStatus(SrmAchThesis thesis,SrmAchProcess process);
    
    /**
     * 论文及作者
     * @param existThesis
     * @param authorList
     * @return
     */
	int edit(SrmAchThesis thesis, List<SrmAchThesisAuthor> authorList, SrmAchFile file);
}
