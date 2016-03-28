package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.PubProj;
import com.pinde.sci.model.mo.SrmFundScheme;
import com.pinde.sci.model.mo.SrmProjFundDetail;
import com.pinde.sci.model.mo.SrmProjFundInfo;


/**
 * @Description ������չ
 *
 */
public class FundInfoExt implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6610469354483743473L;
	/**
	 * ����
	 */
	private SrmProjFundInfo fund; 
	/**
	 * ��Ӧ��Ŀ
	 */
	private PubProj project;
	/**
	 * ������ϸ
	 */
	private List<FundDetailExt> alaimList;
	/**
	 * Ԥ��
	 */
	private List<SrmProjFundDetail> budgetList;
	/**
	 * ���ѷ���
	 */
	private SrmFundScheme fundScheme;

	public PubProj getProject() {
		return project;
	}

	public void setProject(PubProj project) {
		this.project = project;
	}

	public List<SrmProjFundDetail> getBudgetList() {
		return budgetList;
	}

	public void setBudgetList(List<SrmProjFundDetail> budgetList) {
		this.budgetList = budgetList;
	}

	public SrmProjFundInfo getFund() {
		return fund;
	}

	public void setFund(SrmProjFundInfo fund) {
		this.fund = fund;
	}

	public SrmFundScheme getFundScheme() {
		return fundScheme;
	}

	public void setFundScheme(SrmFundScheme fundScheme) {
		this.fundScheme = fundScheme;
	}

	public List<FundDetailExt> getAlaimList() {
		return alaimList;
	}

	public void setAlaimList(List<FundDetailExt> alaimList) {
		this.alaimList = alaimList;
	}
	
}
