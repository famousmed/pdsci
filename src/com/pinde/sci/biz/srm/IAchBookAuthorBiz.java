package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchBookAuthor;

public interface IAchBookAuthorBiz {

	/**
	 * �޸�һ����������
	 * @param achBookAuthor
	 */
	void editBookAthor(SrmAchBookAuthor author);
	
	/**
	 * ��ѯ����
	 * @return
	 */
	List<SrmAchBookAuthor> searchAuthorList(SrmAchBookAuthor author);
}
