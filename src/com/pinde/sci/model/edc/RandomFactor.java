package com.pinde.sci.model.edc;

import java.io.Serializable;
import java.util.Map;



public class RandomFactor implements Serializable{
	
	private static final long serialVersionUID = 8367529755781711277L;
	
	private String index;
	private String weight;
	private Map<String,String> itemMap;
	
	
	public String getIndex() {
		return index;
	}
	public void setIndex(String index) {
		this.index = index;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public Map<String, String> getItemMap() {
		return itemMap;
	}
	public void setItemMap(Map<String, String> itemMap) {
		this.itemMap = itemMap;
	}
	
	
}
