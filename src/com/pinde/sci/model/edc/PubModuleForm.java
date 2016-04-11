package com.pinde.sci.model.edc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.PubAttrCode;
import com.pinde.sci.model.mo.PubAttribute;
import com.pinde.sci.model.mo.PubElement;
import com.pinde.sci.model.mo.PubModule;

public class PubModuleForm implements Serializable{
	
	private static final long serialVersionUID = 2148461720616807085L;

	//element
	private PubModule module = new PubModule();
	
	private List<PubElement> elements = new ArrayList<PubElement>();
	private Map<String,PubElement> elementMap = new HashMap<String, PubElement>();
	
	//attr
	private List<PubAttribute> attrs = new ArrayList<PubAttribute>();
	private Map<String,PubAttribute> attrMap = new HashMap<String, PubAttribute>();
	private Map<String,List<PubAttribute>> eleAttrMap = new HashMap<String, List<PubAttribute>>();
	//code
	private List<PubAttrCode> codes = new ArrayList<PubAttrCode>();
	private Map<String ,PubAttrCode> codeMap = new HashMap<String, PubAttrCode>();
	private Map<String ,List<PubAttrCode>> attrCodeMap = new HashMap<String, List<PubAttrCode>>();
	
	
	public PubModule getModule() {
		return module;
	}
	public void setModule(PubModule module) {
		this.module = module;
	}
	public List<PubElement> getElements() {
		return elements;
	}
	public void setElements(List<PubElement> elements) {
		this.elements = elements;
	}
	public Map<String, List<PubAttribute>> getEleAttrMap() {
		return eleAttrMap;
	}
	public void setEleAttrMap(Map<String, List<PubAttribute>> eleAttrMap) {
		this.eleAttrMap = eleAttrMap;
	}
	public Map<String, List<PubAttrCode>> getAttrCodeMap() {
		return attrCodeMap;
	}
	public void setAttrCodeMap(Map<String, List<PubAttrCode>> attrCodeMap) {
		this.attrCodeMap = attrCodeMap;
	}
	public Map<String, PubElement> getElementMap() {
		return elementMap;
	}
	public void setElementMap(Map<String, PubElement> elementMap) {
		this.elementMap = elementMap;
	}
	public Map<String, PubAttribute> getAttrMap() {
		return attrMap;
	}
	public void setAttrMap(Map<String, PubAttribute> attrMap) {
		this.attrMap = attrMap;
	}
	public Map<String, PubAttrCode> getCodeMap() {
		return codeMap;
	}
	public void setCodeMap(Map<String, PubAttrCode> codeMap) {
		this.codeMap = codeMap;
	}
	public List<PubAttribute> getAttrs() {
		return attrs;
	}
	public void setAttrs(List<PubAttribute> attrs) {
		this.attrs = attrs;
	}
	public List<PubAttrCode> getCodes() {
		return codes;
	}
	public void setCodes(List<PubAttrCode> codes) {
		this.codes = codes;
	}
}
