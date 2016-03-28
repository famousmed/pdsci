package com.pinde.sci.model.irb;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;


public class IrbSingleForm implements Serializable{
	
	private static final long serialVersionUID = -9135551514432083976L;
	
	private String productType;  //product¡¢sysCfg
	private String jspPath;	
	private String viewPath;	
	private String category;	// yw¡¢ky¡¢qx
	private String version;    
	private List<Element> itemList;
	private Map<String,Map<String,CodeValues>> itemCodeMap;
	
	public String getProductType() {
		return productType;
	}
	public void setProductType(String productType) {
		this.productType = productType;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getJspPath() {
		return jspPath;
	}
	public void setJspPath(String jspPath) {
		this.jspPath = jspPath;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public List<Element> getItemList() {
		return itemList;
	}
	public void setItemList(List<Element> itemList) {
		this.itemList = itemList;
	}
	public String getViewPath() {
		return viewPath;
	}
	public void setViewPath(String viewPath) {
		this.viewPath = viewPath;
	}
	public Map<String, Map<String, CodeValues>> getItemCodeMap() {
		return itemCodeMap;
	}
	public void setItemCodeMap(Map<String, Map<String, CodeValues>> itemCodeMap) {
		this.itemCodeMap = itemCodeMap;
	}

}
