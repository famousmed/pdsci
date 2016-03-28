package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchReseachrepAuthor;

public interface IReseachrepAuthorBiz {

    /**
     * É¾³ý
     * @param author
     * @return
     */
    int editReseachrepAuthor(SrmAchReseachrepAuthor author);
	
	/**
	 * ²éÑ¯×÷Õß
	 * @param author
	 * @return
	 */
	List<SrmAchReseachrepAuthor> searchAuthorList(SrmAchReseachrepAuthor author);
}
