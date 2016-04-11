package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchAppraisal;
import com.pinde.sci.model.mo.SrmAchAppraisalAuthor;
import com.pinde.sci.model.mo.SrmAchFile;

public class SrmAchAppraisalAuthorList implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2485562159544694652L;
	private List<SrmAchAppraisalAuthor> authorList;
	private SrmAchAppraisal appraisal;
	private SrmAchFile srmAchFile;
	
	public List<SrmAchAppraisalAuthor> getAuthorList() {
		return authorList;
	}
	public void setAuthorList(List<SrmAchAppraisalAuthor> authorList) {
		this.authorList = authorList;
	}
	public SrmAchAppraisal getAppraisal() {
		return appraisal;
	}
	public void setAppraisal(SrmAchAppraisal appraisal) {
		this.appraisal = appraisal;
	}
	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}

	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}

	
}
