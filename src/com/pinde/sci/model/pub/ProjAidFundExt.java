package com.pinde.sci.model.pub;

import java.io.Serializable;

public class ProjAidFundExt implements Serializable{
   
	/**
	 * 
	 */
	private static final long serialVersionUID = -317519864799834713L;

	private String fundYear;
	
	private String fundCountryCount;
	
	private String fundProvinceCount;
	
	private String fundCityCount;
	
	private String fundAreaCount;


	public String getFundYear() {
		return fundYear;
	}

	public void setFundYear(String fundYear) {
		this.fundYear = fundYear;
	}

	public String getFundCountryCount() {
		return fundCountryCount;
	}

	public void setFundCountryCount(String fundCountryCount) {
		this.fundCountryCount = fundCountryCount;
	}

	public String getFundProvinceCount() {
		return fundProvinceCount;
	}

	public void setFundProvinceCount(String fundProvinceCount) {
		this.fundProvinceCount = fundProvinceCount;
	}

	public String getFundCityCount() {
		return fundCityCount;
	}

	public void setFundCityCount(String fundCityCount) {
		this.fundCityCount = fundCityCount;
	}

	public String getFundAreaCount() {
		return fundAreaCount;
	}

	public void setFundAreaCount(String fundAreaCount) {
		this.fundAreaCount = fundAreaCount;
	}
	
	
}
