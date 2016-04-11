package com.pinde.sci.model.srm;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpertProjEval;
import com.pinde.sci.model.mo.SrmGradeScheme;

public class SrmExpertGroupProjExt extends SrmExpertProjEval{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7740923876378420576L;

	private SrmGradeScheme srmGradeScheme;
	
	private PubProj pubProj;
	
	public PubProj getPubProj() {
		return pubProj;
	}

	public void setPubProj(PubProj pubProj) {
		this.pubProj = pubProj;
	}

	public SrmGradeScheme getSrmGradeScheme() {
		return srmGradeScheme;
	}

	public void setSrmGradeScheme(SrmGradeScheme srmGradeScheme) {
		this.srmGradeScheme = srmGradeScheme;
	}

	
	
	
}
