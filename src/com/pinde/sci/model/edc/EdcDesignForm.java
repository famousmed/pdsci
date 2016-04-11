package com.pinde.sci.model.edc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pinde.sci.model.mo.EdcAttrCode;
import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcModule;
import com.pinde.sci.model.mo.EdcNormalValue;
import com.pinde.sci.model.mo.EdcVisit;
import com.pinde.sci.model.mo.EdcVisitAttrCode;
import com.pinde.sci.model.mo.EdcVisitAttribute;
import com.pinde.sci.model.mo.EdcVisitElement;
import com.pinde.sci.model.mo.EdcVisitModule;

public class EdcDesignForm implements Serializable{
	
	private static final long serialVersionUID = -6577453972045234035L;
	
	//mo map
	private List<EdcModule> moduleList = new ArrayList<EdcModule>();
	private Map<String,EdcModule> moduleMap = new HashMap<String, EdcModule>();
	private Map<String,EdcElement> elementMap = new HashMap<String, EdcElement>();
	private Map<String,List<EdcElement>> moduleElementMap = new HashMap<String, List<EdcElement>>();
	private Map<String,EdcAttribute> attrMap = new HashMap<String, EdcAttribute>();
	private Map<String,List<EdcAttribute>> elementAttrMap = new HashMap<String, List<EdcAttribute>>();
	private Map<String ,EdcAttrCode> codeMap = new HashMap<String, EdcAttrCode>();
	private Map<String ,List<EdcAttrCode>> attrCodeMap = new HashMap<String, List<EdcAttrCode>>();
	private Map<String,Map<String,String>> attrCodeValueMap = new HashMap<String, Map<String,String>>();
	
	//
	private List<EdcVisit> visitList = new ArrayList<EdcVisit>();
	private Map<String,EdcVisit> visitMap = new HashMap<String, EdcVisit>();
	//VisitModule
	private Map<String,List<EdcVisitModule>>  visitModuleMap = new HashMap<String, List<EdcVisitModule>>();
	private Map<String,List<EdcVisitElement>>  visitModuleElementMap = new HashMap<String, List<EdcVisitElement>>();
	private Map<String,List<EdcVisitAttribute>> visitElementAttributeMap = new HashMap<String, List<EdcVisitAttribute>>();
	private Map<String,List<EdcVisitAttrCode>> visitAttrCodeMap = new HashMap<String, List<EdcVisitAttrCode>>();
	
	//NormalValue
	private Map<String,String> elementStandardUnitMap = new HashMap<String, String>();
	// orgFlow_elementCode <sexEnum,normalValue>
	private Map<String,Map<String,EdcNormalValue>> normalValueMap = new HashMap<String, Map<String,EdcNormalValue>>();
	
	public Map<String, Map<String, String>> getAttrCodeValueMap() {
		return attrCodeValueMap;
	}
	public void setAttrCodeValueMap(
			Map<String, Map<String, String>> attrCodeValueMap) {
		this.attrCodeValueMap = attrCodeValueMap;
	}
	
	public Map<String, EdcVisit> getVisitMap() {
		return visitMap;
	}
	public void setVisitMap(Map<String, EdcVisit> visitMap) {
		this.visitMap = visitMap;
	}
	public Map<String, Map<String, EdcNormalValue>> getNormalValueMap() {
		return normalValueMap;
	}
	public void setNormalValueMap(
			Map<String, Map<String, EdcNormalValue>> normalValueMap) {
		this.normalValueMap = normalValueMap;
	}
	public Map<String, String> getElementStandardUnitMap() {
		return elementStandardUnitMap;
	}
	public void setElementStandardUnitMap(Map<String, String> elementStandardUnitMap) {
		this.elementStandardUnitMap = elementStandardUnitMap;
	}
	public List<EdcModule> getModuleList() {
		return moduleList;
	}
	public void setModuleList(List<EdcModule> moduleList) {
		this.moduleList = moduleList;
	}
	public Map<String, EdcModule> getModuleMap() {
		return moduleMap;
	}
	public void setModuleMap(Map<String, EdcModule> moduleMap) {
		this.moduleMap = moduleMap;
	}
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
	public Map<String, EdcAttrCode> getCodeMap() {
		return codeMap;
	}
	public void setCodeMap(Map<String, EdcAttrCode> codeMap) {
		this.codeMap = codeMap;
	}
	public Map<String, List<EdcAttrCode>> getAttrCodeMap() {
		return attrCodeMap;
	}
	public void setAttrCodeMap(Map<String, List<EdcAttrCode>> attrCodeMap) {
		this.attrCodeMap = attrCodeMap;
	}
	public Map<String, List<EdcVisitModule>> getVisitModuleMap() {
		return visitModuleMap;
	}
	public void setVisitModuleMap(Map<String, List<EdcVisitModule>> visitModuleMap) {
		this.visitModuleMap = visitModuleMap;
	}
	public Map<String, List<EdcVisitElement>> getVisitModuleElementMap() {
		return visitModuleElementMap;
	}
	public void setVisitModuleElementMap(
			Map<String, List<EdcVisitElement>> visitModuleElementMap) {
		this.visitModuleElementMap = visitModuleElementMap;
	}
	public Map<String, List<EdcVisitAttribute>> getVisitElementAttributeMap() {
		return visitElementAttributeMap;
	}
	public void setVisitElementAttributeMap(
			Map<String, List<EdcVisitAttribute>> visitElementAttributeMap) {
		this.visitElementAttributeMap = visitElementAttributeMap;
	}
	public Map<String, List<EdcVisitAttrCode>> getVisitAttrCodeMap() {
		return visitAttrCodeMap;
	}
	public void setVisitAttrCodeMap(
			Map<String, List<EdcVisitAttrCode>> visitAttrCodeMap) {
		this.visitAttrCodeMap = visitAttrCodeMap;
	}
	public Map<String, List<EdcElement>> getModuleElementMap() {
		return moduleElementMap;
	}
	public void setModuleElementMap(Map<String, List<EdcElement>> moduleElementMap) {
		this.moduleElementMap = moduleElementMap;
	}
	public Map<String, List<EdcAttribute>> getElementAttrMap() {
		return elementAttrMap;
	}
	public void setElementAttrMap(Map<String, List<EdcAttribute>> elementAttrMap) {
		this.elementAttrMap = elementAttrMap;
	}
	public List<EdcVisit> getVisitList() {
		return visitList;
	}
	public void setVisitList(List<EdcVisit> visitList) {
		this.visitList = visitList;
	}
	
}
