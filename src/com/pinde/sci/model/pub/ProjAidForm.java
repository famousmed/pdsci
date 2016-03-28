package com.pinde.sci.model.pub;

import java.io.Serializable;

import com.pinde.sci.model.mo.AidProj;

public class ProjAidForm implements Serializable{
    
	/**
	 * 
	 */
	private static final long serialVersionUID = -725128532585795326L;

	private AidProj aidProj;
	
	private AidProjExt aidProjExt;
	

	public AidProj getAidProj() {
		return aidProj;
	}

	public void setAidProj(AidProj aidProj) {
		this.aidProj = aidProj;
	}

	public AidProjExt getAidProjExt() {
		return aidProjExt;
	}

	public void setAidProjExt(AidProjExt aidProjExt) {
		this.aidProjExt = aidProjExt;
	}



	
	

	


	
	
	
}
