package com.pinde.sci.model.srm;

import java.io.Serializable;

import com.pinde.sci.model.mo.SrmFundSchemeDetail;
import com.pinde.sci.model.mo.SrmProjFundDetail;

public class FundDetailExt implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3996465481399796382L;
	private SrmProjFundDetail fundDetail;
	private SrmFundSchemeDetail item;
	public SrmProjFundDetail getFundDetail() {
		return fundDetail;
	}
	public void setFundDetail(SrmProjFundDetail fundDetail) {
		this.fundDetail = fundDetail;
	}
	public SrmFundSchemeDetail getItem() {
		return item;
	}
	public void setItem(SrmFundSchemeDetail item) {
		this.item = item;
	}
}
