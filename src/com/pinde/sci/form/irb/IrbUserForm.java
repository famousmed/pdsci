package com.pinde.sci.form.irb;

import java.io.Serializable;

import com.pinde.sci.model.mo.IrbApply;
import com.pinde.sci.model.mo.IrbUser;
import com.pinde.sci.model.mo.PubProj;

public class IrbUserForm implements Serializable{
	
	private static final long serialVersionUID = 5207606324851086476L;
	
	private PubProj proj;
	private IrbApply apply;
	private IrbUser irbUser;
	public PubProj getProj() {
		return proj;
	}
	public void setProj(PubProj proj) {
		this.proj = proj;
	}
	public IrbApply getApply() {
		return apply;
	}
	public void setApply(IrbApply apply) {
		this.apply = apply;
	}
	public IrbUser getIrbUser() {
		return irbUser;
	}
	public void setIrbUser(IrbUser irbUser) {
		this.irbUser = irbUser;
	}
	
}
