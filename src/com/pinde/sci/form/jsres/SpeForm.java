package com.pinde.sci.form.jsres;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.pinde.sci.model.mo.ResOrgSpe;

public class SpeForm implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1553421967232984092L;
	
	private List<ResOrgSpe> speList = new ArrayList<ResOrgSpe>();

	public List<ResOrgSpe> getSpeList() {
		return speList;
	}

	public void setSpeList(List<ResOrgSpe> speList) {
		this.speList = speList;
	}

	
}
