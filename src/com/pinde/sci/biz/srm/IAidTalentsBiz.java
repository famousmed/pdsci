package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.srm.AidTalentsExt;

public interface IAidTalentsBiz {
	/**
	 * 新增或修改
	 * @param aidExt
	 * @return
	 *  @throws Exception
	 */
	int edit(AidTalentsExt aidExt);
	/**
	 * 查询
	 * @param aid
	 * @param orgFlowList
	 * @return
	 */
	List<AidTalents> queryList(AidTalents aid,List<String> orgFlowList );
	/**
	 * 按主键查找
	 * @param talentsFlow
	 * @return
	 * @throws Exception
	 */
	AidTalentsExt query(String talentsFlow);
	/**
	 * 新增或修改
	 * @param aid
	 * @return
	 */
	int edit(AidTalents aid);
}
