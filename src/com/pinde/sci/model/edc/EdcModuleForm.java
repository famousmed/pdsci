package com.pinde.sci.model.edc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;

public class EdcModuleForm implements Serializable{
	
	private static final long serialVersionUID = 5203743937266041652L;

	//Element
	private List<EdcElement> elements = new ArrayList<EdcElement>();
	private Map<String,EdcElement> elementMap = new HashMap<String, EdcElement>();
	
	//attr
	private List<EdcAttribute> attrs = new ArrayList<EdcAttribute>();
	private Map<String,EdcAttribute> attrMap = new HashMap<String, EdcAttribute>();
	private Map<String,List<EdcAttribute>> eleAttrMap = new HashMap<String, List<EdcAttribute>>();
	
	//code
	private List<EdcAttrCode> codes = new ArrayList<EdcAttrCode>();
	private Map<String ,EdcAttrCode> codeMap = new HashMap<String, EdcAttrCode>();
	private Map<String ,List<EdcAttrCode>> attrCodeMap = new HashMap<String, List<EdcAttrCode>>();
	
	//code 方便设计CRF是否已选择
	private List<String> elementCodes = new ArrayList<String>();
	private List<String> attrCodes = new ArrayList<String>();
	private List<String> codeValue = new ArrayList<String>();
	
	
	
	public Map<String, EdcElement> getElementMap() {
		return elementMap;
	}
	public void setElementMap(Map<String, EdcElement> elementMap) {
		this.elementMap = elementMap;
	}
	public Map<String, EdcAttribute> getAttrMap() {
		return attrMap;
	}
	public void setAttrMap(Map<String, EdcAttribute> attrMap) {
		this.attrMap = attrMap;
	}
	public List<EdcAttrCode> getCodes() {
		return codes;
	}
	public void setCodes(List<EdcAttrCode> codes) {
		this.codes = codes;
	}
	public Map<String, EdcAttrCode> getCodeMap() {
		return codeMap;
	}
	public void setCodeMap(Map<String, EdcAttrCode> codeMap) {
		this.codeMap = codeMap;
	}
	
	public List<String> getAttrCodes() {
		return attrCodes;
	}
	public void setAttrCodes(List<String> attrCodes) {
		this.attrCodes = attrCodes;
	}
	public List<String> getElementCodes() {
		return elementCodes;
	}
	public void setElementCodes(List<String> elementCodes) {
		this.elementCodes = elementCodes;
	}
	
	public List<String> getCodeValue() {
		return codeValue;
	}
	public void setCodeValue(List<String> codeValue) {
		this.codeValue = codeValue;
	}
	
	public List<EdcElement> getElements() {
		return elements;
	}
	public void setElements(List<EdcElement> elements) {
		this.elements = elements;
	}
	public Map<String, List<EdcAttribute>> getEleAttrMap() {
		return eleAttrMap;
	}
	public void setEleAttrMap(Map<String, List<EdcAttribute>> eleAttrMap) {
		this.eleAttrMap = eleAttrMap;
	}
	public Map<String, List<EdcAttrCode>> getAttrCodeMap() {
		return attrCodeMap;
	}
	public void setAttrCodeMap(Map<String, List<EdcAttrCode>> attrCodeMap) {
		this.attrCodeMap = attrCodeMap;
	}
	public List<EdcAttribute> getAttrs() {
		return attrs;
	}
	public void setAttrs(List<EdcAttribute> attrs) {
		this.attrs = attrs;
	}
}
