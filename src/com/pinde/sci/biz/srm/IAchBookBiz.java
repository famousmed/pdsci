package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchBook;
import com.pinde.sci.model.mo.SrmAchBookAuthor;
import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchProcess;
import com.pinde.sci.model.mo.SysOrg;

public interface IAchBookBiz {
	/**
	 * ����bookFlow��ʾ����
	 * @param bookFlow
	 * @return
	 */
	public SrmAchBook readBook(String bookFlow);

	/**
	 * ����
	 * @param book
	 * @param bookFlowList
	 * @param childOrgList ��˼����ӻ���
	 * @return
	 */
	public List<SrmAchBook> search(SrmAchBook book, List<SysOrg> childOrgList);
	
	/**
	 * ����
	 * @param book
	 * @param authorList
	 * @param srmAchFile
	 * @param srmAchProcess
	 */
	public void save(SrmAchBook book, List<SrmAchBookAuthor> authorList, SrmAchFile file, SrmAchProcess process);
	public int save(SrmAchBook book);
    
	/**
	 * �޸�״̬
	 * @param book
	 * @param process
	 */
	public void updateBookStatus(SrmAchBook book,SrmAchProcess process);
	
	/**
	 * �޸�����������
	 * @param book
	 * @param authorList
	 * @return
	 */
	int edit(SrmAchBook book, List<SrmAchBookAuthor> authorList, SrmAchFile file);
}
