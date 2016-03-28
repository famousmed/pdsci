package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchCopyright;
import com.pinde.sci.model.mo.SrmAchCopyrightAuthor;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;


public interface ICopyrightBiz{
	/**
	 * �����б� 
	 * @param copyright
	 * @param childOrgList ��ѯ�ӻ���
	 * @return
	 */
	List<SrmAchCopyright> search(SrmAchCopyright copyright, List<SysOrg> childOrgList);
	
	/**
	 * ������ˮ�Ų�ѯ����Ȩ
	 * @param copyrightFlow
	 * @return
	 */
	SrmAchCopyright readCopyright(String copyrightFlow);
	
	/**
	 * ��������Ȩ�����ߡ�����������
	 * @param copyright
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 */
	void save(SrmAchCopyright copyright, List<SrmAchCopyrightAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	
	/**
	 * �޸�����Ȩ������
	 * @param copyright
	 */
	int edit(SrmAchCopyright copyright, List<SrmAchCopyrightAuthor> authorList, SrmAchFile file);
	
	/**
	 * �޸�����Ȩ״̬
	 * @param copyright
	 * @param process
	 */
	void updateCopyrightStatus(SrmAchCopyright copyright, SrmAchProcess process);
}
