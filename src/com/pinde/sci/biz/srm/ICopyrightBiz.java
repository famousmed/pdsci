package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchCopyright;
import com.pinde.sci.model.mo.SrmAchCopyrightAuthor;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;


public interface ICopyrightBiz{
	/**
	 * 加载列表 
	 * @param copyright
	 * @param childOrgList 查询子机构
	 * @return
	 */
	List<SrmAchCopyright> search(SrmAchCopyright copyright, List<SysOrg> childOrgList);
	
	/**
	 * 根据流水号查询著作权
	 * @param copyrightFlow
	 * @return
	 */
	SrmAchCopyright readCopyright(String copyrightFlow);
	
	/**
	 * 保存著作权、作者、附件、流程
	 * @param copyright
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 */
	void save(SrmAchCopyright copyright, List<SrmAchCopyrightAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	
	/**
	 * 修改著作权及作者
	 * @param copyright
	 */
	int edit(SrmAchCopyright copyright, List<SrmAchCopyrightAuthor> authorList, SrmAchFile file);
	
	/**
	 * 修改著作权状态
	 * @param copyright
	 * @param process
	 */
	void updateCopyrightStatus(SrmAchCopyright copyright, SrmAchProcess process);
}
