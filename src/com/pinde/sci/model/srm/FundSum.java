package com.pinde.sci.model.srm;

import java.io.Serializable;
import java.math.BigDecimal;

public class FundSum implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6199430099085500654L;
	/**
	 * 经费总计
	 */
	private BigDecimal amountFundSum;
	/**
	 * 下拨总计
	 */
	private BigDecimal goveFundSum;
	/**
	 * 配套总计
	 */
	private BigDecimal orgFundSum;
	/**
	 * 到账总计
	 */
	private BigDecimal realityAmountSum;
	/**
	 * 支出总计
	 */
	private BigDecimal yetPaymentAmountSum;
	/**
	 * 剩余经费总计
	 */
	private BigDecimal realityBalanceSum;
	
	
	public FundSum() {
	}
	
	public FundSum(BigDecimal amountFundSum, BigDecimal goveFundSum,
			BigDecimal orgFundSum, BigDecimal realityAmountSum,
			BigDecimal yetPaymentAmountSum, BigDecimal realityBalanceSum) {
		this.amountFundSum = amountFundSum;
		this.goveFundSum = goveFundSum;
		this.orgFundSum = orgFundSum;
		this.realityAmountSum = realityAmountSum;
		this.yetPaymentAmountSum = yetPaymentAmountSum;
		this.realityBalanceSum = realityBalanceSum;
	}

	public BigDecimal getAmountFundSum() {
		return amountFundSum;
	}
	public void setAmountFundSum(BigDecimal amountFundSum) {
		this.amountFundSum = amountFundSum;
	}
	public BigDecimal getGoveFundSum() {
		return goveFundSum;
	}
	public void setGoveFundSum(BigDecimal goveFundSum) {
		this.goveFundSum = goveFundSum;
	}
	public BigDecimal getOrgFundSum() {
		return orgFundSum;
	}
	public void setOrgFundSum(BigDecimal orgFundSum) {
		this.orgFundSum = orgFundSum;
	}
	public BigDecimal getRealityAmountSum() {
		return realityAmountSum;
	}
	public void setRealityAmountSum(BigDecimal realityAmountSum) {
		this.realityAmountSum = realityAmountSum;
	}
	public BigDecimal getYetPaymentAmountSum() {
		return yetPaymentAmountSum;
	}
	public void setYetPaymentAmountSum(BigDecimal yetPaymentAmountSum) {
		this.yetPaymentAmountSum = yetPaymentAmountSum;
	}
	public BigDecimal getRealityBalanceSum() {
		return realityBalanceSum;
	}
	public void setRealityBalanceSum(BigDecimal realityBalanceSum) {
		this.realityBalanceSum = realityBalanceSum;
	}
	
}
