package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchBook;
import com.pinde.sci.model.mo.SrmAchBookAuthor;
import com.pinde.sci.model.mo.SrmAchFile;

public class SrmAchBookAuthorList implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2618977822625938959L;
	private List<SrmAchBookAuthor> authorList;
	private SrmAchBook book;
	private SrmAchFile srmAchFile;
	
	public List<SrmAchBookAuthor> getAuthorList() {
		return authorList;
	}
	public void setAuthorList(List<SrmAchBookAuthor> authorList) {
		this.authorList = authorList;
	}
	public SrmAchBook getBook() {
		return book;
	}
	public void setBook(SrmAchBook book) {
		this.book = book;
	}
	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}

	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}

}
