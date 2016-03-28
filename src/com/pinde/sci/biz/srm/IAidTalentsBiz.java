package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.AidTalents;
import com.pinde.sci.model.srm.AidTalentsExt;

public interface IAidTalentsBiz {
	/**
	 * �������޸�
	 * @param aidExt
	 * @return
	 *  @throws Exception
	 */
	int edit(AidTalentsExt aidExt);
	/**
	 * ��ѯ
	 * @param aid
	 * @param orgFlowList
	 * @return
	 */
	List<AidTalents> queryList(AidTalents aid,List<String> orgFlowList );
	/**
	 * ����������
	 * @param talentsFlow
	 * @return
	 * @throws Exception
	 */
	AidTalentsExt query(String talentsFlow);
	/**
	 * �������޸�
	 * @param aid
	 * @return
	 */
	int edit(AidTalents aid);
}
