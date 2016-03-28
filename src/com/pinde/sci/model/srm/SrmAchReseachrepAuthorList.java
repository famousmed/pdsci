package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchReseachrep;
import com.pinde.sci.model.mo.SrmAchReseachrepAuthor;

public class SrmAchReseachrepAuthorList implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4518795855948404431L;
	private List<SrmAchReseachrepAuthor> authorList;
	private SrmAchReseachrep reseachrep;
	private SrmAchFile srmAchFile;
	public List<SrmAchReseachrepAuthor> getAuthorList() {
		return authorList;
	}
	public void setAuthorList(List<SrmAchReseachrepAuthor> authorList) {
		this.authorList = authorList;
	}
	public SrmAchReseachrep getReseachrep() {
		return reseachrep;
	}
	public void setReseachrep(SrmAchReseachrep reseachrep) {
		this.reseachrep = reseachrep;
	}
	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}
	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}
	
}
