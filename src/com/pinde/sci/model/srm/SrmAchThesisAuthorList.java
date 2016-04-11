package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchThesis;
import com.pinde.sci.model.mo.SrmAchThesisAuthor;

public class SrmAchThesisAuthorList implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4915304753740456768L;

	private List<SrmAchThesisAuthor> authorList;
    
	private SrmAchThesis thesis;
	
	private SrmAchFile srmAchFile;
	
	public List<SrmAchThesisAuthor> getAuthorList() {
		return authorList;
	}

	public void setAuthorList(List<SrmAchThesisAuthor> authorList) {
		this.authorList = authorList;
	}

	public SrmAchThesis getThesis() {
		return thesis;
	}

	public void setThesis(SrmAchThesis thesis) {
		this.thesis = thesis;
	}

	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}

	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}

	
	
   
}
