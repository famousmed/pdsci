package com.pinde.sci.form.res;

import java.io.Serializable;
import java.util.List;

public class ResAssessCfgForm implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5655638586544400099L;
	
	private String cfgFlow;
	private List<ResAssessCfgItemForm> itemFormList;

	public String getCfgFlow() {
		return cfgFlow;
	}
	public void setCfgFlow(String cfgFlow) {
		this.cfgFlow = cfgFlow;
	}
	public List<ResAssessCfgItemForm> getItemFormList() {
		return itemFormList;
	}
	public void setItemFormList(List<ResAssessCfgItemForm> itemFormList) {
		this.itemFormList = itemFormList;
	}
	
}
