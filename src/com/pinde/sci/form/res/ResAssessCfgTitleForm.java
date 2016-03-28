package com.pinde.sci.form.res;

import java.io.Serializable;
import java.util.List;

public class ResAssessCfgTitleForm implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1343184604234324999L;
	
	private String id;
	private String name;
	private List<ResAssessCfgItemForm> itemList;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<ResAssessCfgItemForm> getItemList() {
		return itemList;
	}
	public void setItemList(List<ResAssessCfgItemForm> itemList) {
		this.itemList = itemList;
	}
	
}
