package com.pinde.sci.form.edc;

import java.io.Serializable;
import java.util.List;

import com.pinde.sci.model.mo.EdcAttribute;
import com.pinde.sci.model.mo.EdcElement;
import com.pinde.sci.model.mo.EdcModule;

public class ObservationCfgForm implements Serializable{
	private static final long serialVersionUID = 3772407381314180378L;
		
	private String projFlow;
	private String inspectTypeId;
	private String elementName;
	private String attrName;
	private String attrCode;
	private String isCode;
	private String chartType;
	public String getChartType() {
		return chartType;
	}
	public void setChartType(String chartType) {
		this.chartType = chartType;
	}
	public String getElementName() {
		return elementName;
	}
	public void setElementName(String elementName) {
		this.elementName = elementName;
	}
	public String getAttrName() {
		return attrName;
	}
	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}
	public String getIsCode() {
		return isCode;
	}
	public void setIsCode(String isCode) {
		this.isCode = isCode;
	}
	public String getProjFlow() {
		return projFlow;
	}
	public void setProjFlow(String projFlow) {
		this.projFlow = projFlow;
	}
	public String getInspectTypeId() {
		return inspectTypeId;
	}
	public void setInspectTypeId(String inspectTypeId) {
		this.inspectTypeId = inspectTypeId;
	}
	public String getAttrCode() {
		return attrCode;
	}
	public void setAttrCode(String attrCode) {
		this.attrCode = attrCode;
	}
	
}
