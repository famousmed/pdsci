package com.pinde.sci.model.srm;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmExpertProj;

public class SrmExpertProjExt extends SrmExpertProj{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5790015737675464041L;
	private PubProj pubProj;
	private SrmExpertGroupProjExt srmExpertGroupProjExt;
	private SysUserExt userExt;
	
	public SysUserExt getUserExt() {
		return userExt;
	}

	public void setUserExt(SysUserExt userExt) {
		this.userExt = userExt;
	}

	public PubProj getPubProj() {
		return pubProj;
	}

	public void setPubProj(PubProj pubProj) {
		this.pubProj = pubProj;
	}

	public SrmExpertGroupProjExt getSrmExpertGroupProjExt() {
		return srmExpertGroupProjExt;
	}

	public void setSrmExpertGroupProjExt(SrmExpertGroupProjExt srmExpertGroupProjExt) {
		this.srmExpertGroupProjExt = srmExpertGroupProjExt;
	}
	
	
	
}
