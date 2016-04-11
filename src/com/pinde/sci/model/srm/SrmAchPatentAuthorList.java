package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchPatent;
import com.pinde.sci.model.mo.SrmAchPatentAuthor;

public class SrmAchPatentAuthorList implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4216701666871392930L;

	private List<SrmAchPatentAuthor> achPatentList;
    
	private SrmAchPatent patent;
	
	private SrmAchFile srmAchFile;
	
	public List<SrmAchPatentAuthor> getAchPatentList() {
		return achPatentList;
	}

	public void setAchPatentList(List<SrmAchPatentAuthor> achPatentList) {
		this.achPatentList = achPatentList;
	}

	public SrmAchPatent getPatent() {
		return patent;
	}

	public void setPatent(SrmAchPatent patent) {
		this.patent = patent;
	}

	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}

	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}
	
	
}
