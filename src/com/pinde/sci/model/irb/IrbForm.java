package com.pinde.sci.model.irb;

import java.io.Serializable;

import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.PubProj;

public class IrbForm implements Serializable{
	
	private static final long serialVersionUID = -126722533879881813L;
	
	private IrbApply irb;
	private PubProj proj;
	public IrbApply getIrb() {
		return irb;
	}
	public void setIrb(IrbApply irb) {
		this.irb = irb;
	}
	public PubProj getProj() {
		return proj;
	}
	public void setProj(PubProj proj) {
		this.proj = proj;
	}
	
}
