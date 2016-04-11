package com.pinde.sci.model.srm;

import java.io.Serializable;

import com.pinde.sci.model.mo.SrmFundItem;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmFundSchemeDetail;

public class FundItemInfo implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6808340231874568469L;
	private SrmFundItem item;
	private SrmFundScheme scheme;
	private SrmFundSchemeDetail fundSchemeDetail;
	public SrmFundItem getItem() {
		return item;
	}
	public void setItem(SrmFundItem item) {
		this.item = item;
	}
	public SrmFundScheme getScheme() {
		return scheme;
	}
	public void setScheme(SrmFundScheme scheme) {
		this.scheme = scheme;
	}
	public SrmFundSchemeDetail getFundSchemeDetail() {
		return fundSchemeDetail;
	}
	public void setFundSchemeDetail(SrmFundSchemeDetail fundSchemeDetail) {
		this.fundSchemeDetail = fundSchemeDetail;
	}
	
}
