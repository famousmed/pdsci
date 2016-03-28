package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchPatentAuthor;

public interface IPatentAuthorBiz {   
    /**
     * 修改专利作者信息
     * @param achPatentAuthor
     * @return
     */
    public int editAuthor(SrmAchPatentAuthor author);
	
	/**
	 * 查询作者
	 * @param srmAchPatentAuthor
	 * @return
	 */
	List<SrmAchPatentAuthor> searchAuthorList(SrmAchPatentAuthor author);
}
