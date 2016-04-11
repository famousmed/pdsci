package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.SrmAchCopyrightAuthor;

public interface ICopyrightAuthorBiz {

	void editAuthor(SrmAchCopyrightAuthor copyrightAuthor);

	List<SrmAchCopyrightAuthor> searchAuthorList(SrmAchCopyrightAuthor author);
}
