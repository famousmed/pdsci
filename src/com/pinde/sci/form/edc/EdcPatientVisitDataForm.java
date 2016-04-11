package com.pinde.sci.form.edc;

import java.io.Serializable;
import java.util.List;

public class EdcPatientVisitDataForm implements Serializable{
	private static final long serialVersionUID = -8460375372031438709L;
	
	private String visitFlow;
	private String visitName;
	private String orgFlow;
	private String patientFlow;
	private String patientNamePy;
	private Integer patientSeq;
	private String patientCode;
	private String elementSerialSeq;
	private String attrValue;
	private String attrValueTip;
	private String elementCode;
	private String elementName;
	private String attrCode;
	private String attrName;
	public String getVisitFlow() {
		return visitFlow;
	}
	public void setVisitFlow(String visitFlow) {
		this.visitFlow = visitFlow;
	}
	public String getVisitName() {
		return visitName;
	}
	public void setVisitName(String visitName) {
		this.visitName = visitName;
	}
	public String getPatientFlow() {
		return patientFlow;
	}
	public void setPatientFlow(String patientFlow) {
		this.patientFlow = patientFlow;
	}
	public String getPatientNamePy() {
		return patientNamePy;
	}
	public void setPatientNamePy(String patientNamePy) {
		this.patientNamePy = patientNamePy;
	}
	public Integer getPatientSeq() {
		return patientSeq;
	}
	public void setPatientSeq(Integer patientSeq) {
		this.patientSeq = patientSeq;
	}
	public String getPatientCode() {
		return patientCode;
	}
	public void setPatientCode(String patientCode) {
		this.patientCode = patientCode;
	}
	public String getElementSerialSeq() {
		return elementSerialSeq;
	}
	public void setElementSerialSeq(String elementSerialSeq) {
		this.elementSerialSeq = elementSerialSeq;
	}
	public String getAttrValue() {
		return attrValue;
	}
	public void setAttrValue(String attrValue) {
		this.attrValue = attrValue;
	}
	public String getAttrValueTip() {
		return attrValueTip;
	}
	public void setAttrValueTip(String attrValueTip) {
		this.attrValueTip = attrValueTip;
	}
	public String getElementCode() {
		return elementCode;
	}
	public void setElementCode(String elementCode) {
		this.elementCode = elementCode;
	}
	public String getAttrCode() {
		return attrCode;
	}
	public void setAttrCode(String attrCode) {
		this.attrCode = attrCode;
	}
	public String getOrgFlow() {
		return orgFlow;
	}
	public void setOrgFlow(String orgFlow) {
		this.orgFlow = orgFlow;
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
}
