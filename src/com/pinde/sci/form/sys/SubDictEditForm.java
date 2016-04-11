package com.pinde.sci.form.sys;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.SysDict;

public class SubDictEditForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String topDictFlow;
	
	private SysDict dict;
	
	private List<SysDict> subDicts;

	public String getTopDictFlow() {
		return topDictFlow;
	}

	public void setTopDictFlow(String topDictFlow) {
		this.topDictFlow = topDictFlow;
	}

	public SysDict getDict() {
		return dict;
	}

	public void setDict(SysDict dict) {
		this.dict = dict;
	}

	public List<SysDict> getSubDicts() {
		return subDicts;
	}

	public void setSubDicts(List<SysDict> subDicts) {
		this.subDicts = subDicts;
	}
	
	
}
