package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchSatAuthor;

public interface IAchSatAuthorBiz {
	
	/**
	 * ɾ��һ�Ƽ�����
	 * @param achSatAuthor
	 */
	int editSatAuthor(SrmAchSatAuthor achSatAuthor);
	
	/**
	 * ��ѯ����
	 * @param author
	 * @return
	 */
	List<SrmAchSatAuthor> searchAuthorList(SrmAchSatAuthor author);
}
