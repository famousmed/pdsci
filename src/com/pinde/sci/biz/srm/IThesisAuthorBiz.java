package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchThesisAuthor;

public interface IThesisAuthorBiz {

	/**
	 * �޸ġ�ɾ������
	 * @param author
	 * @return
	 */
    int editAuthor(SrmAchThesisAuthor author);

	
	/**
	 * ��ѯ����
	 * @param author
	 * @return
	 */
	List<SrmAchThesisAuthor> searchAuthorList(SrmAchThesisAuthor author);


}
