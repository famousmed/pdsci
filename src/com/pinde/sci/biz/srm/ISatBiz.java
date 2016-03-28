package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchSatAuthor;
import com.pinde.sci.model.mo.SysOrg;

public interface ISatBiz {
	
	/**读科技信息
	 * @param achSat
	 * @return
	 */
	SrmAchSat readSat(String satFlow);
	
	/**
	 * 保存和修改科技信息及作者
	 * @param sat
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 */
	int save(SrmAchSat sat, List<SrmAchSatAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	int save(SrmAchSat sat);
	
	/**
	 * 修改状态
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
	 * 修改科技及作者
	 * @param sat
	 * @param authorList
	 * @return
	 */
	int edit(SrmAchSat sat, List<SrmAchSatAuthor> authorList, SrmAchFile file);

}
