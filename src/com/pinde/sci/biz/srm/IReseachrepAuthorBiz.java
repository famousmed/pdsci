package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchReseachrepAuthor;

public interface IReseachrepAuthorBiz {

    /**
     * ɾ��
     * @param author
     * @return
     */
    int editReseachrepAuthor(SrmAchReseachrepAuthor author);
	
	/**
	 * ��ѯ����
	 * @param author
	 * @return
	 */
	List<SrmAchReseachrepAuthor> searchAuthorList(SrmAchReseachrepAuthor author);
}
