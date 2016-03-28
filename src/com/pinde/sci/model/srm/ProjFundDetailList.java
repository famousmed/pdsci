package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;

public class ProjFundDetailList implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -482897590208840916L;
	private SrmProjFundInfo fundInfo;
	private List<SrmProjFundDetail> detailList;
	

	public SrmProjFundInfo getFundInfo() {
		return fundInfo;
	}
	public void setFundInfo(SrmProjFundInfo fundInfo) {
		this.fundInfo = fundInfo;
	}
	public List<SrmProjFundDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<SrmProjFundDetail> detailList) {
		this.detailList = detailList;
	}
	
	
}
