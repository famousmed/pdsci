package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchCopyright;
import com.pinde.sci.model.mo.SrmAchCopyrightAuthor;
import com.pinde.sci.model.mo.SrmAchFile;

public class SrmAchCopyrightAuthorList implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6517270464749974032L;
	private List<SrmAchCopyrightAuthor> authorList;
	private SrmAchCopyright copyright;
	private SrmAchFile srmAchFile;
	
	public List<SrmAchCopyrightAuthor> getAuthorList() {
		return authorList;
	}
	public void setAuthorList(List<SrmAchCopyrightAuthor> authorList) {
		this.authorList = authorList;
	}
	public SrmAchCopyright getCopyright() {
		return copyright;
	}
	public void setCopyright(SrmAchCopyright copyright) {
		this.copyright = copyright;
	}
	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}
	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}
	
	
}
