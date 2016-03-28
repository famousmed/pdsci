package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmAchFile;
import com.pinde.sci.model.mo.SrmAchSat;
import com.pinde.sci.model.mo.SrmAchSatAuthor;

public class SrmAchSatAuthorList implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2667680495276364004L;
	private List<SrmAchSatAuthor> authorList;
	private SrmAchSat sat;
	private SrmAchFile srmAchFile;
	
	
	public List<SrmAchSatAuthor> getAuthorList() {
		return authorList;
	}
	public void setAuthorList(List<SrmAchSatAuthor> authorList) {
		this.authorList = authorList;
	}
	public SrmAchSat getSat() {
		return sat;
	}
	public void setSat(SrmAchSat sat) {
		this.sat = sat;
	}
	public SrmAchFile getSrmAchFile() {
		return srmAchFile;
	}
	public void setSrmAchFile(SrmAchFile srmAchFile) {
		this.srmAchFile = srmAchFile;
	}
	
}
