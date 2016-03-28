package com.pinde.sci.biz.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.PubProjRec;
import com.pinde.sci.model.mo.SysOrg;

public interface IProjSearchBiz {
     
	public List<PubProj> searchProj(PubProj proj,List<SysOrg> orgList);
	
	public List<PubProj> searchProj(PubProj proj);
	
	
}
