package com.pinde.sci.model.srm;

import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;

public class ProjFundDetailExt extends SrmProjFundDetail{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8581599445454774910L;

	private SrmProjFundInfo projFundInfo;
	
	private PubProj proj;
	
	private SrmFundSchemeDetail schemeDetail;
	private List<String> operStatusIds;

	public SrmProjFundInfo getProjFundInfo() {
		return projFundInfo;
	}

	public void setProjFundInfo(SrmProjFundInfo projFundInfo) {
		this.projFundInfo = projFundInfo;
	}

	public PubProj getProj() {
		return proj;
	}

	public void setProj(PubProj proj) {
		this.proj = proj;
	}

	public SrmFundSchemeDetail getSchemeDetail() {
		return schemeDetail;
	}

	public void setSchemeDetail(SrmFundSchemeDetail schemeDetail) {
		this.schemeDetail = schemeDetail;
	}

	public List<String> getOperStatusIds() {
		return operStatusIds;
	}

	public void setOperStatusIds(List<String> operStatusIds) {
		this.operStatusIds = operStatusIds;
	}
	
	
}
