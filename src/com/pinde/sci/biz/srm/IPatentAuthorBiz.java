package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchPatentAuthor;

public interface IPatentAuthorBiz {   
    /**
     * �޸�ר��������Ϣ
     * @param achPatentAuthor
     * @return
     */
    public int editAuthor(SrmAchPatentAuthor author);
	
	/**
	 * ��ѯ����
	 * @param srmAchPatentAuthor
	 * @return
	 */
	List<SrmAchPatentAuthor> searchAuthorList(SrmAchPatentAuthor author);
}
